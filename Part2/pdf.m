function [y, h_centers] = pdf(x, n_bins)
[h_counts, h_centers] = hist(x, n_bins);
y = h_counts./trapz(h_centers, h_counts);
end