clc;
clear;

%Step 1: Add the workspace according to your path
addpath('/home/user/01_matlab/01_Offline_Simulation/Data/src');
addpath('/home/user/01_matlab/01_Offline_Simulation/Data/csv');
addpath('/home/user/01_matlab/01_Offline_Simulation/Data/src/Function');

%Step 2: Enter the date
Filename = '/2018-07-02-15-57-52';

DataReadGeneral(Filename);
load DataReadGeneral.mat;
ESR_Info = DataReadesr(Filename);
%Laser_Info = DataReadlaser(Filename);   need revision.....
Fusion_Info = DataReadfusion(Filename);
ME_Info = DataReadMobileye(Filename);
Radar_Result_Info = DataReadRadarProcess(Filename);

% ** ifndef ESR_Info, ESR_Info instead ** OPTIONAL  need revision......
Laser_Info = ESR_Info;

%set start_timestamp
start_time_sec=[ESR_Info.signals.values(1,10); Laser_Info.signals.values(1,10); 
                ME_Info.signals.values(1,10); Fusion_Info.signals.values(1,10)];
            
start_time_nsec=[ESR_Info.signals.values(1,11); Laser_Info.signals.values(1,11); 
                ME_Info.signals.values(1,11); Fusion_Info.signals.values(1,11)];

%get minimum start_time
start_time=min(start_time_sec+start_time_nsec*1e-9);

%start_time in coincidence
ESR_Info.time=ESR_Info.time-start_time;
Laser_Info.time=Laser_Info.time-start_time;
ME_Info.time=ME_Info.time-start_time;
%Fusion_Info.time=Fusion_Info.time-start_time;%%%%%%%%% need revision...

filename = strcat('/home/user/01_matlab/01_Offline_Simulation/Data/rawdata/',num2str(year),num2str(month),num2str(day),'/frame_timestamp_vc0.txt');
%filename = strcat('/home/nullmax_xuliqing/Work/01_Mainwork/01_Offline_Simulation/Data/rawdata/20180514/frame_timestamp_vc0.txt');
fid=fopen(filename','r'); 
C = textscan(fid,'%d-%d-%d %f:%f:%f +%d: int_time = %d frame_id = %d');
Lookup_Table = [C{:,4},C{:,5},C{:,6},C{:,9}];

year = str2num(year);% optimizaition needed
month = str2num(month);
day = str2num(day);
