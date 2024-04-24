function [leftImage,rightImage] = testCapture(leftFile,rigthFile)
    leftImage = imread(leftFile);
    rightImage = imread(rigthFile);
end

