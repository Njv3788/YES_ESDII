function [center] = zynqMethod(calibrate,leftImageRGB,rightImageRGB,client)
  
    width  = 814;
    height = 573;

    leftImageRGB = uint8(leftImageRGB);
    rightImageRGB = uint8(rightImageRGB);
    leftImageGray = im2gray(leftImageRGB);
    rightImageGray = im2gray(rightImageRGB);
    
    imageStack = uint8(ones(height,width,8));
    imageStack(:,:,1:3) = leftImageRGB;
    imageStack(:,:,5:7) = rightImageRGB;
    imageStack(:,:,4) = leftImageGray;
    imageStack(:,:,4) = rightImageGray;
    imageStack = permute(imageStack,[3 2 1]);
    
    idx = client.runLink(calibrate,imageStack);  
    if(size(idx) == 1)
        center = idx;
        return;
    end
    center = idx;           
end

