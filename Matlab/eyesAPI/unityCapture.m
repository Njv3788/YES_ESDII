function [leftImage,rightImage] = unityCapture(pose,client)
    leftImage = client.runLink(pose);
    rightImage = leftImage;
end

