clear all;

c = struct('darkred', [139/255   0   0], ...
    'red', [220/255  20/255  60/255], ... 
    'darkorange', [254/255 102/255 13/255],...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0]);

%% 4.5.3 resample at 16000Hz 
% read audio files
[eIn eFs] = audioread('e.mp3');
[aIn aFs] = audioread('a.mp3');
[sIn sFs] = audioread('s.mp3');
[tIn tFs] = audioread('t.mp3');
[xIn xFs] = audioread('x.mp3');

% resample at 16000Hz
eIn = resample(eIn,16000,eFs); 
aIn = resample(aIn,16000,eFs); 
sIn = resample(sIn,16000,eFs); 
rIn = resample(tIn,16000,eFs); 
xIn = resample(xIn,16000,eFs);

% obtain 1000-sample vectors
e = eIn(10001:11000);
a = aIn(10001:11000);
s = sIn(10001:11000);
t = tIn(2001:3000);
x = xIn(1001:2000);

% make data zero-mean
e = zscore(e);
a = zscore(a);
s = zscore(s);
t = zscore(t);
x = zscore(x);

%% model order selection 

% e
[e_orderMDL, e_orderAIC, e_orderAICc] = OrderSelection(e, 20); % find local minimum of each predictor

% a
[a_orderMDL, a_orderAIC, a_orderAICc] = OrderSelection(a, 20);

% s
[s_orderMDL, s_orderAIC, s_orderAICc] = OrderSelection(s, 20);

% t
[t_orderMDL, t_orderAIC, t_orderAICc] = OrderSelection(t, 30);

% x
[x_orderMDL, x_orderAIC, x_orderAICc] = OrderSelection(x, 20);

%% plot of the estimate
% e
eDelayed = zeros(1000, 1);
eDelayed(2:1000) = e(1:999);
[eHat, errorE, w] = lms(eDelayed, e, 0.1, 6); 
figure; hold on; grid on
plot(e, '-', 'color', c.darkred, 'linewidth', 1);
plot(eHat, '-', 'color', c.orange, 'linewidth', 1);
title('Signal for E', 'FontSize', 14); 
legend('Original from audio','Estimated with predictor','FontSize', 15, 'location','southeast')

% a
aDelayed = zeros(1000, 1);
aDelayed(2:1000) = a(1:999);
[aHat, errorA, w] = lms(aDelayed, a, 0.1, 3); 
figure; hold on; grid on
plot(a, '-', 'color', c.darkred, 'linewidth', 1);
plot(aHat, '-', 'color', c.orange, 'linewidth', 1);
title('Signal for A', 'FontSize', 14); 
legend('Original from audio','Estimated with predictor','FontSize', 15, 'location','southeast')

% s
sDelayed = zeros(1000, 1);
sDelayed(2:1000) = s(1:999);
[sHat, errorS, w] = lms(sDelayed, s, 0.07, 8); 
figure ; hold on; grid on
plot(s, '-', 'color', c.darkred, 'linewidth', 1);
plot(sHat, '-', 'color', c.orange, 'linewidth', 1);
title('Signal for S', 'FontSize', 14); 
legend('Original from audio','Estimated with predictor','FontSize', 15, 'location','southeast')

% t
tDelayed = zeros(1000, 1);
tDelayed(2:1000) = t(1:999);
[tHat, errorT, w] = lms(tDelayed, t, 0.05, 10); 
figure ; hold on; grid on
plot(t, '-', 'color', c.darkred, 'linewidth', 1);
plot(tHat, '-', 'color', c.orange, 'linewidth', 1);
title('Signal for T', 'FontSize', 14); 
legend('Original from audio','Estimated with predictor','FontSize', 15, 'location','southeast')

% x
xDelayed = zeros(1000, 1);
xDelayed(2:1000) = x(1:999);
[xHat, errorX, w] = lms(xDelayed, x, 0.05, 8); 
figure ; hold on; grid on
plot(x, '-', 'color', c.darkred, 'linewidth', 1);
plot(xHat, '-', 'color', c.orange, 'linewidth', 1);
title('Signal for X', 'FontSize', 14); 
legend('Original from audio','Estimated with predictor','FontSize', 15, 'location','southeast')

%% 4.5.2 for 16000Hz
RpE = 10*log10( var(e(:)) / var(errorE(:)) );
RpA = 10*log10( var(a(:)) / var(errorA(:)) );
RpS = 10*log10( var(s(:)) / var(errorS(:)) );
RpT = 10*log10( var(t(:)) / var(errorT(:)) );
RpX = 10*log10( var(x(:)) / var(errorX(:)) );