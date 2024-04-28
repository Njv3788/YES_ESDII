%% Unity Example
    clc
    clear
% Declarations 
    path = "../../algorithms/Algro_test/TestImages/testImage_";
    file = ["ball_n","ball_0","ball_2","ball_3"];
    tag = ".jpg";
    server_ip   = '127.0.0.1';     % IP address of the Unity Server
    server_port = 55001;           % Server Port of the Unity Sever
    method = @(C,S,L,T) zynqMethod(C,S,L,T);
    mArg = @(T,C,I) zynqLink(T,C,I);
    camera = @(A,L,R) testCamera(A,L,R);
    cArg = 0;
% Initialize
    api = eyesAPI(method,camera,mArg,cArg);
    api = api.manageServer('method',"Start",server_ip,server_port);
    name = path+file(1)+tag;
    api.calibrate(name,name);
% Track
  for i = 2:4
      name = path+file(i)+tag;
      [C,leftImage,~] = api.track(name,name);
      
      if(size(C) == 1)
          fprintf("ERROR: Centriod unable to be found\n")
          continue;
      end
      
      figure(1);
      imshow(leftImage); 
      viscircles(C(:,1)', 3,'EdgeColor','b');
  end
  api = api.manageServer('method',"Stop");