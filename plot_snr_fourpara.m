clc;
clear;

% 设置绘图参数
y_label = 'SNR';
x_label_1 = 'Clustering coefficient';
x_label_2 = 'Characteristic path length';
x_label_3 = 'Global efficiency';
x_label_4 = 'Local efficiency';
y_range = [0 10];
y_ticks = [0 2 4 6 8 10];
x_range_1 = [-0.2 0.4];
x_ticks_1 = [-0.2 0 0.2 0.4];
x_range_2 = [-2 1];
x_ticks_2 = [-2 -1 0 1];
x_range_3 = [-0.2 0.4];
x_ticks_3 = [-0.2 0 0.2 0.4];
x_range_4 = [-0.2 0.4];
x_ticks_4 = [-0.2 0 0.2 0.4];

output_folder = 'D:/ssvepnet/sub_all_fourpara/';

% % 循环遍历所有状态的信噪比
% for state = 1:27
%     % 获取当前状态的信噪比数据
%     filename1 = ['D:/ssvepnet/sub_all_snr/sub_all_snr_', num2str(state), '.csv'];
%     data1 = csvread(filename1);
%     snr_data = data1(:,1); 
% 
%     %获得四个拓扑参数
%     filename2 = ['D:/ssvepnet/sub_all_fourpara/all_fourpara/fourpara_', num2str(state), '.csv'];
%     data2 = csvread(filename2);
%     charpath_data = data2(:,1);
%     cluster_data = data2(:,2);
%     Eglob_data = data2(:,3);
%     Eloc_data = data2(:,4);
% 
%     % 创建散点图
%     fig = figure('Visible', 'off');
%     %左上1
%     subplot(2,2,1);
%     scatter(cluster_data, snr_data, "o", 'MarkerEdgeColor', [0 0 1]);
%     hold on;
%     [rho1, pval1] = corr(cluster_data, snr_data, 'type', 'Pearson');
%     p1 = polyfit(cluster_data, snr_data, 1);
%     x1 = linspace(min(cluster_data),max(cluster_data));
%     y1 = polyval(p1, x1);
%     plot(x1, y1)
% %     hold on;
%     % 设置图形属性
%     xlabel(x_label_1);
%     ylabel(y_label);
% %     title(['State ', num2str(state)]);
% %     subtitle(['r = ' num2str(rho1), '   p = ', num2str(pval1)]);
%     ylim(y_range);
%     yticks(y_ticks);
%     xlim(x_range_1);
%     xticks(x_ticks_1);
% 
%     %右上2
%     subplot(2,2,2);
%     scatter(charpath_data, snr_data, "square", 'MarkerEdgeColor', [0 0 1]);
%     hold on;
%     [rho2, pval2] = corr(charpath_data, snr_data, 'type', 'Pearson');
%     p2 = polyfit(charpath_data, snr_data, 1);
%     x2 = linspace(min(charpath_data),max(charpath_data));
%     y2 = polyval(p2, x2);
%     plot(x2, y2)
% %     hold on;
%     % 设置图形属性
%     xlabel(x_label_2);
%     ylabel(y_label);
% %     title(['State ', num2str(state)]);
% %     subtitle(['r = ' num2str(rho2), '   p = ', num2str(pval2)]);
%     ylim(y_range);
%     yticks(y_ticks);
%     xlim(x_range_2);
%     xticks(x_ticks_2);
%     % 连接每个点
% %     plot(rie_data, snr_data);
% 
%     %左下3
%     subplot(2,2,3);
%     scatter(Eglob_data, snr_data, "^", 'MarkerEdgeColor', [0 0 1]);
%     hold on;
%     [rho3, pval3] = corr(Eglob_data, snr_data, 'type', 'Pearson');
%     p3 = polyfit(Eglob_data, snr_data, 1);
%     x3 = linspace(min(Eglob_data),max(Eglob_data));
%     y3 = polyval(p3, x3);
%     plot(x3, y3)
% %     hold on;
%     % 设置图形属性
%     xlabel(x_label_3);
%     ylabel(y_label);
% %     title(['State ', num2str(state)]);
% %     subtitle(['r = ' num2str(rho3), '   p = ', num2str(pval3)]);
%     ylim(y_range);
%     yticks(y_ticks);
%     xlim(x_range_3);
%     xticks(x_ticks_3);
% 
%     %右下4
%     subplot(2,2,4);
%     scatter(Eloc_data, snr_data, "diamond", 'MarkerEdgeColor', [0 0 1]);
%     hold on;
%     [rho4, pval4] = corr(Eloc_data, snr_data, 'type', 'Pearson');
%     p4 = polyfit(Eloc_data, snr_data, 1);
%     x4 = linspace(min(Eloc_data),max(Eloc_data));
%     y4 = polyval(p4, x4);
%     plot(x4, y4)
% %     hold on;
%     % 设置图形属性
%     xlabel(x_label_4);
%     ylabel(y_label);
% %     title(['State ', num2str(state)]);
% %     subtitle(['r = ' num2str(rho4), '   p = ', num2str(pval4)]);
%     ylim(y_range);
%     yticks(y_ticks);
%     xlim(x_range_4);
%     xticks(x_ticks_4);
% 
%     %给四张图加一个总标题
% %     sgtitle(['State ', num2str(state)]);
%     title(['State ', num2str(state)]);
%     % 保存图像为JPEG文件
%     saveas(fig, [output_folder, 'fourpara_state', num2str(state), '.jpg'], 'jpg');
%     close(fig);
% end

snr_data2 = zeros(10,27);
charpath_data2 = zeros(10,27);
cluster_data2 = zeros(10,27);
Eglob_data2 = zeros(10,27);
Eloc_data2 = zeros(10,27);


% 循环遍历所有状态的信噪比
for state = 1:27
    % 获取当前状态的信噪比数据
    filename1 = ['D:/ssvepnet/sub_all_snr/sub_all_snr_', num2str(state), '.csv'];
    data1 = csvread(filename1);
    snr_data2(:,state) = data1(:,1); 
    
    %获得四个拓扑参数
    filename2 = ['D:/ssvepnet/sub_all_fourpara/all_fourpara/fourpara_', num2str(state), '.csv'];
    data2 = csvread(filename2);
    charpath_data2(:,state) = data2(:,1);
    cluster_data2(:,state) = data2(:,2);
    Eglob_data2(:,state) = data2(:,3);
    Eloc_data2(:,state) = data2(:,4);
end

fre_L = [3,4,10,11,12,16,19,21,22];
fre_M = [1,5,7,13,15,20,24,26,27];
fre_H = [2,6,8,9,14,17,18,23,25];

col_W = [1,4,8,10,14,17,21,24,27];
col_R = [3,5,9,12,15,18,20,22,25];
col_G = [2,6,7,11,13,16,19,23,26];

lum_1 = [1,3,8,11,13,20,21,23,25];
lum_2 = [2,7,10,12,14,15,18,19,24];
lum_3 = [4,5,6,9,16,17,22,26,27];

fre_L_char = zeros(1,90);
fre_L_snr = zeros(1,90);
fre_L_clus = zeros(1,90);
fre_L_Eglo = zeros(1,90);
fre_L_Eloc = zeros(1,90);

fre_M_char = zeros(1,90);
fre_M_snr = zeros(1,90);
fre_M_clus = zeros(1,90);
fre_M_Eglo = zeros(1,90);
fre_M_Eloc = zeros(1,90);

fre_H_char = zeros(1,90);
fre_H_snr = zeros(1,90);
fre_H_clus = zeros(1,90);
fre_H_Eglo = zeros(1,90);
fre_H_Eloc = zeros(1,90);

col_W_char = zeros(1,90);
col_W_snr = zeros(1,90);
col_W_clus = zeros(1,90);
col_W_Eglo = zeros(1,90);
col_W_Eloc = zeros(1,90);

col_R_char = zeros(1,90);
col_R_snr = zeros(1,90);
col_R_clus = zeros(1,90);
col_R_Eglo = zeros(1,90);
col_R_Eloc = zeros(1,90);

col_G_char = zeros(1,90);
col_G_snr = zeros(1,90);
col_G_clus = zeros(1,90);
col_G_Eglo = zeros(1,90);
col_G_Eloc = zeros(1,90);

lum_1_char = zeros(1,90);
lum_1_snr = zeros(1,90);
lum_1_clus = zeros(1,90);
lum_1_Eglo = zeros(1,90);
lum_1_Eloc = zeros(1,90);

lum_2_char = zeros(1,90);
lum_2_snr = zeros(1,90);
lum_2_clus = zeros(1,90);
lum_2_Eglo = zeros(1,90);
lum_2_Eloc = zeros(1,90);

lum_3_char = zeros(1,90);
lum_3_snr = zeros(1,90);
lum_3_clus = zeros(1,90);
lum_3_Eglo = zeros(1,90);
lum_3_Eloc = zeros(1,90);

for i = 1:9
    fre_L_snr((i-1)*10+1 : i*10) = snr_data2(:, fre_L(i));
    fre_L_char((i-1)*10+1 : i*10) = charpath_data2(:, fre_L(i));
    fre_L_clus((i-1)*10+1 : i*10) = cluster_data2(:, fre_L(i));
    fre_L_Eglo((i-1)*10+1 : i*10) = Eglob_data2(:, fre_L(i));
    fre_L_Eloc((i-1)*10+1 : i*10) = Eloc_data2(:, fre_L(i));
    
    fre_M_snr((i-1)*10+1 : i*10) = snr_data2(:, fre_M(i));
    fre_M_char((i-1)*10+1 : i*10) = charpath_data2(:, fre_M(i));
    fre_M_clus((i-1)*10+1 : i*10) = cluster_data2(:, fre_M(i));
    fre_M_Eglo((i-1)*10+1 : i*10) = Eglob_data2(:, fre_M(i));
    fre_M_Eloc((i-1)*10+1 : i*10) = Eloc_data2(:, fre_M(i));
    
    fre_H_snr((i-1)*10+1 : i*10) = snr_data2(:, fre_H(i));
    fre_H_char((i-1)*10+1 : i*10) = charpath_data2(:, fre_H(i));
    fre_H_clus((i-1)*10+1 : i*10) = cluster_data2(:, fre_H(i));
    fre_H_Eglo((i-1)*10+1 : i*10) = Eglob_data2(:, fre_H(i));
    fre_H_Eloc((i-1)*10+1 : i*10) = Eloc_data2(:, fre_H(i));

    col_W_snr((i-1)*10+1 : i*10) = snr_data2(:, col_W(i));
    col_W_char((i-1)*10+1 : i*10) = charpath_data2(:, col_W(i));
    col_W_clus((i-1)*10+1 : i*10) = cluster_data2(:, col_W(i));
    col_W_Eglo((i-1)*10+1 : i*10) = Eglob_data2(:, col_W(i));
    col_W_Eloc((i-1)*10+1 : i*10) = Eloc_data2(:, col_W(i));
    
    col_R_snr((i-1)*10+1 : i*10) = snr_data2(:, col_R(i));
    col_R_char((i-1)*10+1 : i*10) = charpath_data2(:, col_R(i));
    col_R_clus((i-1)*10+1 : i*10) = cluster_data2(:, col_R(i));
    col_R_Eglo((i-1)*10+1 : i*10) = Eglob_data2(:, col_R(i));
    col_R_Eloc((i-1)*10+1 : i*10) = Eloc_data2(:, col_R(i));
    
    col_G_snr((i-1)*10+1 : i*10) = snr_data2(:, col_G(i));
    col_G_char((i-1)*10+1 : i*10) = charpath_data2(:, col_G(i));
    col_G_clus((i-1)*10+1 : i*10) = cluster_data2(:, col_G(i));
    col_G_Eglo((i-1)*10+1 : i*10) = Eglob_data2(:, col_G(i));
    col_G_Eloc((i-1)*10+1 : i*10) = Eloc_data2(:, col_G(i));

    lum_1_snr((i-1)*10+1 : i*10) = snr_data2(:, lum_1(i));
    lum_1_char((i-1)*10+1 : i*10) = charpath_data2(:, lum_1(i));
    lum_1_clus((i-1)*10+1 : i*10) = cluster_data2(:, lum_1(i));
    lum_1_Eglo((i-1)*10+1 : i*10) = Eglob_data2(:, lum_1(i));
    lum_1_Eloc((i-1)*10+1 : i*10) = Eloc_data2(:, lum_1(i));
    
    lum_2_snr((i-1)*10+1 : i*10) = snr_data2(:, lum_2(i));
    lum_2_char((i-1)*10+1 : i*10) = charpath_data2(:, lum_2(i));
    lum_2_clus((i-1)*10+1 : i*10) = cluster_data2(:, lum_2(i));
    lum_2_Eglo((i-1)*10+1 : i*10) = Eglob_data2(:, lum_2(i));
    lum_2_Eloc((i-1)*10+1 : i*10) = Eloc_data2(:, lum_2(i));
    
    lum_3_snr((i-1)*10+1 : i*10) = snr_data2(:, lum_3(i));
    lum_3_char((i-1)*10+1 : i*10) = charpath_data2(:, lum_3(i));
    lum_3_clus((i-1)*10+1 : i*10) = cluster_data2(:, lum_3(i));
    lum_3_Eglo((i-1)*10+1 : i*10) = Eglob_data2(:, lum_3(i));
    lum_3_Eloc((i-1)*10+1 : i*10) = Eloc_data2(:, lum_3(i));
end

% 将变量存入cell数组中
fre_snr_cell = {fre_L_snr, fre_M_snr, fre_H_snr};
fre_char_cell = {fre_L_char, fre_M_char, fre_H_char};
fre_clus_cell = {fre_L_clus, fre_M_clus, fre_H_clus};
fre_Eglo_cell = {fre_L_Eglo, fre_M_Eglo, fre_H_Eglo};
fre_Eloc_cell = {fre_L_Eloc, fre_M_Eloc, fre_H_Eloc};

col_snr_cell = {col_W_snr, col_R_snr, col_G_snr};
col_char_cell = {col_W_char, col_R_char, col_G_char};
col_clus_cell = {col_W_clus, col_R_clus, col_G_clus};
col_Eglo_cell = {col_W_Eglo, col_R_Eglo, col_G_Eglo};
col_Eloc_cell = {col_W_Eloc, col_R_Eloc, col_G_Eloc};

lum_snr_cell = {lum_1_snr, lum_2_snr, lum_3_snr};
lum_char_cell = {lum_1_char, lum_2_char, lum_3_char};
lum_clus_cell = {lum_1_clus, lum_2_clus, lum_3_clus};
lum_Eglo_cell = {lum_1_Eglo, lum_2_Eglo, lum_3_Eglo};
lum_Eloc_cell = {lum_1_Eloc, lum_2_Eloc, lum_3_Eloc};

fre_moji = {'6Hz', '15Hz', '30Hz'};
col_moji = {'White', 'Red', 'Green'};
lum_moji = {'30%', '60%', '90%'};


for i=1:3 

    snr_current = fre_snr_cell{i}';
    cluster_current = fre_clus_cell{i}';
    charpath_current = fre_char_cell{i}';
    Eglob_current = fre_Eglo_cell{i}';
    Eloc_current = fre_Eloc_cell{i}';

% 创建散点图
    fig = figure('Visible', 'off');
    %左上1
    subplot(2,2,1);
    scatter(cluster_current, snr_current, "o", 'MarkerEdgeColor', [0 0 1]);
    hold on;
    [rho1, pval1] = corr(cluster_current, snr_current, 'type', 'Pearson');
    p1 = polyfit(cluster_current, snr_current, 1);
    x1 = linspace(min(cluster_current),max(cluster_current));
    y1 = polyval(p1, x1);
    plot(x1, y1)
%     hold on;
    % 设置图形属性
    xlabel(x_label_1);
    ylabel(y_label);
%     title(['State ', num2str(state)]);
    subtitle(['r = ' num2str(rho1), '   p = ', num2str(pval1)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range_1);
    xticks(x_ticks_1);
    
    %右上2
    subplot(2,2,2);
    scatter(charpath_current, snr_current, "square", 'MarkerEdgeColor', [0 0 1]);
    hold on;
    [rho2, pval2] = corr(charpath_current, snr_current, 'type', 'Pearson');
    p2 = polyfit(charpath_current, snr_current, 1);
    x2 = linspace(min(charpath_current),max(charpath_current));
    y2 = polyval(p2, x2);
    plot(x2, y2)
%     hold on;
    % 设置图形属性
    xlabel(x_label_2);
    ylabel(y_label);
%     title(['State ', num2str(state)]);
    subtitle(['r = ' num2str(rho2), '   p = ', num2str(pval2)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range_2);
    xticks(x_ticks_2);
    % 连接每个点
%     plot(rie_data, snr_data);
    
    %左下3
    subplot(2,2,3);
    scatter(Eglob_current, snr_current, "^", 'MarkerEdgeColor', [0 0 1]);
    hold on;
    [rho3, pval3] = corr(Eglob_current, snr_current, 'type', 'Pearson');
    p3 = polyfit(Eglob_current, snr_current, 1);
    x3 = linspace(min(Eglob_current),max(Eglob_current));
    y3 = polyval(p3, x3);
    plot(x3, y3)
%     hold on;
    % 设置图形属性
    xlabel(x_label_3);
    ylabel(y_label);
%     title(['State ', num2str(state)]);
    subtitle(['r = ' num2str(rho3), '   p = ', num2str(pval3)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range_3);
    xticks(x_ticks_3);
    
    %右下4
    subplot(2,2,4);
    scatter(Eloc_current, snr_current, "diamond", 'MarkerEdgeColor', [0 0 1]);
    hold on;
    [rho4, pval4] = corr(Eloc_current, snr_current, 'type', 'Pearson');
    p4 = polyfit(Eloc_current, snr_current, 1);
    x4 = linspace(min(Eloc_current),max(Eloc_current));
    y4 = polyval(p4, x4);
    plot(x4, y4)
%     hold on;
    % 设置图形属性
    xlabel(x_label_4);
    ylabel(y_label);
%     title(['State ', num2str(state)]);
    subtitle(['r = ' num2str(rho4), '   p = ', num2str(pval4)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range_4);
    xticks(x_ticks_4);
    
    %给四张图加一个总标题
    sgtitle(['Frequency: ', fre_moji{i}]);
    % title(['Frequency: ', fre_moji{i}]);
    % 保存图像为JPEG文件
    saveas(fig, [output_folder, 'fourpara_', fre_moji{i}, '.jpg'], 'jpg');
    close(fig);
end

for i=1:3 

    snr_current = col_snr_cell{i}';
    cluster_current = col_clus_cell{i}';
    charpath_current = col_char_cell{i}';
    Eglob_current = col_Eglo_cell{i}';
    Eloc_current = col_Eloc_cell{i}';

% 创建散点图
    fig = figure('Visible', 'off');
    %左上1
    subplot(2,2,1);
    scatter(cluster_current, snr_current, "o", 'MarkerEdgeColor', [0 0 1]);
    hold on;
    [rho1, pval1] = corr(cluster_current, snr_current, 'type', 'Pearson');
    p1 = polyfit(cluster_current, snr_current, 1);
    x1 = linspace(min(cluster_current),max(cluster_current));
    y1 = polyval(p1, x1);
    plot(x1, y1)
%     hold on;
    % 设置图形属性
    xlabel(x_label_1);
    ylabel(y_label);
%     title(['State ', num2str(state)]);
    subtitle(['r = ' num2str(rho1), '   p = ', num2str(pval1)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range_1);
    xticks(x_ticks_1);
    
    %右上2
    subplot(2,2,2);
    scatter(charpath_current, snr_current, "square", 'MarkerEdgeColor', [0 0 1]);
    hold on;
    [rho2, pval2] = corr(charpath_current, snr_current, 'type', 'Pearson');
    p2 = polyfit(charpath_current, snr_current, 1);
    x2 = linspace(min(charpath_current),max(charpath_current));
    y2 = polyval(p2, x2);
    plot(x2, y2)
%     hold on;
    % 设置图形属性
    xlabel(x_label_2);
    ylabel(y_label);
%     title(['State ', num2str(state)]);
    subtitle(['r = ' num2str(rho2), '   p = ', num2str(pval2)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range_2);
    xticks(x_ticks_2);
    % 连接每个点
%     plot(rie_data, snr_data);
    
    %左下3
    subplot(2,2,3);
    scatter(Eglob_current, snr_current, "^", 'MarkerEdgeColor', [0 0 1]);
    hold on;
    [rho3, pval3] = corr(Eglob_current, snr_current, 'type', 'Pearson');
    p3 = polyfit(Eglob_current, snr_current, 1);
    x3 = linspace(min(Eglob_current),max(Eglob_current));
    y3 = polyval(p3, x3);
    plot(x3, y3)
%     hold on;
    % 设置图形属性
    xlabel(x_label_3);
    ylabel(y_label);
%     title(['State ', num2str(state)]);
    subtitle(['r = ' num2str(rho3), '   p = ', num2str(pval3)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range_3);
    xticks(x_ticks_3);
    
    %右下4
    subplot(2,2,4);
    scatter(Eloc_current, snr_current, "diamond", 'MarkerEdgeColor', [0 0 1]);
    hold on;
    [rho4, pval4] = corr(Eloc_current, snr_current, 'type', 'Pearson');
    p4 = polyfit(Eloc_current, snr_current, 1);
    x4 = linspace(min(Eloc_current),max(Eloc_current));
    y4 = polyval(p4, x4);
    plot(x4, y4)
%     hold on;
    % 设置图形属性
    xlabel(x_label_4);
    ylabel(y_label);
%     title(['State ', num2str(state)]);
    subtitle(['r = ' num2str(rho4), '   p = ', num2str(pval4)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range_4);
    xticks(x_ticks_4);
    
    %给四张图加一个总标题
    sgtitle(['Color: ', col_moji{i}]);
    % title(['Frequency: ', fre_moji{i}]);
    % 保存图像为JPEG文件
    saveas(fig, [output_folder, 'fourpara_', col_moji{i}, '.jpg'], 'jpg');
    close(fig);
end

for i=1:3 

    snr_current = lum_snr_cell{i}';
    cluster_current = lum_clus_cell{i}';
    charpath_current = lum_char_cell{i}';
    Eglob_current = lum_Eglo_cell{i}';
    Eloc_current = lum_Eloc_cell{i}';

% 创建散点图
    fig = figure('Visible', 'off');
    %左上1
    subplot(2,2,1);
    scatter(cluster_current, snr_current, "o", 'MarkerEdgeColor', [0 0 1]);
    hold on;
    [rho1, pval1] = corr(cluster_current, snr_current, 'type', 'Pearson');
    p1 = polyfit(cluster_current, snr_current, 1);
    x1 = linspace(min(cluster_current),max(cluster_current));
    y1 = polyval(p1, x1);
    plot(x1, y1)
%     hold on;
    % 设置图形属性
    xlabel(x_label_1);
    ylabel(y_label);
%     title(['State ', num2str(state)]);
    subtitle(['r = ' num2str(rho1), '   p = ', num2str(pval1)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range_1);
    xticks(x_ticks_1);
    
    %右上2
    subplot(2,2,2);
    scatter(charpath_current, snr_current, "square", 'MarkerEdgeColor', [0 0 1]);
    hold on;
    [rho2, pval2] = corr(charpath_current, snr_current, 'type', 'Pearson');
    p2 = polyfit(charpath_current, snr_current, 1);
    x2 = linspace(min(charpath_current),max(charpath_current));
    y2 = polyval(p2, x2);
    plot(x2, y2)
%     hold on;
    % 设置图形属性
    xlabel(x_label_2);
    ylabel(y_label);
%     title(['State ', num2str(state)]);
    subtitle(['r = ' num2str(rho2), '   p = ', num2str(pval2)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range_2);
    xticks(x_ticks_2);
    % 连接每个点
%     plot(rie_data, snr_data);
    
    %左下3
    subplot(2,2,3);
    scatter(Eglob_current, snr_current, "^", 'MarkerEdgeColor', [0 0 1]);
    hold on;
    [rho3, pval3] = corr(Eglob_current, snr_current, 'type', 'Pearson');
    p3 = polyfit(Eglob_current, snr_current, 1);
    x3 = linspace(min(Eglob_current),max(Eglob_current));
    y3 = polyval(p3, x3);
    plot(x3, y3)
%     hold on;
    % 设置图形属性
    xlabel(x_label_3);
    ylabel(y_label);
%     title(['State ', num2str(state)]);
    subtitle(['r = ' num2str(rho3), '   p = ', num2str(pval3)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range_3);
    xticks(x_ticks_3);
    
    %右下4
    subplot(2,2,4);
    scatter(Eloc_current, snr_current, "diamond", 'MarkerEdgeColor', [0 0 1]);
    hold on;
    [rho4, pval4] = corr(Eloc_current, snr_current, 'type', 'Pearson');
    p4 = polyfit(Eloc_current, snr_current, 1);
    x4 = linspace(min(Eloc_current),max(Eloc_current));
    y4 = polyval(p4, x4);
    plot(x4, y4)
%     hold on;
    % 设置图形属性
    xlabel(x_label_4);
    ylabel(y_label);
%     title(['State ', num2str(state)]);
    subtitle(['r = ' num2str(rho4), '   p = ', num2str(pval4)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range_4);
    xticks(x_ticks_4);
    
    %给四张图加一个总标题
    sgtitle(['Luminance: ', lum_moji{i}]);
    % title(['Frequency: ', fre_moji{i}]);
    % 保存图像为JPEG文件
    saveas(fig, [output_folder, 'fourpara_', lum_moji{i}, '.jpg'], 'jpg');
    close(fig);
end