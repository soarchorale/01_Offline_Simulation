## Offline Simulation

 This project for fusion data processing in simulation offline. Version 1.0

# Updated 2018.07.09

+ Automaticly read data from .csv files that extracted from ros.bag file.
+ Resize and adjust the positions and colors of imformation in figure.
+ Keep the timestamp in ASCENDING instead of 0.02 times of local_id.
+ Optimize the dimensions according to the number of data at the same time.
+ Set a default values if the .csv file is empty and not display in figure.

# Introduction

This program is to process the offline simulation of raw data from vehcile test, which we can display it on the figure in matlab to see how many vehcles detected with timestamp. Offline means we can processing it anywhere instead of in the automatic vehcle and launch the ROS simulation development such as rviz, etc. In this program, we display 4 kinds of vehcles detected from ESR, Laser, Mobileye and Fusion. And we draw the lane lines at the center of figures to see the detected moving vehcles according to the relative rest car we test. And images taken from camera are shown at right of the figure. The colored words shown in figure are information of detected vehcles obtained from sensors above.

# Content

+ csv *data extracted from .bag file by python script*
+ rawdata *pictures taken from camera*
+ src *source code of this offline simulation* 
+ 2018-XX-XX-XX-XX-XX.bag *rosbag file*
+ Offline_Replay.mdl *the launch file of simulation*
+ other cached files generated when simulated

# Data in csv

The style of .csv files is '*time_sonser.csv8'. 
eg. '*2018-04-26-14-27-47_esr.csv*' means data taken from ESR sensor at 2018-04-26-14-27-47.
The labels in csv files are explained as follow:

+ local_id *show a basic number of each status*
+ times *time excat to second at that moment*
+ secs *the absolute second, which is equal to times in differet style*
+ nsec *the nano second, which unit is within 1 second*
+ obs_rel_x **