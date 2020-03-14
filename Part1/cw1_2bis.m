clear all;
%If dim = 1, then mean(A,1) returns a row vector containing the mean of the elements in each column.signal1 =  sum(v1, 1)./N;
%If dim = 1, then std(A,0,1) returns a row vector containing the standard deviation of the elements in each column.
c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0]);

N = 100;
M = 100;
M_bis = 100000;
N2 = 1000;
M2 = 4;

%% signal A
vA = rp1(M,N);
meanA = mean(vA, 1);
stdevA = std(vA, 0, 1);
vA_bis = rp1(M_bis, N);
meanA_bis = mean(vA_bis, 1);
stdevA_bis = std(vA_bis, 0, 1);

figure; 
subplot(1,2,1); plot(meanA, '-', 'color', c.red, 'linewidth', 1.5); 
hold on; plot(meanA_bis, ':', 'color', c.red, 'linewidth', 1.5);
grid on; title('Ensemble mean of RP1, N = 100'); 
legend('M = 100', 'M = 100 000', 'location', 'northwest');
xlabel('sample'); ylabel('mean')

subplot(1,2,2); plot(stdevA, '-', 'color', c.darkred, 'linewidth', 1.5); 
hold on; plot(stdevA_bis, ':', 'color', c.darkred, 'linewidth', 1.5);
grid on; title('Ensemble standard deviation of RP1, N = 100'); 
legend('M = 100', 'M = 100 000', 'location', 'southwest');
xlabel('sample'); ylabel('standard deviation')

vA2 = rp1(M2, N2);
meanA2 = mean(vA2, 2);
stdevA2 = std(vA2, 0, 2);

figure; 
subplot(1,2,1); stem(meanA2, '-', 'color', c.red, 'linewidth', 1.5); 
grid on; title('Time mean of RP1, N = 1000 M = 4'); 
xlabel('realisation'); ylabel('mean')

subplot(1,2,2); stem(stdevA2, '-', 'color', c.darkred, 'linewidth', 1.5); 
grid on; title('Time standard deviation of RP1, N = 1000 M = 4'); 
xlabel('realisation'); ylabel('standard deviation')

%% signal B 
vB =  rp2(M,N);
meanB = mean(vB, 1);
stdevB = std(vB, 0, 1);
vB_bis = rp2(M_bis, N);
meanB_bis = mean(vB_bis, 1);
stdevB_bis = std(vB_bis, 0, 1);

figure; 
subplot(1,2,1); plot(meanB, '-', 'color', c.red, 'linewidth', 1.5); 
hold on; plot(meanB_bis, ':', 'color', c.red, 'linewidth', 1.5);
grid on; title('Ensemble mean of RP2, N = 100'); 
legend('M = 100', 'M = 100 000', 'location', 'northwest');
xlabel('sample'); ylabel('mean')

subplot(1,2,2); plot(stdevB, '-', 'color', c.darkred, 'linewidth', 1.5); 
hold on; plot(stdevB_bis, ':', 'color', c.darkred, 'linewidth', 1.5);
grid on; title('Ensemble standard deviation of RP2, N = 100'); 
legend('M = 100', 'M = 100 000', 'location', 'southwest');
xlabel('sample'); ylabel('standard deviation')

vB2 = rp2(M2, N2);
meanB2 = mean(vB2, 2);
stdevB2 = std(vB2, 0, 2);

figure; 
subplot(1,2,1); stem(meanB2, '-', 'color', c.red, 'linewidth', 1.5); 
grid on; title('Time mean of RP2, N = 1000 M = 4'); 
xlabel('realisation'); ylabel('mean')

subplot(1,2,2); stem(stdevB2, '-', 'color', c.darkred, 'linewidth', 1.5); 
grid on; title('Time standard deviation of RP2, N = 1000 M = 4'); 
xlabel('realisation'); ylabel('standard deviation')

%% signal C
vC =  rp3(M,N);
meanC = mean(vC, 1);
stdevC = std(vC, 0, 1);
vC_bis = rp3(M_bis, N);
meanC_bis = mean(vC_bis, 1);
stdevC_bis = std(vC_bis, 0, 1);

figure; 
subplot(1,2,1); plot(meanC, '-', 'color', c.red, 'linewidth', 1.5); 
hold on; plot(meanC_bis, ':', 'color', c.red, 'linewidth', 1.5);
grid on; title('Ensemble mean of RP3, N = 100'); 
legend('M = 100', 'M = 100 000', 'location', 'northwest');
xlabel('sample'); ylabel('mean')

subplot(1,2,2); plot(stdevC, '-', 'color', c.darkred, 'linewidth', 1.5); 
hold on; plot(stdevC_bis, ':', 'color', c.darkred, 'linewidth', 1.5);
grid on; title('Ensemble standard deviation of RP3, N = 100'); 
legend('M = 100', 'M = 100 000', 'location', 'southwest');
xlabel('sample'); ylabel('standard deviation')

vC2 = rp3(M2, N2);
meanC2 = mean(vC2, 2);
stdevC2 = std(vC2, 0, 2);

figure; 
subplot(1,2,1); stem(meanC2, '-', 'color', c.red, 'linewidth', 1.5); 
grid on; title('Time mean of RP3, N = 1000 M = 4'); 
xlabel('realisation'); ylabel('mean')

subplot(1,2,2); stem(stdevC2, '-', 'color', c.darkred, 'linewidth', 1.5); 
grid on; title('Time standard deviation of RP3, N = 1000 M = 4'); 
xlabel('realisation'); ylabel('standard deviation')
