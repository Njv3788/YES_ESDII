classdef cameraModual
    %CAMERA_MODUAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
         type = "unInit";
         capture;
    end
    
    methods
        function obj = cameraModual(camera)
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
        end
        
        function type = getType(obj)
            type = obj.type;
        end
        
        function [leftImage,rightImage] = captureImage(obj,varargin)
        % Use the objects capture to capture a image
        % Each the type of camera have different pose requirement 
            switch(obj.type)
                case "Unity"
                    [leftImage,rightImage] = obj.capture(varargin{1},varargin{2});
                case "Test"
                    [leftImage,rightImage] = obj.capture(varargin{1},varargin{2});
                otherwise
                    fprintf("ERROR : UNRECONIZED CAMERA");
            end
        end 
    end
end

