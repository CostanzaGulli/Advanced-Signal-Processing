%% load data (ecg to rri)
load('RAW.mat');
figure; plot(data);

data1 = data(2799:242300);
data2 = data(259900:501600);
data3 = data(544500:end);

[xRRI1,fsRRI1]=ECG_to_RRI(data1,fs);
[xRRI2,fsRRI2]=ECG_to_RRI(data2,fs);
[xRRI3,fsRRI3]=ECG_to_RRI(data3,fs);
save('RRI','xRRI1','xRRI2','xRRI3')