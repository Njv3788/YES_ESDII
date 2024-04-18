%% Clear
    clc
    clear
%% Load Images
    testRGB_n = imread("testImages/testImage_ball_n.jpg");
    testRGB_0 = imread("testImages/testImage_ball_0.jpg");
%% Conversions
    % To grayscale
    testG_n  = rgb2gray(testRGB_n);
    testG_0  = rgb2gray(testRGB_0);
    % To uint32
    testU32_n = uint32(testG_n);
    testU32_0 = uint32(testG_0);
%% Preform Sumations
    x_su32 = padarray([sum(testU32_n,1,"native") ;sum(testU32_0,1,"native") ], ...
                      [0,1024-size(testU32_n,2)],0,"post");
    y_su32 = padarray([sum(testU32_n,2,"native")';sum(testU32_0,2,"native")'], ...
                      [0,1024-size(testU32_n,1)],0,"post");
    su32 = [x_su32;y_su32];

    du32 = sub_com(su32);
    plot_com(du32);
    centroid = locate(du32);
%% Plot Function
function plot_com(array)
    figure;
    
    switch(size(array,1))
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
%% Differnce Function 
function array_out = sub_com(array_in)
    array_size = size(array_in);
    array_out = zeros(array_size./[2,1]);
    switch(array_size(1))
        case 4
            array_out(1,:) = array_in(1,:) - array_in(2,:);
            array_out(2,:) = array_in(3,:) - array_in(4,:);
    end     
end
%% Locate Function
function location = locate(array)
    [~,location] = max(array,[],2); 
end

