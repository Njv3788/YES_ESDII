%% Clear
    clc
    clear
%% Declarations
    idx = 1; size_t = 1024; shift = [-2,-2]; numImages = 5;
    dim = [573 814]; type = "uint32";
    centriod = zeros(2,numImages);
%% Main Algorithm 
    while(idx <= numImages)
        % Algorithm API Should not change
        [centriod(:,idx),testImageRGB] = Algorithm(loadImage(idx),size_t,shift,type,idx == 1);
        % Test Algorithm
        if(idx >1) 
            showCentriod (centriod(:,idx),testImageRGB,1);
        end
        idx = idx + 1;
    end

%% Function for the Algorithm
    function [centriod,testImageRGB] = Algorithm(testImageRGB,size_t,shift,type,calibrate)
        persistent Initial_normalized;
       
        testImageGray = rgb2gray(testImageRGB);
        character = findCharacter(testImageGray,size_t,type);
        normalized = int32(normalize(character,size_t,shift,type));
        
        if(calibrate == 1)
            Initial_normalized = normalized;
            centriod = [0,0];
        else
            differential_normalize = abs(Initial_normalized - normalized);
            centriod = int16(locate(differential_normalize));
        end
    end
%% function to Show Centriod 
    function showCentriod (centriod, testImageRGB,fig_num) 
        figure(fig_num);
        hold on;
        imshow(testImageRGB);
        viscircles(centriod', 3,'EdgeColor','b');
        hold off;
    end
 %% Function for retriving Images
    function testImageRGB = loadImage(idx)
        folder = "testImages/testImage_";
        file = ["ball_n";"ball_0";"ball_1";"ball_2";"ball_3"];
        testImageRGB = imread(folder+file(idx)+".jpg");
    end

%% Function to Find Characteristic
    function character = findCharacter(testImageGray,size_t,type)
        testImageGrayU32 = int32(testImageGray);
        character = zeros(2,size_t,type);
        x = sum(testImageGrayU32,1,"native");
        y = sum(testImageGrayU32,2,"native")';
        character(1,:) = padarray(x,[0,size_t-size(x,2)],0,"post");
        character(2,:) = padarray(y,[0,size_t-size(y,2)],0,"post");
    end
%% Function to Nomarlize Characteristic
    function normalized = normalize(character,size_t,shift,type)
        normalized = zeros(2,size_t,type);
        if(type == "double")
            normalized (1,:) = character(1,:)/(2^shift(1));
            normalized (2,:) = character(2,:)/(2^shift(2));
        else
            normalized (1,:) = bitshift(character(1,:),shift(1));
            normalized (2,:) = bitshift(character(2,:),shift(2));
        end

    end
%% Locate Function
    function location = locate(array)
        [~,location] = max(array,[],2); 
    end
%% Function Plot Characteristics
    function plot_char(array,fig_num)
        figure(fig_num);
        switch(size(array,1))
            case 1
                plot(array); grid on;
            case 2
                subplot(2,1,1); plot(array(1,:)); grid on;
                subplot(2,1,2); plot(array(2,:)); grid on;
            case 4
                subplot(2,2,1); plot(array(1,:)); grid on;
                subplot(2,2,2); plot(array(3,:)); grid on;
                subplot(2,2,3); plot(array(2,:)); grid on;
                subplot(2,2,4); plot(array(4,:)); grid on;
        end
    end