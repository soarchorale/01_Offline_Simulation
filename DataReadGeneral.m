function DataReadGeneral(Filename)
Data = readtable(strcat(Filename,'.csv'));

IN_x_value = Data.x;
IN_y_value = Data.y;
% IN_r_value = C(:,3);

IN_x_max = max(Data.x);
IN_x_min = min(Data.x);
IN_y_max = max(Data.y);
IN_y_min = min(Data.y);

% mobileye_id_value = C(:,4);
% lc0_value = C(:,5);
% lc1_value = C(:,6);
% lc2_value = C(:,7);
% lc3_value = C(:,8);
% lquality_value = C(:,9);
% rc0_value = C(:,10);
% rc1_value = C(:,11);
% rc2_value = C(:,12);
% rc3_value = C(:,13);
% rquality_value = C(:,14);
% twist_id_value = C(:,15);
% veh_speed_value = C(:,16);
% angular_value = C(:,17);
% cmd_id_value = C(:,18);
% cmd_veh_speed_value = C(:,19);
% cmd_angular_value = C(:,20);
% dbw_id_value = C(:,21);
% enable_value = C(:,22);
% target_id_value = C(:,23);
target_x_value = Data.tx;
target_y_value = Data.ty;
% target_r_value = C(:,26);
% replan_value = C(:,27);
% steering_id_value = C(:,28);
% steering_angle_value = C(:,29);
% obs_id_value = C(:,30);

t_skip = 0.02;
t_40_ms = (0:t_skip:t_skip*(length(Data.x)-1));
t_start = t_40_ms(1);
t_stop = t_40_ms(end);
% default_no_data = zeros(1,length(t))';

% record_time.time=t_40_ms';
% record_time.signals.values = Data.time;
% record_time.signals.dimensions=1;
% 
% 
time_char = cell2mat(Data.time);
year = (time_char(1,1:4));
month = (time_char(1,6:7));
day = (time_char(1,9:10));

hour_value = str2num(time_char(:,12:13));
minute_value = str2num(time_char(:,15:16));
second_value = str2num(time_char(:,18:19));

hour.time=t_40_ms';
hour.signals.values = hour_value;
hour.signals.dimensions=1;

minute.time=t_40_ms';
minute.signals.values = minute_value;
minute.signals.dimensions=1;

second.time=t_40_ms';
second.signals.values = second_value;
second.signals.dimensions=1;

% 1
IN_x.time=t_40_ms';
IN_x.signals.values = Data.x;
IN_x.signals.dimensions=1;

% 2
IN_y.time=t_40_ms';
IN_y.signals.values = Data.y;
IN_y.signals.dimensions=1;

% 3
IN_r.time=t_40_ms';
IN_r.signals.values = Data.r;
IN_r.signals.dimensions=1;

% 4
mobileye_id.time=t_40_ms';
mobileye_id.signals.values = Data.mobileye_id;
mobileye_id.signals.dimensions=1;

% 5
lc0.time=t_40_ms';
lc0.signals.values = Data.lc0;
lc0.signals.dimensions=1;

% 6
lc1.time=t_40_ms';
lc1.signals.values = Data.lc1;
lc1.signals.dimensions=1;

% 7
lc2.time=t_40_ms';
lc2.signals.values = Data.lc2;
lc2.signals.dimensions=1;

% 8
lc3.time=t_40_ms';
lc3.signals.values = Data.lc3;
lc3.signals.dimensions=1;

% 9
lquality.time=t_40_ms';
lquality.signals.values = Data.lquality;
lquality.signals.dimensions=1;

% 10
rc0.time=t_40_ms';
rc0.signals.values = Data.rc0;
rc0.signals.dimensions=1;

% 11
rc1.time=t_40_ms';
rc1.signals.values = Data.rc1;
rc1.signals.dimensions=1;

% 12
rc2.time=t_40_ms';
rc2.signals.values = Data.rc2;
rc2.signals.dimensions=1;

% 13
rc3.time=t_40_ms';
rc3.signals.values = Data.rc3;
rc3.signals.dimensions=1;

% 14
rquality.time=t_40_ms';
rquality.signals.values = Data.rquality;
rquality.signals.dimensions=1;

% 15
twist_id.time=t_40_ms';
twist_id.signals.values = Data.twist_id;
twist_id.signals.dimensions=1;

% 16
veh_speed.time=t_40_ms';
veh_speed.signals.values = Data.vel;
veh_speed.signals.dimensions=1;

% 17
angular.time=t_40_ms';
angular.signals.values = Data.angular;
angular.signals.dimensions=1;

% 18
cmd_id.time=t_40_ms';
cmd_id.signals.values = Data.cmd_id;
cmd_id.signals.dimensions=1;

% 19
cmd_veh_speed.time=t_40_ms';
cmd_veh_speed.signals.values = Data.cmd_vel;
cmd_veh_speed.signals.dimensions=1;

% 20
cmd_angular.time=t_40_ms';
cmd_angular.signals.values = Data.cmd_angular;
cmd_angular.signals.dimensions=1;

% 21
dbw_id.time=t_40_ms';
dbw_id.signals.values = Data.dbw_id;
dbw_id.signals.dimensions=1;

% 22
enable.time=t_40_ms';
enable.signals.values = Data.enable;
enable.signals.dimensions=1;

% 23
target_id.time=t_40_ms';
target_id.signals.values = Data.target_id;
target_id.signals.dimensions=1;

% 24
target_x.time=t_40_ms';
target_x.signals.values = Data.tx;
target_x.signals.dimensions=1;

% 25
target_y.time=t_40_ms';
target_y.signals.values = Data.ty;
target_y.signals.dimensions=1;

% 26 
target_r.time=t_40_ms';
target_r.signals.values = Data.tr;
target_r.signals.dimensions=1;

% 27 
replan.time=t_40_ms';
replan.signals.values = Data.replan;
replan.signals.dimensions=1;

% 28
steering_id.time=t_40_ms';
steering_id.signals.values = Data.steering_id;
steering_id.signals.dimensions=1;

% 29
steering_angle.time=t_40_ms';
steering_angle.signals.values = Data.steering_angle;
steering_angle.signals.dimensions=1;

% 30
obs_id.time=t_40_ms';
obs_id.signals.values = obs_id;
obs_id.signals.dimensions=1;

save DataReadGeneral;