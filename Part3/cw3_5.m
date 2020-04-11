clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0] );

load RRI

%% RRI1

RRI1 = detrend(RRI1,0);
[pRRI1, xaxisRRI1] = pgm(RRI1);
figure; subplot(1,3,1); plot(xaxisRRI1.*fsRRI, pRRI1, '-', 'color', c.orange, 'linewidth', 1); axis([0 0.5 -inf inf]);
title('PSD of RRI1', 'FontSize', 15); grid on;
xlabel('Frequency (Hz)', 'FontSize', 15); ylabel('P_{RRI1}(f)', 'FontSize', 15);

L = 400; %100s windows
N = floor(length(RRI2)/L);
p_out1 = zeros(L,1);
for i = 1:N
    RRI1Tmp = RRI1((i-1)*L+1 : i*L);
    [pTmp1, xaxisTmp1] = pgm(RRI1Tmp);
    p_out1 = p_out1 + (1/N).*pTmp1;
end
hold on; plot(xaxisTmp1.*fsRRI, p_out1, '-', 'color', c.red, 'linewidth', 1);

L = 200; %50s windows
N = floor(length(RRI2)/L);
p_out1 = zeros(L,1);
for i = 1:N
    RRI1Tmp = RRI1((i-1)*L+1 : i*L);
    [pTmp1, xaxisTmp1] = pgm(RRI1Tmp);
    p_out1 = p_out1 + (1/N).*pTmp1;
end
plot(xaxisTmp1.*fsRRI, p_out1, '-', 'color', c.darkred, 'linewidth', 1);
legend('Periodogram', 'Averaged Periodogram (100s windows)', 'Averaged Periodogram (50s windows)', 'FontSize', 12, 'location', 'northeast');

%% RRI2
RRI2 = detrend(RRI2,0);
[pRRI2, xaxisRRI2] = pgm(RRI2);
subplot(1,3,2); plot(xaxisRRI2.*fsRRI, pRRI2, '-', 'color', c.orange, 'linewidth', 1); axis([0 0.5 -inf inf]);
title('PSD of RRI2', 'FontSize', 15); grid on;
xlabel('Frequency (Hz)', 'FontSize', 15); ylabel('P_{RRI2}(f)', 'FontSize', 15);

L = 400; %100s windows
N = floor(length(RRI2)/L);
p_out2 = zeros(L,1);
for i = 1:N
    RRI2Tmp = RRI2((i-1)*L+1 : i*L);
    [pTmp2, xaxisTmp2] = pgm(RRI2Tmp);
    p_out2 = p_out2 + (1/N).*pTmp2;
end
hold on; plot(xaxisTmp2.*fsRRI, p_out2, '-', 'color', c.red, 'linewidth', 1);

clear RRI2Tmp pTmp2 xaxisTmp2 p_out2;
L = 200; %50s windows
N = floor(length(RRI2)/L);
p_out2 = zeros(L,1);
for i = 1:N
    RRI2Tmp = RRI2((i-1)*L+1 : i*L);
    [pTmp2, xaxisTmp2] = pgm(RRI2Tmp);
    p_out2 = p_out2 + (1/N).*pTmp2;
end
plot(xaxisTmp2.*fsRRI, p_out2, '-', 'color', c.darkred, 'linewidth', 1);
legend('Periodogram', 'Averaged Periodogram (100s windows)', 'Averaged Periodogram (50s windows)', 'FontSize', 12, 'location', 'northeast');

%% RRI3
RRI3 = detrend(RRI3,0);
[pRRI3, xaxisRRI3] = pgm(RRI3);
subplot(1,3,3); plot(xaxisRRI3.*fsRRI, pRRI3, '-', 'color', c.orange, 'linewidth', 1); axis([0 0.5 -inf inf]);
title('PSD of RRI3', 'FontSize', 15); grid on;
xlabel('Frequency (Hz)', 'FontSize', 15); ylabel('P_{RRI3}(f)', 'FontSize', 15);

L = 400; %100s windows
N = floor(length(RRI3)/L);
p_out3 = zeros(L,1);
for i = 1:N
    RRI3Tmp = RRI3((i-1)*L+1 : i*L);
    [pTmp3, xaxisTmp3] = pgm(RRI3Tmp);
    p_out3 = p_out3 + (1/N).*pTmp3;
end
hold on; plot(xaxisTmp3.*fsRRI, p_out3, '-', 'color', c.red, 'linewidth', 1);

clear RRI3Tmp pTmp3 xaxisTmp3 p_out3;
L = 200; %50s windows
N = floor(length(RRI3)/L);
p_out3 = zeros(L,1);
for i = 1:N
    RRI3Tmp = RRI3((i-1)*L+1 : i*L);
    [pTmp3, xaxisTmp3] = pgm(RRI3Tmp);
    p_out3 = p_out3 + (1/N).*pTmp3;
end
plot(xaxisTmp3.*fsRRI, p_out3, '-', 'color', c.darkred, 'linewidth', 1);
legend('Periodogram', 'Averaged Periodogram (100s windows)', 'Averaged Periodogram (50s windows)', 'FontSize', 12, 'location', 'northeast');