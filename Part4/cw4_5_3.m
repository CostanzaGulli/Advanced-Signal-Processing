clear all;

c = struct('darkred', [139/255   0   0], ...
    'red', [220/255  20/255  60/255], ... 
    'darkorange', [254/255 102/255 13/255],...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0]);

%% 4.5.3 resample at 16000Hz 
[eIn eFs] = audioread('e.mp3');
[aIn aFs] = audioread('a.mp3');
[sIn sFs] = audioread('s.mp3');
[tIn tFs] = audioread('t.mp3');
[xIn xFs] = audioread('x.mp3');
eIn = resample(eIn,16000,eFs); 
aIn = resample(aIn,16000,eFs); 
sIn = resample(sIn,16000,eFs); 
rIn = resample(tIn,16000,eFs); 
xIn = resample(xIn,16000,eFs);
e = eIn(10001:11000);
a = aIn(10001:11000);
s = sIn(10001:11000);
t = tIn(2001:3000);
x = xIn(1001:2000);

%% model order selection 

% e
e = zscore(e);
[e_orderMDL, e_orderAIC, e_orderAICc] = OrderSelection(e, 20); % find local minima of each predictor

% a
a = zscore(a);
[a_orderMDL, a_orderAIC, a_orderAICc] = OrderSelection(a, 20);

% s
s = zscore(s);
[s_orderMDL, s_orderAIC, s_orderAICc] = OrderSelection(s, 20);

% t
t = zscore(t);
[t_orderMDL, t_orderAIC, t_orderAICc] = OrderSelection(t, 30);

% x
x = zscore(x);
[x_orderMDL, x_orderAIC, x_orderAICc] = OrderSelection(x, 20);

%% plot of the estimate
% e
eDelayed = zeros(1000, 1);
eDelayed(2:1000) = e(1:999);
[eHat, errorE, w] = lms(eDelayed, e, 0.1, 6); 
figure; hold on; 
plot(e, '-', 'color', c.darkred, 'linewidth', 1);
plot(eHat, '-', 'color', c.orange, 'linewidth', 1);

% a
aDelayed = zeros(1000, 1);
aDelayed(2:1000) = a(1:999);
[aHat, errorA, w] = lms(aDelayed, a, 0.1, 3); 
figure; hold on; 
plot(a, '-', 'color', c.darkred, 'linewidth', 1);
plot(aHat, '-', 'color', c.orange, 'linewidth', 1);

% s
sDelayed = zeros(1000, 1);
sDelayed(2:1000) = s(1:999);
[sHat, errorS, w] = lms(sDelayed, s, 0.07, 8); 
figure ; hold on; 
plot(s, '-', 'color', c.darkred, 'linewidth', 1);
plot(sHat, '-', 'color', c.orange, 'linewidth', 1);

% t
tDelayed = zeros(1000, 1);
tDelayed(2:1000) = t(1:999);
[tHat, errorT, w] = lms(tDelayed, t, 0.05, 10); 
figure ; hold on; 
plot(t, '-', 'color', c.darkred, 'linewidth', 1);
plot(tHat, '-', 'color', c.orange, 'linewidth', 1);

% x
xDelayed = zeros(1000, 1);
xDelayed(2:1000) = x(1:999);
[xHat, errorX, w] = lms(xDelayed, x, 0.05, 8); 
figure ; hold on; 
plot(x, '-', 'color', c.darkred, 'linewidth', 1);
plot(xHat, '-', 'color', c.orange, 'linewidth', 1);