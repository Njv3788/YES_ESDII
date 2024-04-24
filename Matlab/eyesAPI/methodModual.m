classdef methodModual
    %METHOD_MODUAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        method;
        type = "unInit";
    end
    
    methods (Access = public)
        function obj = methodModual(method)
            switch(method)
                case "MATLAB"
                    obj.method =  @(L,R,S,C) MATLABmethod(L,R,S,C);
                    obj.type = "MATLAB";
                case "Zynq"
                    obj.type = "Zynq";
                case "OpenCV"
                    obj.type = "OpenCV";
                otherwise
                    fprintf("ERROR : UNRECONIZED METHOD");
            end
        end

        function type = getType(obj)
            type = obj.type;
        end

        function calibrate(obj,leftImage,rightImage)
            switch(obj.type)
                case "MATLAB"
                    obj.method(leftImage,rightImage,[-2,-2],1);
                case "Zynq"
                case "OpenCV"
                otherwise
                    fprintf("ERROR : UNINIT\n");
            end
        end
        
        function centriod = track(obj,leftImage,rightImage)
            switch(obj.type)
                case "MATLAB"
                    centriod = obj.method(leftImage,rightImage,[-2,-2],0);
                case "Zynq"
                case "OpenCV"
                otherwise
                    fprintf("ERROR : UNINIT\n");
            end
        end
    end

    methods(Access = private)

    end
end

