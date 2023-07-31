clc;
clear;

% 设置绘图参数
y_label_2 = 'Riemannian distance';
y_label = 'Signal-to-noise ratio';
x_label_2 = 'State';
x_ticks = 1:10;
x_ticks_2 = 1:2:27;
output_folder = 'D:/ssvepnet/';


aveconnect = zeros(27,1);
snrall = zeros(27,1);

for state = 1:27
    filename = ['D:/ssvepnet/sub_all_riemann/sub_all_riemann_', num2str(state), '.csv'];
    data2 = csvread(filename);
    aveconnect(state) = mean(data2);
end

for state = 1:27
    filename = ['D:/ssvepnet/sub_all_snr/sub_all_snr_', num2str(state), '.csv'];
    data2 = csvread(filename);
    snrall(state) = mean(data2);
end

fig = figure('Visible', 'off');
hold on

yyaxis left
scatter(1:27, snrall, 'square', 'MarkerEdgeColor', [0 .7 .9], 'SizeData', 90);

plot(1:27, snrall);
ylabel('Signal-to-noise ratio', 'color', [0 .7 .9]);

yyaxis right
% 创建散点图
% fig = figure('Visible', 'off');
scatter(1:27, aveconnect, "MarkerEdgeColor", [1 0 0]);

% 连接每个点
plot(1:27, aveconnect);

% 设置图形属性
xlabel(x_label_2);
ylabel(y_label_2);

xticks(x_ticks_2);
% xticklabels(x_tick_labels_2);
xtickangle(45);

output_filename = [output_folder, 'riemann_all.jpg'];
% 保存图像为JPEG文件
print(fig, output_filename,'-djpeg', '-r300', '-noui');
close(fig);
