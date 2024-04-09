%Load test images
ball   = imread("testImage_ball.jpg");
ball_n = imread("testImage_ball.jpg");

figure
%show the images
subplot(2,2,1);imshow(ball);
subplot(2,2,2);imshow(ball_n);

%Convert to Grey 
ball   = rgb2gray(ball);
ball_n = rgb2gray(ball_n);

%show the images
subplot(2,2,1);imshow(ball);
subplot(2,2,2);imshow(ball_n);

figure
%show the images
subplot(2,2,3);imshow(ball);
subplot(2,2,4);imshow(ball_n);
