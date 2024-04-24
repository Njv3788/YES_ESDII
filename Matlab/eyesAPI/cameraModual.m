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
                         obj.capture = @(P,C)unityCapture(P,C);
                     case "Test"
                         obj.type = "Test";
                         obj.capture = @(L,R)testCapture(L,R);
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
        
        function [leftImage,rightImage] = captureImage(obj,varagin)
        % Use the objects capture to capture a image
        % Each the type of camera have different pose requirement 
        % Type = test  pose = [index (1:4)]
            switch(obj.type)
                case "Unity"
                case "Test"
                    leftFile = varagin{1};
                    rightFile = varagin{2};
                    [leftImage,rightImage]=obj.capture(leftFile,rightFile);
                otherwise
                    fprintf("ERROR : UNRECONIZED CAMERA");
            end
        end 
    end
end

