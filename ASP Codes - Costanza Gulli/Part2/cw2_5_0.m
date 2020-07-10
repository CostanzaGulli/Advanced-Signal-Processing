%% load data (ecg to rri)
load('RAW.mat');
figure; plot(data);

data1 = data(2799:242300);
data2 = data(259900:501600);
data3 = data(544500:end);

[RRI1,fsRRI]=ECG_to_RRI(data1,fs);
[RRI2,fsRRI2]=ECG_to_RRI(data2,fs);
[RRI3,fsRRI3]=ECG_to_RRI(data3,fs);
save('RRI','RRI1','RRI2','RRI3','fsRRI')