function [px, xaxis] = pgm(x)
    N = length(x);
    px=zeros(N,1);
    for i_f = 1:N
        sum = 0;
        for i_x = 1:N
            sum = sum + x(i_x)*exp(-2i*pi*(i_f-1)*((i_x-1)/N));
        end
        px(i_f) = (1/N)*(abs(sum)^2);
    end
    xaxis = 0:(1/N):(1-(1/N));
end 