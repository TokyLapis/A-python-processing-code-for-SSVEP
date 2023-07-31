clc;
clear;
%初始化一个cell数组，其中包含了所有的被试文件夹
subjects = {'sub01wuxiaoliang', 'sub02xulan', 'sub03zhouhaobo', 'sub04qiaohe', ...
    'sub05zhangyueling', 'sub06chenyiming2', 'sub07wangzihao', 'sub08zhangjingna', ...
    'sub09wangzhaoyang', 'sub10laijunjie'};

% 对每个被试进行处理，保存每个被试每种状态下的值在同一csv文件中
for file_num = 1:27
    % 初始化一个数组用来存储每个被试的对应值
    data = zeros(length(subjects), 1);
    
    for sub = 1:length(subjects)
        % 读取csv文件
        file_path = ['D:/ssvepnet/', subjects{sub}, '/snr/snr_', num2str(file_num), '.csv'];
        data(sub) = readmatrix(file_path);
    end
    
    % 将数据写入新的csv文件
    new_file_path = ['D:/ssvepnet/sub_all_snr/sub_all_snr_', num2str(file_num), '.csv'];
    writematrix(data, new_file_path);
end