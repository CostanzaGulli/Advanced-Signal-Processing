clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0]);

%% load data
load NASDAQ
closingPrice = NASDAQ.Close;
closingDate = NASDAQ.Date;
figure; plot(closingDate, closingPrice, '-', 'color', c.darkred, 'linewidth', 1.2);
title('NASDAQ end-of-day prices', 'FontSize', 15); grid on; 
xlabel('Date', 'FontSize', 15); ylabel('Price', 'FontSize', 15);

%% part 1a
N = length(closingPrice);

x = zeros(N, 10);
for order = 1:10
    arCoeffN = aryule(closingPrice,order);
    x(:,order) = filter(-arCoeffN,1,closingPrice);
end

error = zeros(N, 10);
for i=1:10
    error(:,i) = (x(:,i) - closingPrice(:)).^2;
end
cumulativeError = zeros(1,10);
for i = 1:N
    cumulativeError(1,:) = cumulativeError(1,:) + error(i,:);
end

p=1:1:10;
MDL = log(cumulativeError(1,:)) + (p(1,:)*log(N))/N;
AIC = log(cumulativeError(1,:)) + (2*p(1,:))/N;
AICc = AIC + (2*p(1,:).*(p(1,:)+1))./(N-p(1,:)-1);

figure; hold on;
plot(log(cumulativeError), '-k', 'linewidth', 1.5);
plot(p, MDL, '-', 'color', c.red, 'linewidth', 1.5);
plot(p, AIC, '-', 'color', c.darkred, 'linewidth', 1.5);
plot(p, AICc, '-', 'color', c.orange, 'linewidth', 1.5);

title('Model order selection for the NASDAQ financial index', 'FontSize', 15); grid on; axis([0 11 22.1 22.4])
xlabel('Model Order (p)', 'FontSize', 15); ylabel('', 'FontSize', 15);
legend('Cumulative Squared Error','MDL','AIC','AIC_c','location','northwest','FontSize', 15)

%% part 1a PACF
[arCoeff,E,rc] = aryule(closingPrice,10);
figure;
stem((-1).*rc(:,1), '-', 'color', c.darkred, 'linewidth', 1.5); %.*(-1) because rc IS the PACF coefficients scaled by -1
title('Partial autocorrelation of the NASDAQ financial index', 'FontSize', 15); grid on;
xlabel('k', 'FontSize', 15); ylabel('PACF', 'FontSize', 15); axis([0 11 -0.2 1.1])

%% part c(i)

Ncrlb = 1001:-50:51;
sigma = 51:50:1001;

sigma_crlb = zeros(20,20);
for i=1:20 %index for N
    for j=1:20 %index for sigma
        sigma_crlb(i,j) = (2.*(sigma(j).^4))./(Ncrlb(i));
    end
end
figure; h = heatmap(sigma, Ncrlb, sigma_crlb);
h.Colormap = autumn;
h.ColorScaling = 'log';
title('CRLB of \sigma^2');
xlabel('\sigma'); ylabel('N');

Rxx = xcorr(closingPrice, 'unbiased');
Rxx0 = Rxx(N);
a1_crlb = zeros(20,20);
for i=1:20 %index for N
    for j=1:20 %index for sigma
        a1_crlb(i,j) = (sigma(j).^2)./(Ncrlb(i).*Rxx0);
    end
end
figure; h = heatmap(sigma, Ncrlb, a1_crlb);
h.Colormap = autumn;
h.ColorScaling = 'log';
title('CRLB of a_1');
xlabel('\sigma'); ylabel('N');

%% part c(ii)
arCoeff_1 = aryule(closingPrice,1);
var_a1 = (1/N)*(1-(arCoeff_1(2)^2));

arCoeff_1test = -2:0.001:2;
var_a1test = (1/N).*(1-(arCoeff_1test(:).^2));
plot(arCoeff_1test, var_a1test, '-', 'color', c.red, 'linewidth', 1.5);
title('CRLB for var(a_1) as a_1 changes', 'FontSize', 15); grid on; 
xlabel('a_1', 'FontSize', 15); ylabel('CRLB for var(a_1)', 'FontSize', 15);