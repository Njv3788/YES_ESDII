classdef Eyes_APIModulal
    %  EYES_TESTMODULAL 

    properties(Access = public)
        camera; 
        method;
    end

    methods(Access = public)
        function  obj = Eyes_APIModulal(method,camera)
           obj.camera = cameraModual(camera);
           obj.method = methodModual(method);
        end

        function calibrate(obj,file)
            
            switch(obj.camera.getType())
                case "Test"
                    RGBimage = obj.camera.captureImage(file);
                otherwise
                    return; 
            end 
            
            switch(obj.method.getType())
                case "MATLAB"
                    obj.method.calibrate(RGBimage,RGBimage);
                otherwise
                    return;
            end
        end

        function [center,leftImage,rightImage] = Track(obj,pose)
            switch(obj.camera.getType())
                case "Test"
                    [leftImage,rightImage] = obj.camera.captureImage(pose);
                    center = obj.method.track(leftImage,rightImage);
                otherwise
                    return; 
            end 
        end
    end
end

