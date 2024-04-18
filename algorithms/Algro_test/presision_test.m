%% Clear
    clc
    clear
%% Declarations
    foldername = "testImages/testImage_";
    filename = ["ball_n";"ball_0";"ball_1";"ball_2";"ball_3"];
    idx = 1; size_t = 1024; shift = [-2,-2]; numImages = size(filename,1);
    dim = [753 814];
%% Initialize Algorithm
    Initial_normalized = Algorithm(foldername,filename,idx,size_t,shift);
    idx = idx + 1;
%% Main Algorithm 
    while(idx <=size(filename,1))
        normalized = Algorithm(foldername,filename,idx,size_t,shift);
        differential_normalize =  normalized - Initial_normalized;
        plot_char(differential_normalize);
        Initial_normalized = normalized;
        idx = idx + 1;
    end
%% Function for retriving Images
    function testImageRGB = loadImage(folder,file,idx)
        testImageRGB = imread(folder+file(idx)+".jpg");
    end
%% Function Plot Characteristics
    function plot_char(array)
        figure;
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
%% Function to Find Characteristic
    function character = findCharacter(testImageGray,size_t)
        testImageGrayU32 = uint32(testImageGray);
        character = zeros(2,size_t,"uint32");
        x = sum(testImageGrayU32,1,"native");
        y = sum(testImageGrayU32,2,"native")';
        character(1,:) = padarray(x,[0,size_t-size(x,2)],0,"post");
        character(2,:) = padarray(y,[0,size_t-size(y,2)],0,"post");
    end
%% Function to Nomarlize Characteristic
    function normalized = normalize(character,size_t,shift)
        normalized = zeros(2,size_t,"uint16");
        normalized (1,:) = bitshift(character(1,:),shift(1));
        normalized (2,:) = bitshift(character(2,:),shift(2));
    end 
%% Function for the Algorithm
    function normalized = Algorithm(folder,file,idx,size_t,shift)
        testImageRGB = loadImage(folder,file,idx);
        testImageGray = rgb2gray(testImageRGB);
        character = findCharacter(testImageGray,size_t);
        normalized = normalize(character,size_t,shift);
    end