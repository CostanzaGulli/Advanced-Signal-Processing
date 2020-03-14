%% plot for ERROR IN MEAN AND STANDARD DEVIATION ESTIMATION

clear all
c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0]);

th_mean = 0.5;
th_stdev = sqrt(1/12);

figure;
subplot(1,2,1);
nbins = 10;
hold on;
while nbins < 50000
x = rand(1,nbins);
sample_mean = mean(x, 2);
error = th_mean - sample_mean;
plot(nbins, error, 'or')
nbins = nbins + 10;
end
title('Error in sample mean estimation'); xlabel('number of samples N'); ylabel('error'); grid on; 

nbins = 10;
subplot(1,2,2); hold on;
while nbins < 50000
x = rand(1,nbins);
sample_mean = mean(x, 2);
error = th_mean - sample_mean;
plot(nbins, error, 'o', 'color', c.darkred)
nbins = nbins + 10;
end
title('Error in sample standard deviation estimation'); xlabel('number of samples N'); ylabel('error'); grid on; 