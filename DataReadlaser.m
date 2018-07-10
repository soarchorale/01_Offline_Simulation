function [Laser_Info] = DataReadlaser(Filename)
Data_Laser = readtable(strcat(Filename,'_laser.csv'));

values_num=9;

if height(Data_Laser)
    
    obsolute_time=Data_Laser.secs+Data_Laser.nsecs*1e-9;% set bunch with same time instead of local_id
    count_data=tabulate(obsolute_time);
    count_MAX=max(count_data(:,2));

    Laser_Info.signals.dimensions=count_MAX*values_num+2;
    Laser_Info.signals.values = zeros(count_MAX*values_num+2,1);

    j=0;
    m=1;
for i=2:1:length(Data_Laser.local_id)+1
    if i<=length(Data_Laser.local_id)
        if(Data_Laser.secs(i-1)==Data_Laser.secs(i)&&Data_Laser.nsecs(i-1)==Data_Laser.nsecs(i))
        %if (Data.local_id(i-1)==Data.local_id(i))
            %if (j<=29)
                Laser_Info.signals.values(j*values_num+3,m) = Data_Laser.obs_rel_x(i-1);
                Laser_Info.signals.values(j*values_num+4,m) = -Data_Laser.obs_rel_y(i-1);
                Laser_Info.signals.values(j*values_num+5,m) = Data_Laser.obs_x(i-1);
                Laser_Info.signals.values(j*values_num+6,m) = -Data_Laser.obs_y(i-1);
                Laser_Info.signals.values(j*values_num+7,m) = Data_Laser.vel_x(i-1);
                Laser_Info.signals.values(j*values_num+8,m) = -Data_Laser.vel_y(i-1);                             
                Laser_Info.signals.values(j*values_num+9,m) = Data_Laser.id(i-1);
                Laser_Info.signals.values(j*values_num+10,m) = Data_Laser.secs(i-1);
                Laser_Info.signals.values(j*values_num+11,m) = Data_Laser.nsecs(i-1);
                j=j+1;
%             else
%                 j=29;
%                 Laser_Info.signals.values(j*values_num+3,m) = Data_Laser.obs_rel_x(i-1);
%                 Laser_Info.signals.values(j*values_num+4,m) = -Data_Laser.obs_rel_y(i-1);
%                 Laser_Info.signals.values(j*values_num+5,m) = Data_Laser.obs_x(i-1);
%                 Laser_Info.signals.values(j*values_num+6,m) = -Data_Laser.obs_y(i-1);
%                 Laser_Info.signals.values(j*values_num+7,m) = Data_Laser.vel_x(i-1);
%                 Laser_Info.signals.values(j*values_num+8,m) = -Data_Laser.vel_y(i-1);                             
%                 Laser_Info.signals.values(j*values_num+9,m) = Data_Laser.id(i-1);
%                 Laser_Info.signals.values(j*values_num+10,m) = Data_Laser.secs(i-1);
%                 Laser_Info.signals.values(j*values_num+11,m) = Data_Laser.nsecs(i-1);
%             end
        else
            Laser_Info.signals.values(j*values_num+3,m) = Data_Laser.obs_rel_x(i-1);
            Laser_Info.signals.values(j*values_num+4,m) = -Data_Laser.obs_rel_y(i-1);
            Laser_Info.signals.values(j*values_num+5,m) = Data_Laser.obs_x(i-1);
            Laser_Info.signals.values(j*values_num+6,m) = -Data_Laser.obs_y(i-1);
            Laser_Info.signals.values(j*values_num+7,m) = Data_Laser.vel_x(i-1);
            Laser_Info.signals.values(j*values_num+8,m) = -Data_Laser.vel_y(i-1);
            Laser_Info.signals.values(j*values_num+9,m) = Data_Laser.id(i-1);
            Laser_Info.signals.values(j*values_num+10,m) = Data_Laser.secs(i-1);
            Laser_Info.signals.values(j*values_num+11,m) = Data_Laser.nsecs(i-1);
            Laser_Info.signals.values(1,m) = j+1;
            Laser_Info.signals.values(2,m) = Data_Laser.local_id(i-1);
            %Laser_Info.time(m,1) = Data.local_id(i-1)*0.02;
            Laser_Info.time(m,1) = Data_Laser.secs(i-1)+Data_Laser.nsecs(i-1)*1e-9;
            
            j=0;
            m=m+1;
        end
    else
        if(Data_Laser.secs(i-2)==Data_Laser.secs(i-1)&&Data_Laser.nsecs(i-2)==Data_Laser.nsecs(i-1))
        %if Data.local_id(i-2)==Data.local_id(i-1)
            %if (j<=29)
                Laser_Info.signals.values(j*values_num+3,m) = Data_Laser.obs_rel_x(i-1);
                Laser_Info.signals.values(j*values_num+4,m) = -Data_Laser.obs_rel_y(i-1);
                Laser_Info.signals.values(j*values_num+5,m) = Data_Laser.obs_x(i-1);
                Laser_Info.signals.values(j*values_num+6,m) = -Data_Laser.obs_y(i-1);
                Laser_Info.signals.values(j*values_num+7,m) = Data_Laser.vel_x(i-1);
                Laser_Info.signals.values(j*values_num+8,m) = -Data_Laser.vel_y(i-1);
                Laser_Info.signals.values(j*values_num+9,m) = Data_Laser.id(i-1);
                Laser_Info.signals.values(j*values_num+10,m) = Data_Laser.secs(i-1);
                Laser_Info.signals.values(j*values_num+11,m) = Data_Laser.nsecs(i-1);
%             else
%                 j=29;
%                 Laser_Info.signals.values(j*values_num+3,m) = Data_Laser.obs_rel_x(i-1);
%                 Laser_Info.signals.values(j*values_num+4,m) = -Data_Laser.obs_rel_y(i-1);
%                 Laser_Info.signals.values(j*values_num+5,m) = Data_Laser.obs_x(i-1);
%                 Laser_Info.signals.values(j*values_num+6,m) = -Data_Laser.obs_y(i-1);
%                 Laser_Info.signals.values(j*values_num+7,m) = Data_Laser.vel_x(i-1);
%                 Laser_Info.signals.values(j*values_num+8,m) = -Data_Laser.vel_y(i-1);
%                 Laser_Info.signals.values(j*values_num+9,m) = Data_Laser.id(i-1);
%                 Laser_Info.signals.values(j*values_num+10,m) = Data_Laser.secs(i-1);
%                 Laser_Info.signals.values(j*values_num+11,m) = Data_Laser.nsecs(i-1);
%             end
        else
            j=0;
            Laser_Info.signals.values(j*values_num+3,m) = Data_Laser.obs_rel_x(i-1);
            Laser_Info.signals.values(j*values_num+4,m) = -Data_Laser.obs_rel_y(i-1);
            Laser_Info.signals.values(j*values_num+5,m) = Data_Laser.obs_x(i-1);
            Laser_Info.signals.values(j*values_num+6,m) = -Data_Laser.obs_y(i-1);
            Laser_Info.signals.values(j*values_num+7,m) = Data_Laser.vel_x(i-1);
            Laser_Info.signals.values(j*values_num+8,m) = -Data_Laser.vel_y(i-1);
            Laser_Info.signals.values(j*values_num+9,m) = Data_Laser.id(i-1);
            Laser_Info.signals.values(j*values_num+10,m) = Data_Laser.secs(i-1);
            Laser_Info.signals.values(j*values_num+11,m) = Data_Laser.nsecs(i-1);

        end
        
        Laser_Info.signals.values(1,m) = j+1;
        Laser_Info.signals.values(2,m) = Data_Laser.local_id(i-1);
        %Laser_Info.time(m,1) = Data.local_id(i-1)*0.02;
        Laser_Info.time(m,1) = Data_Laser.secs(i-1)+Data_Laser.nsecs(i-1)*1e-9;
        
    end
end
    Laser_Info=Ordered_Info(Laser_Info);
else
    Laser_Info.signals.dimensions=281;
    Laser_Info.signals.values = ones(281,1)*1e+20;
    Laser_Info.time=0;
end
    Laser_Info.signals.values = Laser_Info.signals.values';
end


