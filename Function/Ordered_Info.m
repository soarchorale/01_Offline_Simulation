function [Info_]=Ordered_Info(Info)

diff_values=diff(Info.time);
flag=diff_values<0;

while(sum(flag))
    
    for i=1:length(Info.time)-1
        if flag(i)==1
            temp.time=Info.time(i);
            Info.time(i)=Info.time(i+1);
            Info.time(i+1)=temp.time;
            
            temp.values=Info.signals.values(:,i);
            Info.signals.values(:,i)=Info.signals.values(:,i+1);
            Info.signals.values(:,i+1)=temp.values;
        end
    end
    
    diff_values=diff(Info.time);
    flag=diff_values<0;
end
Info_=Info;
end
        
