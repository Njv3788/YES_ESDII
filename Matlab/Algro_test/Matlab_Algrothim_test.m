ball   = imread("testImage_ball.jpg");
ball_n = imread("testImage_ball_n.jpg");

figure
% show the images
% subplot(2,2,1);imshow(ball);
% subplot(2,2,2);imshow(ball_n);

% Convert to Grey and Show the Image 
ball   = rgb2gray(ball);subplot(2,2,3);imshow(ball);
ball_n = rgb2gray(ball_n);subplot(2,2,4);imshow(ball_n);

% Sum the columns
b_ys = sum(ball,1);b_xs = sum(ball,2);
n_ys = sum(ball_n,1);n_xs = sum(ball_n,2);

% Display sums
subplot(3,2,1);plot(b_ys);
subplot(3,2,2);plot(b_xs);
subplot(3,2,3);plot(n_ys);
subplot(3,2,4);plot(n_xs);
subplot(3,2,5);plot(n_ys-b_ys);
subplot(3,2,6);plot(n_xs-b_xs);