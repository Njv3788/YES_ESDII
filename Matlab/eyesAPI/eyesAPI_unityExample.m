%% Unity Example
    clc
    clear
% Declarations 
    file = "../trajectories/serve2.dat";
    server_ip   = '127.0.0.1';     % IP address of the Unity Server
    server_port = 55001;           % Server Port of the Unity Sever
    method = @(L,R,S,C) MATLABmethod(L,R,S,C);
    mArg = [-2,-2];
    camera = @(C,P) unityCamera(C,P);
    cArg = @(C,P) unityCamera(C,P);
    pose = [ 0.5,0,-15,90,-90,0;
            -0.5,0,-15,90,-90,0];
    trajectory = importdata(file);
% Initialize
    api = eyesAPI(method,camera,mArg,cArg);
    api = api.manageServer('camera',"Start",server_ip,server_port); 
    api = api.manageServer('camera',"runLink",[0,0,0,0,0,0],3);
    api.calibrate(pose);
    for i = 1:size(trajectory,1)
        x = trajectory(i,1);
        y = trajectory(i,2);
        z = trajectory(i,3);
        
        api = api.manageServer('camera',"runLink",[z,x,-y,0,0,0],3);
        [C,leftImage,rightImage] = api.track(pose);
        
        if(size(C) == 1)
            fprintf("ERROR: Centriod unable to be found\n")
            continue;
        end

        figure(1); subplot(1,2,1);
        imshow(leftImage); 
        viscircles(C(:,1)', 3,'EdgeColor','b');
        figure(1); subplot(1,2,2);
        imshow(rightImage); 
        viscircles(C(:,2)', 3,'EdgeColor','b');
    end
    api = api.manageClient('camera',"Stop");