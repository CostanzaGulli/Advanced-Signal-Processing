function [px, xaxis] = pgm(x)   
    N = length(x);
    ft = fft(x);
    px = (1/N).*(abs(ft).^2);
    xaxis = 0:(1/N):(1-(1/N));
end