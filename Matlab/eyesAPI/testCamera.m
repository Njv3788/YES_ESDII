function [leftImage,rightImage] = testCamera(~,leftFile,rigthFile)
    leftImage = imread(leftFile);
    rightImage = imread(rigthFile);
end

