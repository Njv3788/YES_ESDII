 function [leftImage,rightImage] = unityCamera(client,pose)
    leftImage = client.runLink(pose(1,:),1);
    rightImage = client.runLink(pose(2,:),2);
end

