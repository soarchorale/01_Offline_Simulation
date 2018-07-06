clc;
clear;

%Revised: addpath '~/.../csv' to the Filename
addpath('/home/user/01_matlab/01_Offline_Simulation/Data/src','/home/user/01_matlab/01_Offline_Simulation/Data/csv','/home/user/01_matlab/01_Offline_Simulation/Data/src/Function');
Filename = '/2018-07-02-15-57-52';

DataReadGeneral(Filename);
load DataReadGeneral.mat;
ME_Info = DataReadMobileye(Filename);
ESR_Info = DataReadesr(Filename);
Laser_Info = DataReadlaser(Filename);
Fusion_Info = DataReadfusion(Filename);
Radar_Result_Info = DataReadRadarProcess(Filename);

%ifndef ESR_Info
Laser_Info = ESR_Info;

filename = strcat('/home/user/01_matlab/01_Offline_Simulation/Data/rawdata/',num2str(year),num2str(month),num2str(day),'/frame_timestamp_vc0.txt');
%filename = strcat('/home/nullmax_xuliqing/Work/01_Mainwork/01_Offline_Simulation/Data/rawdata/20180514/frame_timestamp_vc0.txt');
fid=fopen(filename','r'); 
C = textscan(fid,'%d-%d-%d %f:%f:%f +%d: int_time = %d frame_id = %d');
Lookup_Table = [C{:,4},C{:,5},C{:,6},C{:,9}];

year = str2num(year);
month = str2num(month);
day = str2num(day);
