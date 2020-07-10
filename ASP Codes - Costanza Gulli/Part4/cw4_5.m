clear all;

c = struct('darkred', [139/255   0   0], ...
    'red', [220/255  20/255  60/255], ... 
    'darkorange', [254/255 102/255 13/255],...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0]);

%% 4.5.1 model order selection
[eIn eFs] = audioread('e.mp3');
[aIn aFs] = audioread('a.mp3');
[sIn sFs] = audioread('s.mp3');
[tIn tFs] = audioread('t.mp3');
[xIn xFs] = audioread('x.mp3');

% e
e = eIn(20001:21000);
e = zscore(e);
[e_orderMDL, e_orderAIC, e_orderAICc] = OrderSelection(e, 20); % find local minimum of each predictor

% a
a = aIn(20001:21000);
a = zscore(a);
[a_orderMDL, a_orderAIC, a_orderAICc] = OrderSelection(a, 20);

% s
s = sIn(20001:21000);
s = zscore(s);
[s_orderMDL, s_orderAIC, s_orderAICc] = OrderSelection(s, 20);

% t
t = tIn(2001:3000);
t = zscore(t);
[t_orderMDL, t_orderAIC, t_orderAICc] = OrderSelection(t, 30);

% x
x = xIn(2001:3000);
x = zscore(x);
[x_orderMDL, x_orderAIC, x_orderAICc] = OrderSelection(x, 20);

%% 4.5.1 show prediction and evolution of coefficients
% e
eDelayed = zeros(1000, 1);
eDelayed(2:1000) = e(1:999);
[eHat, errorE, w] = lms(eDelayed, e, 0.1, 6); 
figure; subplot(2,3,1); 
hold on; grid on; 
plot(e, '-', 'color', c.darkred, 'linewidth', 1);
plot(eHat, '-', 'color', c.orange, 'linewidth', 1);
title('Signal for E. \mu = 0.1', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('Original from audio','Estimated with predictor','FontSize', 15, 'location','southeast')

newcolors = [0 0 0
            139/255   0   0
            220/255  20/255  60/255 
            254/255 102/255 13/255
            255/255 165/255   0
            255/255 230/255 0];         
colororder(newcolors);
subplot(2,3,4); hold on; grid on;
for i = 1:6
    plot (w(i,:), '-', 'linewidth', 1.5);
end
title('AR coefficient estimate for E. \mu = 0.1', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('a1','a2','a3','a4','a5','a6','FontSize', 15, 'location','northeast')

clear error w

% a
aDelayed = zeros(1000, 1);
aDelayed(2:1000) = a(1:999);
[aHat, errorA, w] = lms(aDelayed, a, 0.1, 2); 

subplot(2,3,2); 
hold on; grid on; 
plot(a, '-', 'color', c.darkred, 'linewidth', 1);
plot(aHat, '-', 'color', c.orange, 'linewidth', 1);
title('Signal for A. \mu = 0.1', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('Original from audio','Estimated with predictor','FontSize', 15, 'location','southeast')

subplot(2,3,5); hold on; grid on;
plot (w(1,:), '-',  'color', c.darkred, 'linewidth', 1.5);
plot (w(2,:), '-',  'color', c.red, 'linewidth', 1.5);
title('AR coefficient estimate for A. \mu = 0.1', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('a1','a2','FontSize', 15, 'location','southeast')

clear error w

% s
sDelayed = zeros(1000, 1);
sDelayed(2:1000) = s(1:999);
[sHat, errorS, w] = lms(sDelayed, s, 0.1, 6); 
subplot(2,3,3); 
hold on; grid on; 
plot(s, '-', 'color', c.darkred, 'linewidth', 1);
plot(sHat, '-', 'color', c.orange, 'linewidth', 1);
title('Signal for S. \mu = 0.1', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('Original from audio','Estimated with predictor','FontSize', 15, 'location','southeast')

newcolors = [0 0 0
            139/255   0   0
            220/255  20/255  60/255 
            254/255 102/255 13/255
            255/255 165/255   0
            255/255 230/255 0];         
colororder(newcolors);
subplot(2,3,6); hold on; grid on;
for i = 1:6
    plot (w(i,:), '-', 'linewidth', 1.5);
end
title('AR coefficient estimate for S. \mu = 0.1', 'FontSize', 14); 
xlabel('Time', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('a1','a2','a3','a4','a5','a6','FontSize', 15, 'location','northeast')

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
[xHat, errorX, w] = lms(xDelayed, x, 0.05, 10); 
figure ; hold on; 
plot(x, '-', 'color', c.darkred, 'linewidth', 1);
plot(xHat, '-', 'color', c.orange, 'linewidth', 1);

%% 4.5.2 for 44100Hz
RpE = 10*log10( var(e(:)) / var(errorE(:)) );
RpA = 10*log10( var(a(:)) / var(errorA(:)) );
RpS = 10*log10( var(s(:)) / var(errorS(:)) );
RpT = 10*log10( var(t(:)) / var(errorT(:)) );
RpX = 10*log10( var(x(:)) / var(errorX(:)) );