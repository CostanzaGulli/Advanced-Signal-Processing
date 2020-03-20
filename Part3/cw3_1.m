clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0]);

%% 3.1.1
x = wgn(128, 1, 1);
[px, xaxis] = pgm(x);
py = filter(0.2*[1 1 1 1 1],1,px);
theoretical_px = ones(length(x));
figure; subplot(1,3,1);
plot(xaxis, px, '-', 'color', c.orange, 'linewidth', 1.5)
hold on; plot(xaxis, py, '-', 'color', c.red, 'linewidth', 1.5);
plot(xaxis, theoretical_px, '-', 'color', c.darkred, 'linewidth', 1.5);
title('PSD of WGN, N = 128', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_X(f)', 'FontSize', 15);
legend('Periodogram','Filtered periodogram','Theoretical PSD', 'FontSize', 15)

x = wgn(256, 1, 1);
[px, xaxis] = pgm(x);
py = filter(0.2*[1 1 1 1 1],1,px);
theoretical_px = ones(length(x));
subplot(1,3,2);
plot(xaxis, px, '-', 'color', c.orange, 'linewidth', 1.5);
hold on; plot(xaxis, py, '-', 'color', c.red, 'linewidth', 1.5);
plot(xaxis, theoretical_px, '-', 'color', c.darkred, 'linewidth', 1.5);
title('PSD of WGN, N = 256', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_X(f)', 'FontSize', 15);
legend('Periodogram','Filtered periodogram','Theoretical PSD', 'FontSize', 15)

x = wgn(512, 1, 1);
[px, xaxis] = pgm(x);
py = filter(0.2*[1 1 1 1 1],1,px);
theoretical_px = ones(length(x));
subplot(1,3,3);
plot(xaxis, px, '-', 'color', c.orange, 'linewidth', 1.5)
hold on; plot(xaxis, py, '-', 'color', c.red, 'linewidth', 1.5);
plot(xaxis, theoretical_px, '-', 'color', c.darkred, 'linewidth', 1.5);
title('PSD of WGN, N = 512', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_X(f)', 'FontSize', 15);
legend('Periodogram','Filtered periodogram','Theoretical PSD', 'FontSize', 15)

%% 3.1.2
clearvars -except c
x = wgn(1024,1,1);
xSegm = zeros(128,8);
for i = 1:8
    xSegm(:,i) = x(128*(i-1)+1 : 128*i);
end
figure;
px_out = zeros(128,1);
for i=1:8
    [px, xaxis] = pgm(xSegm(:,i));
    subplot(2,4,i); plot(xaxis, px, '-', 'color', c.orange, 'linewidth', 1.5);
    str = sprintf('PSD of segment %d', i);
    title(str, 'FontSize', 15); grid on; xlabel('f (normalised)', 'FontSize', 15); ylabel('P_X(f)', 'FontSize', 15);
    px_out = px_out + (1/8).*px;
end

%% 3.1.3
theoretical_px = ones(length(px_out));
figure; hold on;
plot(xaxis, px, '-', 'color', c.orange, 'linewidth', 1.5);
plot(xaxis, px_out, '-', 'color', c.red, 'linewidth', 1.5);
plot(xaxis, theoretical_px, '-k', 'color', c.darkred, 'linewidth', 1.5);
title('PSD of WGN', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_X(f)', 'FontSize', 15);