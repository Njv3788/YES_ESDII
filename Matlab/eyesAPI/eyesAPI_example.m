% %% Test Example
%     clc
%     clear
% % Declarations 
%     path = "../../algorithms/Algro_test/TestImages/testImage_";
%     file = ["ball_n","ball_0","ball_2","ball_3"];
%     tag = ".jpg";
%     method = @(C,S,L,R) MATLABmethod(C,S,L,R);
%     camera = @(A,L,R) testCamera(A,L,R);
% % Initialize
%     api = eyesAPI(method,camera,[-2,-2],0);
%     name = path+file(1)+tag;
%     api.calibrate(name,name);
% % Track
%   for i = 2:4
%       name = path+file(i)+tag;
%       [C,leftImage,~] = api.track(name,name);
%       figure(1);
%       imshow(leftImage); 
%       viscircles(C(:,1)', 3,'EdgeColor','b');
%       pause(1)
%   end
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
    cArg = @(T,P) unityLink(T,P);
% Initialize
    api = eyesAPI(method,camera,mArg,cArg);
    api = api.manageClient("Unity","Start",server_ip,server_port); 
    trajectory = importdata(file);
    api.calibrate([0,0,0,0,0,0]);
    for i = 1:size(trajectory,1)
        x = trajectory(i,1);
        y = trajectory(i,2);
        z = trajectory(i,3);
        [C,leftImage,~] = api.track([x,y,z,0,0,0]);
        imshow(leftImage); 
        viscircles(C(:,1)', 10,'EdgeColor','b');
    end
    api = api.manageClient("Unity","Stop");