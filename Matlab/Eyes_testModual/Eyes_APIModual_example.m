%% clear
    clc
    clear
%% Declarations 
 path = "../../algorithms/Algro_test/TestImages/testImage_";
 file = ["ball_n","ball_0","ball_1","ball_2","ball_3"];
 tag = ".jpg";
%% Initialize
test = Eyes_APIModulal("MATLAB","Test");
name = path+file(1)+tag;
test.calibrate([name,name]);

%% Preform
for i = 2:5
    name = path+file(i)+tag;
    [C,leftImage,rightImage] = test.Track([name,name]);
    figure(1);
    imshow(leftImage); 
    viscircles(C(:,1)', 3,'EdgeColor','b');

    figure(2);
    imshow(rightImage); 
    viscircles(C(:,2)', 3,'EdgeColor','b');
    pause(1)
end
