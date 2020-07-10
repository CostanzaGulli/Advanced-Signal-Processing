clear all;

c = struct('darkred', [139/255   0   0], ...
    'red', [220/255  20/255  60/255], ... 
    'darkorange', [254/255 102/255 13/255],...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0]);

%% 4.2.1 time evolution
N = 1000;
x = randn(N, 1);
y = filter([1 2 3 2 1], [1], x);
% y = zscore(y);
eta = 0.1*randn(N,1);
z = y + eta;
order = 5;
mu = 0.1;
[yHat, e, w] = lms(x, z, mu, order);
figure; hold on; grid on;

% plot time evolution of the estimate
plot (w(1,:), '-k', 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.darkred, 'linewidth', 1.5);
plot (w(3,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(4,:), '-', 'color', c.orange, 'linewidth', 1.5);
plot (w(5,:), '-', 'color', c.yellow, 'linewidth', 1.5);
title('Time evolution of MA coefficient estimate', 'FontSize', 15); grid on;
xlabel('time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('w1','w2','w3','w4','w5','FontSize', 15, 'location','southeast')

% plot MA coefficients results
figure; hold on; grid on; 
plot(w(:,N), '-*', 'color', c.red, 'linewidth', 1.5);
title('MA coefficient estimate', 'FontSize', 15);
xlabel('Coefficient', 'FontSize', 15); ylabel('Value', 'FontSize', 15);

%% 4.2.1 MA coefficients results varying noise variance
clearvars -except c
N = 1000;
x = randn(N, 1);
y = filter([1 2 3 2 1], [1], x);
order = 5;
mu = 0.1;
figure; hold on; grid on; 

plot([1 2 3 2 1], '--m', 'linewidth', 1.5);
% variance = 0.1
eta = sqrt(0.1)*randn(N,1);
z = y + eta;
[yHat, e, w] = lms(x, z, mu, order);
plot(w(:,N), '-*k', 'linewidth', 1.5);

% variance = 2.08
eta = sqrt(2.08)*randn(N,1);
z = y + eta;
[yHat, e, w] = lms(x, z, mu, order);
plot(w(:,N), '-*', 'color', c.darkred, 'linewidth', 1.5);

% variance = 4.06
eta = sqrt(4.06)*randn(N,1);
z = y + eta;
[yHat, e, w] = lms(x, z, mu, order);
plot(w(:,N), '-*', 'color', c.red, 'linewidth', 1.5);

% variance = 6.04
eta = sqrt(6.04)*randn(N,1);
z = y + eta;
[yHat, e, w] = lms(x, z, mu, order);
plot(w(:,N), '-*', 'color', c.darkorange, 'linewidth', 1.5);

% variance = 8.02
eta = sqrt(8.02)*randn(N,1);
z = y + eta;
[yHat, e, w] = lms(x, z, mu, order);
plot(w(:,N), '-*', 'color', c.orange, 'linewidth', 1.5);

% variance = 10
eta = sqrt(10)*randn(N,1);
z = y + eta;
[yHat, e, w] = lms(x, z, mu, order);
plot(w(:,N), '-*', 'color', c.yellow, 'linewidth', 1.5);

title('LMS coefficient estimate varing noise variance', 'FontSize', 15);
xlabel('Coefficient', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('Theoretical','\sigma^2 = 0.1','\sigma^2 = 2.08','\sigma^2 = 4.06','\sigma^2 = 6.04','\sigma^2 = 8.02','\sigma^2 = 10','FontSize', 15, 'location','south');

%% 4.2.2 time evolution of the estimate
clearvars -except c
N = 5000;
x = randn(N, 1);
y = filter([1 2 3 2 1], [1], x);
eta = 0.1*randn(N,1); % sigma = 0.1
z = y + eta;
order = 5;
figure;

% mu = 0.1
mu = 0.1;
[yHat, e, w] = lms(x, z, mu, order); 
subplot(2,3,2); 
hold on; grid on;
plot (w(1,:), '-k', 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.darkred, 'linewidth', 1.5);
plot (w(3,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(4,:), '-', 'color', c.orange, 'linewidth', 1.5);
plot (w(5,:), '-', 'color', c.yellow, 'linewidth', 1.5);
title('MA coefficient estimate. \mu=0.1', 'FontSize', 12); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('w1','w2','w3','w4','w5','FontSize', 15, 'location','southeast')

subplot(2,3,5); plot (e.^2, '-','color', c.red, 'linewidth', 1);
title('Squared estimate error. \mu=0.1', 'FontSize', 12); grid on;
xlabel('Time', 'FontSize', 15); ylabel('e^2', 'FontSize', 15);

% mu = 0.002
mu = 0.002;
[yHat, e, w] = lms(x, z, mu, order); 
subplot(2,3,1); 
hold on; grid on;
plot (w(1,:), '-k', 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.darkred, 'linewidth', 1.5);
plot (w(3,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(4,:), '-', 'color', c.orange, 'linewidth', 1.5);
plot (w(5,:), '-', 'color', c.yellow, 'linewidth', 1.5);
title('MA coefficient estimate. \mu=0.002', 'FontSize', 12); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('w1','w2','w3','w4','w5','FontSize', 15, 'location','southeast')

subplot(2,3,4); plot (e.^2, '-','color', c.red, 'linewidth', 1);
title('Squared estimate error. \mu=0.002', 'FontSize', 12); grid on;
xlabel('Time', 'FontSize', 15); ylabel('e^2', 'FontSize', 15);

% mu = 0.5
mu = 0.5;
[yHat, e, w] = lms(x, z, mu, order); 
subplot(2,3,3); 
hold on; grid on;
plot (w(1,:), '-k', 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.darkred, 'linewidth', 1.5);
plot (w(3,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(4,:), '-', 'color', c.orange, 'linewidth', 1.5);
plot (w(5,:), '-', 'color', c.yellow, 'linewidth', 1.5);
title('MA coefficient estimate. \mu=0.5', 'FontSize', 12); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('w1','w2','w3','w4','w5','FontSize', 15, 'location','northwest')

subplot(2,3,6); plot (e.^2, '-','color', c.red, 'linewidth', 1);
title('Squared estimate error. \mu=0.5', 'FontSize', 12); grid on;
xlabel('Time', 'FontSize', 15); ylabel('e^2', 'FontSize', 15);
