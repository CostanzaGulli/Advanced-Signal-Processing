clear all;

c = struct('darkred', [139/255   0   0], ...
    'red', [220/255  20/255  60/255], ... 
    'darkorange', [254/255 102/255 13/255],...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0]);

%% 4.4.1

a = [1 0.9 0.2];
b = 1;
N = 5000;
Nw = length(a);
n = randn(N,1);
x = filter(b, a, n);
xDelayed = zeros(N, 1);
xDelayed(2:N) = x(1:N-1);

figure;

% mu = 0.001;
[yHat, e, w] = lms(xDelayed, x, 0.001, 2); 
subplot(1,4,1); hold on; grid on;
plot (w(1,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.darkred, 'linewidth', 1.5);
title('AR coefficient estimate. \mu = 0.001', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('a1','a2','FontSize', 15, 'location','northeast')


% mu = 0.01;
[yHat, e, w] = lms(xDelayed, x, 0.01, 2); 
subplot(1,4,2); hold on; grid on;
plot (w(1,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.darkred, 'linewidth', 1.5);
title('AR coefficient estimate. \mu = 0.01', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('a1','a2','FontSize', 15, 'location','northeast')

% mu = 0.05;
[yHat, e, w] = lms(xDelayed, x, 0.05, 2); 
subplot(1,4,3); hold on; grid on;
plot (w(1,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.darkred, 'linewidth', 1.5);
title('AR coefficient estimate. \mu = 0.05', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('a1','a2','FontSize', 15, 'location','northeast')

% mu = 0.2;
[yHat, e, w] = lms(xDelayed, x, 0.2, 2); 
subplot(1,4,4); hold on; grid on;
plot (w(1,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.darkred, 'linewidth', 1.5);
title('AR coefficient estimate. \mu = 0.2', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('a1','a2','FontSize', 15, 'location','northeast')