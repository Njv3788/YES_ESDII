classdef Eyes_testModulal
    %  EYES_TESTMODULAL 

    properties(Access = public)
        file = "intial.dat";
        path = "trajectories/";
        tractory; camera; method;
    end

    methods(Access = public)
        function  obj = Eyes_testModulal(method,camera)
           obj.camera = cameraModual(camera);
           obj.method = methodModual(method);
           obj.tractory = readTrajectory(obj,obj.file,obj.path);
        end

        function obj = setFile(obj,file)
            obj.file = file;
            obj.tractory = readTrajectory(obj,obj.file,obj.path);
        end 
        
        function obj = setPath(obj,path)
            obj.path = path;
            obj.tractory = readTrajectory(obj,obj.file,obj.path);
        end 
     
        function [path,file] = getFilePath(obj)
            path = obj.path;
            file = obj.file;
        end
    end

    methods(Access = private)
        function trajectory = readTrajectory(~,file,path)
            try
                trajectory = importdata(path+file);
            catch
                fprintf("ERROR: PROBLEM OCCURED RUNNING readTrajectory \n")
                trajectory = [0,0,0];
            end
        end
    end
end

