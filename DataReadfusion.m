function [Fusion_Info] = DataReadfusion(Filename)
Data_Fusion = readtable(strcat(Filename,'_obs_fusion.csv'));

values_num=9;

if height(Data_Fusion)

    obsolute_time=Data_Fusion.secs+Data_Fusion.nsecs*1e-9;% set bunch with same time instead of local_id
    count_data=tabulate(obsolute_time);
    count_MAX=max(count_data(:,2));

    Fusion_Info.signals.dimensions=count_MAX*values_num+2;
    Fusion_Info.signals.values = zeros(count_MAX*values_num+2,1);

    j=0;
    m=1;
for i=2:1:length(Data_Fusion.local_id)+1
    if i<=length(Data_Fusion.local_id)
        if(Data_Fusion.secs(i-1)==Data_Fusion.secs(i)&&Data_Fusion.nsecs(i-1)==Data_Fusion.nsecs(i))

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
            Fusion_Info.time(m,1)=Data_Fusion.secs(i-1)+Data_Fusion.nsecs(i-1)*1e-9;
            j=0;
            m=m+1;
            
        end
        
    else
        
        if(Data_Fusion.secs(i-2)==Data_Fusion.secs(i-1)&&Data_Fusion.nsecs(i-2)==Data_Fusion.nsecs(i-1))

            Fusion_Info.signals.values(j*values_num+3,m) = Data_Fusion.obs_rel_x(i-1);
            Fusion_Info.signals.values(j*values_num+4,m) = -Data_Fusion.obs_rel_y(i-1);
            Fusion_Info.signals.values(j*values_num+5,m) = Data_Fusion.obs_x(i-1);
            Fusion_Info.signals.values(j*values_num+6,m) = -Data_Fusion.obs_y(i-1);
            Fusion_Info.signals.values(j*values_num+7,m) = Data_Fusion.vel_x(i-1);
            Fusion_Info.signals.values(j*values_num+8,m) = -Data_Fusion.vel_y(i-1);
            Fusion_Info.signals.values(j*values_num+9,m) = Data_Fusion.id(i-1);
            Fusion_Info.signals.values(j*values_num+10,m) = Data_Fusion.secs(i-1);
            Fusion_Info.signals.values(j*values_num+11,m) = Data_Fusion.nsecs(i-1);

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
        Fusion_Info.time(m,1)=Data_Fusion.secs(i-1)+Data_Fusion.nsecs(i-1)*1e-9;
        
    end
end
    Fusion_Info=Ordered_Info(Fusion_Info);
else
    Fusion_Info.signals.dimensions=281;
    Fusion_Info.signals.values = ones(281,1)*1e+20;
    Fusion_Info.time=0;
end
    Fusion_Info.signals.values = Fusion_Info.signals.values';
end

