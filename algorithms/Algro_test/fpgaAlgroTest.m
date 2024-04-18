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
%% Preform Sumations & bit shift
    x_sG = [sum(testG_n,1,"double") ;sum(testG_0,1,"double") ]; 
    y_sG = [sum(testG_n,2,"double")';sum(testG_0,2,"double")']; 
    x_su32 = [sum(testU32_n,1,"native") ;sum(testU32_0,1,"native") ];  
    y_su32 = [sum(testU32_n,2,"native")';sum(testU32_0,2,"native")'];
    x_su16 = uint16(bitshift(x_su32,-2));
    y_su16 = uint16(bitshift(y_su32,-2));
    x_su8 =  uint8(bitshift(x_su16,-8));
    y_su8 =  uint8(bitshift(y_su16,-8));
%% Pad the Sumations
    x_psG = padarray(x_sG,[0,1024-size(testG_n,2)],0,"post");
    y_psG = padarray(y_sG,[0,1024-size(testG_n,1)],0,"post");
    x_psu32 = padarray(x_su32,[0,1024-size(testU32_n,2)],0,"post");
    y_psu32 = padarray(y_su32,[0,1024-size(testU32_n,1)],0,"post");
    x_psu16 = padarray(x_su16,[0,1024-size(testU32_n,2)],0,"post");
    y_psu16 = padarray(y_su16,[0,1024-size(testU32_n,1)],0,"post");
    x_psu8 = padarray(x_su8,[0,1024-size(testU32_n,2)],0,"post");
    y_psu8 = padarray(y_su8,[0,1024-size(testU32_n,1)],0,"post");
%% Catenate for Math
    sG = [x_psG;y_psG];
    su32 = [x_psu32;y_psu32];
    su16 = [x_psu16;y_psu16];
    su8 = [x_psu8;y_psu8];
%% Preform Subtraction
    dG = sub_com(sG);
    du32 = sub_com(su32);
    du16 = sub_com(su16);
    du8 = sub_com(su8);
%% Plot the differences
    plot_com(dG);
    plot_com(du32);
    plot_com(du16);
    plot_com(du8);
%% Locate Centroids
    centroid_d = locate(dG);
    centroid_u32 = locate(du32);
    centroid_u16 = locate(du16);
    centroid_u8 = locate(du8);
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
    array_out = zeros(array_size./[2,1],class(array_in));
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

