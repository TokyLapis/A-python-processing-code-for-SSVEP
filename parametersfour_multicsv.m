clc
clear

% 选择多个文件
[fileNames, path] = uigetfile('*.csv', 'Select CSV files', 'MultiSelect', 'on');
numFiles = length(fileNames);

% 初始化用于存储结果的变量
char_path_sum = 0;
clustercoef_ave_sum = 0;
Eglob_sum = 0;
Eloc_sum = 0;

for i = 1:numFiles
    file_path = fullfile(path, fileNames{i});
    matrix = readmatrix(file_path);

    % 生成对称矩阵
%     symmetric_matrix = matrix + matrix.';
    symmertric_matrix = matrix;
    % 计算特征值
    %计算聚类系数
    clustercoef_each_node = clustering_coef_wu(symmertric_matrix);
    clustercoef_ave = mean(clustercoef_each_node);

    %计算全局效率
    Eglob = efficiency_wei(symmetric_matrix);

    %计算局部效率
    Eloc_each_node = efficiency_wei(symmetric_matrix, 2);
    Eloc = mean(Eloc_each_node);

    %计算特征路径长度
    distance_matrix_simplyinverse = convertWeightToDistance(symmetric_matrix);
    distance_matrix = distance_wei(distance_matrix_simplyinverse);
    char_path = charpath(distance_matrix);

    % 累加求和
    char_path_sum = char_path_sum + char_path;
    clustercoef_ave_sum = clustercoef_ave_sum + clustercoef_ave;
    Eglob_sum = Eglob_sum + Eglob;
    Eloc_sum = Eloc_sum + Eloc;
end

% 计算平均值
char_path_avg = char_path_sum / numFiles;
clustercoef_ave_avg = clustercoef_ave_sum / numFiles;
Eglob_avg = Eglob_sum / numFiles;
Eloc_avg = Eloc_sum / numFiles;

% 保存结果
%特征路径长度，聚类系数，全局效率，局部效率
result = [char_path_avg, clustercoef_ave_avg, Eglob_avg, Eloc_avg];
file_name = input('Enter the name for the new CSV file: ', 's');
% csvwrite(fullfile(path, [file_name, '.csv']), result);
writematrix(result, fullfile(path, [file_name, '.csv']));


%%
function distance_matrix = convertWeightToDistance(weight_matrix)
    % 使用权重的倒数作为距离的表示
    distance_matrix = 1 ./ weight_matrix;

    % 将无穷大的距离设为0
    distance_matrix(isinf(distance_matrix)) = 0;
end
