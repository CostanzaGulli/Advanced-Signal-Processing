clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0]);

%% 3.0
x = wgn(128, 1, 1);
[px, xaxis] = pgm(x);
figure; subplot(1,3,1);
stem(xaxis, px, '-', 'color', c.red, 'linewidth', 1)
title('PSD of WGN, N = 128', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_X(f)', 'FontSize', 15);

x = wgn(256, 1, 1);
[px, xaxis] = pgm(x);
subplot(1,3,2);
stem(xaxis, px, '-', 'color', c.red, 'linewidth', 1)
title('PSD of WGN, N = 256', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_X(f)', 'FontSize', 15);

x = wgn(512, 1, 1);
[px, xaxis] = pgm(x);
subplot(1,3,3);
stem(xaxis, px, '-', 'color', c.red, 'linewidth', 1)
title('PSD of WGN, N = 512', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_X(f)', 'FontSize', 15);

%% 3.1.1
x = wgn(128, 1, 1);
[px, xaxis] = pgm(x);
py = filter(0.2*[1 1 1 1 1],1,px);
theoretical_px = ones(length(x));
figure; subplot(1,3,1);
plot(xaxis, px, '-', 'color', c.orange, 'linewidth', 1.5)
hold on; plot(xaxis, py, '-', 'color', c.red, 'linewidth', 1.5);
plot(xaxis, theoretical_px, '-', 'color', c.darkred, 'linewidth', 1.5);
title('PSD of WGN, N = 128', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_X(f)', 'FontSize', 15);
legend('Periodogram','Averaged periodogram','Theoretical PSD', 'FontSize', 15)

x = wgn(256, 1, 1);
[px, xaxis] = pgm(x);
py = filter(0.2*[1 1 1 1 1],1,px);
theoretical_px = ones(length(x));
subplot(1,3,2);
plot(xaxis, px, '-', 'color', c.orange, 'linewidth', 1.5);
hold on; plot(xaxis, py, '-', 'color', c.red, 'linewidth', 1.5);
plot(xaxis, theoretical_px, '-', 'color', c.darkred, 'linewidth', 1.5);
title('PSD of WGN, N = 256', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_X(f)', 'FontSize', 15);
legend('Periodogram','Averaged periodogram','Theoretical PSD', 'FontSize', 15)

x = wgn(512, 1, 1);
[px, xaxis] = pgm(x);
py = filter(0.2*[1 1 1 1 1],1,px);
theoretical_px = ones(length(x));
subplot(1,3,3);
plot(xaxis, px, '-', 'color', c.orange, 'linewidth', 1.5)
hold on; plot(xaxis, py, '-', 'color', c.red, 'linewidth', 1.5);
plot(xaxis, theoretical_px, '-', 'color', c.darkred, 'linewidth', 1.5);
title('PSD of WGN, N = 512', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_X(f)', 'FontSize', 15);
legend('Periodogram','Averaged periodogram','Theoretical PSD', 'FontSize', 15)
