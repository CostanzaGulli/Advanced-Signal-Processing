clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0]);

%% sbagliato

load sunspot.dat
sun = sunspot(:,2);
M = length(sun);
P = 2;
rxx = xcorr(sun);
% build x
x(:,1) = rxx(288:end);
% build H
H = zeros(M,P);
for k=1:M
   for i=1:P
       H(k,i) = rxx(k-i+M);
   end
end
a_lse = inv(transpose(H)*H)*transpose(H)*x;

a_yw = aryule(sun,2);