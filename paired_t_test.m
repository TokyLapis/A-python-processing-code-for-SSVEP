% function paired_t_test()
    % 选择差异矩阵CSV文件
    [file_names, path] = uigetfile('*.csv', '请选择差异矩阵CSV文件', 'MultiSelect', 'on');
    
    if isequal(file_names, 0) || isequal(path, 0)
        disp('未选择文件');
        return;
    end

    % 读取差异矩阵文件 
    num_files = length(file_names);
    diff_matrices = cell(1, num_files);
    
    for i = 1:num_files
        file_name = fullfile(path, file_names{i});
        diff_matrices{i} = csvread(file_name);
    end

    % 将差异矩阵堆叠在一起
    stacked_matrices = cat(3, diff_matrices{:});

    % 计算平均差异矩阵
    mean_diff_matrix = mean(stacked_matrices, 3);

    % 计算标准误差
    standard_error = std(stacked_matrices, 0, 3) / sqrt(num_files);

    % 配对t检验（计算t值）
    t_values = mean_diff_matrix ./ standard_error;

    % 计算p值
    p_values = 2 * tcdf(-abs(t_values), num_files - 1);

    % 显示结果
    fprintf('t-values:\n');
    disp(t_values);
    
    fprintf('\np-values:\n');
    disp(p_values);
% end

% paired_t_test();
