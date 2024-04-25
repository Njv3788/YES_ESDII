 function [leftImage,rightImage] = unityCamera(client,pose)
    leftImage = client.runLink(pose);
    rightImage = leftImage;
end

