classdef tcpModual
    %TCPMODUAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
        client;
        link;
        type;
    end
    
    methods
        function obj = tcpModual(client)
            switch(client)
                case "Unity"
                    obj.link = @(C,P) unityLink(C,P);
                    obj.type = "Unity";
                otherwise 
            end
        end
        
        function obj = startServer(obj,ipAddress,ipPort)
            try
                obj.client = tcpclient(ipAddress,ipPort);
            catch
                fprintf("ERROR : Unable to connect\n");
                delete(obj.client);
            end
        end

        function obj = stopServer(obj)
            delete(obj.client);
        end
        
        function varargout = runLink(obj,varagin)
            switch(obj.type)
                case "Unity"
                    pose = varagin;
                    varargout{1} = obj.link(obj.client,pose);
                otherwise 
            end
        end
    end
end

