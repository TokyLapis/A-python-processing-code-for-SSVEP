# A-python-processing-code-for-SSVEP
This code can be used to process 64-lead EEG data acquired using a Nihon Kogen device.
main.py 处理eeg的主程序
ssvepfunction.py 处理eeg的自定义函数
eegpreprocessing.m 对.data文件进行预处理
marker.m 将annotation转换成所需的marker
average_matrices.m 将多个矩阵合并的程序
paired_t_test.m 配对t检验程序，未使用
avedeltamatrix 将10个被试在27种状态下的连接矩阵做平均再保存
snrdeltamatrix.m 对snr和功能链接做相关性分析的计算程序 保留有相关性的边链接
finalcorrelationsnr 将snrdeltamatrix和avedeltamatrix的结果做计算，将snr与功能连接相关性矩阵中有相关性的元素位置，在平均delta矩阵中做保留
parametersfour.m 计算单个矩阵的四个拓扑参数
parametersfour_multicsv.m 自由选择多个csv文件，计算多个矩阵的四个拓扑参数的平均值
aveconnectstrength.m 计算一种刺激下激发态与静息态的平均连接强度差值，并保存每个被试每个状态下的差值在同一csv文件中
sub_all_snr.m 将所有被试每个状态下的snr保存在同一csv文件中
sub_all_riemann 将所有被试每个状态下的黎曼距离保存在同一csv文件中
sub_all_fourpara 将所有被试的每个状态下的四个拓扑参数计算并保存csv， 并保存每个状态下每个被试的四个参数在同一csv中
plot_snr 画出10个被试在27种情况下的snr连接图
plot_snr_aveconnectstrength画出平均连接强度与snr的散点图并做了拟合与pearson相关性计算
plot_snr_fourpara画出四个拓扑特征与snr的散点图并做了拟合与pearson相关性计算
plot_snr_riemann画出黎曼距离与snr的散点图并做了拟合与pearson相关性计算

使用顺序：EDFbrower从日本光电.EEG文件中导出四个txt文件（.data, .annotation, .signal, .header）. 用matlab中的eegpreprocessing处理.data，用marker处理annotation得到marker.txt。 
使用记事本给marker.txt加第一行为latency与type。
用eeglab导入matlab中的eeg变量，导入marker为event_info。得到.set与.fdt文件
使用main.py和ssvepfunction得到每个被试的三个文件夹，matrix, riemann, snr。使用snrdeltamatrix计算每种状态下snr与功能连接的相关性矩阵。
sub_all_snr.m 将所有被试每个状态下的snr保存在同一csv文件中
parametersfour_multicsv.m 计算多个矩阵的四个拓扑参数
aveconnectstrength.m 计算一种刺激下激发态与静息态的平均连接强度差值，并保存每个被试每个状态下的差值在同一csv文件中
snrdeltamatrix.m 对snr和功能链接做相关性分析的计算程序 保留有相关性的边链接 遍历每种情况，存为csv
sub_all_fourpara 将所有被试的每个状态下的四个拓扑参数计算并保存csv， 并保存每个状态下每个被试的四个参数在同一csv中
