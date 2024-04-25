classdef cameraModual
    %CAMERA_MODUAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
         capture;
         arg;
    end
    
    methods
        function obj = cameraModual(camera,arg)
            if (0 == isa(camera,'function_handle'))
                msgID = 'tcpModual:Fail';
                msgtxr = 'link must be a function handle';
                ME = MException(msgID, msgtxr);
                throw(ME)
            end 
            
            obj.capture = camera;
            if(0 ~= isa(arg,'function_handle'))
                obj.arg = tcpModual(arg);
            else
                obj.arg = arg;
            end
        end
        
        function [leftImage,rightImage] = captureImage(obj,varargin)
            [leftImage,rightImage] = obj.capture(obj.arg,varargin{:});
        end

        function [obj,output]= manageServer(obj,operation,varargin)
            if( 0 == isa(obj.arg,'tcpModual'))
                fprintf("Camera has no server to manage\n")
                output = 0;
                return;
            end
            
            switch (operation)
                case "Start"
                    obj.arg = obj.arg.startServer(varargin{:});
                    output = 0;
                case "Stop"
                    obj.arg = obj.arg.stopServer();
                    output = 0;
                case "runLink"
                    output = obj.arg.runLink(varargin{:});
                    
            end
        end
    end
end

