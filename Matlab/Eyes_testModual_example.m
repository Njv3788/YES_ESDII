%% clear
    clc
    clear
%% Declarations 
filename = "serve1.dat";
%% Example
test = Eyes_testModulal("MATLAB","Unity");
test = test.setFile(filename);
[path,filename] = test.getFilePath;