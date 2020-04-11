clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0] );

%% 4.1.0
N = 1000;
x = randn(N, 1); % input

b = [1 2 3 2 1]; % filter coefficients
y = filter(b, [1], x); % MA filter
y = zscore(y);% normalise output to unit variance

eta = 0.1*randn(N,1); %noise
z = y + eta; %output z = signal y + noise eta

SNRz = var(y(:))/var(eta(:)); % SNR of z

%% 4.1.1
Nw = 5;
rxx = xcorr(x, 'unbiased');
rzx = xcorr(z,x, 'unbiased');

% build Pzx
Pzx = zeros(Nw,1);
for i = 1:Nw 
    Pzx(i) = rzx(length(x)-i);
end
    
% build Rxx
Rxx = zeros(Nw, Nw);
for i=1:Nw %row
    for j=1:Nw %col
        Rxx(i,j) = rxx(length(x)+i-j);
    end 
end
wopt = inv(Rxx)*Pzx;

%% 4.1.2
N = 1000;
Nw = 5;
noiseVariance = 0.1;
SNRz = zeros(6,1);
figure; hold on; grid on; title('Wiener coefficient estimate varing noise variance');
for n=1:6
    x = randn(N, 1); % input
    y = filter([1 2 3 2 1], [1], x); % MA filter
    y = zscore(y); % normalise output to unit variance
    eta = sqrt(noiseVariance)*randn(N,1); %noise
    z = y + eta; %output z = signal y + noise eta
    SNRz(n,1) = 10*log10(var(y(:))/var(eta(:))); % SNR of z
    
    rxx = xcorr(x, 'unbiased');
    rzx = xcorr(z,x, 'unbiased');

    % build Pzx
    Pzx = zeros(Nw,1);
    for i = 1:Nw 
        Pzx(i) = rzx(length(x)-i);
    end

    % build Rxx
    Rxx = zeros(Nw, Nw);
    for i=1:Nw %row
        for j=1:Nw %col
            Rxx(i,j) = rxx(length(x)+i-j);
        end 
    end
    
    wopt = inv(Rxx)*Pzx;
    plot(wopt);
   
    noiseVariance = noiseVariance + 1.98;
end