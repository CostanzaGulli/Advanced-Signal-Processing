clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0] );

load sunspot.dat
sun = sunspot(:,2);
sun = zscore(sun); 
M = length(sun);
rxx = xcorr(sun);

%% 3.3.3,4 build estimate for sun
for p = 1:10 % order
    H = zeros(M-(p+1), p);
    for i = p+1:M
        for ii = 1:p
            H(i-p, ii) = sun(i-ii, 1);
        end
    end
    a(p,1:p) = inv(H'*H)*H'*sun(p+1:end);
end

a_yw2 = aryule(sun, 2);% calculate coefficients with yw equations to check results

x = zeros(M, 10);
error = zeros(M, 10);
for p = 1:10
   coeff = a(p, 1:p);
   x(:,p) = filter([-1, coeff],1, sun);
   error(:,p) = (x(:,p) - sun(:)).^2;
end
E = zeros(1,10); % E is the cumulative error
for i = 1:M
    E(1,:) = E(1,:) + error(i,:);
end

p=1:1:10;
MDL = log(E(1,:)) + (p(1,:)*log(M))/M;
AIC = log(E(1,:)) + (2*p(1,:))/M;
AICc = AIC + (2*p(1,:).*(p(1,:)+1))./(M-p(1,:)-1);

% plot model order selection
figure; hold on;
plot(log(E), '-k', 'linewidth', 1.5);
plot(p, MDL, '-', 'color', c.red, 'linewidth', 1.5);
plot(p, AIC, '-', 'color', c.darkred, 'linewidth', 1.5);
plot(p, AICc, '-', 'color', c.orange, 'linewidth', 1.5);
title('Model order selection', 'FontSize', 15); grid on;
xlabel('Model Order (p)', 'FontSize', 15); ylabel('', 'FontSize', 15);
legend('Cumulative Squared Error','MDL','AIC','AIC_c','location','northwest','FontSize', 15)

% plot coefficients
figure; hold on;
for p = 1:10
    arCoeff = a(p, 1:p);
    plot(arCoeff, '-', 'linewidth', 1.5);
end
title('AR coefficients of sunspot time series', 'FontSize', 13); grid on;
xlabel('n', 'FontSize', 13); ylabel('a', 'FontSize', 13);
legend('p=1','p=2','p=3','p=4','p=5','p=6','p=7','p=8','p=9','p=10','FontSize', 12)

%% 3.3.5
figure; hold on;
[pgmout, pgm_xaxis] = pgm(sun);
plot(pgm_xaxis, pgmout, '-', 'color', c.orange, 'linewidth', 1);

[~, var] = aryule(sun, 1);
coeff = a(1, 1);
[h, w] = freqz(sqrt(var),[1, -coeff],M);
plot(w./(2*pi), abs(h).^2, '-k', 'linewidth', 1.5);

[~, var] = aryule(sun, 2);
coeff = a(2, 1:2);
[h, w] = freqz(sqrt(var),[1, -coeff],M);
plot(w./(2*pi), abs(h).^2, '-', 'color', c.darkred, 'linewidth', 1.5);

[~, var] = aryule(sun, 10);
coeff = a(10, 1:10);
[h, w] = freqz(sqrt(var),[1, -coeff],M);
plot(w./(2*pi), abs(h).^2, '-', 'color', c.red, 'linewidth', 1.5);

title('PSD of normalised sunspot data', 'FontSize', 15); grid on;
xlabel('f (normalised)', 'FontSize', 15); ylabel('P_Y(f)', 'FontSize', 15); axis([0 0.5 -inf inf])
legend('Periodogram', 'from AR(1) model', 'from AR(2) model', 'from AR(10) model', 'FontSize', 15, 'location', 'northeast');

%% 3.3.6
N = 10;
MSE = [];

for N = 10:5:250
    sun2 = sun(1:N);

    p = 2; % model order 2
    H = zeros(N-(p+1), p);
    for i = p+1:N
        for ii = 1:p
            H(i-p, ii) = sun2(i-ii, 1);
        end
    end
    coeff = inv(H'*H)*H'*sun2(p+1:end);
    x = filter(1,coeff,sun2);
    E=zeros(N,1);
    E(:,1) = (x(:,1) - sun2(:,1)).^2;

    E_mse = mean(E);
    MSE = [MSE E_mse];
end
figure;
plot(10:5:250, MSE, '-', 'color', c.red, 'linewidth', 1.5);