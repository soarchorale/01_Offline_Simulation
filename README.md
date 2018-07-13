# Offline Simulation

 This project for fusion data processing in Matlab/Simulink. Version 1.0

## Updated 2018.07.09

+ Automaticly read data from csv files that extracted from ros.bag file.
+ Resize and adjust the positions and colors of imformation in figure.
+ Keep the timestamp in ASCENDING instead of 0.02 times of local_id.
+ Optimize the dimensions according to the number of data at the same timestamp.
+ Set a default values if the corresponding csv file is empty then not display in figure.

## Introduction

+ This program is to process the offline simulation of raw data from automatic vehcile test, which we can display it on the figure in Matlab/Simulink to see how many vehcles detected as timestamp goes.
+ Offline means we can processing it anywhere instead of boarding on the automatic vehcle or launching the ROS simulation development such as rviz, etc.
+ In this program, we display 4 kinds of vehcles detected from **ESR, Laser, Mobileye and Fusion**.
+ We draw the lane lines at the center of figures to see the detected moving vehcles according to the relative rest car we test.
+ Images taken from camera are shown at right of the figure.
+ The different colored words shown in figure are information of detected vehcles obtained from sensors above.

## Content

+ **csv** --*data extracted from .bag file by python script*
+ **rawdata** --*pictures taken from camera*
+ **src** --*source code of this offline simulation*
+ **2018-XX-XX-XX-XX-XX.bag** --*rosbag file*
+ **Offline_Replay.mdl** --*the launch file of simulation*
+ Other cached files generated when simulated

## Installation

On your work directory:

+ Clone the whole [repository](https://github.com/soarchorale/01_Offline_Simulation) on master branch
+ Copy the simulink model and rawdata files

(Or ask [Liqing](lqxu@nullmax.ai) to duplicate the complete directory from hardrive.)

The directory tree in your work space like this:

```ruleslanguage
.
└── Data
    ├── csv
    ├── rawdata
    │   └── 20180514
    └── src
        └── Function
```

## Data strcture in csv

The style of **csv** files is --'*time_sonser.csv*'.
Eg. '**2018-04-26-14-27-47_esr.csv**'-- means data that collected from **ESR** sensor on **2018-04-26-14-27-47**.
The labels in **csv** files are explained as follow:

+ **local_id** --*show a basic number of each status*
+ **times** --*time excat to second at that moment*
+ **secs** --*the absolute second, which is equal to times in differet style*
+ **nsec** --*the nano second, whose limitation is within 1 second. eg. 1 sec = 1*e+9 nsec*
+ **obs_rel_x** --*the x coordinate of obstacle according to automatic vehcile*
+ **obs_rel_y** --*the y coordinate of obstacle according to automatic vehcile*
+ **vel_x** --*the current speed of automatic vehcile at coordinate x*
+ **vel_y** --*the current speed of automatic vehcile at coordinate y*
+ **obs_x** --*the absolute coordinate x of obsacle*
+ **obs_y** --*the absolute coordinate y of obsacle*
+ **id** --*the id number of obstacle detected by corresponding sensor*

## Source code files

Source code tree contains 1 directory *Function* and other 10 files.

+ **'process_ros.bag'** is the python script that extracts data from rosbag file.

### DataReadesr.m / DataReadlaser.m / DataReadMobileye.m / DataReadFusion.m

These functions are to read data obtained from sonsers, which relisted in one line according to its same timestamp.
The followed steps are used to read data:

+ Set the total number of values that you want to use.
+ Judge whether the table(...esr/laser/mobileye/obs_fusion.csv file) is empty.
+ Read data.
+ Ordered the timestamp in ASCENDING if necessary.

**Note:**
In this case, the coordinates y of sensors are oppsite from automatic vehcile, so we add the nagetive sign '-' in obs_rel_y, obs_y and vel_y.

### DataRead.m

The main .m file that you should first run to read data from csv files.

+ Please set the addpath according to your local address. And the address of filename on bottom should also be changed.
+ Selcet the exact date that you want to simulate, then it will read the corresponding data automaticly.

**Note:**
The line `Radar_Result_Info = DataReadRadarProcess(Filename);`is being maintanancing. Comment it and just display others.
Considering that the start time of differnt sonsers could not be in coincidence, all timestamps are adjusted according to the *minimum* 'start time' which selected as the initial timestamp.

### Offline_Relay.mdl

+ This simulink model could run after you read all data from csv files.
+ Double click **Offline_Relay.mdl** to see the whole model.
+ Double click **Plot/PlotResult** to see the plot function and run **plot/plot** can also launch the offline model.

The information of automatic vechile and detected obstacles should be displayed as this:
![eg](https://github.com/soarchorale/01_Offline_Simulation/blob/master/Eg.png?raw=true)

## Issues

+ Any questions request about this project could contact *xsun@nullmax.ai* *lqxu@nullmax.ai*
+ New pull request on the dev branch