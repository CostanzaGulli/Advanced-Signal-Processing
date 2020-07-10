clear all;

c = struct('darkred', [139/255   0   0], ...
    'red', [220/255  20/255  60/255], ... 
    'darkorange', [254/255 102/255 13/255],...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0]);

%% 4.3.1

% plot of how mu changes
% figure;
% plot([0 10 90 100],[0.002 0.002 0.1 0.1], '-', 'color', c.darkred, 'linewidth', 1.5);
% title('Gear shifting', 'FontSize', 15); axis([0 100 0 0.102]); grid on;
% xlabel('%Error', 'FontSize', 15); ylabel('\mu', 'FontSize', 15);

N = 5000;
x = randn(N, 1);
y = filter([1 2 3 2 1], [1], x);
eta = 0.1*randn(N,1); % sigma = 0.1
z = y + eta;
order = 5;

figure;
[yHat, e, w] = lms_gearshifting(x, z, order); 

subplot(1,2,1);
hold on; grid on;
plot (w(1,:), '-k', 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.darkred, 'linewidth', 1.5);
plot (w(3,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(4,:), '-', 'color', c.orange, 'linewidth', 1.5);
plot (w(5,:), '-', 'color', c.yellow, 'linewidth', 1.5);
title('MA coefficient estimate with Gear Shifting', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('w1','w2','w3','w4','w5','FontSize', 15, 'location','southeast');

subplot(1,2,2); plot (e.^2, '-','color', c.red, 'linewidth', 1);
title('Squared estimate error with Gear Shiftin', 'FontSize', 14); grid on;
xlabel('Time', 'FontSize', 15); ylabel('e^2', 'FontSize', 15);