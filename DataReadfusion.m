function [Fusion_Info] = DataReadfusion(Filename)
Data_Fusion = readtable(strcat(Filename,'_obs_fusion.csv'));

obsolute_time=Data_Fusion.secs+Data_Fusion.nsecs*1e-9;% set bunch with same time instead of local_id
count_data=tabulate(obsolute_time);
count_MAX=max(count_data(:,2));
values_num=9;

Fusion_Info.signals.dimensions=count_MAX*values_num+2;
Fusion_Info.signals.values = zeros(count_MAX*values_num+2,1);

% Fusion_Info.signals.dimensions=281;
% Fusion_Info.signals.values = zeros(281,1);

%values_num=9;
j=0;
m=1;
for i=2:1:length(Data_Fusion.local_id)+1
    if i<=length(Data_Fusion.local_id)
        if(Data_Fusion.secs(i-1)==Data_Fusion.secs(i)&&Data_Fusion.nsecs(i-1)==Data_Fusion.nsecs(i))
        %if (Data_Fusion.local_id(i-1)==Data_Fusion.local_id(i))
            %if (j<=9)
                Fusion_Info.signals.values(j*values_num+3,m) = Data_Fusion.obs_rel_x(i-1);
                Fusion_Info.signals.values(j*values_num+4,m) = -Data_Fusion.obs_rel_y(i-1);
                Fusion_Info.signals.values(j*values_num+5,m) = Data_Fusion.obs_x(i-1);
                Fusion_Info.signals.values(j*values_num+6,m) = -Data_Fusion.obs_y(i-1);
                Fusion_Info.signals.values(j*values_num+7,m) = Data_Fusion.vel_x(i-1);
                Fusion_Info.signals.values(j*values_num+8,m) = -Data_Fusion.vel_y(i-1);
                Fusion_Info.signals.values(j*values_num+9,m) = Data_Fusion.id(i-1);
                Fusion_Info.signals.values(j*values_num+10,m) = Data_Fusion.secs(i-1);
                Fusion_Info.signals.values(j*values_num+11,m) = Data_Fusion.nsecs(i-1);
                j=j+1;
%             else
%                 j=9;
%                 Fusion_Info.signals.values(j*values_num+3,m) = Data_Fusion.obs_rel_x(i-1);
%                 Fusion_Info.signals.values(j*values_num+4,m) = -Data_Fusion.obs_rel_y(i-1);
%                 Fusion_Info.signals.values(j*values_num+5,m) = Data_Fusion.obs_x(i-1);
%                 Fusion_Info.signals.values(j*values_num+6,m) = -Data_Fusion.obs_y(i-1);
%                 Fusion_Info.signals.values(j*values_num+7,m) = Data_Fusion.vel_x(i-1);
%                 Fusion_Info.signals.values(j*values_num+8,m) = -Data_Fusion.vel_y(i-1);
%                 Fusion_Info.signals.values(j*values_num+9,m) = Data_Fusion.id(i-1);
%                 Fusion_Info.signals.values(j*values_num+10,m) = Data_Fusion.secs(i-1);
%                 Fusion_Info.signals.values(j*values_num+11,m) = Data_Fusion.nsecs(i-1);
%             end
        else
            Fusion_Info.signals.values(j*values_num+3,m) = Data_Fusion.obs_rel_x(i-1);
            Fusion_Info.signals.values(j*values_num+4,m) = -Data_Fusion.obs_rel_y(i-1);
            Fusion_Info.signals.values(j*values_num+5,m) = Data_Fusion.obs_x(i-1);
            Fusion_Info.signals.values(j*values_num+6,m) = -Data_Fusion.obs_y(i-1);
            Fusion_Info.signals.values(j*values_num+7,m) = Data_Fusion.vel_x(i-1);
            Fusion_Info.signals.values(j*values_num+8,m) = -Data_Fusion.vel_y(i-1);           
            Fusion_Info.signals.values(j*values_num+9,m) = Data_Fusion.id(i-1);
            Fusion_Info.signals.values(j*values_num+10,m) = Data_Fusion.secs(i-1);
            Fusion_Info.signals.values(j*values_num+11,m) = Data_Fusion.nsecs(i-1);
            Fusion_Info.signals.values(1,m) = j+1;
            Fusion_Info.signals.values(2,m) = Data_Fusion.local_id(i-1);
            Fusion_Info.time(m,1) = Data_Fusion.local_id(i-1)*0.02;
            %Fusion_Info.time(m,1)=Data_Fusion.secs(i-1)+Data_Fusion.nsecs(i-1)*1e-9;
            j=0;
            m=m+1;
        end
    else
        if(Data_Fusion.secs(i-2)==Data_Fusion.secs(i-1)&&Data_Fusion.nsecs(i-2)==Data_Fusion.nsecs(i-1))
        %if Data_Fusion.local_id(i-2)==Data_Fusion.local_id(i-1)
            %if (j<=9)
                Fusion_Info.signals.values(j*values_num+3,m) = Data_Fusion.obs_rel_x(i-1);
                Fusion_Info.signals.values(j*values_num+4,m) = -Data_Fusion.obs_rel_y(i-1);
                Fusion_Info.signals.values(j*values_num+5,m) = Data_Fusion.obs_x(i-1);
                Fusion_Info.signals.values(j*values_num+6,m) = -Data_Fusion.obs_y(i-1);
                Fusion_Info.signals.values(j*values_num+7,m) = Data_Fusion.vel_x(i-1);
                Fusion_Info.signals.values(j*values_num+8,m) = -Data_Fusion.vel_y(i-1);
                Fusion_Info.signals.values(j*values_num+9,m) = Data_Fusion.id(i-1);
                Fusion_Info.signals.values(j*values_num+10,m) = Data_Fusion.secs(i-1);
                Fusion_Info.signals.values(j*values_num+11,m) = Data_Fusion.nsecs(i-1);
%             else
%                 j=9;
%                 Fusion_Info.signals.values(j*values_num+3,m) = Data_Fusion.obs_rel_x(i-1);
%                 Fusion_Info.signals.values(j*values_num+4,m) = -Data_Fusion.obs_rel_y(i-1);
%                 Fusion_Info.signals.values(j*values_num+5,m) = Data_Fusion.obs_x(i-1);
%                 Fusion_Info.signals.values(j*values_num+6,m) = -Data_Fusion.obs_y(i-1);
%                 Fusion_Info.signals.values(j*values_num+7,m) = Data_Fusion.vel_x(i-1);
%                 Fusion_Info.signals.values(j*values_num+8,m) = -Data_Fusion.vel_y(i-1);         
%                 Fusion_Info.signals.values(j*values_num+9,m) = Data_Fusion.id(i-1);
%                 Fusion_Info.signals.values(j*values_num+10,m) = Data_Fusion.secs(i-1);
%                 Fusion_Info.signals.values(j*values_num+11,m) = Data_Fusion.nsecs(i-1);
%             end
        else
            j=0;
            Fusion_Info.signals.values(j*values_num+3,m) = Data_Fusion.obs_rel_x(i-1);
            Fusion_Info.signals.values(j*values_num+4,m) = -Data_Fusion.obs_rel_y(i-1);
            Fusion_Info.signals.values(j*values_num+5,m) = Data_Fusion.obs_x(i-1);
            Fusion_Info.signals.values(j*values_num+6,m) = -Data_Fusion.obs_y(i-1);
            Fusion_Info.signals.values(j*values_num+7,m) = Data_Fusion.vel_x(i-1);
            Fusion_Info.signals.values(j*values_num+8,m) = -Data_Fusion.vel_y(i-1);         
            Fusion_Info.signals.values(j*values_num+9,m) = Data_Fusion.id(i-1);
            Fusion_Info.signals.values(j*values_num+10,m) = Data_Fusion.secs(i-1);
            Fusion_Info.signals.values(j*values_num+11,m) = Data_Fusion.nsecs(i-1);

        end
        
        Fusion_Info.signals.values(1,m) = j+1;
        Fusion_Info.signals.values(2,m) = Data_Fusion.local_id(i-1);
        Fusion_Info.time(m,1) = Data_Fusion.local_id(i-1)*0.02;
        %Fusion_Info.time(m,1)=Data_Fusion.secs(i-1)+Data_Fusion.nsecs(i-1)*1e-9;
        
    end
end
Fusion_Info.signals.values = Fusion_Info.signals.values';
% ME_Info.signals.values(:,1) = (1:1:length(Data)); % total valid number
% ME_Info.signals.values(:,2) = (1:1:length(Data)); % coresponding ID 
% 
% ME_Info.signals.values(:,3) = (1:1:length(Data)); % 1st veh x
% ME_Info.signals.values(:,4) = (1:1:length(Data)); % 1st veh y
% ME_Info.signals.values(:,5) = (1:1:length(Data)); % 1st IN x
% ME_Info.signals.values(:,6) = (1:1:length(Data)); % 1st IN y
% ME_Info.signals.values(:,7) = (1:1:length(Data)); % 1st target ID
% 
% ME_Info.signals.values(:,8) = (1:1:length(Data)); % 2nd veh x
% ME_Info.signals.values(:,9) = (1:1:length(Data)); % 2nd veh y
% ME_Info.signals.values(:,10) = (1:1:length(Data)); % 2nd IN x
% ME_Info.signals.values(:,11) = (1:1:length(Data)); % 2nd IN y
% ME_Info.signals.values(:,12) = (1:1:length(Data)); % 2nd target ID
% 
% ME_Info.signals.values(:,13) = (1:1:length(Data)); % 3rd veh x
% ME_Info.signals.values(:,14) = (1:1:length(Data)); % 3rd veh y
% ME_Info.signals.values(:,15) = (1:1:length(Data)); % 3rd IN x
% ME_Info.signals.values(:,16) = (1:1:length(Data)); % 3rd IN y
% ME_Info.signals.values(:,17) = (1:1:length(Data)); % 3rd target ID
% 
% ME_Info.signals.values(:,18) = (1:1:length(Data)); % 4th veh x
% ME_Info.signals.values(:,19) = (1:1:length(Data)); % 4th veh y
% ME_Info.signals.values(:,20) = (1:1:length(Data)); % 4th IN x
% ME_Info.signals.values(:,21) = (1:1:length(Data)); % 4th IN y
% ME_Info.signals.values(:,22) = (1:1:length(Data)); % 4th target ID
% 
% ME_Info.signals.values(:,23) = (1:1:length(Data)); % 5th veh x
% ME_Info.signals.values(:,24) = (1:1:length(Data)); % 5th veh y
% ME_Info.signals.values(:,25) = (1:1:length(Data)); % 5th IN x
% ME_Info.signals.values(:,26) = (1:1:length(Data)); % 5th IN y
% ME_Info.signals.values(:,27) = (1:1:length(Data)); % 5th target ID
% 
% ME_Info.signals.values(:,28) = (1:1:length(Data)); % 6th veh x
% ME_Info.signals.values(:,29) = (1:1:length(Data)); % 6th veh y
% ME_Info.signals.values(:,30) = (1:1:length(Data)); % 6th IN x
% ME_Info.signals.values(:,31) = (1:1:length(Data)); % 6th IN y
% ME_Info.signals.values(:,32) = (1:1:length(Data)); % 6th target ID
% 
% ME_Info.signals.values(:,33) = (1:1:length(Data)); % 7th veh x
% ME_Info.signals.values(:,34) = (1:1:length(Data)); % 7th veh y
% ME_Info.signals.values(:,35) = (1:1:length(Data)); % 7th IN x
% ME_Info.signals.values(:,36) = (1:1:length(Data)); % 7th IN y
% ME_Info.signals.values(:,37) = (1:1:length(Data)); % 7th target ID
% 
% ME_Info.signals.values(:,38) = (1:1:length(Data)); % 8th veh x
% ME_Info.signals.values(:,39) = (1:1:length(Data)); % 8th veh y
% ME_Info.signals.values(:,40) = (1:1:length(Data)); % 8th IN x
% ME_Info.signals.values(:,41) = (1:1:length(Data)); % 8th IN y
% ME_Info.signals.values(:,42) = (1:1:length(Data)); % 8th target ID
% 
% ME_Info.signals.values(:,43) = (1:1:length(Data)); % 9th veh x
% ME_Info.signals.values(:,44) = (1:1:length(Data)); % 9th veh y
% ME_Info.signals.values(:,45) = (1:1:length(Data)); % 9th IN x
% ME_Info.signals.values(:,46) = (1:1:length(Data)); % 9th IN y
% ME_Info.signals.values(:,47) = (1:1:length(Data)); % 9th target ID
% 
% ME_Info.signals.values(:,48) = (1:1:length(Data)); % 10th veh x
% ME_Info.signals.values(:,49) = (1:1:length(Data)); % 10th veh y
% ME_Info.signals.values(:,50) = (1:1:length(Data)); % 10th IN x
% ME_Info.signals.values(:,51) = (1:1:length(Data)); % 10th IN y
% ME_Info.signals.values(:,52) = (1:1:length(Data)); % 10th target ID

