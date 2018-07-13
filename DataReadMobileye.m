function [ME_Info] = DataReadMobileye(Filename)
Data_ME = readtable(strcat(Filename,'_mobileye.csv'));

values_num=9;

if height(Data_ME)

    obsolute_time=Data_ME.secs+Data_ME.nsecs*1e-9;% set bunch with same time instead of local_id
    count_data=tabulate(obsolute_time);
    count_MAX=max(count_data(:,2));


    ME_Info.signals.dimensions=count_MAX*values_num+2;
    ME_Info.signals.values = zeros(count_MAX*values_num+2,1);

    j=0;
    m=1;
for i=2:1:length(Data_ME.local_id)+1
    if i<=length(Data_ME.local_id)
        if(Data_ME.secs(i-1)==Data_ME.secs(i)&&Data_ME.nsecs(i-1)==Data_ME.nsecs(i))
            
            ME_Info.signals.values(j*values_num+3,m) = Data_ME.obs_rel_x(i-1);
            ME_Info.signals.values(j*values_num+4,m) = -Data_ME.obs_rel_y(i-1);
            ME_Info.signals.values(j*values_num+5,m) = Data_ME.obs_x(i-1);
            ME_Info.signals.values(j*values_num+6,m) = -Data_ME.obs_y(i-1);
            ME_Info.signals.values(j*values_num+7,m) = Data_ME.vel_x(i-1);
            ME_Info.signals.values(j*values_num+8,m) = -Data_ME.vel_y(i-1);
            ME_Info.signals.values(j*values_num+9,m) = Data_ME.id(i-1);
            ME_Info.signals.values(j*values_num+10,m) = Data_ME.secs(i-1);
            ME_Info.signals.values(j*values_num+11,m) = Data_ME.nsecs(i-1);
            j=j+1;

        else
            
            ME_Info.signals.values(j*values_num+3,m) = Data_ME.obs_rel_x(i-1);
            ME_Info.signals.values(j*values_num+4,m) = -Data_ME.obs_rel_y(i-1);
            ME_Info.signals.values(j*values_num+5,m) = Data_ME.obs_x(i-1);
            ME_Info.signals.values(j*values_num+6,m) = -Data_ME.obs_y(i-1);
            ME_Info.signals.values(j*values_num+7,m) = Data_ME.vel_x(i-1);
            ME_Info.signals.values(j*values_num+8,m) = -Data_ME.vel_y(i-1);
            ME_Info.signals.values(j*values_num+9,m) = Data_ME.id(i-1);
            ME_Info.signals.values(j*values_num+10,m) = Data_ME.secs(i-1);
            ME_Info.signals.values(j*values_num+11,m) = Data_ME.nsecs(i-1);
            ME_Info.signals.values(1,m) = j+1;
            ME_Info.signals.values(2,m) = Data_ME.local_id(i-1);
            ME_Info.time(m,1) = Data_ME.secs(i-1)+Data_ME.nsecs(i-1)*1e-9;
            j=0;
            m=m+1;
            
        end
        
    else
        
        if(Data_ME.secs(i-2)==Data_ME.secs(i-1)&&Data_ME.nsecs(i-2)==Data_ME.nsecs(i-1))
            
            ME_Info.signals.values(j*values_num+3,m) = Data_ME.obs_rel_x(i-1);
            ME_Info.signals.values(j*values_num+4,m) = -Data_ME.obs_rel_y(i-1);
            ME_Info.signals.values(j*values_num+5,m) = Data_ME.obs_x(i-1);
            ME_Info.signals.values(j*values_num+6,m) = -Data_ME.obs_y(i-1);
            ME_Info.signals.values(j*values_num+7,m) = Data_ME.vel_x(i-1);
            ME_Info.signals.values(j*values_num+8,m) = -Data_ME.vel_y(i-1);
            ME_Info.signals.values(j*values_num+9,m) = Data_ME.id(i-1);
            ME_Info.signals.values(j*values_num+10,m) = Data_ME.secs(i-1);
            ME_Info.signals.values(j*values_num+11,m) = Data_ME.nsecs(i-1);

        else
            
            j=0;
            ME_Info.signals.values(j*values_num+3,m) = Data_ME.obs_rel_x(i-1);
            ME_Info.signals.values(j*values_num+4,m) = -Data_ME.obs_rel_y(i-1);
            ME_Info.signals.values(j*values_num+5,m) = Data_ME.obs_x(i-1);
            ME_Info.signals.values(j*values_num+6,m) = -Data_ME.obs_y(i-1);
            ME_Info.signals.values(j*values_num+7,m) = Data_ME.vel_x(i-1);
            ME_Info.signals.values(j*values_num+8,m) = -Data_ME.vel_y(i-1);
            ME_Info.signals.values(j*values_num+9,m) = Data_ME.id(i-1);
            ME_Info.signals.values(j*values_num+10,m) = Data_ME.secs(i-1);
            ME_Info.signals.values(j*values_num+11,m) = Data_ME.nsecs(i-1);

        end
        
        ME_Info.signals.values(1,m) = j+1;
        ME_Info.signals.values(2,m) = Data_ME.local_id(i-1);
        ME_Info.time(m,1) = Data_ME.secs(i-1)+Data_ME.nsecs(i-1)*1e-9;
        
    end
end
    ME_Info=Ordered_Info(ME_Info);
else
    ME_Info.signals.dimensions=101;
    ME_Info.signals.values = ones(101,1)*1e+20;
    ME_Info.time=0;
end
    ME_Info.signals.values = ME_Info.signals.values';
end

