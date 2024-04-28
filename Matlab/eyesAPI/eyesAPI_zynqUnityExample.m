%% Unity Example
    clc
    clear
% Declarations 
    server_ip   = ['127.0.0.1','192.168.1.213'];% IP address of the Unity Server
    server_port = [55001,9999];             % Server Port of the Unity Server
    method = @(C,S,L,T) zynqMethod(C,S,L,T);
    mArg = @(T,C,I) zynqLink(T,C,I);
    camera = @(C,P) unityCamera(C,P);
    cArg = @(C,P) unityCamera(C,P);
% Initialize
    api = eyesAPI(method,camera,mArg,0);
    api = api.manageServer('camera',"Start",server_ip(1),server_port(1));
    api = api.manageServer('method',"Start",server_ip(2),server_port(2)); 
    api = api.manageServer('camera',"runLink",[0,0,0,0,0,0],3);
    api.calibrate(pose);
% Track
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

        figure(1);subplot(1,2,1);
        imshow(leftImage); 
        viscircles(C(:,1)', 3,'EdgeColor','b');
        figure(1); subplot(1,2,2);
        imshow(rightImage); 
        viscircles(C(:,2)', 3,'EdgeColor','b');
    end
    api = api.manageClient('camera',"Stop");
    api = api.manageClient('method',"Stop");