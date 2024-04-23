function [leftImage,rightImage] = testCapture(file)
    leftImage = imread(file(1));
    rightImage = imread(file(2));
end

