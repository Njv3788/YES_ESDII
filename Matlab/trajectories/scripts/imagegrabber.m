%% Unity Example
    clc
    clear
% Addpaths
    addpath("../eyesAPI");
    addpath("../scripts");
% Declarations 
    server_ip   = '127.0.0.1';     % IP address of the Unity Server
    server_port = 55001;           % Server Port of the Unity Sever
    method = @(L,R,S,C) MATLABmethod(L,R,S,C);
    mArg = [-2,-2];
    camera = @(C,P) unityCamera(C,P);
    cArg = @(T,P,S) unityLink(T,P,S);
    pose = [ 4,0,-20,90,-90,0;
             0,0,-20,90,-90,0];
    imfig = figure(1);
    trajectory = importdata("../trajectories/serve1.dat");
    traceFound = zeros(size(trajectory,1),size(trajectory,2)+2);
    showImages = true;
    
    % Initialize
    api = eyesAPI(method,camera,mArg,cArg);
    api = api.manageServer('camera',"Start",server_ip,server_port); 
    api = api.manageServer('camera',"runLink",[0,0,0,0,0,0],3);
    api.calibrate(pose);
    [C,leftImage,rightImage] = api.track(pose);
    api = api.manageServer('camera',"runLink", ...
    [trajectory(200,3),trajectory(200,1),-trajectory(200,2),0,0,0],3);
    [C,leftImage,rightImage] = api.track(pose);