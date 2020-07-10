clear all
c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0]);

%% 1.1.1 and 1.1.2 sample mean and standard deviation
n = 1000;
x1 = randn(n, 1);
e(1:n) = mean(x1);
s(1:n)= std(x1);

xval = 1:n;
figure
plot(x1, 'o', 'color', c.orange, 'linewidth', 1.5);
title('randn: x = N(0,1)','FontSize', 15); grid on; 
xlabel('sample','FontSize', 15); ylabel('x','FontSize', 15); hold on;
plot(xval, e, '-r', 'linewidth', 2);
plot(xval, s, '-', 'color', c.darkred, 'linewidth', 2);
legend('randn realisations', 'sample mean', 'sample standard deviation','FontSize', 15);

%% 1.1.3 sample mean and standard deviation errors
clear xval e s

n_realisations = 10;
x2 = randn(n_realisations, n); 
sample_mean = mean(x2, 2);
sample_stdeviation = std(x2, 0, 2);

xval = 1:n_realisations;
figure
subplot(1,2,1)
plot(xval, sample_mean, 'or', 'LineWidth', 1.5);
hold on; grid on; title('Sample Mean Estimation','FontSize', 15);
theoretical_mean(1:n_realisations) = 0;
plot(xval, theoretical_mean, '-r', 'LineWidth', 1.5);
plot(0, 0.5, 'ow');
plot(0, -0.5, 'ow');
legend('sample mean', 'theoretical mean','FontSize', 15); 
xlabel('realisation','FontSize', 15); ylabel('mean','FontSize', 15)

subplot(1,2,2)
plot(xval, sample_stdeviation, 'o', 'color', c.darkred, 'LineWidth', 1.5);
hold on; grid on; title('Sample Standard Deviation Estimation','FontSize', 15);
theoretical_stdeviation(1:n_realisations) = 1;
plot(xval, theoretical_stdeviation, '-', 'color', c.darkred, 'LineWidth', 1.5);
plot(0, 0, 'ow');
plot(0, 1.5, 'ow');
legend('sample st deviation','theoretical st deviation', 'location','southwest','FontSize', 15);
xlabel('realisation','FontSize', 15); ylabel('standard deviation','FontSize', 15)

%% 1.1.3 plot for error in mean and standard deviation estimation
th_mean = 0;
th_stdev = 1;

figure;
subplot(1,2,1);
nbins = 10;
hold on;
while nbins < 100000
x = randn(1,nbins);
sample_mean = mean(x, 2);
error = th_mean - sample_mean;
plot(nbins, error, 'or')
nbins = nbins + 10;
end
title('Error in sample mean estimation'); xlabel('number of samples N'); ylabel('error'); grid on; 

nbins = 10;
subplot(1,2,2); hold on;
while nbins < 100000
x = randn(1,nbins);
sample_mean = mean(x, 2);
error = th_mean - sample_mean;
plot(nbins, error, 'o', 'color', c.darkred)
nbins = nbins + 10;
end
title('Error in sample standard deviation estimation'); xlabel('number of samples N'); ylabel('error'); grid on; 

%% 1.1.4 pdf estimation
figure;
xval2 = -5:0.01:5;
theoretical_psd = (1/sqrt(2*pi)).*exp((-1/2).*(xval2.^2));

n = 1000;
n_bins = 10;
x1 = randn(n, 1);
subplot(1,4,1)
[h_counts, h_centers] = hist(x1, n_bins); 
%h_counts = h_counts./(n/n_bins); 
h_counts = h_counts./trapz(h_centers, h_counts); 
bar(h_centers, h_counts, 'FaceColor', c.orange, 'EdgeColor', c.orange);
hold on; plot(xval2, theoretical_psd, '-r', 'LineWidth', 2);
grid on; title('10 bins; 1000 samples','FontSize', 15); xlabel('x','FontSize', 15); ylabel('f_X(x)','FontSize', 15);
legend('PSD Estimation','Theoretical PSD','location','southwest','FontSize', 15);
clear n n_bins x1 h_counts h_centers

n = 1000;
n_bins = 100;
x1 = randn(n, 1);
subplot(1,4,2)
[h_counts, h_centers] = hist(x1, n_bins); 
h_counts = h_counts./trapz(h_centers, h_counts);  
bar(h_centers, h_counts, 'FaceColor', c.orange, 'EdgeColor', c.orange);
hold on; plot(xval2, theoretical_psd, '-r', 'LineWidth', 2);
grid on; title('100 bins; 1000 samples','FontSize', 15); xlabel('x','FontSize', 15); ylabel('f_X(x)','FontSize', 15);
clear n n_bins x1 h_counts h_centers

n = 100000;
n_bins = 10;
x1 = randn(n, 1);
subplot(1,4,3)
[h_counts, h_centers] = hist(x1, n_bins); 
h_counts = h_counts./trapz(h_centers, h_counts);  
bar(h_centers, h_counts, 'FaceColor', c.orange, 'EdgeColor', c.orange);
hold on; plot(xval2, theoretical_psd, '-r', 'LineWidth', 2);
grid on; title('10 bins; 100 000 samples','FontSize', 15); xlabel('x','FontSize', 15); ylabel('f_X(x)','FontSize', 15);
clear n n_bins x1 h_counts h_centers

n = 100000;
n_bins = 100;
x1 = randn(n, 1);
subplot(1,4,4)
[h_counts, h_centers] = hist(x1, n_bins); 
h_counts = h_counts./trapz(h_centers, h_counts); 
bar(h_centers, h_counts, 'FaceColor', c.orange, 'EdgeColor', c.orange);
hold on; plot(xval2, theoretical_psd, '-r', 'LineWidth', 2);
grid on; title('100 bins; 100 000 samples','FontSize', 15); xlabel('x','FontSize', 15); ylabel('f_X(x)','FontSize', 15);
clear n n_bins x1 h_counts h_centers