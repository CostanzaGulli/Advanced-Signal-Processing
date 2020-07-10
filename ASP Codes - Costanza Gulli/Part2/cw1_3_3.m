v = zeros(1000,1);
v(1:500) = rand(500,1)-0.5; 
v(501:1000) = rand(500,1)+0.5; 
[y, h_centers] = pdf(v, 10);
figure; bar(h_centers, y);

[y1, h_centers1] = pdf(v(1:500), 10);
figure; subplot(1,2,1); bar(h_centers1, y1);
xaxis = -1:0.1:2.9;
yaxis = zeros(40,1);
yaxis(6:15,1) = 1;
hold on; stairs(xaxis, yaxis, 'linewidth', 2);

[y2, h_centers2] = pdf(v(501:1000), 10);
subplot(1,2,2); bar(h_centers2, y2);
yaxis = zeros(40,1);
yaxis(16:25,1) = 1;
hold on; stairs(xaxis, yaxis, 'linewidth', 2);