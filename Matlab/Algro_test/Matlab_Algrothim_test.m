%% Clear
    clc
    clear
%% Load test images
    ball_1 = imread("testImage_ball_1.jpg");
    ball_0 = imread("testImage_ball_0.jpg");
    ball_n = imread("testImage_ball_n.jpg");
%% Convert RGB to Grey 
    ball_0 = rgb2gray(ball_0);
    ball_1 = rgb2gray(ball_1);
    ball_n = rgb2gray(ball_n);
%% Show the images
    % figure;imshow(ball_n);
    % figure;imshow(ball_0);
    % figure;imshow(ball_1);
%% Find the sums
    x_s = [sum(ball_n,1) ;sum(ball_0,1) ;sum(ball_1,1)];
    y_s = [sum(ball_n,2)';sum(ball_0,2)';sum(ball_1,2)'];
%% Plot the graphs 
    figure name 'Sums before filtering';
    subplot(3,2,1);plot(x_s(1,:)/256);
    subplot(3,2,2);plot(y_s(1,:)/256);
    subplot(3,2,3);plot(x_s(2,:)/256);
    subplot(3,2,4);plot(y_s(2,:)/256);
    subplot(3,2,5);plot(x_s(3,:)/256);
    subplot(3,2,6);plot(y_s(3,:)/256);
%% Preform the FFT on the SUM 
    xfft = fftshift(fft(x_s,1024,2));
    yfft = fftshift(fft(y_s,1024,2));
%% Plot FFT of SUMS
    % figure;
    % subplot(3,2,1);plot(20*log10(abs(xfft(1,:))));
    % subplot(3,2,2);plot(20*log10(abs(yfft(1,:))));
    % subplot(3,2,3);plot(20*log10(abs(xfft(2,:))));
    % subplot(3,2,4);plot(20*log10(abs(yfft(2,:))));
    % subplot(3,2,5);plot(20*log10(abs(xfft(3,:))));
    % subplot(3,2,6);plot(20*log10(abs(yfft(3,:))));
%% Make filter
    % Define parameters
    fc = 0.05; % Cutoff frequency (normalized to Nyquist frequency)
    N = 101; % Filter length (odd for symmetric sinc)
    high = zeros(1,101);
    high(51) = 1;
    % Create sinc filter
    n = -(N-1)/2 : (N-1)/2;
    h = sinc(2 * fc * n); % Sinc filter formula
    % Normalize filter
    h = h / sum(h); % Normalize the filter to have unit gain
    h = h-high;
    % Plot The filter
    % figure;plot(h);
    hfft = fftshift(fft(h,1024));
    % figure;plot(20*log10(abs(hfft)));
%% Apply Filter
    xfft_h = xfft.*hfft;
    yfft_h = yfft.*hfft;
%% Plot the graphs 
    %figure
    % subplot(3,2,1);plot(20*log10(abs(xfft_h(1,:))));
    % subplot(3,2,2);plot(20*log10(abs(yfft_h(1,:))));
    % subplot(3,2,3);plot(20*log10(abs(xfft_h(2,:))));
    % subplot(3,2,4);plot(20*log10(abs(yfft_h(2,:))));
    % subplot(3,2,5);plot(20*log10(abs(xfft_h(3,:))));
    % subplot(3,2,6);plot(20*log10(abs(yfft_h(3,:))));
%% IFFT the filtered SUM
    x_i = ifft(xfft_h,1024,2);
    y_i = ifft(yfft_h,1024,2);
%% Plot IFFT
    figure name 'Sums after filtering';
    subplot(3,2,1);plot(abs(x_i(1,:))/256);
    subplot(3,2,2);plot(abs(y_i(1,:))/256);
    subplot(3,2,3);plot(abs(x_i(2,:))/256);
    subplot(3,2,4);plot(abs(y_i(2,:))/256);
    subplot(3,2,5);plot(abs(x_i(3,:))/256);
    subplot(3,2,6);plot(abs(y_i(3,:))/256);
%% Find Differences before Filtering
    x_sd = zeros(4,814);
    x_sd(1,:)= x_s(1,:);           % Just initial image 
    x_sd(2,:)= x_s(2,:)-x_s(1,:);  % 0 - n
    x_sd(3,:)= x_s(3,:)-x_s(2,:);  % 1 - 0
    x_sd(4,:)= x_s(3,:)-x_s(1,:);  % 1 - n
    y_sd = zeros(4,573);
    y_sd(1,:)= y_s(1,:);           % Just initial image 
    y_sd(2,:)= y_s(2,:)-y_s(1,:);  % 0 - n
    y_sd(3,:)= y_s(3,:)-y_s(2,:);  % 1 - 0
    y_sd(4,:)= y_s(3,:)-y_s(1,:);  % 1 - n
%% Plot Difference 
    figure name 'Differences before filtering';
    subplot(4,2,1);plot(x_sd(1,:)/256);
    subplot(4,2,2);plot(y_sd(1,:)/256);
    subplot(4,2,3);plot(x_sd(2,:)/256);
    subplot(4,2,4);plot(y_sd(2,:)/256);
    subplot(4,2,5);plot(x_sd(3,:)/256);
    subplot(4,2,6);plot(y_sd(3,:)/256);
    subplot(4,2,7);plot(x_sd(4,:)/256);
    subplot(4,2,8);plot(y_sd(4,:)/256);
%% Find Differences afer Filtering
    x_id = zeros(4,1024);
    x_id(1,:)= x_i(1,:);           % Just initial image 
    x_id(2,:)= x_i(2,:)-x_i(1,:);  % 0 - n
    x_id(3,:)= x_i(3,:)-x_i(2,:);  % 1 - 0
    x_id(4,:)= x_i(3,:)-x_i(1,:);  % 1 - n
    y_id = zeros(4,1024);
    y_id(1,:)= y_i(1,:);           % Just initial image 
    y_id(2,:)= y_i(2,:)-y_i(1,:);  % 0 - n
    y_id(3,:)= y_i(3,:)-y_i(2,:);  % 1 - 0
    y_id(4,:)= y_i(3,:)-y_i(1,:);  % 1 - n
%% Plot Difference 
    figure name 'Differences after filtering';
    subplot(4,2,1);plot(abs(x_id(1,:))/128);
    subplot(4,2,2);plot(abs(y_id(1,:))/128);
    subplot(4,2,3);plot(abs(x_id(2,:))/128);
    subplot(4,2,4);plot(abs(y_id(2,:))/128);
    subplot(4,2,5);plot(abs(x_id(3,:))/128);
    subplot(4,2,6);plot(abs(y_id(3,:))/128);
    subplot(4,2,7);plot(abs(x_id(4,:))/128);
    subplot(4,2,8);plot(abs(y_id(4,:))/128);