clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0]);

%% 3.2. 1,2,3
x = wgn(1064, 1, 1);
y_tmp = filter([1], [1 0.9], x);
y = y_tmp(41:end);

[h, w] = freqz([1], [1 0.9], 512);
[py, xaxis] = pgm(y);
figure; hold on;  
plot(xaxis, py, '-', 'color', c.orange, 'linewidth', 1); 
plot(w/(2*pi), abs(h).^2, '-', 'color', c.darkred, 'linewidth', 1.5);
title('PSD of AR(1)', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_Y(f)', 'FontSize', 15); axis([0 0.5 -inf inf])
legend('Periodogram', 'Theoretical', 'FontSize', 15, 'location', 'northwest');

%% 3.2.4
corr = xcorr(y, 'unbiased');
a1 = -corr(1025)/corr(1024);
varx = corr(1024) + a1*corr(1025);
[h2, w2] = freqz([sqrt(varx)],[1 a1],512);
figure; hold on;
plot(xaxis, py, '-', 'color', c.orange, 'linewidth', 1);
plot(w2/(2*pi), abs(h2).^2, '-', 'color', c.red, 'linewidth', 1.5);
plot(w/(2*pi), abs(h).^2, '-','color', c.darkred, 'linewidth', 1.5);
title('PSD of AR(1)', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_Y(f)', 'FontSize', 15); axis([0 0.5 -inf inf])
legend('Periodogram', 'From model', 'Theoretical', 'FontSize', 15, 'location', 'northwest');