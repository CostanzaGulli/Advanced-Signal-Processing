clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0]);

%% 
load sunspot.dat
sun = sunspot(:, 2);
sun = zscore(sun);
N = 100;