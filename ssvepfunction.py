import os
import numpy as np
import mne
import mne_connectivity
import pyriemann
import matplotlib.pyplot as plt



# #将resting state的raw data crop成6段后使用con的方法的结果等于不crop的完整resting state的结果，epoch[0]的con不等于epoch的con。crop以后的epoch里包含六个epoch，epoch和epoch[0]的type相同。
# #con得到的是严格下三角矩阵，对角线及对角线上元素全为0

#define a function to compute and save the coherence of resting state at diff frequency
def compute_save_resting_frequency_coherence(epochs, frequency, output_folder):
    # 创建一个空列表来存储每个con_resting_data_squeezed
    con_resting_data_squeezed_list = []

    # 遍历每个epochs
    for i in range(len(epochs)):
        con_resting = mne_connectivity.spectral_connectivity_epochs(epochs[i], method='coh', mode='multitaper', sfreq=epochs[i].info['sfreq'],
                                                                fmin=frequency, fmax=frequency, fskip=1, faverage=True, verbose=None)
        con_resting_data = con_resting.get_data(output='dense')
        con_resting_data_squeezed = np.squeeze(con_resting_data)
        con_resting_data_squeezed_list.append(con_resting_data_squeezed)

    # 计算平均的con_resting_data_squeezed
    average_con_resting_data_squeezed = np.mean(con_resting_data_squeezed_list, axis=0)
    symmetric_con = average_con_resting_data_squeezed.copy()

    # 将下三角部分复制到上三角部分
    symmetric_con[np.triu_indices(average_con_resting_data_squeezed.shape[0], 1)] = average_con_resting_data_squeezed.T[np.triu_indices(average_con_resting_data_squeezed.shape[0], 1)]
    #saveto csv
    #np.savetxt('average_con_resting_data_squeezed.csv', average_con_resting_data_squeezed, delimiter=',')
    filename = os.path.join(output_folder, f'ave_resting_{frequency}.csv')
    np.savetxt(filename, symmetric_con, delimiter=',')
    return symmetric_con

#define a function to compute and save the coherence of evoked state at diff frequency(minus resting state at specific frequency)
def compute_save_evoked_frequency_coherence(epochs_list_dic, frequency, output_folder):
    for j in range(len(epochs_list_dic)):
        # 创建一个空列表来存储每个con_evoked_data_squeezed
        con_evoked_data_squeezed_list=[]
        #range中选择15个段中的第几个到第几个，4s一个段
        for i in range(2, 6):
            con_evoked = mne_connectivity.spectral_connectivity_epochs(epochs_list_dic[j]["data"][i], method='coh', mode='multitaper', sfreq=epochs_list_dic[j]["data"][i].info['sfreq'],
                                                    fmin=frequency, fmax=frequency, fskip=1, faverage=True, verbose=None)
            con_evoked_data = con_evoked.get_data(output='dense')
            con_evoked_data_squeezed = np.squeeze(con_evoked_data)
            con_evoked_data_squeezed_list.append(con_evoked_data_squeezed)
        # 计算平均的con_evoked_data_squeezed
        average_con_evoked_data_squeezed = np.mean(con_evoked_data_squeezed_list, axis=0)
        # 将evoked的平均减去resting的平均
        # average_con_evoked_data_squeezed -= average_con_resting_data_squeezed
        symmetric_con = average_con_evoked_data_squeezed.copy()

        # 将下三角部分复制到上三角部分
        symmetric_con[np.triu_indices(average_con_evoked_data_squeezed.shape[0], 1)] = average_con_evoked_data_squeezed.T[np.triu_indices(average_con_evoked_data_squeezed.shape[0], 1)]
        #save to csv
        #np.savetxt('average_con_evoked_data_squeezed_'+str(j)+'.csv', average_con_evoked_data_squeezed, delimiter=',')
        filename = os.path.join(output_folder, f'ave_{epochs_list_dic[j]["name"]}_{frequency}.csv')
        np.savetxt(filename, symmetric_con, delimiter=',')
    return symmetric_con

#define a function to compute and save the coherence of evoked state at diff frequency(minus resting state at specific frequency)
def compute_save_delta_coherence(epochs_list_dic, frequency, average_con_resting_data_squeezed, output_folder):
    for j in range(len(epochs_list_dic)):
        # 创建一个空列表来存储每个con_evoked_data_squeezed
        con_evoked_data_squeezed_list=[]
        #range中选择15个段中的第几个到第几个，4s一个段
        for i in range(2, 6):
            con_evoked = mne_connectivity.spectral_connectivity_epochs(epochs_list_dic[j]["data"][i], method='coh', mode='multitaper', sfreq=epochs_list_dic[j]["data"][i].info['sfreq'],
                                                    fmin=frequency, fmax=frequency, fskip=1, faverage=True, verbose=None)
            con_evoked_data = con_evoked.get_data(output='dense')
            con_evoked_data_squeezed = np.squeeze(con_evoked_data)
            con_evoked_data_squeezed_list.append(con_evoked_data_squeezed)
        # 计算平均的con_evoked_data_squeezed
        average_con_evoked_data_squeezed = np.mean(con_evoked_data_squeezed_list, axis=0)
        # 将evoked的平均减去resting的平均
        average_con_evoked_data_squeezed -= average_con_resting_data_squeezed
        symmetric_con = average_con_evoked_data_squeezed.copy()

        # 将下三角部分复制到上三角部分
        symmetric_con[np.triu_indices(average_con_evoked_data_squeezed.shape[0], 1)] = average_con_evoked_data_squeezed.T[np.triu_indices(average_con_evoked_data_squeezed.shape[0], 1)]
        #save to csv
        #np.savetxt('average_con_evoked_data_squeezed_'+str(j)+'.csv', average_con_evoked_data_squeezed, delimiter=',')
        filename = os.path.join(output_folder, f'delta_{epochs_list_dic[j]["name"]}_{frequency}.csv')
        np.savetxt(filename, symmetric_con, delimiter=',')
    return symmetric_con

#compute SNR across specific frequency evoked epochs
def compute_save_snr(epochs_list_dict, stim_freq, output_folder):
    for j in range(len(epochs_list_dict)):
        each_evoked_epoch_snr_list = []
        for i in range(2, 6):

            # Define frequency bands
            freq_band = (stim_freq - 0.5, stim_freq + 0.5)

            # Compute the power spectral density (PSD) using the Welch method
            #步长设置为0.25Hz，即在1Hz的带宽内除刺激频率外还有四个邻接频率
            psd, freqs = mne.time_frequency.psd_array_welch(epochs_list_dict[j]["data"][i].get_data(), sfreq=epochs_list_dict[j]["data"][i].info['sfreq'], fmin=freq_band[0], fmax=freq_band[1], n_fft=4*int(epochs_list_dict[j]["data"][i].info['sfreq']), average='mean')
            # plt.plot(freqs, psd[:,2].T)
            # Find the index of the stimulus frequency and neighboring frequencies
            stim_freq_idx = np.argmin(np.abs(freqs - stim_freq))
            # neighbor_freqs_idx = [np.argmin(np.abs(freqs - (stim_freq + 0.1 * i))) for i in range(-5, 6) if i != 0]
            # Calculate the start and end index for the neighbor frequencies
            neighbor_start_idx = np.argmin(np.abs(freqs - (stim_freq - 0.5)))  # The start index for the neighbor frequencies
            neighbor_end_idx = np.argmin(np.abs(freqs - (stim_freq + 0.5)))  # The end index for the neighbor frequencies
            # Get the indices of the neighboring frequencies
            neighbor_freqs_idx = list(range(neighbor_start_idx, neighbor_end_idx + 1))
            neighbor_freqs_idx.remove(stim_freq_idx)  # Remove the stimulus frequency index from the neighbor frequencies

            # Print the frequency values for debugging
            print("Stimulus frequency:", freqs[stim_freq_idx])
            print("Neighbor frequencies:", freqs[neighbor_freqs_idx])

            # Calculate the SNR
            # np.mean(psd[:, :, neighbor_freq_idx], axis=1) will return the mean of the psd across len(neighbor_freq_idx) frequency, and got len(neighbor_freq_idx)
            # 计算snr的分母只有刺激频率的psd，分子上应该有其余几个频率的psd的平均，除数是其余频率的数量，但由于np.mean方法将数组元素全部平均，因此不必再次除频率数量
            snr = np.mean(psd[:, :, stim_freq_idx])/ np.mean(psd[:, :, neighbor_freqs_idx])
            #append
            each_evoked_epoch_snr_list.append(snr)
        average_each_evoked_epoch_snr = np.mean(each_evoked_epoch_snr_list)
        # 转换为字符串
        average_each_evoked_epoch_snr_str = str(average_each_evoked_epoch_snr)
        #save
        filename = os.path.join(output_folder, f'snr_{epochs_list_dict[j]["name"]}.csv')
        with open(filename, 'w') as file:
            file.write(average_each_evoked_epoch_snr_str)
        # sp_evoked_snr_list.append(average_each_evoked_epoch_snr)
    return average_each_evoked_epoch_snr_str

#define a function to compute the covariance matrix of resting state 
def compute_resting_covariance(epochs):
    # 创建一个空列表来存储每个con_resting_data_squeezed
    cov_resting_data_list = []

    # 遍历每个epochs
    for i in range(len(epochs)):
        cov_resting = mne.compute_covariance(epochs[i], method='empirical')
        cov_resting_data = cov_resting.data
        cov_resting_data_list.append(cov_resting_data)

    # 计算平均的con_resting_data_sque
    average_cov_resting_data = np.mean(cov_resting_data_list, axis=0)
    return average_cov_resting_data

#define a function to compute and save the covariance matrix of evoked state (minus resting state)
def compute_riemann_distance(epochs_list_dic, average_cov_resting_data, output_folder):
    for j in range(len(epochs_list_dic)):
        # 创建一个空列表来存储每个cov_evoked_data_squeezed
        cov_evoked_data_list=[]
        #range中选择6个段，10s一个段
        for i in range(len(epochs_list_dic[j])):
            cov_evoked = mne.compute_covariance(epochs_list_dic[j]["data"][i], method='empirical')
            cov_evoked_data = cov_evoked.data
            cov_evoked_data_list.append(cov_evoked_data)
        # 计算平均的cov_evoked_data
        average_cov_evoked_data = np.mean(cov_evoked_data_list, axis=0)
        #计算黎曼距离
        distance_riemann = pyriemann.utils.distance.distance_riemann(average_cov_evoked_data, average_cov_resting_data)
        # 转换为字符串
        distance_riemann_str = str(distance_riemann)
        #save
        filename = os.path.join(output_folder, f'riemannian_{epochs_list_dic[j]["name"]}.csv')
        with open(filename, 'w') as file:
            file.write(distance_riemann_str)
    return distance_riemann