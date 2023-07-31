clc;
clear;

% 设置绘图参数
y_label = 'SNR';
x_label = 'Subjects';
x_label_2 = 'State';
y_range = [0 10];
y_ticks = [0 5 10];
x_ticks = 1:10;
x_ticks_2 = 1:2:27;
x_tick_labels = {'S1', 'S2', 'S3', 'S4', 'S5', 'S6', 'S7', 'S8', 'S9', 'S10'};
x_tick_labels_2 = {'S1', 'S2', 'S3', 'S4', 'S5', 'S6', 'S7', 'S8', 'S9', 'S10', 'S11', 'S12', ...
    'S13', 'S14', 'S15', 'S16', 'S17', 'S18', 'S19', 'S20', 'S21', 'S22', 'S23', 'S24', 'S25', 'S26', 'S27'};
output_folder = 'D:/ssvepnet/sub_all_snr/';

% 循环遍历所有状态的信噪比
for state = 1:27
    % 获取当前状态的信噪比数据
    filename = ['D:/ssvepnet/sub_all_snr/sub_all_snr_', num2str(state), '.csv'];
    data = csvread(filename);
    snr_data = data(:,1); 
    
    % 创建散点图
    fig = figure('Visible', 'off');
    scatter(1:10, snr_data, "blue");
    hold on;
   
    % 连接每个点
    plot(1:10, snr_data);

    %设置纵横比
    pbaspect([4 1 4])
    
    % 设置图形属性
    xlabel(x_label);
    ylabel(y_label);
    title(['State ', num2str(state)]);
    ylim(y_range);
    yticks(y_ticks);
    xticks(x_ticks);
    xticklabels(x_tick_labels);
    
    % 保存图像为JPEG文件
    saveas(fig, [output_folder, 'snr_state', num2str(state), '.jpg'], 'jpg');
    close(fig);
end

emptyarray = zeros(27,1);

for state = 1:27
    filename = ['D:/ssvepnet/sub_all_snr/sub_all_snr_', num2str(state), '.csv'];
    data2 = csvread(filename);
    emptyarray(state) = mean(data2);
end
% 创建散点图
fig = figure('Visible', 'off');
scatter(1:27, emptyarray, "filled", "MarkerFaceColor", [0 .7 .9]);
hold on;

% 连接每个点
plot(1:27, emptyarray);

%设置纵横比
% pbaspect([90 10 90])

%设置数据比例，注意这里的设置与你的需求相反，因为这里是比例，而不是实际长度
% set(gca,'DataAspectRatio',[1 5 1])

% set(gca,'xtick',[0:3:27]);
% set(gca,'ytick',[0:1:10]);

% 设置图形属性
xlabel(x_label_2);
ylabel(y_label);
ylim(y_range);
yticks(y_ticks);
xticks(x_ticks_2);
% xticklabels(x_tick_labels_2);
xtickangle(45);

% 保存图像为JPEG文件
saveas(fig, [output_folder, 'snr_state_all.jpg'], 'jpg');
close(fig);
