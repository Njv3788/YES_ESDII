clear
clc

s1t= readmatrix('../flightPaths/serve1.dat');
s1 = readmatrix('../trajectories/serve1.dat');

f = 20.78461;
b = 4000;
ps = .04785;
c = [752/2,480/2,752/2,480/2];
[X,Y,Z] = centriods2xyz(s1t,c,b,f,ps);

X = -X/1000;
Y = -Y/1000;
Z = -((Z)/1000-20);

figure(1)
hold on
grid on
plot(s1(:,2))
plot(Z)
hold off

figure(2)
hold on 
plot(s1(:,3))
plot(X)
hold off

figure(3)
hold on
plot(s1(:,1))
plot(Y)
grid on
hold off
