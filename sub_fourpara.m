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
        evoked = readmatrix(char(filepaths{i, 1}));
        resting = readmatrix(char(filepaths{i, 2}));

        %计算聚类系数
        clustercoef_each_node_evoked = clustering_coef_wu(evoked);
        clustercoef_ave_evoked = mean(clustercoef_each_node_evoked);
        
        clustercoef_each_node_resting = clustering_coef_wu(resting);
        clustercoef_ave_resting = mean(clustercoef_each_node_resting);

        %计算全局效率
        Eglob_evoked = efficiency_wei(evoked); %global effiency
        Eglob_resting = efficiency_wei(resting); %global effiency
        
        %计算局部效率
        Eloc_each_node_evoked = efficiency_wei(evoked,2); %each node local effiency
        Eloc_evoked = mean(Eloc_each_node_evoked); % average local effiency
        
        Eloc_each_node_resting = efficiency_wei(resting,2); %each node local effiency
        Eloc_resting = mean(Eloc_each_node_resting); % average local effiency
        
        %计算特征路径长度
        char_path_evoked = calculateCharPath(evoked);
        char_path_resting = calculateCharPath(resting);
        
        % 计算激发态和静息态的差值
        delta_clustercoef_ave = clustercoef_ave_evoked - clustercoef_ave_resting;
        delta_Eglob = Eglob_evoked - Eglob_resting;
        delta_Eloc = Eloc_evoked - Eloc_resting;
        delta_char_path = char_path_evoked - char_path_resting;

        %保存结果
        %特征路径长度，聚类系数，全局效率，局部效率
        result = [delta_char_path, delta_clustercoef_ave, delta_Eglob, delta_Eloc];

        % 保存差值到csv文件
        csvwrite([ 'D:/ssvepnet/sub_all_fourpara/', subjects{sub}, '/sub_', num2str(sub), '_fourpara_',num2str(i) ,'.csv'], result);
        
    end
end

%%
% 对每个被试进行处理，保存每个被试每种状态下的值在同一csv文件中
for file_num = 1:27
    % 初始化一个矩阵用来存储每个被试的对应值
    data = zeros(length(subjects), 4);
    
    for sub = 1:length(subjects)
        % 读取csv文件
        file_path = ['D:/ssvepnet/sub_all_fourpara/', subjects{sub}, '/sub_', num2str(sub), '_fourpara_',num2str(file_num), '.csv'];
        data(sub,:) = readmatrix(file_path);
    end
    
    % 将数据写入新的csv文件
    new_file_path = ['D:/ssvepnet/sub_all_fourpara/all_fourpara/fourpara_', num2str(file_num), '.csv'];
    writematrix(data, new_file_path);
end
%%
%定义计算特征路径长度的函数
function char_path = calculateCharPath(symmetric_matrix)
    % 计算特征路径长度
    distance_matrix_simplyinverse = convertWeightToDistance(symmetric_matrix);
    distance_matrix = distance_wei(distance_matrix_simplyinverse);
    char_path = charpath(distance_matrix);
end
%%
function distance_matrix = convertWeightToDistance(weight_matrix)
    % 使用权重的倒数作为距离的表示
    distance_matrix = 1 ./ weight_matrix;

    % 将无穷大的距离设为0
    distance_matrix(isinf(distance_matrix)) = 0;
end