%% Test Example
    clc
    clear
% Declarations 
    path = "../../algorithms/Algro_test/TestImages/testImage_";
    file = ["ball_n","ball_0","ball_2","ball_3"];
    tag = ".jpg";
    method = @(C,S,L,R) MATLABmethod(C,S,L,R);
    camera = @(A,L,R) testCamera(A,L,R);
% Initialize
    api = eyesAPI(method,camera,[-2,-2],0);
    name = path+file(1)+tag;
    api.calibrate(name,name);
% Track
  for i = 2:4
      name = path+file(i)+tag;
      [C,leftImage,~] = api.track(name,name);
      figure(1);
      imshow(leftImage); 
      viscircles(C(:,1)', 3,'EdgeColor','b');
  end