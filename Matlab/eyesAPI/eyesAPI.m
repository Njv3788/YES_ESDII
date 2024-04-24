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

        function calibrate(obj,vargin)
           [leftImage,rightImage] = obj.camera.captureImage(vargin);
           obj.method.calibrate(leftImage,rightImage);
        end

        function [center,leftImage,rightImage] = Track(obj,varagin)
            [leftImage,rightImage] = obj.camera.captureImage(varagin);
            center = obj.method.track(leftImage,rightImage);
        end
    end
end

