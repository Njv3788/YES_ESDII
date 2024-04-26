classdef eyesAPI
    %  EYES_API

    properties(Access = public)
        camera; 
        method;
    end

    methods(Access = public)
        function  obj = eyesAPI(method,camera,mArg,cArg)
            obj.camera = cameraModual(camera,cArg);
            obj.method = methodModual(method,mArg);
        end

        function calibrate(obj,varargin)
            [leftImage,rightImage] = obj.camera.captureImage(varargin{:});
            if(6 ~= obj.imageLoad(leftImage,rightImage))
                fprintf('ERROR : Image not captured properly\n');
                return;
            end
            obj.method.calibrate(leftImage,rightImage);
        end

        function [center,leftImage,rightImage] = track(obj,varargin)
            [leftImage,rightImage] = obj.camera.captureImage(varargin{:});
            if(6 ~= obj.imageLoad(leftImage,rightImage))
                fprintf('ERROR : Image not captured properly\n');
                center = nan;
                return;
            end
            center = obj.method.track(leftImage,rightImage);
        end

        function obj = manageServer(obj,type,operation,varargin)
            switch(type)
                case 'camera'
                    obj.camera = obj.camera.manageServer(operation,varargin{:});
                case 'method'
                    obj.camera = obj.camera.manageServer(operation,varargin{:});
                otherwise
                    fprintf("Unreconized type\n");
                    return;
            end    
        end 
    end

    methods(Access = private)
        function loaded = imageLoad(~,leftImage,rightImage)
            loaded = size(leftImage,3) + size(rightImage,3);
        end 
    end
end

