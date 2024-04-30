clear
clc

s1_4k = readmatrix('../4kPaths/serve1.dat');
s1 = readmatrix('../trajectories/serve1.dat');

f = 20.78461;
b = .2;
ps = .05;
c = [3840/2,2160/2,3840/2,2160/2];
[X,Y,Z] = centriods2xyz(s1_4k,c,b,f,ps);


figure(1)
hold on
grid on
scatter3(s1(:,1),s1(:,2),s1(:,3))
scatter3(X,Z,Y)
hold off