clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0] );

%% plot f0 estimate

f0 = linspace(0,1/2,50);
N = 10;
n = 0:1:(N-1);
% figure; hold on
for i=1:50
    x = cos(2*pi*f0(i)*n);
    [px, xaxis] = pgm(x);
    % plot(xaxis, px)
    [mle1, mleIndex] = max(px);
    f(i) = xaxis(mleIndex);  
end
f0 = linspace(0,1/2,50);
N = 1000;
n = 0:1:(N-1);
% figure; hold on
for i=1:50
    x = cos(2*pi*f0(i)*n);
    [px, xaxis] = pgm(x);
    % plot(xaxis, px)
    [mle1, mleIndex] = max(px);
    f2(i) = xaxis(mleIndex);  
end
figure; hold on; grid on; 
plot(f0, f0, '*', 'color', c.orange, 'linewidth', 1);
plot(f0, f, '*', 'color', c.red, 'linewidth', 1);
plot(f0, f2, '--', 'color', c.darkred, 'linewidth', 1);

title('Real and estimated f0', 'FontSize', 15); grid on;
xlabel('Real f0', 'FontSize', 15); ylabel('Estimated f0', 'FontSize', 15);
legend('Ideal','Experimental N=10','Experimental N=1000','FontSize', 15);

%% plot periodogram
N = 10;
n = 0:1:(N-1);
figure; hold on; grid on;
% f0 = 0
f0 = 0;
x = cos(2*pi*f0*n);
[px, xaxis] = pgm(x);
plot(xaxis, px, '-*k', 'linewidth', 1);

% f0 = 0.2
f0 = 0.2;
x = cos(2*pi*f0*n);
[px, xaxis] = pgm(x);
plot(xaxis, px, '-*', 'color', c.darkred, 'linewidth', 1);

% f0 = 0.3
f0 = 0.3;
x = cos(2*pi*f0*n);
[px, xaxis] = pgm(x);
plot(xaxis, px, '-*', 'color', c.red, 'linewidth', 1);

% f0 = 0.5
f0 = 0.5;
x = cos(2*pi*f0*n);
[px, xaxis] = pgm(x);
plot(xaxis, px, '-*', 'color', c.orange, 'linewidth', 1);

title('Periodogram', 'FontSize', 15); grid on;
xlabel('Frequency', 'FontSize', 15); ylabel('PDF', 'FontSize', 15);
legend('f0 = 0', 'f0 = 0.2','f0 = 0.3','f0 = 0.5','FontSize', 15);