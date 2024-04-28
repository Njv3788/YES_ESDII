%% Test Example
    clc
    clear
% Addpaths
    addpath("../eyesAPI");
    addpath("../scripts");
% Declarations 
    path = "../../algorithms/Algro_test/TestImages/testImage_";
    file = ["ball_n.jpg","ball_0.jpg","ball_2.jpg","ball_3.jpg"];
    method = @(C,S,L,R) MATLABmethod(C,S,L,R);
    camera = @(A,L,R) testCamera(A,L,R);
    cArg = 0;
    showImages = true;
% Initialize
    api = eyesAPI(method,camera,[-2,-2],cArg);
    name = path+file(1);
    api.calibrate(name,name);
% Track
    run("modifyScript.m");
    run("trajectoryScript.m");