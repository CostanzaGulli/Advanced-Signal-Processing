clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0]);

%% part 2.1.1-2-3: autocorr of WGN
N = 1000;
x = randn(N, 1);
x_corr = xcorr(x, 'unbiased');
x_axis = -((length(x)-1)):1:(length(x)-1);
figure; 
subplot(1,2,1); stem(x_axis, x_corr , '-', 'color', c.red, 'linewidth', 1); axis([-999 999 -0.6 1.2])
title('Autocorrelation of WGN', 'FontSize', 15); grid on;
xlabel('\tau', 'FontSize', 15); ylabel('R_X(\tau)', 'FontSize', 15);
z = zoom;
z.Motion = 'horizontal';
z.Enable = 'on';
subplot(1,2,2); stem(x_axis, x_corr , '-', 'color', c.red, 'linewidth', 1); axis([-50 50 -0.6 1.2])
title('Autocorrelation of WGN (zoomed)', 'FontSize', 15); grid on;
xlabel('\tau', 'FontSize', 15); ylabel('R_X(\tau)', 'FontSize', 15);

%clear x x_corr x_axis z;

%% 2.1.4 filter
%N = 1000;
%x = randn(N, 1);
figure; hold on;

y = filter(ones(9,1),[1],x);

x_axis = -((length(y)-1)):1:(length(y)-1);
y_corr = xcorr(y, 'unbiased');
stem(x_axis, y_corr, '-', 'color', c.red, 'linewidth', 1.5); axis([-20 20 -2.2 10.2]);
title('Autocorrelation of filtered signal MA(8) R_Y(\tau)', 'FontSize', 15); grid on;
xlabel('\tau', 'FontSize', 15); ylabel('R_Y(\tau)', 'FontSize', 15);

%% plot for different filter orders
% x = randn(N, 1);
% figure; hold on;
% 
% M = 0; %filter order 0. R_X(\tau)
% y = filter(ones(M+1,1),[1],x);
% x_axis = -((length(y)-1)):1:(length(y)-1);
% x_corr = xcorr(y, 'unbiased');
% plot(x_axis, x_corr , 'ok', 'linewidth', 1.5);
% M = 3; %filter order 3
% y = filter(ones(M+1,1),[1],x);
% x_axis = -((length(y)-1)):1:(length(y)-1);
% y_corr3 = xcorr(y, 'unbiased');
% plot(x_axis, y_corr3 , 'o', 'color', c.darkred, 'linewidth', 1.5);
% M = 7; %filter order 7
% y = filter(ones(M+1,1),[1],x);
% x_axis = -((length(y)-1)):1:(length(y)-1);
% y_corr7 = xcorr(y, 'unbiased');
% plot(x_axis, y_corr7 , 'o', 'color', c.red, 'linewidth', 1.5);
% M = 10; %filter order 10
% y = filter(ones(M+1,1),[1],x);
% x_axis = -((length(y)-1)):1:(length(y)-1);
% y_corr10 = xcorr(y, 'unbiased');
% plot(x_axis, y_corr10 , 'o', 'color', c.orange, 'linewidth', 1.5);
% 
% plot(x_axis, x_corr , '-k', 'linewidth', 1.5);
% plot(x_axis, y_corr3 , '-', 'color', c.darkred, 'linewidth', 1.5);
% plot(x_axis, y_corr7 , '-', 'color', c.red, 'linewidth', 1.5);
% plot(x_axis, y_corr10 , '-', 'color', c.orange, 'linewidth', 1.5);
% 
% 
% axis([-20 20 -2.2 15.2]);
% title('Autocorrelation of filtered signal', 'FontSize', 15); grid on;
% xlabel('\tau', 'FontSize', 15); ylabel('R_Y(\tau)', 'FontSize', 15);
% legend('R_X(\tau)','MA(3)', 'MA(7)','MA(10)','FontSize', 12)

%% 2.2 cross-correlation
crosscorr = xcorr(x, y, 'unbiased');
clear x_axis
x_axis(:,1) = -((length(x)-1)):1:(length(x)-1);
figure; stem(x_axis, crosscorr, '-', 'color', c.red, 'linewidth', 1.5); axis([-20 20 -0.3 1.5]);
title('Cross-correlation R_{XY}(\tau)', 'FontSize', 15); grid on;
xlabel('\tau', 'FontSize', 15); ylabel('R_Y(\tau)', 'FontSize', 15);
h = ones(9,1);
%h(10:1999) = 0;
con = conv(h, x_corr);
clear x_axis
x_axis(:,1) = -((length(x)-1))-8:1:(length(x)-1);
hold on; plot (x_axis, con, '-', 'color', c.orange, 'linewidth', 1.5);
legend('R_{XY}(\tau)','h(\tau)*R_X(\tau)', 'FontSize', 12)