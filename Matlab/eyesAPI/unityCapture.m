function [leftImage,rightImage] = unityCapture(pose,client)
    leftImage = unityLink(client,pose);
    rightImage = leftImage;
end

