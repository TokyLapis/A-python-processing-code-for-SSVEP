%% 读trigger数据fromcyl
[data] = open_files();


data1 = ones(size(data,1),2);
%%
 for i = 1:size(data,1)
    data1(i,1) = extractDoubleFromTable1(data(i,1));
    data1(i,2) = extractDoubleFromTable2(data(i,3));
 end



% 找出时间戳近乎相同的行，并用最小值代替，去除千分之一秒误差
data2 = data1(:,1);
for i = 1:length(data2)-1
    diff_time = data2(i+1) - data2(i);
    if diff_time <= 0.1
        data2(i+1) = data2(i);
    end
end
data1(:,1)=data2;
%%
% 获得时间和触发器编号
timestamps = data1(:,1);
triggers = data1(:,2);

% 将触发器编号转换为二进制
n = numel(timestamps);
binary_triggers = zeros(n, 8);

for i = 1:n
    index = triggers(i) - 8;
    fprintf('i: %d, trigger: %f, index: %d\n', i, triggers(i), index);
    binary_triggers(i, index) = 1;
end

% 按时间汇总二进制触发器
[unique_timestamps, ~, groups] = unique(timestamps);
num_unique_timestamps = numel(unique_timestamps);
binary_output = zeros(num_unique_timestamps, 8);

for i = 1:num_unique_timestamps
    group_indices = groups == i;

    binary_output(i, :) = any(binary_triggers(group_indices, :));
end
%左右翻转
binary_output = fliplr(binary_output);


binary_result = strings(num_unique_timestamps,index);
% 循环遍历每一行
for i = 1:num_unique_timestamps
    % 将每一行的元素拼接为一个字符串
    row_str = sprintf('%d', binary_output(i, :));
    
    % 将字符串转换为数字
    row_num = str2double(row_str);
    
    % 将转换后的数字存储到结果矩阵中
    binary_result(i) = row_num;
end

binary_result = str2double(binary_result);


% 结果整合到一个数组中
result = zeros(num_unique_timestamps, 2);
result(:, 1) = unique_timestamps;
% 填充result的第二列
for i = 1:num_unique_timestamps
    result(i, 2) = binary_result(i,1);
end
%将resting state的trigger改成所需的x81 10000001 对应的DC16与9 以后的实验可删除这句
%result(1,2) = 10000001;
% 显示结果
disp(result);
%将第一次实验错误的trigger改成所需的x81 10000001
save marker.txt -ascii result
%%
function b = extractDoubleFromTable1(a)
    b = a.(1);
    b = b{:, 1};
%     b = str2double(b);
    b = regexp(b,'\d*\.?\d*','match');
    b = str2double(b);
end

function b = extractDoubleFromTable2(a)
    b = a.Var3;
end


function [data] = open_files()
 % Prompt user for filename
   [fname, fdir] = uigetfile( ...
   {'*.txt*', 'Text Files (*.txt*)'}, ...
   'Pick a file');

 % Create fully-formed filename as a string
   filename = fullfile(fdir, fname);

 % Check that file exists
   assert(exist(filename, 'file') == 2, '%s does not exist.', filename);

 % Read in the data, skipping the n first rows 根据annotation文件决定删除前面的几行
   data = readtable(filename,'NumHeaderLines',4);
  

end
