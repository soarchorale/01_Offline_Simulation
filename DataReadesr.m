function [ESR_Info] = DataReadesr(Filename)
Data_ESR = readtable(strcat(Filename,'_esr.csv'));

values_num=9;

if height(Data_ESR)
    
    obsolute_time=Data_ESR.secs+Data_ESR.nsecs*1e-9;% set bunch with same time instead of local_id
    count_data=tabulate(obsolute_time);
    count_MAX=max(count_data(:,2));
    
    ESR_Info.signals.dimensions=count_MAX*values_num+2;
    ESR_Info.signals.values = zeros(count_MAX*values_num+2,1);

    j=0;
    m=1;
for i=2:1:length(Data_ESR.local_id)+1
    if i<=length(Data_ESR.local_id)
        if(Data_ESR.secs(i-1)==Data_ESR.secs(i)&&Data_ESR.nsecs(i-1)==Data_ESR.nsecs(i))
        %if (Data.local_id(i-1)==Data.local_id(i)) 
            %if (j<=29)
                ESR_Info.signals.values(j*values_num+3,m) = Data_ESR.obs_rel_x(i-1);
                ESR_Info.signals.values(j*values_num+4,m) = -Data_ESR.obs_rel_y(i-1);
                ESR_Info.signals.values(j*values_num+5,m) = Data_ESR.obs_x(i-1);
                ESR_Info.signals.values(j*values_num+6,m) = -Data_ESR.obs_y(i-1);
                ESR_Info.signals.values(j*values_num+7,m) = Data_ESR.vel_x(i-1);
                ESR_Info.signals.values(j*values_num+8,m) = -Data_ESR.vel_y(i-1);                             
                ESR_Info.signals.values(j*values_num+9,m) = Data_ESR.id(i-1);
                ESR_Info.signals.values(j*values_num+10,m) = Data_ESR.secs(i-1);
                ESR_Info.signals.values(j*values_num+11,m) = Data_ESR.nsecs(i-1);
                j=j+1;
%             else
%                 j=29;
%                 ESR_Info.signals.values(j*values_num+3,m) = Data_ESR.obs_rel_x(i-1);
%                 ESR_Info.signals.values(j*values_num+4,m) = -Data_ESR.obs_rel_y(i-1);
%                 ESR_Info.signals.values(j*values_num+5,m) = Data_ESR.obs_x(i-1);
%                 ESR_Info.signals.values(j*values_num+6,m) = -Data_ESR.obs_y(i-1);
%                 ESR_Info.signals.values(j*values_num+7,m) = Data_ESR.vel_x(i-1);
%                 ESR_Info.signals.values(j*values_num+8,m) = -Data_ESR.vel_y(i-1);
%                 ESR_Info.signals.values(j*values_num+9,m) = Data_ESR.id(i-1);
%                 ESR_Info.signals.values(j*values_num+10,m) = Data_ESR.secs(i-1);
%                 ESR_Info.signals.values(j*values_num+11,m) = Data_ESR.nsecs(i-1);
%             end
        else
            ESR_Info.signals.values(j*values_num+3,m) = Data_ESR.obs_rel_x(i-1);
            ESR_Info.signals.values(j*values_num+4,m) = -Data_ESR.obs_rel_y(i-1);
            ESR_Info.signals.values(j*values_num+5,m) = Data_ESR.obs_x(i-1);
            ESR_Info.signals.values(j*values_num+6,m) = -Data_ESR.obs_y(i-1);
            ESR_Info.signals.values(j*values_num+7,m) = Data_ESR.vel_x(i-1);
            ESR_Info.signals.values(j*values_num+8,m) = -Data_ESR.vel_y(i-1);                             
            ESR_Info.signals.values(j*values_num+9,m) = Data_ESR.id(i-1);
            ESR_Info.signals.values(j*values_num+10,m) = Data_ESR.secs(i-1);
            ESR_Info.signals.values(j*values_num+11,m) = Data_ESR.nsecs(i-1);
            ESR_Info.signals.values(1,m) = j+1;
            ESR_Info.signals.values(2,m) = Data_ESR.local_id(i-1);
            %ESR_Info.time(m,1) = Data.local_id(i-1)*0.02;
            ESR_Info.time(m,1) = Data_ESR.secs(i-1)+Data_ESR.nsecs(i-1)*1e-9;
            j=0;
            m=m+1;
        end
    else
        if(Data_ESR.secs(i-2)==Data_ESR.secs(i-1)&&Data_ESR.nsecs(i-2)==Data_ESR.nsecs(i-1))
        %if Data.local_id(i-2)==Data.local_id(i-1)
            %if (j<=29)
                
                ESR_Info.signals.values(j*values_num+3,m) = Data_ESR.obs_rel_x(i-1);
                ESR_Info.signals.values(j*values_num+4,m) = -Data_ESR.obs_rel_y(i-1);
                ESR_Info.signals.values(j*values_num+5,m) = Data_ESR.obs_x(i-1);
                ESR_Info.signals.values(j*values_num+6,m) = -Data_ESR.obs_y(i-1);
                ESR_Info.signals.values(j*values_num+7,m) = Data_ESR.vel_x(i-1);
                ESR_Info.signals.values(j*values_num+8,m) = -Data_ESR.vel_y(i-1);
                ESR_Info.signals.values(j*values_num+9,m) = Data_ESR.id(i-1);
                ESR_Info.signals.values(j*values_num+10,m) = Data_ESR.secs(i-1);
                ESR_Info.signals.values(j*values_num+11,m) = Data_ESR.nsecs(i-1);
                
%             else
%                 j=29;
%                 
%                 ESR_Info.signals.values(j*values_num+3,m) = Data_ESR.obs_rel_x(i-1);
%                 ESR_Info.signals.values(j*values_num+4,m) = -Data_ESR.obs_rel_y(i-1);
%                 ESR_Info.signals.values(j*values_num+5,m) = Data_ESR.obs_x(i-1);
%                 ESR_Info.signals.values(j*values_num+6,m) = -Data_ESR.obs_y(i-1);
%                 ESR_Info.signals.values(j*values_num+7,m) = Data_ESR.vel_x(i-1);
%                 ESR_Info.signals.values(j*values_num+8,m) = -Data_ESR.vel_y(i-1);
%                 ESR_Info.signals.values(j*values_num+9,m) = Data_ESR.id(i-1);
%                 ESR_Info.signals.values(j*values_num+10,m) = Data_ESR.secs(i-1);
%                 ESR_Info.signals.values(j*values_num+11,m) = Data_ESR.nsecs(i-1);
%                 
%             end
        else
            j=0;
            
            ESR_Info.signals.values(j*values_num+3,m) = Data_ESR.obs_rel_x(i-1);
            ESR_Info.signals.values(j*values_num+4,m) = -Data_ESR.obs_rel_y(i-1);
            ESR_Info.signals.values(j*values_num+5,m) = Data_ESR.obs_x(i-1);
            ESR_Info.signals.values(j*values_num+6,m) = -Data_ESR.obs_y(i-1);
            ESR_Info.signals.values(j*values_num+7,m) = Data_ESR.vel_x(i-1);
            ESR_Info.signals.values(j*values_num+8,m) = -Data_ESR.vel_y(i-1);
            ESR_Info.signals.values(j*values_num+9,m) = Data_ESR.id(i-1);
            ESR_Info.signals.values(j*values_num+10,m) = Data_ESR.secs(i-1);
            ESR_Info.signals.values(j*values_num+11,m) = Data_ESR.nsecs(i-1);

        end
        
        ESR_Info.signals.values(1,m) = j+1;
        ESR_Info.signals.values(2,m) = Data_ESR.local_id(i-1);
        %ESR_Info.time(m,1) = Data.local_id(i-1)*0.02;
        ESR_Info.time(m,1) = Data_ESR.secs(i-1)+Data_ESR.nsecs(i-1)*1e-9;
        
    end
end
    ESR_Info=Ordered_Info(ESR_Info);
else 
    ESR_Info.signals.dimensions=281;
    ESR_Info.signals.values = ones(281,1)*1e+20;
    ESR_Info.time=0;
end
    ESR_Info.signals.values = ESR_Info.signals.values';
end

