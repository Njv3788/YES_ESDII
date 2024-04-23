classdef cameraModual
    %CAMERA_MODUAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
         type = "unInit";
         capture;
    end
    
    methods
        function obj = cameraModual(camera)
             try
                 switch(camera)
                     case "Unity"
                         obj.type = "Unity";
                     case "Test"
                         obj.type = "Test";
                         obj.capture = @(pose)testCapture(pose);
                     otherwise
                         fprintf("ERROR : UNRECONIZED CAMERA");
                 end
             catch
                 fprintf("ERROR PROBLEM OCCURED RUNNING cameraModual\n")
             end
        end
        
        function type = getType(obj)
            type = obj.type;
        end
        
        function [leftImage,rightImage] = captureImage(obj,pose)
        % Use the objects capture to capture a image
        % Each the type of camera have different pose requirement 
        % Type = test  pose = [index (1:4)]
            switch(obj.type)
                case "Unity"
                case "Test"
                    [leftImage,rightImage] = obj.capture(pose);
                otherwise
                    fprintf("ERROR : UNRECONIZED CAMERA");
            end
        end 
    end
end

