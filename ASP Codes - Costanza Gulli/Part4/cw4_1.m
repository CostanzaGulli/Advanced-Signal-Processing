clear all;
c = struct('darkred', [139/255   0   0], ...
    'red', [220/255  20/255  60/255], ... 
    'darkorange', [254/255 102/255 13/255],...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0]);

%% 
N = 1000;
x = randn(N,1); 
y = filter([1,2,3,2,1], 1, x); 

% std = 0.1; % standard deviation of noise
% wgn = std*randn(N, 1);
% z = y + wgn; 
% SNR = snr(z,wgn);
Nw = 4;

var = [0.1, 2.08, 4.06, 6.04, 8.02, 10];
wopt = zeros(5, 6);
SNR = zeros(1,6);
for i=1:length(var)
    wgn = sqrt(var(i))*randn(N, 1);
    z = y + wgn;
    ccf_zx = xcorr(z, x, Nw);
    acf_x = xcorr(x, x, Nw);
    snr = std(z)^2/std(wgn)^2;
    %SNR(:,i) = 10*log10(  ) ;
    pzx = ccf_zx(5:end);
    Rxx = toeplitz(acf_x(Nw+1:end),conj(acf_x(Nw+1:end)));
    wopt(:,i) = Rxx\pzx;
end

figure; hold on; grid on; 
plot([1 2 3 2 1], '--m', 'linewidth', 1.5);

plot(wopt(:,1), '-*k', 'linewidth', 1.5);
plot(wopt(:,2), '-*', 'color', c.darkred, 'linewidth', 1.5);
plot(wopt(:,3), '-*', 'color', c.red, 'linewidth', 1.5);
plot(wopt(:,4), '-*', 'color', c.darkorange, 'linewidth', 1.5);
plot(wopt(:,5), '-*', 'color', c.orange, 'linewidth', 1.5);
plot(wopt(:,6), '-*', 'color', c.yellow, 'linewidth', 1.5);

title('LMS coefficient estimate varing noise variance', 'FontSize', 15);
xlabel('Coefficient', 'FontSize', 15); ylabel('Value', 'FontSize', 15);
legend('Theoretical','\sigma^2 = 0.1','\sigma^2 = 2.08','\sigma^2 = 4.06','\sigma^2 = 6.04','\sigma^2 = 8.02','\sigma^2 = 10','FontSize', 15, 'location','south');
