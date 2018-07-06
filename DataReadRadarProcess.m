function [Radar_Info] = DataReadRadarProcess(Filename)
Data = readtable(strcat(Filename,'_radar_process.csv'));
Radar_Info.signals.dimensions=312;
Radar_Info.signals.values = zeros(312,1);
j=0;
m=1;
for i=2:1:length(Data.local_id)+1
    if i<=length(Data.local_id)
        if (Data.local_id(i-1)==Data.local_id(i))
            if (j<=29)
                Radar_Info.signals.values(j*10+3,m) = Data.track_id(i-1);
                Radar_Info.signals.values(j*10+4,m) = Data.track_shape_x(i-1);
                Radar_Info.signals.values(j*10+5,m) = Data.track_shape_y(i-1);
                Radar_Info.signals.values(j*10+6,m) = Data.linear_velocity_x(i-1);
                Radar_Info.signals.values(j*10+7,m) = Data.linear_velocity_y(i-1);
                Radar_Info.signals.values(j*10+8,m) = Data.time_id(i-1);                             
                Radar_Info.signals.values(j*10+9,m) = Data.s_current_idx(i-1);
                Radar_Info.signals.values(j*10+10,m) = Data.obs_id(i-1);
                Radar_Info.signals.values(j*10+11,m) = Data.tracked_times(i-1);
                Radar_Info.signals.values(j*10+12,m) = Data.tracking_time(i-1);
                
                j=j+1;
            else
                j=29;
                Radar_Info.signals.values(j*10+3,m) = Data.track_id(i-1);
                Radar_Info.signals.values(j*10+4,m) = Data.track_shape_x(i-1);
                Radar_Info.signals.values(j*10+5,m) = Data.track_shape_y(i-1);
                Radar_Info.signals.values(j*10+6,m) = Data.linear_velocity_x(i-1);
                Radar_Info.signals.values(j*10+7,m) = Data.linear_velocity_y(i-1);
                Radar_Info.signals.values(j*10+8,m) = Data.time_id(i-1);                             
                Radar_Info.signals.values(j*10+9,m) = Data.s_current_idx(i-1);
                Radar_Info.signals.values(j*10+10,m) = Data.obs_id(i-1);
                Radar_Info.signals.values(j*10+11,m) = Data.tracked_times(i-1);
                Radar_Info.signals.values(j*10+12,m) = Data.tracking_time(i-1);
            end
        else
            Radar_Info.signals.values(j*10+3,m) = Data.track_id(i-1);
            Radar_Info.signals.values(j*10+4,m) = Data.track_shape_x(i-1);
            Radar_Info.signals.values(j*10+5,m) = Data.track_shape_y(i-1);
            Radar_Info.signals.values(j*10+6,m) = Data.linear_velocity_x(i-1);
            Radar_Info.signals.values(j*10+7,m) = Data.linear_velocity_y(i-1);
            Radar_Info.signals.values(j*10+8,m) = Data.time_id(i-1);                             
            Radar_Info.signals.values(j*10+9,m) = Data.s_current_idx(i-1);
            Radar_Info.signals.values(j*10+10,m) = Data.obs_id(i-1);
            Radar_Info.signals.values(j*10+11,m) = Data.tracked_times(i-1);
            Radar_Info.signals.values(j*10+12,m) = Data.tracking_time(i-1);
            Radar_Info.signals.values(1,m) = j+1;
            Radar_Info.signals.values(2,m) = Data.local_id(i-1);
            Radar_Info.time(m,1) = Data.local_id(i-1)*0.02;
            j=0;
            m=m+1;
        end
    else
        if Data.local_id(i-2)==Data.local_id(i-1)
            if (j<=29)
                Radar_Info.signals.values(j*10+3,m) = Data.track_id(i-1);
                Radar_Info.signals.values(j*10+4,m) = Data.track_shape_x(i-1);
                Radar_Info.signals.values(j*10+5,m) = Data.track_shape_y(i-1);
                Radar_Info.signals.values(j*10+6,m) = Data.linear_velocity_x(i-1);
                Radar_Info.signals.values(j*10+7,m) = Data.linear_velocity_y(i-1);
                Radar_Info.signals.values(j*10+8,m) = Data.time_id(i-1);                             
                Radar_Info.signals.values(j*10+9,m) = Data.s_current_idx(i-1);
                Radar_Info.signals.values(j*10+10,m) = Data.obs_id(i-1);
                Radar_Info.signals.values(j*10+11,m) = Data.tracked_times(i-1);
                Radar_Info.signals.values(j*10+12,m) = Data.tracking_time(i-1);
            else
                j=29;
                Radar_Info.signals.values(j*10+3,m) = Data.track_id(i-1);
                Radar_Info.signals.values(j*10+4,m) = Data.track_shape_x(i-1);
                Radar_Info.signals.values(j*10+5,m) = Data.track_shape_y(i-1);
                Radar_Info.signals.values(j*10+6,m) = Data.linear_velocity_x(i-1);
                Radar_Info.signals.values(j*10+7,m) = Data.linear_velocity_y(i-1);
                Radar_Info.signals.values(j*10+8,m) = Data.time_id(i-1);                             
                Radar_Info.signals.values(j*10+9,m) = Data.s_current_idx(i-1);
                Radar_Info.signals.values(j*10+10,m) = Data.obs_id(i-1);
                Radar_Info.signals.values(j*10+11,m) = Data.tracked_times(i-1);
                Radar_Info.signals.values(j*10+12,m) = Data.tracking_time(i-1);
            end
        else
            j=0;
                Radar_Info.signals.values(j*10+3,m) = Data.track_id(i-1);
                Radar_Info.signals.values(j*10+4,m) = Data.track_shape_x(i-1);
                Radar_Info.signals.values(j*10+5,m) = Data.track_shape_y(i-1);
                Radar_Info.signals.values(j*10+6,m) = Data.linear_velocity_x(i-1);
                Radar_Info.signals.values(j*10+7,m) = Data.linear_velocity_y(i-1);
                Radar_Info.signals.values(j*10+8,m) = Data.time_id(i-1);                             
                Radar_Info.signals.values(j*10+9,m) = Data.s_current_idx(i-1);
                Radar_Info.signals.values(j*10+10,m) = Data.obs_id(i-1);
                Radar_Info.signals.values(j*10+11,m) = Data.tracked_times(i-1);
                Radar_Info.signals.values(j*10+12,m) = Data.tracking_time(i-1);

        end
        
        Radar_Info.signals.values(1,m) = j+1;
        Radar_Info.signals.values(2,m) = Data.local_id(i-1);
        Radar_Info.time(m,1) = Data.local_id(i-1)*0.02;
        
    end
end
Radar_Info.signals.values = Radar_Info.signals.values';


