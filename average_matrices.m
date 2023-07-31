function average_matrices()
    % 请在此处填写n个CSV文件的路径
    file_names = {
        "D:\ssvepnet\z_sub1_sub5_delta\qiao_delta_1_15.csv",
        "D:\ssvepnet\z_sub1_sub5_delta\wu_delta_1_15.csv",
        "D:\ssvepnet\z_sub1_sub5_delta\xu_delta_1_15.csv",
        "D:\ssvepnet\z_sub1_sub5_delta\zhang_delta_1_15.csv",
        "D:\ssvepnet\z_sub1_sub5_delta\zhou_delta_1_15.csv"
    };

    % 读取矩阵文件
    num_files = length(file_names);
    matrices = cell(1, num_files);
    
    for i = 1:num_files
        matrices{i} = csvread(file_names{i});
    end

    % 将矩阵堆叠在一起
    stacked_matrices = cat(3, matrices{:});

    % 计算平均矩阵
    mean_matrix = mean(stacked_matrices, 3);

    % 保存平均矩阵到指定的CSV文件
    output_file_name = "D:\ssvepnet\z_sub1_sub5_delta\all_5_delta.csv";
    csvwrite(output_file_name, mean_matrix);
    
    fprintf('平均矩阵已保存到：%s\n', output_file_name);
end
