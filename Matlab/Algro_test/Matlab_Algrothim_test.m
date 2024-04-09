% Load test images
ball_1 = imread("testImage_ball_1.jpg");
ball_0 = imread("testImage_ball_0.jpg");
ball_n = imread("testImage_ball_n.jpg");

figure
% Convert to Grey 
ball_0 = rgb2gray(ball_0);
ball_1 = rgb2gray(ball_1);
ball_n = rgb2gray(ball_n);

% show the images
subplot(3,3,1);imshow(ball_n);
subplot(3,3,2);imshow(ball_0);
subplot(3,3,3);imshow(ball_1);

% find the sums
x_n = sum(ball_n,1);y_n = sum(ball_n,2);
x_0 = sum(ball_0,1);y_0 = sum(ball_0,2);
x_1 = sum(ball_1,1);y_1 = sum(ball_1,2);

% plot the graphs 
subplot(3,2,3);plot(x_n-x_0);
subplot(3,2,4);plot(y_n-y_0);
subplot(3,2,5);plot(x_0-x_1);
subplot(3,2,6);plot(y_0-y_1);