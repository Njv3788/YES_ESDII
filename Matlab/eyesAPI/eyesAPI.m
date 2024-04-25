classdef eyesAPI
    %  EYES_API

    properties(Access = public)
        camera; 
        method;
        unityClient;
    end

    methods(Access = public)
        function  obj = eyesAPI(method,camera)
            obj.camera = cameraModual(camera);
            obj.method = methodModual(method);
            obj.unityClient = tcpModual(camera);
        end

        function calibrate(obj,varargin)
            [leftImage,rightImage] = obj.capture(varargin{:});
            if(6 ~= obj.imageLoad(leftImage,rightImage))
                fprintf('ERROR : Image not captured properly\n');
                return;
            end
            obj.method.calibrate(leftImage,rightImage);
        end

        function [center,leftImage,rightImage] = track(obj,varargin)
            [leftImage,rightImage] = obj.capture(varargin{:});
            if(6 ~= obj.imageLoad(leftImage,rightImage))
                fprintf('ERROR : Image not captured properly\n');
                center = nan;
                return;
            end
            center = obj.method.track(leftImage,rightImage);
        end

        function obj = manageClient(obj,type,operation,varargin)
            switch(type)
                case "Unity"
                    switch (operation)
                        case "Start"
                            obj.unityClient = obj.unityClient.startServer(varargin{:});
                        case "Stop"
                            obj.unityClient = obj.unityClient.stopServer();
                        case "runLink"
                            obj.unityClient.runLink(varargin{:});
                    end
                case "Zynq"
                otherwise
                    fprintf("Unreconized type\n");
                    return;
            end    
        end 
    end

    methods(Access = private)
        function [left,right] = capture(obj,varargin)
             switch(obj.camera.getType)
                case "Test"
                    [left,right] = obj.camera.captureImage(varargin{:});
                case"Unity"
                    [left,right] = obj.camera.captureImage(obj.unityClient,varargin{:});
            end
        end
        function loaded = imageLoad(~,leftImage,rightImage)
            loaded = size(leftImage,3) + size(rightImage,3);
        end 
    end
end

