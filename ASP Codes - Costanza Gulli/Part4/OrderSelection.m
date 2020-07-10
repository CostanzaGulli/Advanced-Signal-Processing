function [MinOrderMDL, MinOrderAIC, MinOrderAICc] = OrderSelection(Input, MaxOrder)

    c = struct('darkred', [139/255   0   0], ...
        'red', [220/255  20/255  60/255], ... 
        'darkorange', [254/255 102/255 13/255],...
        'orange', [255/255 165/255   0],...
        'yellow', [255/255 230/255 0]);


    N = length(Input);
    x = zeros(N, MaxOrder);
    error = zeros(N, MaxOrder);
    for order = 1:MaxOrder
        arCoeffN = aryule(Input,order);
        x(:,order) = filter(-arCoeffN,1,Input);
        error(:,order) = (x(:,order) - Input(:)).^2;
    end
    
    cumulativeError = zeros(1,MaxOrder);
    for i = 1:N
        cumulativeError(1,:) = cumulativeError(1,:) + error(i,:);
    end

    p = 1:1:MaxOrder;
    MDL = log(cumulativeError(1,:)) + (p(1,:)*log(N))/N;
    AIC = log(cumulativeError(1,:)) + (2*p(1,:))/N;
    AICc = AIC + (2*p(1,:).*(p(1,:)+1))./(N-p(1,:)-1);
    
    [m,MinOrderMDL] = min(MDL);
    [m,MinOrderAIC] = min(AIC);
    [m,MinOrderAICc] = min(AICc);
    
    figure; hold on;
    plot(log(cumulativeError), '-k', 'linewidth', 1.5);
    plot(p, MDL, '-', 'color', c.red, 'linewidth', 1.5);
    plot(p, AIC, '-', 'color', c.darkred, 'linewidth', 1.5);
    plot(p, AICc, '-', 'color', c.orange, 'linewidth', 1.5);
    title('Model order selection', 'FontSize', 15); grid on;
    xlabel('Model Order (p)', 'FontSize', 15); ylabel('', 'FontSize', 15);
    legend('Cumulative Squared Error','MDL','AIC','AIC_c','location','northwest','FontSize', 15)
end