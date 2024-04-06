%Initialization Parameters
server_ip   = '127.0.0.1';     %IP address of the Unity Server
server_port = 55001;           %Server Port of the Unity Sever

client = tcpclient(server_ip,server_port);
fprintf(1,"Connected to server\n");

%depth = -2;
b = 60; % baseline [mm]
f = 6; % focal length [mm]
ps = 0.006;


serve1_postions = fopen('serve1.dat','r');


while ~feof(serve1_postions)
    line = fgetl(serve1_postions);
    if isempty(line)
        continue;
    end
    
    
    
    coordinates = str2num(line);  % Assuming coordinates are separated by spaces
    
    x = coordinates(1);
    y = coordinates(2);
    z = coordinates(3);
    
    pose = [x,y,z,0,0,0];%
    unityImageLeft = unityLink(client,pose);
    imshow(unityImageLeft)
    % Check if the line was parsed successfully
    if isempty(coordinates)
        warning('Failed to parse line: %s', line);
        continue;
    end
end




% for i = [0 -0.1 -0.2 -0.3]
% % x,y,z,yaw[z],pitch[y],roll[x]
% pose = [i,0.1,2,0,0,0];%
% disp(i)
% unityImageLeft = unityLink(client,pose);
% %gray = rgb2gray(unityImageLeft);
% %bw = im2bw(gray,0.7);
% s = regionprops(unityImageLeft, 'centroid')
% %leftCentroid = s.Centroid;
% imshow(unityImageLeft)

%end