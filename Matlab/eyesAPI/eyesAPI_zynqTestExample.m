%% Unity Example
    clc
    clear
% Addpaths
    addpath("../eyesAPI");
    addpath("../scripts");
% Declarations 
    file = ["leftCal.png","rightCal.png","leftImage.png","rightImage.png"];
    tag = ".jpg";
    server_ip   = '127.0.0.1';     % IP address of the Unity Server
    server_port = 55001;           % Server Port of the Unity Sever
    method = @(C,S,L,T) zynqMethod(C,S,L,T);
    mArg = @(T,C,I) zynqLink(T,C,I);
    camera = @(A,L,R) testCamera(A,L,R);
    cArg = 0;
    showImages = true;
% Initialize
    api = eyesAPI(method,camera,mArg,cArg);
    api = api.manageServer('method',"Start",server_ip,server_port);
    api.calibrate(name,name);
% Track
    run("modifyScript.m");
    run("trajectoryScript.m");
    api = api.manageServer('method',"Stop");