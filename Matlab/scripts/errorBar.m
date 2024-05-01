
figure(1); hold on;grid on;

scatter3(trajectory(:,1),trajectory(:,3),trajectory(:,2));
scatter3(path(:,1),path(:,3),path(:,2));

hold off

figure(2); hold on;

subplot(3,1,1); grid on;
xPercentError = (trajectory(:,1)-path(:,1))./trajectory(:,1);
plot(xPercentError*100);
xlim([0,size(trajectory,1)/4])
ylim([0 100])
subplot(3,1,2); grid on;
yPercentError = (trajectory(:,2)-path(:,2))./trajectory(:,2);
plot(xPercentError*100);
xlim([0,size(trajectory,1)/4])
ylim([0 100])
subplot(3,1,3); grid on;
zPercentError = (trajectory(:,3)-path(:,3))./trajectory(:,3);
plot(zPercentError*100);
xlim([0,size(trajectory,1)/4])
ylim([0 100])
hold off