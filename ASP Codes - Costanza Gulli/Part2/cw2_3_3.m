clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0]);

%% 2.3.3 
load sunspot.dat;
sun = sunspot(:,2);
sunNormalised = zscore(sun);

figure; 
subplot(1,2,1); hold on;
for i = 1:10
    [arCoeff,estVar,rc] = aryule(sun,i);
    plot(arCoeff, '-', 'linewidth', 1.5);
end
title('AR coefficients of sunspot time series', 'FontSize', 13); grid on;
xlabel('n', 'FontSize', 13); ylabel('a', 'FontSize', 13);
legend('p=1','p=2','p=3','p=4','p=5','p=6','p=7','p=8','p=9','p=10','location','southeast')
axis([0 14 -02 1.2])

subplot(1,2,2); hold on;
for i = 1:10
    [arCoeffN,estVarN,rcN] = aryule(sunNormalised,i);
    plot(arCoeffN, '-', 'linewidth', 1.5);
end
title('AR coefficients of sunspot time series normalised', 'FontSize', 13); grid on;
xlabel('n', 'FontSize', 13); ylabel('a', 'FontSize', 13);
legend('p=1','p=2','p=3','p=4','p=5','p=6','p=7','p=8','p=9','p=10','location','southeast')
axis([0 14 -02 1.2])

figure; hold on;
stem(rc, '-', 'color', c.orange, 'linewidth', 1.5);
stem(rcN, '-', 'color', c.darkred, 'linewidth', 1.5);
title('Partial autocorrelation of sunspot time series', 'FontSize', 13); grid on;
xlabel('k', 'FontSize', 13); ylabel('PACF', 'FontSize', 13);
legend('Sunspot', 'Sunspot normalised', 'FontSize', 12)


% [arCoeff1,estVar,rc] = aryule(sun,1);
% [arCoeff2,estVar,rc] = aryule(sun,2);
% [arCoeff3,estVar,rc] = aryule(sun,3);
% [arCoeff4,estVar,rc] = aryule(sun,4);
% [arCoeff5,estVar,rc] = aryule(sun,5);
% [arCoeff6,estVar,rc] = aryule(sun,6);
% [arCoeff7,estVar,rc] = aryule(sun,7);
% [arCoeff8,estVar,rc] = aryule(sun,8);
% [arCoeff9,estVar,rc] = aryule(sun,9);
% [arCoeff10,estVar,rc] = aryule(sun,10);