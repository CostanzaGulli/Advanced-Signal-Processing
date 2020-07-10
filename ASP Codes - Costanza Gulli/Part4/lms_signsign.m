function [yHat, e, w] = lms_signsign(x, z, mu, order)
    Nw = order-1;
    N = length(x);

    yHat = zeros(N, 1);
    e = zeros(N, 1);
    w = zeros(order, N);
        
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
        w(:,n+1) = w(:,n) + mu*sign(e(n,1))*sign(xPortion);
    end
end