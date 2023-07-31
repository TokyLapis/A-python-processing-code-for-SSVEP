clc;
clear;

% 设置绘图参数
y_label = 'SNR';
x_label = 'Riemann Distance';
y_range = [0 10];
y_ticks = [0 2 4 6 8 10];
x_range = [0 10];
x_ticks = [0 5 10];
output_folder = 'D:/ssvepnet/sub_all_riemann/';

% % 循环遍历所有状态的信噪比
% for state = 1:27
%     % 获取当前状态的信噪比数据
%     filename1 = ['D:/ssvepnet/sub_all_snr/sub_all_snr_', num2str(state), '.csv'];
%     data1 = csvread(filename1);
%     snr_data = data1(:,1); 
% 
%     %获得黎曼距离
%     filename2 = ['D:/ssvepnet/sub_all_riemann/sub_all_riemann_', num2str(state), '.csv'];
%     data2 = csvread(filename2);
%     rie_data = data2(:,1);
% 
%     % 创建散点图
%     fig = figure('Visible', 'off');
%     scatter(rie_data, snr_data, "magenta", "*");
%     hold on;
%     [rho, pval] = corr(rie_data, snr_data, 'type', 'Pearson');
%     p = polyfit(rie_data, snr_data, 1);
%     x1 = linspace(min(rie_data),max(rie_data));
%     y1 = polyval(p, x1);
%     plot(x1, y1)
% 
%     % 连接每个点
% %     plot(rie_data, snr_data);
% 
%     %设置纵横比
%     pbaspect([1 1 1])
% 
%     % 设置图形属性
%     xlabel(x_label);
%     ylabel(y_label);
%     title(['State ', num2str(state)]);
%     %subtitle(['r = ' num2str(rho), '   p = ', num2str(pval)]);
%     ylim(y_range);
%     yticks(y_ticks);
%     xlim(x_range);
%     xticks(x_ticks);
% 
%     % 保存图像为JPEG文件
%     saveas(fig, [output_folder, 'dis_state', num2str(state), '.jpg'], 'jpg');
%     close(fig);
% end

fre_L = [3,4,10,11,12,16,19,21,22];
fre_M = [1,5,7,13,15,20,24,26,27];
fre_H = [2,6,8,9,14,17,18,23,25];

col_W = [1,4,8,10,14,17,21,24,27];
col_R = [3,5,9,12,15,18,20,22,25];
col_G = [2,6,7,11,13,16,19,23,26];

lum_1 = [1,3,8,11,13,20,21,23,25];
lum_2 = [2,7,10,12,14,15,18,19,24];
lum_3 = [4,5,6,9,16,17,22,26,27];

snr_data2 = zeros(10,27);
rie_data2 = zeros(10,27);


% 循环遍历所有状态的信噪比
for state = 1:27
    % 获取当前状态的信噪比数据
    filename1 = ['D:/ssvepnet/sub_all_snr/sub_all_snr_', num2str(state), '.csv'];
    data1 = csvread(filename1);
    snr_data2(:,state) = data1(:,1); 
    
    %获得黎曼距离
    filename2 = ['D:/ssvepnet/sub_all_riemann/sub_all_riemann_', num2str(state), '.csv'];
    data2 = csvread(filename2);
    rie_data2(:,state) = data2(:,1);
    
end

fre_L_rie = zeros(1,90);
fre_L_snr = zeros(1,90);
fre_M_rie = zeros(1,90);
fre_M_snr = zeros(1,90);
fre_H_rie = zeros(1,90);
fre_H_snr = zeros(1,90);

col_W_rie = zeros(1,90);
col_W_snr = zeros(1,90);
col_R_rie = zeros(1,90);
col_R_snr = zeros(1,90);
col_G_rie = zeros(1,90);
col_G_snr = zeros(1,90);

lum_1_rie = zeros(1,90);
lum_1_snr = zeros(1,90);
lum_2_rie = zeros(1,90);
lum_2_snr = zeros(1,90);
lum_3_rie = zeros(1,90);
lum_3_snr = zeros(1,90);

for i = 1:9
    fre_L_snr((i-1)*10+1 : i*10) = snr_data2(:, fre_L(i));
    fre_L_rie((i-1)*10+1 : i*10) = rie_data2(:, fre_L(i));
    
    fre_M_snr((i-1)*10+1 : i*10) = snr_data2(:, fre_M(i));
    fre_M_rie((i-1)*10+1 : i*10) = rie_data2(:, fre_M(i));
    
    fre_H_snr((i-1)*10+1 : i*10) = snr_data2(:, fre_H(i));
    fre_H_rie((i-1)*10+1 : i*10) = rie_data2(:, fre_H(i));

    col_W_snr((i-1)*10+1 : i*10) = snr_data2(:, col_W(i));
    col_W_rie((i-1)*10+1 : i*10) = rie_data2(:, col_W(i));
    
    col_R_snr((i-1)*10+1 : i*10) = snr_data2(:, col_R(i));
    col_R_rie((i-1)*10+1 : i*10) = rie_data2(:, col_R(i));
    
    col_G_snr((i-1)*10+1 : i*10) = snr_data2(:, col_G(i));
    col_G_rie((i-1)*10+1 : i*10) = rie_data2(:, col_G(i));

    lum_1_snr((i-1)*10+1 : i*10) = snr_data2(:, lum_1(i));
    lum_1_rie((i-1)*10+1 : i*10) = rie_data2(:, lum_1(i));
    
    lum_2_snr((i-1)*10+1 : i*10) = snr_data2(:, lum_2(i));
    lum_2_rie((i-1)*10+1 : i*10) = rie_data2(:, lum_2(i));
    
    lum_3_snr((i-1)*10+1 : i*10) = snr_data2(:, lum_3(i));
    lum_3_rie((i-1)*10+1 : i*10) = rie_data2(:, lum_3(i));
end

% 将变量存入cell数组中
fre_snr_cell = {fre_L_snr, fre_M_snr, fre_H_snr};
fre_rie_cell = {fre_L_rie, fre_M_rie, fre_H_rie};

col_snr_cell = {col_W_snr, col_R_snr, col_G_snr};
col_rie_cell = {col_W_rie, col_R_rie, col_G_rie};

lum_snr_cell = {lum_1_snr, lum_2_snr, lum_3_snr};
lum_rie_cell = {lum_1_rie, lum_2_rie, lum_3_rie};

fre_moji = {'6Hz', '15Hz', '30Hz'};
col_moji = {'White', 'Red', 'Green'};
lum_moji = {'30%', '60%', '90%'};

for i=1:3 

    snr_current = col_snr_cell{i}';
    rie_current = col_rie_cell{i}';

 % 创建散点图
    fig = figure('Visible', 'off');
    scatter(rie_current, snr_current, "magenta", "*");
    hold on;
    [rho, pval] = corr(rie_current, snr_current, 'type', 'Pearson');
    p = polyfit(rie_current, snr_current, 1);
    x1 = linspace(min(rie_current),max(rie_current));
    y1 = polyval(p, x1);
    plot(x1, y1)
   
    % 连接每个点
%     plot(rie_data, snr_data);

    %设置纵横比
    pbaspect([1 1 1])
    
    % 设置图形属性
    xlabel(x_label);
    ylabel(y_label);
    title(['Frequency: ', fre_moji{i}]);
    subtitle(['r = ' num2str(rho), '   p = ', num2str(pval/100)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range);
    xticks(x_ticks);
    
    % 保存图像为JPEG文件
    saveas(fig, [output_folder, 'rieman_', fre_moji{i}, '.jpg'], 'jpg');
    close(fig);
end

for i=1:3 

    snr_current = fre_snr_cell{i}';
    rie_current = fre_rie_cell{i}';

 % 创建散点图
    fig = figure('Visible', 'off');
    scatter(rie_current, snr_current, "magenta", "*");
    hold on;
    [rho, pval] = corr(rie_current, snr_current, 'type', 'Pearson');
    p = polyfit(rie_current, snr_current, 1);
    x1 = linspace(min(rie_current),max(rie_current));
    y1 = polyval(p, x1);
    plot(x1, y1)
   
    % 连接每个点
%     plot(rie_data, snr_data);

    %设置纵横比
    pbaspect([1 1 1])
    
    % 设置图形属性
    xlabel(x_label);
    ylabel(y_label);
    title(['Color： ', col_moji{i}]);
    subtitle(['r = ' num2str(rho), '   p = ', num2str(pval/100)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range);
    xticks(x_ticks);
    
    % 保存图像为JPEG文件
    saveas(fig, [output_folder, 'rieman_', col_moji{i}, '.jpg'], 'jpg');
    close(fig);
end

for i=1:3 

    snr_current = lum_snr_cell{i}';
    rie_current = lum_rie_cell{i}';

 % 创建散点图
    fig = figure('Visible', 'off');
    scatter(rie_current, snr_current, "magenta", "*");
    hold on;
    [rho, pval] = corr(rie_current, snr_current, 'type', 'Pearson');
    p = polyfit(rie_current, snr_current, 1);
    x1 = linspace(min(rie_current),max(rie_current));
    y1 = polyval(p, x1);
    plot(x1, y1)
   
    % 连接每个点
%     plot(rie_data, snr_data);

    %设置纵横比
    pbaspect([1 1 1])
    
    % 设置图形属性
    xlabel(x_label);
    ylabel(y_label);
    title(['Luminance: ', lum_moji{i}]);
    subtitle(['r = ' num2str(rho), '   p = ', num2str(pval/100)]);
    ylim(y_range);
    yticks(y_ticks);
    xlim(x_range);
    xticks(x_ticks);
    
    % 保存图像为JPEG文件
    saveas(fig, [output_folder, 'rieman_', lum_moji{i}, '.jpg'], 'jpg');
    close(fig);
end