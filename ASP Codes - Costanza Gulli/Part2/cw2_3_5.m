clear all;

c = struct('darkred', [139/255   0   0], ...
    'red', [220/255  20/255  60/255], ... 
    'darkorange', [254/255 102/255 13/255],...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0]);

%% 
load sunspot.dat
sun = sunspot(:, 2);
sun = zscore(sun);
N = 100;

load sunspot.dat;
sun = sunspot(:,2);
sun = zscore(sun(1:N));

x1 = ar(sun, 1, 'yw'); 
x2 = ar(sun, 2, 'yw'); 
x10 = ar(sun, 10, 'yw');

x1_p1 = predict(x1, sun, 1);
x1_p2 = predict(x1, sun, 2);
x1_p5 = predict(x1, sun, 5);
x1_p10 = predict(x1, sun, 10);

x2_p1 = predict(x2, sun, 1);
x2_p2 = predict(x2, sun, 2);
x2_p5 = predict(x2, sun, 5);
x2_p10 = predict(x2, sun, 10);

x10_p1 = predict(x10, sun, 1);
x10_p2 = predict(x10, sun, 2);
x10_p5 = predict(x10, sun, 5);
x10_p10 = predict(x10, sun, 10);

figure;
hold on; grid on; 
plot(sun, '-k', 'linewidth', 1.5, 'DisplayName','Real Data');

% plot(x1_p1, '-','color', c.darkred, 'linewidth', 1.5,'DisplayName','AR(1), M=1');
% plot(x1_p2, '-', 'color', c.red, 'linewidth', 1.5,'DisplayName','AR(1), M=2');
% plot(x1_p5, '-', 'color', c.orange, 'linewidth', 1.5,'DisplayName','AR(1), M=5');
% plot(x1_p10, '-', 'color', c.yellow, 'linewidth', 1.5,'DisplayName','AR(1), M=10');

% plot(x2_p1, '-', 'color', c.darkred, 'linewidth', 1.5,'DisplayName','AR(2), M=1');
% plot(x2_p2, '-', 'color', c.red, 'linewidth', 1.5,'DisplayName','AR(2), M=2');
% plot(x2_p5, '-', 'color', c.orange, 'linewidth', 1.5,'DisplayName','AR(2), M=5');
% plot(x2_p10, '-', 'color', c.yellow, 'linewidth', 1.5,'DisplayName','AR(2), M=10');

plot(x10_p1, '-', 'color', c.darkred, 'linewidth', 1.5,'DisplayName','AR(10), M=1');
plot(x10_p2, '-', 'color', c.red, 'linewidth', 1.5,'DisplayName','AR(10), M=2');
plot(x10_p5, '-', 'color', c.orange, 'linewidth', 1.5,'DisplayName','AR(10), M=5');
plot(x10_p10, '-', 'color', c.yellow, 'linewidth', 1.5,'DisplayName','AR(10), M=10');


xlabel('Sample', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('show','FontSize', 15, 'location', 'northwest')
% title('Sunspot data AR(1) prediction', 'FontSize', 15); grid on;
% title('Sunspot data AR(2) prediction', 'FontSize', 15); grid on;
title('Sunspot data AR(10) prediction', 'FontSize', 15); grid on;
