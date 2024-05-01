%% Unity Example
    clc
    clear
% Declarations
    file = "../trajectories/serve2.dat";
    trajectory = importdata(file);
    server_port = [55001,9999];             % Server Port of the Unity Server
    method = @(C,S,L,T) zynqMethod(C,S,L,T);
    mArg = @(T,C,I) zynqLink(T,C,I);
    camera = @(C,P) unityCamera(C,P);
    cArg = @(T,P,S) unityLink(T,P,S);
    pose = [ 0.5,0,-15,90,-90,0;
            -0.5,0,-15,90,-90,0];
    showImages = true;
    imfig = figure(1);
% Initialize
    api = eyesAPI(method,camera,mArg,cArg);
    api = api.manageServer('camera',"Start",'127.0.0.1',55001);
    api = api.manageServer('method',"Start",'129.21.123.155',9999); 
    api = api.manageServer('camera',"runLink",[0,0,0,0,0,0],3);
    api.calibrate(pose);
% Track
    run("modifyScript.m");
    run("trajectoryScript.m");
    api = api.manageServer('camera',"Stop");
    api = api.manageServer('method',"Stop");
    