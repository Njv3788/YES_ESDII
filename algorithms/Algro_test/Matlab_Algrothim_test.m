%% Clear
    clc
    clear
%% Load test images
    ball_n = imread("testImage_ball_n.jpg");
    ball_0 = imread("testImage_ball_0.jpg");
    ball_1 = imread("testImage_ball_1.jpg");
    ball_2 = imread("testImage_ball_2.jpg");
    ball_3 = imread("testImage_ball_3.jpg");
%% Convert RGB to Grey 
    ball_n = rgb2gray(ball_n);
    ball_0 = rgb2gray(ball_0);
    ball_1 = rgb2gray(ball_1);
    ball_2 = rgb2gray(ball_2);
    ball_3 = rgb2gray(ball_3);    
%% Show the images
    % figure;imshow(ball_n);
    % figure;imshow(ball_0);
    % figure;imshow(ball_1);
    % figure;imshow(ball_2);
    % figure;imshow(ball_3);
%% Find the sums
    x_s = [sum(ball_n,1) ;
           sum(ball_0,1) ;
           sum(ball_1,1) ;
           sum(ball_2,1) ;
           sum(ball_3,1)];
    y_s = [sum(ball_n,2)';
           sum(ball_0,2)';
           sum(ball_1,2)';
           sum(ball_2,2)';
           sum(ball_3,2)'];
%% Plot the graphs 
    % figure name 'Sums before filtering';
    % subplot(5,2,1) ;plot(x_s(1,:)/256);
    % subplot(5,2,2) ;plot(y_s(1,:)/256);
    % subplot(5,2,3) ;plot(x_s(2,:)/256);
    % subplot(5,2,4) ;plot(y_s(2,:)/256);
    % subplot(5,2,5) ;plot(x_s(3,:)/256);
    % subplot(5,2,6) ;plot(y_s(3,:)/256);
    % subplot(5,2,7) ;plot(x_s(4,:)/256);
    % subplot(5,2,8) ;plot(y_s(4,:)/256);
    % subplot(5,2,9) ;plot(x_s(5,:)/256);
    % subplot(5,2,10);plot(y_s(5,:)/256);
%% Preform the FFT on the SUM 
    xfft = fft(x_s,1024,2);
    yfft = fft(y_s,1024,2);
%% Make filter
    % Define parameters
    fc = 0.0001; % Cutoff frequency (normalized to Nyquist frequency)
    N = 255; % Filter length (odd for symmetric sinc)
    high = zeros(1,N);
    high((N-1)/2+1) = 1;
    % Create sinc filter
    n = -(N-1)/2 : (N-1)/2;
    h = sinc(2 * fc * n); % Sinc filter formula
    % Normalize filter
    h = h / sum(h); % Normalize the filter to have unit gain
    h = h-high;
    w = window(@bartlett,N)';
    h = h.*w;
    % Plot The filter
    % figure;plot(h);
    hfft = fft(h,1024);
    % figure;plot(20*log10(abs(hfft)));
%% Apply Filter
    xfft_h = xfft.*hfft;
    yfft_h = yfft.*hfft;
%% IFFT the filtered SUM
    x_i = ifft(xfft_h,1024,2);
    y_i = ifft(yfft_h,1024,2);
%% Plot IFFT
    % figure name 'Sums after filtering';
    % subplot(5,2,1) ;plot(abs(x_i(1,:))/256);
    % subplot(5,2,2) ;plot(abs(y_i(1,:))/256);
    % subplot(5,2,3) ;plot(abs(x_i(2,:))/256);
    % subplot(5,2,4) ;plot(abs(y_i(2,:))/256);
    % subplot(5,2,5) ;plot(abs(x_i(3,:))/256);
    % subplot(5,2,6) ;plot(abs(y_i(3,:))/256);
    % subplot(5,2,7) ;plot(abs(x_i(4,:))/256);
    % subplot(5,2,8) ;plot(abs(y_i(4,:))/256);
    % subplot(5,2,9) ;plot(abs(x_i(5,:))/256);
    % subplot(5,2,10);plot(abs(y_i(5,:))/256);
%% Find Differences before Filtering
    x_sd = zeros(4,814);
    x_sd(1,:)= x_s(2,:)-x_s(1,:);  % 0 - n
    x_sd(2,:)= x_s(3,:)-x_s(1,:);  % 1 - n
    x_sd(3,:)= x_s(4,:)-x_s(1,:);  % 2 - n
    x_sd(4,:)= x_s(5,:)-x_s(1,:);  % 3 - n
    y_sd = zeros(4,573);
    y_sd(1,:)= y_s(2,:)-y_s(1,:);  % 0 - n
    y_sd(2,:)= y_s(3,:)-y_s(1,:);  % 2 - n
    y_sd(3,:)= y_s(4,:)-y_s(1,:);  % 3 - n
    y_sd(4,:)= y_s(5,:)-y_s(1,:);  % 4 - n
%% Plot Difference 
    % figure name 'Differences before filtering';
    % subplot(4,2,1);plot(x_sd(1,:)/256);
    % subplot(4,2,2);plot(y_sd(1,:)/256);
    % subplot(4,2,3);plot(x_sd(2,:)/256);
    % subplot(4,2,4);plot(y_sd(2,:)/256);
    % subplot(4,2,5);plot(x_sd(3,:)/256);
    % subplot(4,2,6);plot(y_sd(3,:)/256);
    % subplot(4,2,7);plot(x_sd(4,:)/256);
    % subplot(4,2,8);plot(y_sd(4,:)/256);
%% Find Differences afer Filtering
    x_id = zeros(4,1024);
    x_id(1,:)= x_i(2,:)-x_i(1,:);  % 0 - n
    x_id(2,:)= x_i(3,:)-x_i(1,:);  % 1 - n
    x_id(3,:)= x_i(4,:)-x_i(1,:);  % 2 - n
    x_id(4,:)= x_i(5,:)-x_i(1,:);  % 3 - n
    y_id = zeros(4,1024);
    y_id(1,:)= y_i(2,:)-y_i(1,:);  % 0 - n
    y_id(2,:)= y_i(3,:)-y_i(1,:);  % 2 - n
    y_id(3,:)= y_i(4,:)-y_i(1,:);  % 3 - n
    y_id(4,:)= y_i(5,:)-y_i(1,:);  % 4 - n
%% Plot Differencei
    figure name 'Differences after filtering';
   
    subplot(4,2,1);plot(abs(x_id(1,:))/128); grid on;
    subplot(4,2,2);plot(abs(y_id(1,:))/128); grid on;
    subplot(4,2,3);plot(abs(x_id(2,:))/128); grid on;
    subplot(4,2,4);plot(abs(y_id(2,:))/128); grid on;
    subplot(4,2,5);plot(abs(x_id(3,:))/128); grid on;
    subplot(4,2,6);plot(abs(y_id(3,:))/128); grid on;
    subplot(4,2,7);plot(abs(x_id(4,:))/128); grid on;
    subplot(4,2,8);plot(abs(y_id(4,:))/128); grid on;