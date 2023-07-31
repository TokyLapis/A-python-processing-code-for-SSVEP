import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
# from mne_connectivity import spectral_connectivity
from mne_connectivity.viz import plot_connectivity_circle

# Read the weighted matrix csv file
weighted_matrix = pd.read_csv("D:/ssvepnet/avedeltamatrix/ave_delta_1_15.csv", header=None)


# Make sure the data is in the correct numpy array format
conn = weighted_matrix.to_numpy()

# List of nodes
label_names = ['Fp1', 'Fp2', 'F7', 'F3', 'Fz', 'F4', 'F8', 'T7', 'C3', 'Cz', 'C4', 'T8', 'P7', 'P3', 'Pz', 'P4', 'P8', 'O1', 'O2']

# Plotting the connectivity circle
# plot_connectivity_circle(conn, label_names, n_lines=None, node_angles=None, node_colors=None, title='Connectivity Circle', padding=6.0, fontsize_title=12, fontsize_names=8, fontsize_colorbar=8, linewidth=1.5, colormap='seismic_r', facecolor='white', textcolor='black', node_edgecolor='black', show=True)
# Define a custom colormap
cmap = plt.get_cmap('RdBu_r', 512)
custom_cmap = mcolors.ListedColormap(cmap(np.linspace(0, 1, 512)))

# Plotting the connectivity circle
plot_connectivity_circle(conn, label_names, n_lines=None, node_angles=None, node_colors=None, title='Connectivity Circle', padding=6.0, fontsize_title=12, fontsize_names=8, fontsize_colorbar=8, linewidth=1.5, colormap=custom_cmap, facecolor='white', textcolor='black', node_edgecolor='black', show=True)

