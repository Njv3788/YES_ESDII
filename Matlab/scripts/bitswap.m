s1ns = readmatrix('../flightPaths/serve1.dat');
s2ns = readmatrix('../flightPaths/serve2.dat');
s3ns = readmatrix('../flightPaths/serve3.dat');
s4ns = readmatrix('../flightPaths/serve4.dat');
s5ns = readmatrix('../flightPaths/serve5.dat');
s1s = readmatrix('../4kPaths/serve1.dat');
s2s = readmatrix('../4kPaths/serve2.dat');
s3s = readmatrix('../4kPaths/serve3.dat');
s4s = readmatrix('../4kPaths/serve4.dat');
s5s = readmatrix('../4kPaths/serve5.dat');

plotOutputs(s1ns,s1s,1);
plotOutputs(s2ns,s2s,2);
plotOutputs(s3ns,s3s,3);
plotOutputs(s4ns,s4s,4);
plotOutputs(s5ns,s5s,5);

function plotOutputs(notswapped,byteswapped,fignum)
    figure(fignum)
    subplot(2,2,1);
    hold on;plot(notswapped(:,1));
    plot(byteswapped(:,1));hold off;
    subplot(2,2,2);
    hold on;plot(notswapped(:,2));
    plot(byteswapped(:,2));hold off;
    subplot(2,2,3);
    hold on;plot(notswapped(:,3));
    plot(byteswapped(:,3));hold off;
    subplot(2,2,4);
    hold on;plot(notswapped(:,4));
    plot(byteswapped(:,4));hold off;
end