%% clear
clc
clear
%% Test Example
% Declarations 
path = "../../algorithms/Algro_test/TestImages/testImage_";
file = ["ball_n","ball_0","ball_2","ball_3"];
tag = ".jpg";
cnt = 1;
% Initialize
api = eyesAPI("MATLAB","Test");
name = path+file(1)+tag;
api.calibrate(name,name);
% Track
while(2 >= cnt)
    for i = 2:4
        name = path+file(i)+tag;
        [C,leftImage,rightImage] = api.Track(name,name);
        figure(1);
        imshow(leftImage); 
        viscircles(C(:,1)', 3,'EdgeColor','b');
        pause(1)
    end
    cnt = cnt + 1;
end
%% Unity Example
% Declarations 
file = "../tractoties/serve1.dat";
server_ip   = '127.0.0.1';     %IP address of the Unity Server
server_port = 55001;           %Server Port of the Unity Sever
% Initialize
api = eyesAPI("MATLAB","Unity");
api = api.manageClient("Unity","Start",server_ip,server_port);













api = api.manageClient("Unity","Stop");