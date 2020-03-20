clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0] );

%% 3.2.5
load sunspot.dat;
sun = sunspot(:,2);
n = length(sun);

% raw sunspot data
figure; subplot(1,2,1); hold on;
[pgmout, pgm_xaxis] = pgm(sun);
plot(pgm_xaxis, pgmout, '-', 'color', c.yellow, 'linewidth', 1);

[a, var] = aryule(sun, 1);
[h, w] = freqz(sqrt(var),a,n);
plot(w./(2*pi), abs(h).^2, '-', 'color', c.orange, 'linewidth', 1.5);
[a, var] = aryule(sun, 2);
[h, w] = freqz(sqrt(var),a,n);
plot(w./(2*pi), abs(h).^2, '-', 'color', c.red, 'linewidth', 1.5);
[a, var] = aryule(sun, 10);
[h, w] = freqz(sqrt(var),a,n);
plot(w./(2*pi), abs(h).^2, '-', 'color', c.darkred, 'linewidth', 1.5);

title('PSD of sunspot data', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_Y(f)', 'FontSize', 15); axis([0 0.5 -inf inf])
legend('Periodogram', 'From AR(1) model', 'from AR(2) model', 'from AR(10) model', 'FontSize', 15, 'location', 'northeast');

% normalised sunspot data
subplot(1,2,2); hold on;
figure; hold on
sun = detrend(sun, 0);
[pgmout, pgm_xaxis] = pgm(sun);
plot(pgm_xaxis, pgmout, '-', 'color', c.yellow, 'linewidth', 1);

[a, var] = aryule(sun, 1);
[h, w] = freqz(sqrt(var),a,n);
plot(w./(2*pi), abs(h).^2, '-', 'color', c.orange, 'linewidth', 1.5);
[a, var] = aryule(sun, 2);
[h, w] = freqz(sqrt(var),a,n);
plot(w./(2*pi), abs(h).^2, '-', 'color', c.red, 'linewidth', 1.5);
[a, var] = aryule(sun, 10);
[h, w] = freqz(sqrt(var),a,n);
plot(w./(2*pi), abs(h).^2, '-', 'color', c.darkred, 'linewidth', 1.5);

title('PSD of normalised sunspot data', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_Y(f)', 'FontSize', 15); axis([0 0.5 -inf inf])
legend('Periodogram', 'from AR(1) model', 'from AR(2) model', 'from AR(10) model', 'FontSize', 15, 'location', 'northeast');

%% also show overmodeling
[a, var] = aryule(sun, 60);
[h, w] = freqz(sqrt(var),a,n);
plot(w./(2*pi), abs(h).^2, '--k');
legend('Periodogram', 'from AR(1) model', 'from AR(2) model', 'from AR(10) model','from AR(60) model', 'FontSize', 15, 'location', 'northeast');
