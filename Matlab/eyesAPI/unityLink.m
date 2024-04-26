function image = unityLink(TCP_Handle,pose,selection)
    % x,y,z,yaw[z],pitch[y],roll[x]
    
    width  = 752;
    height = 480;
    
    if(size(TCP_Handle,1) == 0)
       image = 0;
       return;
    end  %Set Position
    write(TCP_Handle,single([width,height,pose,selection]));
    
    %Get image data
    data = read(TCP_Handle,width*height*3);
    
    temp = reshape(data,[3,width*height]);
    image = imrotate(reshape(temp',[width,height,3]),90);
end