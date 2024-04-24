 function [leftImage,rightImage] = unityCapture(client,pose)
    leftImage = client.runLink(pose);
    rightImage = leftImage;
end

