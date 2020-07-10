clear all;

c = struct('darkred', [139/255   0   0], ...
    'red', [220/255  20/255  60/255], ... 
    'darkorange', [254/255 102/255 13/255],...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0]);

%% 4.6 AR coefficients
a = [1 0.9 0.2];
b = 1;
N = 5000;
Nw = length(a);
n = randn(N,1);
x = filter(b, a, n);
xDelayed = zeros(N, 1);
xDelayed(2:N) = x(1:N-1);

figure;

% lms
[yHat, e, w] = lms(xDelayed, x, 0.005, 2); 
subplot(1,4,1); hold on; grid on;
plot (w(1,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.darkred, 'linewidth', 1.5);
title('LMS estimate', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('a1','a2','FontSize', 15, 'location','northeast')

% lms sign-error
[yHat, e, w] = lms_signError(xDelayed, x, 0.005, 2); 
subplot(1,4,2); hold on; grid on;
plot (w(1,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.darkred, 'linewidth', 1.5);
title('Sign-error LMS estimate', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('a1','a2','FontSize', 15, 'location','northeast')

% lms sign-X
[yHat, e, w] = lms_signX(xDelayed, x, 0.005, 2); 
subplot(1,4,3); hold on; grid on;
plot (w(1,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.darkred, 'linewidth', 1.5);
title('Sign-x LMS estimate', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('a1','a2','FontSize', 15, 'location','northeast')

% lms sign-sign
[yHat, e, w] = lms_signsign(xDelayed, x, 0.005, 2); 
subplot(1,4,4); hold on; grid on;
plot (w(1,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.darkred, 'linewidth', 1.5);
title('Sign-sign LMS estimate', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('a1','a2','FontSize', 15, 'location','northeast')

%% 4.6 sound A
[aIn aFs] = audioread('a.mp3');
a = aIn(10001:15000);
a = zscore(a);
aDelayed = zeros(5000, 1);
aDelayed(2:5000) = a(1:4999);
figure;

[aHat, errorA, w] = lms(aDelayed, a, 0.1, 3); 
subplot(1,4,1); hold on; grid on;
plot (w(1,:), '-', 'color', c.darkred, 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(3,:), '-', 'color', c.orange, 'linewidth', 1.5);
title('LMS estimate. \mu = 0.1', 'FontSize', 14); 
legend('w1','w2','w3','FontSize', 15, 'location','southwest')

[aHat, errorA, w] = lms_signError(aDelayed, a, 0.01, 3); 
subplot(1,4,2); hold on; grid on;
plot (w(1,:), '-', 'color', c.darkred, 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(3,:), '-', 'color', c.orange, 'linewidth', 1.5);
title('Sign-error LMS estimate. \mu = 0.01', 'FontSize', 14); 
legend('w1','w2','w3','FontSize', 15, 'location','southwest')

[aHat, errorA, w] = lms_signX(aDelayed, a, 0.1, 3); 
subplot(1,4,3); hold on; grid on;
plot (w(1,:), '-', 'color', c.darkred, 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(3,:), '-', 'color', c.orange, 'linewidth', 1.5);
title('Sign-x LMS estimate. \mu = 0.1', 'FontSize', 14); 
legend('w1','w2','w3','FontSize', 15, 'location','southwest')

[aHat, errorA, w] = lms_signsign(aDelayed, a, 0.01, 3); 
subplot(1,4,4); hold on; grid on;
plot (w(1,:), '-', 'color', c.darkred, 'linewidth', 1.5);
plot (w(2,:), '-', 'color', c.red, 'linewidth', 1.5);
plot (w(3,:), '-', 'color', c.orange, 'linewidth', 1.5);
title('Sign-sign LMS estimate. \mu = 0.01', 'FontSize', 14); 
legend('w1','w2','w3','FontSize', 15, 'location','southwest')