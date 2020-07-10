clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0]);

%% 2.3.4 
load sunspot.dat;
sunNormalised = zscore(sunspot(:,2));
N = length(sunNormalised);
w = wgn(N,1,1);

x = zeros(N, 10);
for order = 1:10
    arCoeffN = aryule(sunNormalised,order);
    x(:,order) = filter(-arCoeffN,1,sunNormalised);
end

error = zeros(N, 10);
for i=1:10
    error(:,i) = (x(:,i) - sunNormalised(:)).^2;
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
title('Model order selection', 'FontSize', 15); grid on;
xlabel('Model Order (p)', 'FontSize', 15); ylabel('', 'FontSize', 15);
legend('Cumulative Squared Error','MDL','AIC','AIC_c','location','northwest','FontSize', 15)

