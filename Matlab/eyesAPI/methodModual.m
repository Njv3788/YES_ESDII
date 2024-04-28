classdef methodModual
    %METHOD_MODUAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        method;
        arg
    end
    
    methods (Access = public)
        function obj = methodModual(method,arg)
            if (0 == isa(method,'function_handle'))
                msgID = 'methodModual:fail';
                msgtxr = 'method must be a function handle';
                ME = MException(msgID, msgtxr);
                throw(ME)
            end
            
            obj.method =  method;
            
            if(0 ~= isa(arg,'function_handle'))
                obj.arg = tcpModual(arg);
            else
                obj.arg = arg;
            end
        end

        function calibrate(obj,leftImage,rightImage)
            obj.method(1,leftImage,rightImage,obj.arg);
        end
        
        function centriod = track(obj,leftImage,rightImage)
            centriod = obj.method(0,leftImage,rightImage,obj.arg);
        end

        function [obj,output]= manageServer(obj,operation,varargin)
            if( 0 == isa(obj.arg,'tcpModual'))
                fprintf("Method has no server to manage\n")
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

