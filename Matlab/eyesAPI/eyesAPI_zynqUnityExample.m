%% Unity Example
    clc
    clear
% Declarations
    file = "../trajectories/serve2.dat";
    trajectory = importdata(file);
    server_ip   = ['127.0.0.1','192.168.1.213'];% IP address of the Unity Server
    server_port = [55001,9999];             % Server Port of the Unity Server
    method = @(C,S,L,T) zynqMethod(C,S,L,T);
    mArg = @(T,C,I) zynqLink(T,C,I);
    camera = @(C,P) unityCamera(C,P);
    cArg = @(T,P,S) unityLink(T,P,S);
    pose = [ 0.5,0,-15,90,-90,0;
            -0.5,0,-15,90,-90,0];
    showImages = true;
% Initialize
    api = eyesAPI(method,camera,mArg,cArg);
    api = api.manageServer('camera',"Start",server_ip(1),server_port(1));
    api = api.manageServer('method',"Start",server_ip(2),server_port(2)); 
    api = api.manageServer('camera',"runLink",[0,0,0,0,0,0],3);
    api.calibrate(pose);
% Track
    run("modifyScript.m");
    run("trajectoryScript.m");
    api = api.manageServer('camera',"Stop");
    api = api.manageServer('method',"Stop");