clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0]);

%% 2.5
load RRI;
h1 = 60./xRRI1;

N = length(h1);
N_hat = floor(N/10);
a1 = 1;
h_hat1 = zeros(N_hat, 1);
for i = 1:N_hat
    sum = 0;
    for j = ((i-1)*10+1):((i-1)*10+10)
        sum = sum + a1*h1(j);
    end
    h_hat1(i) = (1/10)*sum;
end
a2 = 0.6;
h_hat2 = zeros(N_hat, 1);
for i = 1:N_hat
    sum = 0;
    for j = ((i-1)*10+1):((i-1)*10+10)
        sum = sum + a2*h1(j);
    end
    h_hat2(i) = (1/10)*sum;
end

%% parts a,b: pdf estimate
[y, h_centers] = pdf(h1,30);
[y1, h_centers1] = pdf(h_hat1,30);
[y2, h_centers2] = pdf(h_hat2,30);

figure;
subplot(1,3,1); bar(h_centers, y, 'FaceColor', c.orange, 'EdgeColor', c.orange);
title('PDF estimate of $$h(n)$$', 'Interpreter', 'Latex','FontSize', 15); grid on; axis([40 100 0 0.095])
xlabel('n', 'FontSize', 15); ylabel('p_X(n)', 'FontSize', 15);
subplot(1,3,2); bar(h_centers1, y1, 'FaceColor', c.red, 'EdgeColor', c.red);
title('PDF estimate of $$\hat{h}_1(n)$$','Interpreter', 'Latex','FontSize', 15); grid on; axis([40 100 0 0.14])
xlabel('n', 'FontSize', 15); ylabel('p_X(n)','FontSize', 15);
subplot(1,3,3); bar(h_centers2,y2,'FaceColor',c.darkred,'EdgeColor',c.darkred);
title('PDF estimate of $$\hat{h}_2(n)$$','Interpreter','Latex','FontSize',15); grid on; axis([40 100 0 0.23])
xlabel('n','FontSize',15); ylabel('p_X(n)','FontSize',15);

%% find mean and variance
meanh = mean(h1);
meanh1 = mean(h_hat1);
meanh2 = mean(h_hat2);
varh = var(h1);
varh1 = var(h_hat1);
varh2 = var(h_hat2);

%% parts c: autocorrelation 
xRRI1_0mean = detrend(xRRI1,0);
xRRI2_0mean = detrend(xRRI2,0);
xRRI3_0mean = detrend(xRRI3,0);
[corr1, xaxis1] = xcorr(xRRI1_0mean, 'unbiased');
[corr2, xaxis2] = xcorr(xRRI2_0mean, 'unbiased');
[corr3, xaxis3] = xcorr(xRRI3_0mean, 'unbiased');
figure; 
subplot(3,1,1); plot(xaxis1, corr1, '-', 'color', c.red, 'linewidth', 1)
title('Autocorrelation of RRI1', 'FontSize', 12); grid on;
xlabel('\tau', 'FontSize', 15); ylabel('R_{RRI1}(\tau)', 'FontSize', 15);
subplot(3,1,2); plot(xaxis2, corr2, '-', 'color', c.red, 'linewidth', 1)
title('Autocorrelation of RRI2', 'FontSize', 12); grid on;
xlabel('\tau', 'FontSize', 15); ylabel('R_{RRI2}(\tau)', 'FontSize', 15);
subplot(3,1,3); plot(xaxis3, corr3, '-', 'color', c.red, 'linewidth', 1)
title('Autocorrelation of RRI3', 'FontSize', 12); grid on;
xlabel('\tau', 'FontSize', 15); ylabel('R_{RRI3}(\tau)', 'FontSize', 15);

%% part d: ar modelling
% model order selection with MDL AIC and AICc - RRI1
N = length(xRRI1_0mean);
x = zeros(N, 10);
for order = 1:10
    arCoeffN = aryule(xRRI1_0mean,order);
    x(:,order) = filter(-arCoeffN,1,xRRI1_0mean);
end
error = zeros(N, 10);
for i=1:10
    error(:,i) = (x(:,i) - xRRI1_0mean(:)).^2;
end
cumulativeError = zeros(1,10);
for i = 1:N
    cumulativeError(1,:) = cumulativeError(1,:) + error(i,:);
end
p=1:1:10;
MDL = log(cumulativeError(1,:)) + (p(1,:)*log(N))/N;
AIC = log(cumulativeError(1,:)) + (2*p(1,:))/N;
AICc = AIC + (2*p(1,:).*(p(1,:)+1))./(N-p(1,:)-1);
figure; 
subplot(3,2,1);hold on; 
plot(log(cumulativeError), '-k', 'linewidth', 1.5);
plot(p, MDL, '-', 'color', c.red, 'linewidth', 1.5);
plot(p, AIC, '-', 'color', c.darkred, 'linewidth', 1.5);
plot(p, AICc, '-', 'color', c.orange, 'linewidth', 1.5);
title('Model order selection for RRI1', 'FontSize', 15); grid on;
xlabel('Model Order (p)', 'FontSize', 15); ylabel('', 'FontSize', 15);
legend('Cumulative Squared Error','MDL','AIC','AIC_c','location','northwest','FontSize', 12)
% model order selection with PACF - RRI1
[arCoeff,E,rc] = aryule(xRRI1_0mean,10);
subplot(3,2,2);
stem((-1).*rc(:,1), '-', 'color', c.darkred, 'linewidth', 1.5);
title('Partial autocorrelation of RRI1', 'FontSize', 15); grid on;
xlabel('k', 'FontSize', 15); ylabel('PACF', 'FontSize', 15);

clear N x
% model order selection with MDL AIC and AICc - RRI2
N = length(xRRI2_0mean);
x = zeros(N, 10);
for order = 1:10
    arCoeffN = aryule(xRRI2_0mean,order);
    x(:,order) = filter(-arCoeffN,1,xRRI2_0mean);
end
error = zeros(N, 10);
for i=1:10
    error(:,i) = (x(:,i) - xRRI2_0mean(:)).^2;
end
cumulativeError = zeros(1,10);
for i = 1:N
    cumulativeError(1,:) = cumulativeError(1,:) + error(i,:);
end
p=1:1:10;
MDL = log(cumulativeError(1,:)) + (p(1,:)*log(N))/N;
AIC = log(cumulativeError(1,:)) + (2*p(1,:))/N;
AICc = AIC + (2*p(1,:).*(p(1,:)+1))./(N-p(1,:)-1); 
subplot(3,2,3);hold on; 
plot(log(cumulativeError), '-k', 'linewidth', 1.5);
plot(p, MDL, '-', 'color', c.red, 'linewidth', 1.5);
plot(p, AIC, '-', 'color', c.darkred, 'linewidth', 1.5);
plot(p, AICc, '-', 'color', c.orange, 'linewidth', 1.5);
title('Model order selection for RRI2', 'FontSize', 15); grid on;
xlabel('Model Order (p)', 'FontSize', 15); ylabel('', 'FontSize', 15);
legend('Cumulative Squared Error','MDL','AIC','AIC_c','location','northwest','FontSize', 12)
% model order selection with PACF - RRI2
[arCoeff,E,rc] = aryule(xRRI2_0mean,10);
subplot(3,2,4);
stem((-1).*rc(:,1), '-', 'color', c.darkred, 'linewidth', 1.5);
title('Partial autocorrelation of RRI2', 'FontSize', 15); grid on;
xlabel('k', 'FontSize', 15); ylabel('PACF', 'FontSize', 15);

clear N x
% model order selection with MDL AIC and AICc - RRI3
N = length(xRRI3_0mean);
x = zeros(N, 10);
for order = 1:10
    arCoeffN = aryule(xRRI3_0mean,order);
    x(:,order) = filter(-arCoeffN,1,xRRI3_0mean);
end
error = zeros(N, 10);
for i=1:10
    error(:,i) = (x(:,i) - xRRI3_0mean(:)).^2;
end
cumulativeError = zeros(1,10);
for i = 1:N
    cumulativeError(1,:) = cumulativeError(1,:) + error(i,:);
end
p=1:1:10;
MDL = log(cumulativeError(1,:)) + (p(1,:)*log(N))/N;
AIC = log(cumulativeError(1,:)) + (2*p(1,:))/N;
AICc = AIC + (2*p(1,:).*(p(1,:)+1))./(N-p(1,:)-1);
subplot(3,2,5);hold on; 
plot(log(cumulativeError), '-k', 'linewidth', 1.5);
plot(p, MDL, '-', 'color', c.red, 'linewidth', 1.5);
plot(p, AIC, '-', 'color', c.darkred, 'linewidth', 1.5);
plot(p, AICc, '-', 'color', c.orange, 'linewidth', 1.5);
title('Model order selection for RRI3', 'FontSize', 15); grid on;
xlabel('Model Order (p)', 'FontSize', 15); ylabel('', 'FontSize', 15);
legend('Cumulative Squared Error','MDL','AIC','AIC_c','location','northwest','FontSize', 12)
% model order selection with PACF - RRI3
[arCoeff,E,rc] = aryule(xRRI3_0mean,10);
subplot(3,2,6);
stem((-1).*rc(:,1), '-', 'color', c.darkred, 'linewidth', 1.5);
title('Partial autocorrelation of RRI3', 'FontSize', 15); grid on;
xlabel('k', 'FontSize', 15); ylabel('PACF', 'FontSize', 15);