import os
import numpy as np
import mne
from mne.time_frequency import tfr_morlet
from mne.preprocessing import ICA
from mne_connectivity.viz import plot_connectivity_circle, plot_sensors_connectivity
# from ssvepfunction import compute_save_resting_frequency_coherence, compute_save_evoked_frequency_coherence, compute_save_delta_coherence, compute_snr
from ssvepfunction import *

#本次实验的刺激顺序为：
#[4, 5, 22, 18, 20, 25, 2, 11, 24, 9, 6, 8, 19, 13, 14, 3, 15, 12, 17, 21, 23, 7, 16, 26, 10, 1, 27]
#[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]

# 创建当前目录下的文件夹来保存相干性矩阵
matrix_output_folder = './matrix'  # 文件夹路径
if not os.path.exists(matrix_output_folder):
    os.makedirs(matrix_output_folder)
#创建当前目录下的文件夹来保存信噪比
snr_output_folder = './snr'  # 文件夹路径
if not os.path.exists(snr_output_folder):
    os.makedirs(snr_output_folder)
#创建当前目录下的文件夹来保存协方差矩阵所计算出的黎曼距离
cov_output_folder = './riemann'  # 文件夹路径
if not os.path.exists(cov_output_folder):
    os.makedirs(cov_output_folder)

#import eeg data
raw = mne.io.read_raw_eeglab('D:/ssvepnet/sub01wuxiaoliang/sub01wuxiaoliang.set', preload=True)

#copy eeg data
raw_cropped = raw.copy()

#locate electrode
channel_mapping = {
    'EEG 000': 'Fp1', 'EEG 001': 'Fpz', 'EEG 002': 'Fp2', 
    'EEG 003': 'AF7', 'EEG 004': 'AF3', 'EEG 005': 'AFz', 
    'EEG 006': 'AF4', 'EEG 007': 'AF8', 'EEG 008': 'F7', 
    'EEG 009': 'F5', 'EEG 010': 'F3', 'EEG 011': 'F1', 
    'EEG 012': 'Fz', 'EEG 013': 'F2', 'EEG 014': 'F4', 
    'EEG 015': 'F6', 'EEG 016': 'F8', 'EEG 017': 'FT7', 
    'EEG 018': 'FC5', 'EEG 019': 'FC3', 'EEG 020': 'FC1', 
    'EEG 021': 'FCz', 'EEG 022': 'FC2', 'EEG 023': 'FC4', 
    'EEG 024': 'FC6', 'EEG 025': 'FT8', 'EEG 026': 'T7', 
    'EEG 027': 'C5', 'EEG 028': 'C3', 'EEG 029': 'C1', 
    'EEG 030': 'Cz', 'EEG 031': 'C2', 'EEG 032': 'C4', 
    'EEG 033': 'C6', 'EEG 034': 'T8', 'EEG 035': 'TP7', 
    'EEG 036': 'CP5', 'EEG 037': 'CP3', 'EEG 038': 'CP1', 
    'EEG 039': 'CPz', 'EEG 040': 'CP2', 'EEG 041': 'CP4', 
    'EEG 042': 'CP6', 'EEG 043': 'TP8', 'EEG 044': 'P7', 
    'EEG 045': 'P5', 'EEG 046': 'P3', 'EEG 047': 'P1', 
    'EEG 048': 'Pz', 'EEG 049': 'P2', 'EEG 050': 'P4', 
    'EEG 051': 'P6', 'EEG 052': 'P8', 'EEG 053': 'PO7', 
    'EEG 054': 'PO3', 'EEG 055': 'POz', 'EEG 056': 'PO4', 
    'EEG 057': 'PO8', 'EEG 058': 'O1', 'EEG 059': 'Oz', 
    'EEG 060': 'O2'
}

# 使用rename_channels函数更改通道名称
raw_cropped.rename_channels(channel_mapping)
# 用standard_1020模板    
easycap_montage = mne.channels.make_standard_montage('standard_1020')

#应用电极位置信息
raw_cropped.set_montage(easycap_montage)



# raw_cropped.plot()
#滤波
raw_filter = raw_cropped.copy()
raw_filter.load_data()
raw_filter.filter(l_freq=1, h_freq=40)
raw_filter.notch_filter(freqs=50, picks='all') 
# raw_filter.plot()

#ICA
ica = ICA(n_components = 15, method = 'fastica', max_iter = 'auto')
ica.fit(raw_filter)
mne.viz.plot_ica_properties(ica, raw_filter, picks=list(range(15)))

# muscle_idx_auto, scores = ica.find_bads_muscle(raw_filter)
# ica.plot_scores(scores, exclude=muscle_idx_auto)

ica.plot_components()
ica.plot_sources(raw_filter)
ica.exclude
# ica.apply(raw_filter)

# raw_filter.plot()
#downsampling
raw = raw_filter
raw.resample(sfreq = 250)
# raw.plot()
# 创建event_dic字典
event_dic = {
    '28': '10000001', '4': '11011101', '5': '11111110',
    '22': '11111101', '18': '11111011', '20': '11110110', 
    '25': '11110111', '2': '11101011', '11': '11100101', 
    '24': '11011010', '9': '11111111', '6': '11101111',
    '8': '11010111', '19': '11101001', '13': '11100110',
    '14': '11011011', '3': '11110101', '15': '11111010',
    '12': '11111001', '17': '11011111', '21': '11010101',
    '23': '11100111', '7': '11101010', '16': '11101101',
    '26': '11101110', '10': '11011001', '1': '11010110', 
    '27': '11011110'
}

# 创建event_id映射字典
event_id = {v: int(k) for k, v in event_dic.items()}

# 通过event_id生成事件
events, _ = mne.events_from_annotations(raw, event_id=event_id)

#events[0][0]的数字并非time，而是采样点的数，除以采样率得到time
samp_point_nums = [event[0] for event in events]
t_events = [t / raw.info['sfreq'] for t in samp_point_nums]

#pick 19 channels for network analysis
ch_names = [
    'Fp1', 'Fp2', 'F7', 
    'F3', 'Fz', 'F4', 
    'F8', 'T7', 'C3', 
    'Cz', 'C4', 'T8', 
    'P7', 'P3', 'Pz', 
    'P4', 'P8', 'O1', 
    'O2'
]
#pick 9 channels for snr computation
ch_names_snr = ['P3', 'Pz', 'P4', 'PO3', 'POz', 'PO4', 'O1', 'Oz', 'O2']

#get the resting state data, cut them into 6 10s epochs
raw_resting = raw.copy()
tmin_resting = t_events[0]  # Convert index to seconds
tmax_resting = t_events[0] + 60  # Convert index to seconds
raw_resting.crop(tmin=tmin_resting, tmax=tmax_resting, include_tmax=True)
resting_state_epochs = mne.make_fixed_length_epochs(raw_resting, duration=10, preload=True)
resting_state_epochs.pick_channels(ch_names=ch_names) #pick 19 channels

#get the evoked state data, cut them into 15 4s epochs, we have 27 evoked states totally
evoked_state_epochs_list = []
evoked_cov_epochs_list = [] #for computing covariance matrix
evoked_snr_epochs_list = [] #for computing SNR

for i in range(1, len(t_events)):  # Loop through evoked states (from t_events[1] to t_events[27])
    tmin_evoked = t_events[i]
    tmax_evoked = tmin_evoked + 60
    
    # Crop the raw data to the evoked state's time window
    raw_evoked = raw.copy()
    raw_evoked.crop(tmin=tmin_evoked, tmax=tmax_evoked, include_tmax=True)
    
    # Create fixed-length epochs for the evoked state
    evoked_state_epochs = mne.make_fixed_length_epochs(raw_evoked, duration=4, preload=True)
    evoked_cov_epochs = mne.make_fixed_length_epochs(raw_evoked, duration=10, preload=True)
    evoked_snr_epochs = mne.make_fixed_length_epochs(raw_evoked, duration=10, preload=True)
    #pick 19 channels & 9 channels for snr computation
    evoked_state_epochs.pick_channels(ch_names=ch_names)
    evoked_cov_epochs.pick_channels(ch_names=ch_names)
    evoked_snr_epochs.pick_channels(ch_names=ch_names_snr) #pick 9 channels for snr computation
    # Add the epochs to the list
    evoked_state_epochs_list.append(evoked_state_epochs)
    evoked_cov_epochs_list.append(evoked_cov_epochs)
    evoked_snr_epochs_list.append(evoked_snr_epochs)

#low frequency
evoked_LF_list_dic = [
    {"data": evoked_state_epochs_list[0], "name": "4"},
    {"data": evoked_state_epochs_list[2], "name": "22"},
    {"data": evoked_state_epochs_list[7], "name": "11"},
    {"data": evoked_state_epochs_list[12], "name": "19"},
    {"data": evoked_state_epochs_list[15], "name": "3"},
    {"data": evoked_state_epochs_list[17], "name": "12"},
    {"data": evoked_state_epochs_list[19], "name": "21"},
    {"data": evoked_state_epochs_list[22], "name": "16"},
    {"data": evoked_state_epochs_list[24], "name": "10"}
]
#medium frequency
evoked_MF_list_dic = [
    {"data": evoked_state_epochs_list[1], "name": "5"},
    {"data": evoked_state_epochs_list[4], "name": "20"},
    {"data": evoked_state_epochs_list[8], "name": "24"},
    {"data": evoked_state_epochs_list[13], "name": "13"},
    {"data": evoked_state_epochs_list[16], "name": "15"},
    {"data": evoked_state_epochs_list[21], "name": "7"},
    {"data": evoked_state_epochs_list[23], "name": "26"},
    {"data": evoked_state_epochs_list[25], "name": "1"},
    {"data": evoked_state_epochs_list[26], "name": "27"}
]

#high frequency
evoked_HF_list_dic = [
    {"data": evoked_state_epochs_list[3], "name": "18"},
    {"data": evoked_state_epochs_list[5], "name": "25"},
    {"data": evoked_state_epochs_list[6], "name": "2"},
    {"data": evoked_state_epochs_list[9], "name": "9"},
    {"data": evoked_state_epochs_list[10], "name": "6"},
    {"data": evoked_state_epochs_list[11], "name": "8"},
    {"data": evoked_state_epochs_list[14], "name": "14"},
    {"data": evoked_state_epochs_list[18], "name": "17"},
    {"data": evoked_state_epochs_list[20], "name": "23"}
]

#evoked covariance matrix dic
evoked_cov_list_dic = [
    {"data": evoked_cov_epochs_list[0], "name": "4"},
    {"data": evoked_cov_epochs_list[1], "name": "5"},
    {"data": evoked_cov_epochs_list[2], "name": "22"},
    {"data": evoked_cov_epochs_list[3], "name": "18"},
    {"data": evoked_cov_epochs_list[4], "name": "20"},
    {"data": evoked_cov_epochs_list[5], "name": "25"},
    {"data": evoked_cov_epochs_list[6], "name": "2"},
    {"data": evoked_cov_epochs_list[7], "name": "11"},
    {"data": evoked_cov_epochs_list[8], "name": "24"},
    {"data": evoked_cov_epochs_list[9], "name": "9"},
    {"data": evoked_cov_epochs_list[10], "name": "6"},
    {"data": evoked_cov_epochs_list[11], "name": "8"},
    {"data": evoked_cov_epochs_list[12], "name": "19"},
    {"data": evoked_cov_epochs_list[13], "name": "13"},
    {"data": evoked_cov_epochs_list[14], "name": "14"},
    {"data": evoked_cov_epochs_list[15], "name": "3"},
    {"data": evoked_cov_epochs_list[16], "name": "15"},
    {"data": evoked_cov_epochs_list[17], "name": "12"},
    {"data": evoked_cov_epochs_list[18], "name": "17"},
    {"data": evoked_cov_epochs_list[19], "name": "21"},
    {"data": evoked_cov_epochs_list[20], "name": "23"},
    {"data": evoked_cov_epochs_list[21], "name": "7"},
    {"data": evoked_cov_epochs_list[22], "name": "16"},
    {"data": evoked_cov_epochs_list[23], "name": "26"},
    {"data": evoked_cov_epochs_list[24], "name": "10"},
    {"data": evoked_cov_epochs_list[25], "name": "1"},
    {"data": evoked_cov_epochs_list[26], "name": "27"}
]

#low frequency snr
evoked_LF_list_dic_snr = [
    {"data": evoked_snr_epochs_list[0], "name": "4"},
    {"data": evoked_snr_epochs_list[2], "name": "22"},
    {"data": evoked_snr_epochs_list[7], "name": "11"},
    {"data": evoked_snr_epochs_list[12], "name": "19"},
    {"data": evoked_snr_epochs_list[15], "name": "3"},
    {"data": evoked_snr_epochs_list[17], "name": "12"},
    {"data": evoked_snr_epochs_list[19], "name": "21"},
    {"data": evoked_snr_epochs_list[22], "name": "16"},
    {"data": evoked_snr_epochs_list[24], "name": "10"}
]
#medium frequency snr
evoked_MF_list_dic_snr = [
    {"data": evoked_snr_epochs_list[1], "name": "5"},
    {"data": evoked_snr_epochs_list[4], "name": "20"},
    {"data": evoked_snr_epochs_list[8], "name": "24"},
    {"data": evoked_snr_epochs_list[13], "name": "13"},
    {"data": evoked_snr_epochs_list[16], "name": "15"},
    {"data": evoked_snr_epochs_list[21], "name": "7"},
    {"data": evoked_snr_epochs_list[23], "name": "26"},
    {"data": evoked_snr_epochs_list[25], "name": "1"},
    {"data": evoked_snr_epochs_list[26], "name": "27"}
]

#high frequency snr
evoked_HF_list_dic_snr = [
    {"data": evoked_state_epochs_list[3], "name": "18"},
    {"data": evoked_state_epochs_list[5], "name": "25"},
    {"data": evoked_state_epochs_list[6], "name": "2"},
    {"data": evoked_state_epochs_list[9], "name": "9"},
    {"data": evoked_state_epochs_list[10], "name": "6"},
    {"data": evoked_state_epochs_list[11], "name": "8"},
    {"data": evoked_state_epochs_list[14], "name": "14"},
    {"data": evoked_state_epochs_list[18], "name": "17"},
    {"data": evoked_state_epochs_list[20], "name": "23"}
]

#计算并保存三种频率下的resting state相干性均值
average_con_resting_data_squeezed_6 = compute_save_resting_frequency_coherence(resting_state_epochs, 6, matrix_output_folder)
average_con_resting_data_squeezed_15 = compute_save_resting_frequency_coherence(resting_state_epochs, 15, matrix_output_folder)
average_con_resting_data_squeezed_30 = compute_save_resting_frequency_coherence(resting_state_epochs, 30, matrix_output_folder)

#计算并保存三种频率下的evoked state相干性均值
compute_save_evoked_frequency_coherence(evoked_LF_list_dic, 6, matrix_output_folder)
compute_save_evoked_frequency_coherence(evoked_MF_list_dic, 15, matrix_output_folder)
compute_save_evoked_frequency_coherence(evoked_HF_list_dic, 30, matrix_output_folder)

#计算并保存三种频率下的evoked state&resting state相干性差值
compute_save_delta_coherence(evoked_LF_list_dic, 6, average_con_resting_data_squeezed_6, matrix_output_folder)
compute_save_delta_coherence(evoked_MF_list_dic, 15, average_con_resting_data_squeezed_15, matrix_output_folder)
compute_save_delta_coherence(evoked_HF_list_dic, 30, average_con_resting_data_squeezed_30, matrix_output_folder)

#计算并保存三种频率下的snr
evoked_snr_6_list = compute_save_snr(evoked_LF_list_dic_snr, 6, snr_output_folder)
evoked_snr_15_list = compute_save_snr(evoked_MF_list_dic_snr, 15, snr_output_folder)
evoked_snr_30_list = compute_save_snr(evoked_HF_list_dic_snr, 30, snr_output_folder)


#compute  covariance matrix of resting state
average_cov_resting_data = compute_resting_covariance(resting_state_epochs)
#compute reimann distance of evoked state minus the resting state based on the covariance matrix
compute_riemann_distance(evoked_cov_list_dic, average_cov_resting_data, cov_output_folder)

print('fucking done')

