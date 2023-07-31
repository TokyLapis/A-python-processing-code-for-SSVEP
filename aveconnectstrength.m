clc;
clear;
%初始化一个cell数组，其中包含了所有的被试文件夹
subjects = {'sub01wuxiaoliang', 'sub02xulan', 'sub03zhouhaobo', 'sub04qiaohe', ...
    'sub05zhangyueling', 'sub06chenyiming2', 'sub07wangzihao', 'sub08zhangjingna', ...
    'sub09wangzhaoyang', 'sub10laijunjie'};

%对每个被试进行处理
for sub = 1:length(subjects)
    %初始化一个cell数组，其中包含了当前被试所有的evoke的和resting的文件地址
    filepaths = {[ 'D:/ssvepnet/',subjects{sub},'/matrix/ave_1_15.csv'], [ 'D:/ssvepnet/',subjects{sub},'/matrix/ave_resting_15.csv'];
                ['D:/ssvepnet/',subjects{sub},'/matrix/ave_2_30.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_30.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_3_6.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_6.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_4_6.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_6.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_5_15.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_15.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_6_30.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_30.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_7_15.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_15.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_8_30.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_30.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_9_30.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_30.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_10_6.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_6.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_11_6.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_6.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_12_6.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_6.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_13_15.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_15.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_14_30.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_30.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_15_15.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_15.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_16_6.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_6.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_17_30.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_30.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_18_30.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_30.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_19_6.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_6.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_20_15.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_15.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_21_6.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_6.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_22_6.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_6.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_23_30.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_30.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_24_15.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_15.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_25_30.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_30.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_26_15.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_15.csv'];
                ['D:\ssvepnet\',subjects{sub},'\matrix\ave_27_15.csv'], ['D:\ssvepnet\',subjects{sub},'\matrix\ave_resting_15.csv'];
        };

    %对每对文件地址进行处理
    for i = 1:size(filepaths, 1)
        %读取csv文件
        evoked = csvread(char(filepaths{i, 1}));
        resting = csvread(char(filepaths{i, 2}));

        % 获取矩阵大小
        matrix_size = size(evoked, 1);

        % 计算链接总数
        total_links = matrix_size * (matrix_size - 1) / 2;

        % 获取矩阵的上三角部分（不包括对角线），并计算其元素的总和和平均值
        evoked_sum = sum(sum(triu(evoked, 1)));
        resting_sum = sum(sum(triu(resting, 1)));

        evoked_mean = evoked_sum / total_links;
        resting_mean = resting_sum / total_links;

        % 计算激发态和静息态的平均连接强度的差值
        delta = evoked_mean - resting_mean;

        % 保存差值到csv文件
        csvwrite([ 'D:/ssvepnet/aveconnectstrength/', subjects{sub}, '/sub_', num2str(sub), '_diff_',num2str(i) ,'.csv'], delta);
        
    end
end

%%
% 对每个被试进行处理，保存每个被试每种状态下的值在同一csv文件中
for file_num = 1:27
    % 初始化一个数组用来存储每个被试的对应值
    data = zeros(length(subjects), 1);
    
    for sub = 1:length(subjects)
        % 读取csv文件
        file_path = ['D:/ssvepnet/aveconnectstrength/', subjects{sub}, '/sub_', num2str(sub), '_diff_',num2str(file_num), '.csv'];
        data(sub) = readmatrix(file_path);
    end
    
    % 将数据写入新的csv文件
    new_file_path = ['D:/ssvepnet/aveconnectstrength/sub_all_aveconnectstrength/aveconectstrength_', num2str(file_num), '.csv'];
    writematrix(data, new_file_path);
end
