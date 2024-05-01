classdef tcpModual
    %TCPMODUAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
        client;
        link;
    end
    
    methods
        function obj = tcpModual(link)
            if (0 == isa(link,'function_handle'))
                msgID = 'tcpModual:fail';
                msgtxr = 'link must be a function handle';
                ME = MException(msgID, msgtxr);
                throw(ME)
            end 
            obj.link = link;
        end
        
        function obj = startServer(obj,ipAddress,ipPort)
            try
                obj.client = tcpclient(ipAddress,ipPort);
            catch
                fprintf("ERROR : Unable to connect %d\n",ipPort);
                delete(obj.client);
            end
        end

        function obj = stopServer(obj)
            delete(obj.client);
        end
        
        function revData= runLink(obj,varargin)
             revData = obj.link(obj.client,varargin{:});
        end
    end
end

