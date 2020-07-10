clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0], ...
    'yellow', [255/255 255/255 0]);

%% 2.3.2 sunspot time series - ACF 

load sunspot.dat

N = 5;
data(1:N,1) = sunspot(1:N,2);
[acf, xaxis] = xcorr(data, 'unbiased');
subplot(3,2,1); stem(xaxis, acf, 'color', c.red);
title('N = 5; non-zero mean', 'FontSize', 15); grid on;
xlabel('\tau', 'FontSize', 15); ylabel('R_X(\tau)', 'FontSize', 15);

m = mean(data);
data = data - m;
[acf_nodc, xaxis] = xcorr(data, 'unbiased');
subplot(3,2,2); stem(xaxis, acf_nodc, 'color', c.darkred);
title('N = 5; zero mean', 'FontSize', 15); grid on;
xlabel('\tau', 'FontSize', 15); ylabel('R_X(\tau)', 'FontSize', 15);

N = 20;
data(1:N,1) = sunspot(1:N,2);
[acf, xaxis] = xcorr(data, 'unbiased');
subplot(3,2,3); stem(xaxis, acf, 'color', c.red);
title('N = 20; non-zero mean', 'FontSize', 15); grid on;
xlabel('\tau', 'FontSize', 15); ylabel('R_X(\tau)', 'FontSize', 15);

m = mean(data);
data = data - m;
[acf_nodc, xaxis] = xcorr(data, 'unbiased');
subplot(3,2,4); stem(xaxis, acf_nodc, 'color', c.darkred);
title('N = 20; zero mean', 'FontSize', 15); grid on;
xlabel('\tau', 'FontSize', 15); ylabel('R_X(\tau)', 'FontSize', 15);


N = 250;
data(1:N,1) = sunspot(1:N,2);
[acf, xaxis] = xcorr(data, 'unbiased');
subplot(3,2,5); stem(xaxis, acf, 'color', c.red);
title('N = 250; non-zero mean', 'FontSize', 15); grid on;
xlabel('\tau', 'FontSize', 15); ylabel('R_X(\tau)', 'FontSize', 15);

m = mean(data);
data = data - m;
[acf_nodc, xaxis] = xcorr(data, 'unbiased');
subplot(3,2,6); stem(xaxis, acf_nodc, 'color', c.darkred);
title('N = 250; zero mean', 'FontSize', 15); grid on;
xlabel('\tau', 'FontSize', 15); ylabel('R_X(\tau)', 'FontSize', 15);