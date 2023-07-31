%计算与SNR有相关性的边，在每个频率下跨被试计算
clc;
clear;
%初始化一个cell数组，其中包含了所有的激发静息差值矩阵
deltamatrixs = {'delta_1_15', 'delta_2_30', 'delta_3_6', 'delta_4_6', ...
    'delta_5_15', 'delta_6_30', 'delta_7_15', 'delta_8_30', ...
    'delta_9_30', 'delta_10_6', 'delta_11_6', 'delta_12_6', ...
    'delta_13_15', 'delta_14_30', 'delta_15_15', 'delta_16_6', ...
    'delta_17_30', 'delta_18_30', 'delta_19_6', 'delta_20_15', ...
    'delta_21_6', 'delta_22_6', 'delta_23_30', 'delta_24_15', ...
    'delta_25_30', 'delta_26_15', 'delta_27_15'};
for delta = 1:length(deltamatrixs)
    



    % 读取两个矩阵
    matrix_delta = csvread(['D:\ssvepnet\avedeltamatrix\ave_',deltamatrixs{delta},'.csv']);
    matrix_snr = csvread(['D:\ssvepnet\snrdeltamatrix\snrdeltamatrix',num2str(delta),'.csv']);

    % 检查 matrix_snr 中的 0，将这些位置在 matrix2 中设置为 0
    matrix_delta(matrix_snr == 0) = 0;
    
    % 保存修改后的 matrix2
    csvwrite(['D:/ssvepnet/finalcorrelationsnr/finalcorrelationsnr_',num2str(delta),'.csv'], matrix_delta);
    dlmwrite(['D:/ssvepnet/finalcorrelationsnr/finalcorrelationsnr_',num2str(delta),'.txt'], matrix_delta, 'delimiter', ' ');            
end               

