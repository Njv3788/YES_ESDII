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
           obj.unityClient = tcpModual("Unity");
        end

        function calibrate(obj,varargin)
           [leftImage,rightImage] = obj.camera.captureImage(varargin{:});
           obj.method.calibrate(leftImage,rightImage);
        end

        function [center,leftImage,rightImage] = Track(obj,varargin)
            [leftImage,rightImage] = obj.camera.captureImage(varargin{:});
            center = obj.method.track(leftImage,rightImage);
        end

        function obj = manageClient(obj,type,operation,varargin)
            switch(type)
                case "Unity"
                    switch (operation)
                        case "Start"
                            obj.unityClient.startServer(varargin{:});
                        case "Stop"
                            obj.unityClient.stopServer();
                        case "runLink"
                            obj.unityClient.runLink();
                    end
                case "Zynq"
                otherwise
                    fprintf("Unreconized type\n");
                    return;
            end 

            
        end 
    end
end

