classdef cameraModual
    %CAMERA_MODUAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
         
    end
    
    methods
        function obj = cameraModual(camera)
             try
                 switch(camera)
                     case "Unity"
                     otherwise
                         error("ERROR : UNRECONIZED CAMERA");
                 end
             catch
                 fprintf("ERROR PROBLEM OCCURED RUNNING cameraModual\n")
             end
        end
        
    end
end

