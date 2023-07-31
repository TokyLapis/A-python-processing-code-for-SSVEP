clc
clear
file_path = "D:\ssvepnet\sub01wuxiaoliang\matrix\ave_1_15.csv";
matrix = readmatrix(file_path);

% disp(matrix);
% 假设原始矩阵是 matrix，大小为 n x n

% 生成对称矩阵
% symmetric_matrix = matrix + matrix.';
symmetric_matrix = matrix;
% disp(matrix);

%compute clustering coefficient
clustercoef_each_node = clustering_coef_wu(symmetric_matrix);
clustercoef_ave = mean(clustercoef_each_node);

%compute global effiency
Eglob = efficiency_wei(symmetric_matrix); %global effiency

%compute local effiency
Eloc_each_node = efficiency_wei(symmetric_matrix,2); %each node local effiency
Eloc = mean(Eloc_each_node); % average local effiency

%compute characteristic path length
distance_matrix_simplyinverse = convertWeightToDistance(symmetric_matrix);
distance_matrix = distance_wei(distance_matrix_simplyinverse);
char_path = charpath(distance_matrix);







%%
function distance_matrix = convertWeightToDistance(weight_matrix)
    % 使用权重的倒数作为距离的表示
    distance_matrix = 1 ./ weight_matrix;

    % 将无穷大的距离设为0
    distance_matrix(isinf(distance_matrix)) = 0;
end