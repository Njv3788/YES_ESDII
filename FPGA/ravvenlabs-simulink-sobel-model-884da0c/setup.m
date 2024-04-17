% Dr. Kaputa
% Sobel Demo Setup File
R = 752; 
C = 480;
coefficients = [1 0 -1; 
                2 0 -2;
                1 0 -1];
testImage = zeros(480,752,3);
testImage(100,:,:) = 200;
testImage = uint8(testImage);

