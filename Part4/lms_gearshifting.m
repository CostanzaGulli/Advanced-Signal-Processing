function [yHat, e, w] = lms_gearshifting(x, z, order)
    Nw = order-1;
    N = length(x);

    yHat = zeros(N, 1);
    e = zeros(N, 1);
    w = zeros(order, N);
    
    mu = 0.1; %comment out for lms without gear shifting
    
    w(:,1) = 0;
    for n = 1:N-1
        xPortion = zeros(order,1);
        xPortion(1) = x(n);
        for i = 1:Nw
            if (n-i) > 0
                xPortion(i+1) = x(n-i);
            else
                xPortion(i+1) = 0;
            end
        end
        yHat(n,1) = transpose(w(:,n))*xPortion;
        e(n,1) = z(n,1) - yHat(n,1);
        
        PercentageError = abs(e(n,1)./z(n,1))*100;
        if PercentageError > 90
            mu = 0.1;
        elseif PercentageError < 10
            mu = 0.002;
        else
            mu = 1.225*1e-3*PercentageError - 0.01025;
        end

        
        w(:,n+1) = w(:,n) + mu*e(n,1)*xPortion;
    end
end