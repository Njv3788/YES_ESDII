classdef methodModual
    %METHOD_MODUAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        method;
        type = "UnInit";
    end
    
    methods (Access = public)
        function obj = methodModual(method)
             try
                 switch(method)
                     case "MATLAB"
                         obj.method =  @(I,S,C) MATLABmethod(I,S,C);
                         obj.type = "MATLAB";
                     case "Zynq"
                         obj.type = "Zynq";
                     case "OpenCV"
                         obj.type = "OpenCV";
                     otherwise
                         fprintf("ERROR : UNRECONIZED METHOD");
                 end
             catch 
                 fprintf("ERROR PROBLEM OCCURED RUNNING methodModual\n")
             end
        end

        function type = getType(obj)
            type = obj.type;
        end

        function calibrate(obj,image)
            switch(obj.type)
                case "MATLAB"
                    obj.method(image,1024,1);
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

