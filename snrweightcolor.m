clc;
clear;
%计算27种情况在三个维度各三个情况下的加权平均，权值使用snr

snr_all = [];
for i=1:27
    
    snr = csvread(['D:\ssvepnet\sub_all_snr\sub_all_snr_',num2str(i),'.csv']);
    meansnr = mean(snr(:));
    snr_all(i) = meansnr;
end

final_snr_weight = cell(1, 27); % 初始化数值数组

for delta=1:27
    final_snr_weight{delta} = csvread(['D:/ssvepnet/finalcorrelationsnr/finalcorrelationsnr_',num2str(delta),'.csv']);
%     final_snr_weight{delta} = final*(snr_all(delta)/sum(snr_all));
end
% color
final_white = zeros(19,19);
indices_white = [1,4,8,10,14,17,21,24,27];

final_red = zeros(19,19);
indices_red = [3,5,9,12,15,18,20,22,25];

final_green = zeros(19,19);
indices_green = [2,6,7,11,13,16,19,23,26];

% frequency
final_L = zeros(19,19);
indices_L = [3,4,10,11,12,16,19,21,22];

final_M = zeros(19,19);
indices_M = [1,5,7,13,15,20,24,26,27];

final_H = zeros(19,19);
indices_H = [2,6,8,9,14,17,18,23,25];

% luminance
final_1 = zeros(19,19);
indices_1 = [1,3,8,11,13,20,21,23,25];

final_2 = zeros(19,19);
indices_2 = [2,7,10,12,14,15,18,19,24];

final_3 = zeros(19,19);
indices_3 = [4,5,6,9,16,17,22,26,27];
%

for t=1:length(indices_red)
    x = final_snr_weight{indices_red(t)}*(snr_all(indices_red(t))/sum(snr_all(indices_red)));
    final_red = final_red + x;
end
dlmwrite('D:/ssvepnet/snrweightcolor/final_red.txt', final_red, 'delimiter', ' ');

for t=1:length(indices_white)
    x = final_snr_weight{indices_white(t)}*(snr_all(indices_white(t))/sum(snr_all(indices_white)));
    final_white = final_white + x;
end
dlmwrite('D:/ssvepnet/snrweightcolor/final_white.txt', final_white, 'delimiter', ' ');

for t=1:length(indices_green)
    x = final_snr_weight{indices_green(t)}*(snr_all(indices_green(t))/sum(snr_all(indices_green)));
    final_green = final_green + x;
end
dlmwrite('D:/ssvepnet/snrweightcolor/final_green.txt', final_green, 'delimiter', ' ');

for t=1:length(indices_L)
    x = final_snr_weight{indices_L(t)}*(snr_all(indices_L(t))/sum(snr_all(indices_L)));
    final_L = final_L + x;
end
dlmwrite('D:/ssvepnet/snrweightcolor/final_L.txt', final_L, 'delimiter', ' ');

for t=1:length(indices_M)
    x = final_snr_weight{indices_M(t)}*(snr_all(indices_M(t))/sum(snr_all(indices_M)));
    final_M = final_M + x;
end
dlmwrite('D:/ssvepnet/snrweightcolor/final_M.txt', final_M, 'delimiter', ' ');

for t=1:length(indices_H)
    x = final_snr_weight{indices_H(t)}*(snr_all(indices_H(t))/sum(snr_all(indices_H)));
    final_H = final_H + x;
end
dlmwrite('D:/ssvepnet/snrweightcolor/final_H.txt', final_H, 'delimiter', ' ');

for t=1:length(indices_1)
    x = final_snr_weight{indices_1(t)}*(snr_all(indices_1(t))/sum(snr_all(indices_1)));
    final_1 = final_1 + x;
end
dlmwrite('D:/ssvepnet/snrweightcolor/final_1.txt', final_1, 'delimiter', ' ');

for t=1:length(indices_2)
    x = final_snr_weight{indices_2(t)}*(snr_all(indices_2(t))/sum(snr_all(indices_2)));
    final_2 = final_2 + x;
end
dlmwrite('D:/ssvepnet/snrweightcolor/final_2.txt', final_2, 'delimiter', ' ');

for t=1:length(indices_3)
    x = final_snr_weight{indices_3(t)}*(snr_all(indices_3(t))/sum(snr_all(indices_3)));
    final_3 = final_3 + x;
end
dlmwrite('D:/ssvepnet/snrweightcolor/final_3.txt', final_3, 'delimiter', ' ');

