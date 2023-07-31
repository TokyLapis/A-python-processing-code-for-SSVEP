%% 读数据，RT和keyr.corr;去NaN;相乘
[data] = open_files();
% data = readtable('E:/OneDrive - Kyushu University/桌面/eegDataWu/zhou/behavioral_data.csv','NumHeaderLines',3);
% col_vec = table2array(data(:,1));
% col_vec1 = table2array(data(:,2));
% col_vec = removeNaN(col_vec);
% col_vec1 = removeNaN(col_vec1);
% col_vec2 = col_vec.*col_vec1;

%%
data(1,:) = [];
eeg = [data(:,3:11) data(:,24:25) data(:,12:20) data(:,22:23) data(:,26:38) data(:,47:48) data(:,51:74)];
triggerData = data(:,46:-1:39);
heog = data(:,76);
veog = data(:,75);

%% re-reference
common_ref = mean([eeg heog veog],2);
eeg = eeg - common_ref;
veog = veog - common_ref;
heog = heog - common_ref;

%%
eeg = eeg';
function [data] = open_files()
 % Prompt user for filename
   [fname, fdir] = uigetfile( ...
   {'*.csv', 'CSV Files (*.csv)'; ...
   '*.xlsx', 'Excel Files (*.xlsx)'; ...
   '*.txt*', 'Text Files (*.txt*)'}, ...
   'Pick a file');

 % Create fully-formed filename as a string
   filename = fullfile(fdir, fname);

 % Check that file exists
   assert(exist(filename, 'file') == 2, '%s does not exist.', filename);

 % Read in the data, skipping the 5 first rows
   data = csvread(filename,1,0);
end