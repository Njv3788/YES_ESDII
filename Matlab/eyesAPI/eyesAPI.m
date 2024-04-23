classdef eyesAPI
    %  EYES_API

    properties(Access = public)
        camera; 
        method;
    end

    methods(Access = public)
        function  obj = eyesAPI(method,camera)
           obj.camera = cameraModual(camera);
           obj.method = methodModual(method);
        end

        function calibrate(obj,file)
            
            switch(obj.camera.getType())
                case "Test"
                    [leftImage,rightImage] = obj.camera.captureImage(file);
                otherwise
                    return; 
            end 
            
            switch(obj.method.getType())
                case "MATLAB"
                    obj.method.calibrate(leftImage,rightImage);
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

