clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0], ...
    'yellow', [255/255 255/255 0]);

%% 2.3.1 
% figure; hold on;
a1_stables = [];
a2_stables = [];
a1_unstables = [];
a2_unstables = [];
N = 1000;

for i = 1:5000
    a1 = (rand(1,1)-0.5)*5;
    a2 = (rand(1,1)-0.5)*3;

    w = wgn(N,1,1);
    a = [a1 a2];
    a = [1 -a];
    x = filter(1, a, w);
    % plot(x)
    
    stable = 1; 
    j=1;
    while j <= N && stable == 1
        if abs(x(j,1)) > 1000
            stable = 0;
        end
        j=j+1;
    end
    if stable == 1
        a1_stables = [a1_stables, a1];
        a2_stables = [a2_stables, a2];
    else 
        a1_unstables = [a1_unstables, a1];
        a2_unstables = [a2_unstables, a2];
    end 
end
figure; plot(a1_stables, a2_stables, '*', 'color', c.darkred, 'linewidth', 1); 
hold on; plot(a1_unstables, a2_unstables, '*', 'color', c.orange, 'linewidth', 1);
plot([-2 0],[-1 1], '-r', 'linewidth', 2);
plot([-2 2],[-1 -1], '-r', 'linewidth', 2);
plot([0 2],[1 -1], '-r', 'linewidth', 2);
% plot([0 0],[1 -1], '-', 'color', c.red, 'linewidth', 1.5);
% a_one = -2:0.1:2;
% a_two = (-1/4).*(a_one.^2);
% plot(a_one,a_two, '-', 'color', c.red, 'linewidth', 1.5);
axis([-2.5 2.5 -1.5 1.5]);
title('Stability region of AR(2) process', 'FontSize', 15); grid on;
xlabel('a_1', 'FontSize', 15); ylabel('a_2', 'FontSize', 15);
legend('stable','unstable','theoretical stability boundaries','FontSize', 12);