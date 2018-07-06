#!/usr/bin/env python
# -*- coding: UTF-8 -*-
import rosbag, sys
import time
import string
import os #for file management make directory
import shutil #for file management, copy file

import rospy
import math
import sys
from geometry_msgs.msg import Twist,TwistStamped,PoseStamped, Point
from visualization_msgs.msg import MarkerArray
# import util
from std_msgs.msg import Bool
# from driveworks_can_msgs.msg import RadarTrackArray
from radar_msgs.msg import RadarTrackArray
# radar_msgs
from nullmax_msgs.msg import ObstacleArray, Obstacle, TTC, VehicleMonitor
import message_filters
from mobileye_560_660_msgs.msg import LkaLane,ObstacleData
from dbw_mkz_msgs.msg import SteeringCmd
from sick_ldmrs_msgs.msg import ObjectArray
import csv
import time
import math
import datetime
from tf import transformations
def quatToEular(quaternion, axes='sxyz'):
	return transformations.euler_from_quaternion(quaternion, axes)
def tansTimestamp( t):
    ta = time.localtime(t)
    o = time.strftime("%Y-%m-%d %H:%M:%S", ta)
    return o
def self_to_world(obj,robot):
    # dist=geom_dist(obj.x,obj.y)
    # diff_angle=normalize( math.atan2(obj.y,obj.x))
    # angle=normalize( diff_angle+robot.z)
    # diff_x=dist*math.cos(angle)
    # diff_y=dist*math.sin(angle)

    x=obj.x*math.cos(robot.z) - obj.y*math.sin(robot.z)+robot.x
    y=obj.x*math.sin(robot.z) + obj.y*math.cos(robot.z)+robot.y
    pose=[x,y,0]
    return pose

class RosbagReader():
	def __init__(self):
		self.bagdir = '/media/user/Seagate Backup Plus Drive/changchun_rosbag/us0331'
		self.bagdir = '/media/user/Seagate Expansion Drive/changchun_rosbag/sh180322'
		self.bagdir = '/media/user/Seagate Expansion Drive/changchun_rosbag/us180330'
		self.bagdir = '/media/user/Seagate Expansion Drive/changchun_rosbag/us180328'
		self.bagdir = '/media/user/Seagate Backup Plus Drive/changchun_rosbag/us180402'
		self.bagdir = '/media/user/Seagate Backup Plus Drive/changchun_rosbag/sh_2018-04-16-esr'
		self.bagdir = '/media/user/Seagate Backup Plus Drive/changchun_rosbag/temp'
		self.bagdir = '/media/user/Seagate Backup Plus Drive/changchun_rosbag/sh_2018-04-17'
		self.bagdir = '/media/user/4f292847-14d6-49e4-9d9c-164d644e18a5/data'
		self.bagdir = '/media/user/Seagate Backup Plus Drive/changchun_rosbag/sh_2018-04-19'
		self.bagdir = '/media/user/Seagate Backup Plus Drive/changchun_rosbag/sh_2018-04-17'
		self.bag_list = []
		
		self.local_msg = '/odom/current_pose'
		self.esr_msg = '/delphi_esr/as_tx/radar_tracks'
		self.fusion_obs_msg = '/fusion/obstacle_list'

		self.twist_msg = '/vehicle/twist'
		self.cmd_vel_msg = '/vehicle/cmd_vel_stamped'
		self.dbw_enable_msg = '/vehicle/dbw_enabled'
		self.next_target_msg = '/planning/next_target_mark'
		self.mobileye_left_lane_msg = '/mobileye/parsed_tx/left_lka_lane'
		self.mobileye_right_lane_msg = '/mobileye/parsed_tx/right_lka_lane'
		self.mobileye_obs_msg = '/mobileye/parsed_tx/obstacle_data'
		self.vision_obs_msg = '/perception/obstacle_list'
		self.vision_left_lane_msg = '/perception/left_lka_lane'
		self.vision_right_lane_msg = '/perception/right_lka_lane'
		self.monitor_msg = '/planning/vehicle_monitor'
		self.steering_msg = '/vehicle/steering_cmd'
		self.laser_msg = '/laser/objects'
		self.front_obs_msg = '/planning/detected_obstacle'
		self.radar_process_msg = '/radar/radar_process'


		# self.listOfTopics = [self.local_msg, self.vision_obs_msg, self.esr_msg]
		# self.listOfTopics = [self.local_msg, self.twist_msg, self.cmd_vel_msg, self.dbw_enable_msg, self.next_target_msg,\
		# self.left_lane_msg, self.right_lane_msg]
		self.esr_pre_time = None
		self.laser_pre_time = None
		self.obs_pre_time = {}
		self.fusion_obs_pre_time = {}
		self.folder_name = '~/.ros'
		# self.local_pre_time = None
		# self.pre_time = None
		self.localization_id = 0
		self.robot_x = 0
		self.robot_y = 0
		self.robot_r = None
	def read_bags_in_folders(self):
		self.bagdir = sys.argv[1]
		if os.path.exists(self.bagdir):
			self.folder_name = os.path.join(self.bagdir, 'csv')
			if os.path.exists(self.folder_name):
				print 'the folder have already exist'
			else:
				os.makedirs(self.folder_name)
				print 'create folder (%s) to save csv files:' % (self.folder_name)
		else:
			# '%s%s%s' % ('python', 'tab', '.com')
			print 'the input folder (%s) do not exist, please check' % (self.bagdir)
			return

		print 'all the bag file name:'
		strs = "if 1\n  place = '%s';\n" %(self.folder_name)
		for root, dirs, files in os.walk(self.bagdir):
			for file in files:
				if os.path.splitext(file)[1] == '.bag':
					strs += "  bagname = '%s';\n" %(os.path.splitext(file)[0])
					self.bag_list.append(file)
					print file
					self.bagFile = os.path.join(root, file)
					print self.bagFile
					self.processor()
			if len(files)>0:
				strs += 'end\n'
				matlab_input = os.path.join(self.bagdir, 'matlab.txt')
				txtfile = open(matlab_input, 'w')
				txtfile.write(strs)
				txtfile.close()
				print 'the input for matlab code is %s' %(matlab_input)
		print 'have process all the bag file, the csv file have saved to %s\n' % (self.folder_name)
# place = '/media/user/Seagate Backup Plus Drive/changchun_rosbag/sh_2018-04-17/csv/';
#     bagname = '2018-04-17-10-29-35_go1_stable';
	def processor(self):
		bag = rosbag.Bag(self.bagFile)
		bagContents = bag.read_messages()
		bagName = bag.filename
		sumname = string.rstrip(self.bagFile,'.bag')
		stra = sumname.split('/')
		if len(stra)<=1:
			return
		bagName = stra[-1]
		filename = self.folder_name +'/' + bagName + '_esr' + '.csv'
		print 'save to file:',filename
		esrfile = open(filename, 'w')
		esrcsv = csv.writer(esrfile)
		esrcsv.writerow(['local_id', 'time','secs','nsecs','delay','obs_rel_x', 'obs_rel_y', 'vel_x', 'vel_y', 'obs_x', 'obs_y', 'delt', 'id'])

		filename = self.folder_name +'/' + bagName + '_laser' + '.csv'
		print 'save to file:',filename
		laserfile = open(filename, 'w')
		lasercsv = csv.writer(laserfile)
		lasercsv.writerow(['local_id', 'time','secs','nsecs','delay','obs_rel_x', 'obs_rel_y', 'vel_x', 'vel_y', 'obs_x', 'obs_y', 'delt', 'id'])

		filename = self.folder_name +'/' + bagName + '_mobileye' + '.csv'
		mobileyefile = open(filename, 'w')
		mobileyecsv = csv.writer(mobileyefile)
		mobileyecsv.writerow(['local_id','time','secs','nsecs' ,'delay','obs_rel_x', 'obs_rel_y', 'vel_x', 'vel_y', 'obs_x', 'obs_y', 'delt', 'id'])
		print 'save to file:',filename
		num = 0

		filename = self.folder_name +'/' + bagName + '_obs_fusion' + '.csv'
		ffile = open(filename, 'w')
		fcsv = csv.writer(ffile)
		fcsv.writerow(['local_id', 'time','secs','nsecs','delay','obs_rel_x', 'obs_rel_y', 'vel_x', 'vel_y', 'obs_x', 'obs_y', 'delt', 'id'])
		print 'save to file:',filename

		filename = self.folder_name + '/' + bagName + '.csv'
		sfile = open(filename, 'w')
		scsv = csv.writer(sfile)
		scsv.writerow(['time','x', 'y','r', 'mobileye_id', 'lc0', 'lc1', 'lc2', 'lc3', 'lquality',\
		'rc0', 'rc1', 'rc2', 'rc3','rquality', 'twist_id', 'vel', 'angular', 'cmd_id', 'cmd_vel', \
		'cmd_angular', 'dbw_id','enable', 'target_id', 'tx','ty', 'tr', 'replan', 'steering_id', 'steering_angle',\
		'obs_id', 'obs_rel_x', 'obs_rel_y', 'vel_x', 'vel_y', 'monitor_id', 'monitor_map_x', 'monitor_map_y',
		 'monitor_map_r', 'vision_id', 'vlc0', 'vrc0', 'vlc1', 'vlc2', 'vlc3', 'vrc1', 'vrc2', 'vrc3'])
		print 'save to file:', filename


		filename = self.folder_name +'/' + bagName + '_radar_process' + '.csv'
		radarfile = open(filename, 'w')
		radarcsv = csv.writer(radarfile)
		radarcsv.writerow(['local_id', 'track_id', 'track_shape_x','track_shape_y','track_shape_z','linear_velocity_x','linear_velocity_y', 'linear_velocity_z', 'linear_acceleration_x', 'linear_acceleration_y', 'linear_acceleration_z', 'is_background', 'time_id', 's_current_idx','s_tracked_times_threshold','obs_id','tracked_times','tracking_time','id_tracked','validity'])
		print 'save to file:',filename



		self.esr_pre_time = None
		self.laser_pre_time = None
		self.obs_pre_time = {}
		self.fusion_obs_pre_time = {}
		# self.local_pre_time = None
		# self.pre_time = None
		self.localization_id = 0
		self.robot_x = 0
		self.robot_y = 0
		self.robot_r = None

		mobileye_id = 0
		lc0 = 0
		lc1 = 0
		lc2 = 0
		lc3 = 0
		lquality = 0
		rc0 = 0
		rc1 = 0
		rc2 = 0
		rc3 = 0
		rquality = 0
		twist_id = 0
		vel = 0
		angular = 0
		cmd_id = 0
		cmd_vel = 0
		cmd_angular = 0
		dbw_id = 0
		dbw_enable = 0
		tx = 0
		ty = 0
		tr = 0
		target_id = 0
		pre_mobileye_stamp = None
		pre_vision_stamp = None
		replan = 0
		steering_angle = 0
		steering_id = 0
		local_time = 0
		front_obs_id = 0
		front_obs_rel_x = 0
		front_obs_rel_y = 0
		front_obs_vel_x = 0
		front_obs_vel_y = 0

		monitor_msg_id = 0
		monitor_map_x = 0
		monitor_map_y = 0
		monitor_map_r = 0
		vision_id = 0
		vlc0 = 0
		vrc0 = 0
		vlc1 = 0
		vlc2 = 0
		vlc3 = 0
		vrc1 = 0
		vrc2 = 0
		vrc3 = 0

		for topic, msg, t in bagContents:
			# if topic in self.listOfTopics:
			# 	num += 1
			# 	if num >= 2000:
			# 		break
			if topic == self.local_msg:
				self.localization_id += 1
				# ta = self.tansTimestamp(data.header.stamp.secs)
				(t, j, r) = quatToEular((msg.pose.orientation.x, msg.pose.orientation.y, msg.pose.orientation.z, msg.pose.orientation.w))
				# c = [ta, data.pose.position.x, data.pose.position.y, r]
				self.robot_x, self.robot_y, self.robot_r = [msg.pose.position.x, msg.pose.position.y, r]

				ta = tansTimestamp(msg.header.stamp.secs)
				local_time = ta
				mobileye_data = [lc0, lc1, lc2, lc3,lquality, rc0, rc1, rc2, rc3, rquality]
				c = [ta, msg.pose.position.x, msg.pose.position.y, r]
				c.append(mobileye_id)
				c.extend(mobileye_data)
				c.extend([twist_id, vel, angular])
				c.extend([cmd_id, cmd_vel, cmd_angular, dbw_id, dbw_enable, target_id, tx, ty, tr, replan, steering_id, steering_angle])
				c.extend([front_obs_id, front_obs_rel_x, front_obs_rel_y, front_obs_vel_x, front_obs_vel_y])
				c.extend([monitor_msg_id, monitor_map_x, monitor_map_y, monitor_map_r])
				c.extend([vision_id, vlc0, vrc0, vlc1, vlc2, vlc3, vrc1, vrc2, vrc3])
				scsv.writerow(c)
			elif topic == self.front_obs_msg:
				front_obs_id += 1
				front_obs_rel_x = msg.obstacle_pos_x
				front_obs_rel_y = msg.obstacle_pos_y
				front_obs_vel_x = msg.obstacle_rel_vel_x
				front_obs_vel_y = msg.obstacle_rel_vel_y

			elif topic == self.mobileye_left_lane_msg:
				if pre_vision_stamp != msg.header.seq:
					pre_vision_stamp = msg.header.seq
				else:
					# pre_mobileye_stamp = msg.header.stamp, 
					vision_id += 1
					# only when both msg header is the same will update mobileye_id
				vlc0 = msg.position_parameter_c0
				vlc1 = msg.heading_angle_parameter_c1
				vlc2 = msg.curvature_parameter_c2
				vlc3 = msg.curvature_derivative_parameter_c3

			elif topic == self.vision_left_lane_msg:
				# if pre_mobileye_stamp != msg.header.stamp:
				if pre_mobileye_stamp != msg.header.seq:
					pre_mobileye_stamp = msg.header.seq
				else:
					# pre_mobileye_stamp = msg.header.stamp, 
					mobileye_id += 1
					# only when both msg header is the same will update mobileye_id
				lc0 = msg.position_parameter_c0
				lc1 = msg.heading_angle_parameter_c1
				lc2 = msg.curvature_parameter_c2
				lc3 = msg.curvature_derivative_parameter_c3
				lquality = msg.quality

			elif topic == self.mobileye_right_lane_msg:
				if pre_vision_stamp != msg.header.seq:
					pre_vision_stamp = msg.header.seq
				else:
					# pre_mobileye_stamp = msg.header.stamp, 
					vision_id += 1
				vrc0 = msg.position_parameter_c0
				vrc1 = msg.heading_angle_parameter_c1
				vrc2 = msg.curvature_parameter_c2
				vrc3 = msg.curvature_derivative_parameter_c3

			elif topic == self.vision_right_lane_msg:
				# if pre_mobileye_stamp != msg.header.stamp:
				if pre_mobileye_stamp != msg.header.seq:
					pre_mobileye_stamp = msg.header.seq
				else:
					# pre_mobileye_stamp = msg.header.stamp, 
					mobileye_id += 1
				rc0 = msg.position_parameter_c0
				rc1 = msg.heading_angle_parameter_c1
				rc2 = msg.curvature_parameter_c2
				rc3 = msg.curvature_derivative_parameter_c3
				rquality = msg.quality

			elif topic == self.twist_msg:
				twist_id += 1
				vel = msg.twist.linear.x
				angular = msg.twist.angular.z

			elif topic == self.cmd_vel_msg:
				cmd_id += 1
				cmd_vel = msg.twist.linear.x
				cmd_angular = msg.twist.angular.z

			elif topic == self.dbw_enable_msg:
				dbw_id += 1
				dbw_enable = int(msg.data)

			elif topic == self.next_target_msg:
				target_id += 1
				p = msg.pose.position
				tx = p.x
				ty = p.y
				tr = p.z

			elif topic == self.steering_msg:
				steering_id += 1
				steering_angle = msg.steering_wheel_angle_cmd

			elif topic == self.laser_msg:
				rec_time = tansTimestamp(t.secs)
				cur_time = msg.header.stamp
				delay_time = ((t - cur_time).to_nsec())/1000000000.0
				if self.laser_pre_time is not None:
					delt = ((cur_time - self.laser_pre_time).to_nsec())/1000000000.0
				else:
					delt = 0
				self.laser_pre_time = cur_time
				for i in range(0, len(msg.objects)):
					t = msg.objects[i]
					y = t.object_box_center.pose.position.y
					x = t.object_box_center.pose.position.x
					if x == 0 and y == 0:
						continue
					if self.robot_r is not None:
						robot = Point(x = self.robot_x, y = self.robot_y, z = self.robot_r)
						obj = Point(x = x, y = y, z = 0)
						(wx, wy, wz) = self_to_world(obj, robot)
					else :
						wx = wy = wz = 0
					velx = t.velocity.twist.linear.x
					vely = t.velocity.twist.angular.z
					lasercsv.writerow([self.localization_id, rec_time, msg.header.stamp.secs, msg.header.stamp.nsecs,\
					 delay_time, x, y, velx, vely, wx, wy, delt, t.id])

			elif topic == self.esr_msg:
				rec_time = tansTimestamp(t.secs)
				cur_time = msg.header.stamp
				delay_time = ((t - cur_time).to_nsec())/1000000000.0
				if self.esr_pre_time is not None:
					delt = ((cur_time - self.esr_pre_time).to_nsec())/1000000000.0
				else:
					delt = 0
				self.esr_pre_time = cur_time
				for i in range(0, len(msg.tracks)):
					t = msg.tracks[i]
					y = -(t.track_shape.points[0].y + t.track_shape.points[1].y)/2
					x = t.track_shape.points[0].x
					if x == 0 and y == 0:
						continue
					if self.robot_r is not None:
						robot = Point(x = self.robot_x, y = self.robot_y, z = self.robot_r)
						obj = Point(x = x, y = y, z = 0)
						(wx, wy, wz) = self_to_world(obj, robot)
					else :
						wx = wy = wz = 0
					velx = t.linear_velocity.x
					vely = t.linear_velocity.y
					esrcsv.writerow([self.localization_id, rec_time, msg.header.stamp.secs, msg.header.stamp.nsecs,\
					 delay_time, x, y, velx, vely, wx, wy, delt, t.track_id])

			elif topic == self.vision_obs_msg:
				cur_time = msg.header.stamp
				rec_time = tansTimestamp(t.secs)
				delay_time = (t - cur_time).to_nsec()/1000000000.0

				for i in range(0, len(msg.tracks)):
					one = msg.tracks[i]
					delay_time = (t - one.header.stamp).to_nsec()/1000000000.0
					if one.obstacle_id not in self.obs_pre_time:
						self.obs_pre_time[one.obstacle_id] = one.header.stamp
						delt = 0
					else:
						delt = (one.header.stamp - self.obs_pre_time[one.obstacle_id]).to_nsec()/1000000000.0
						self.obs_pre_time[one.obstacle_id] = one.header.stamp
					x = one.obstacle_pos_x
					y = one.obstacle_pos_y
					track_id = one.obstacle_id
					if self.robot_r is not None:
						robot = Point(x = self.robot_x, y = self.robot_y, z = self.robot_r)
						obj = Point(x = x, y = y, z = 0)
						(wx, wy, wz) = self_to_world(obj, robot)
					else :
						wx = wy = wz = 0
					velx = one.obstacle_rel_vel_x
					vely = one.obstacle_rel_vel_y
					mobileyecsv.writerow([self.localization_id, rec_time, one.header.stamp.secs,one.header.stamp.nsecs,\
						delay_time, x, y, velx, vely, wx, wy, delt, track_id])

			elif topic == self.mobileye_obs_msg:
				cur_time = msg.header.stamp
				rec_time = tansTimestamp(t.secs)
				delay_time = (t - cur_time).to_nsec()/1000000000.0

				x = msg.obstacle_pos_x
				y = msg.obstacle_pos_y
				if abs(x) >=120 or abs(y) >=120:
					continue
				if msg.obstacle_id not in self.obs_pre_time:
					self.obs_pre_time[msg.obstacle_id] = cur_time
					delt = 0
				else:
					delt = (cur_time - self.obs_pre_time[msg.obstacle_id]).to_nsec()/1000000000.0
					self.obs_pre_time[msg.obstacle_id] = cur_time				

				track_id = msg.obstacle_id
				if self.robot_r is not None:
					robot = Point(x = self.robot_x, y = self.robot_y, z = self.robot_r)
					obj = Point(x = x, y = y, z = 0)
					(wx, wy, wz) = self_to_world(obj, robot)
				else :
					wx = wy = wz = 0
				velx = msg.obstacle_rel_vel_x
				vely = 0
				mobileyecsv.writerow([self.localization_id, rec_time, msg.header.stamp.secs,msg.header.stamp.nsecs,\
					delay_time, x, y, velx, vely, wx, wy, delt, track_id])

			elif topic == self.monitor_msg:
				if msg.trajectory_replan == True:
					replan = 1
				else:
					replan = 0
				monitor_msg_id += 1
				# monitor_map_x = msg.trajectory_target_map.x
				# monitor_map_y = msg.trajectory_target_map.y
				# monitor_map_r = msg.trajectory_target_map.z
				monitor_map_x = 0
				monitor_map_y = 0
				monitor_map_r = 0

			elif topic == self.fusion_obs_msg:
				print 'get msg'
				cur_time = msg.header.stamp
				rec_time = tansTimestamp(t.secs)
				if len(msg.tracks) == 0:
					print 'msg is empty'
				for i in range(0, len(msg.tracks)):
					one = msg.tracks[i]
					delay_time = (t - one.header.stamp).to_nsec()/1000000000.0
					if one.obstacle_id not in self.fusion_obs_pre_time:
						self.fusion_obs_pre_time[one.obstacle_id] = one.header.stamp
						delt = 0
					else:
						delt = (one.header.stamp - self.fusion_obs_pre_time[one.obstacle_id]).to_nsec()/1000000000.0
						self.fusion_obs_pre_time[one.obstacle_id] = one.header.stamp
					x = one.obstacle_pos_x
					y = one.obstacle_pos_y
					track_id = one.obstacle_id
					if self.robot_r is not None:
						robot = Point(x = self.robot_x, y = self.robot_y, z = self.robot_r)
						obj = Point(x = x, y = y, z = 0)
						(wx, wy, wz) = self_to_world(obj, robot)
					else :
						wx = wy = wz = 0
					velx = one.obstacle_rel_vel_x
					vely = one.obstacle_rel_vel_y
					fcsv.writerow([self.localization_id, rec_time, one.header.stamp.secs,one.header.stamp.nsecs,\
						delay_time, x, y, velx, vely, wx, wy, delt, track_id])

			elif topic == self.radar_process_msg:
				if len(msg.Radar_Info) >0:
					for i in range(0, len(msg.Radar_Info)):
						one = msg.Radar_Info[i]

					#print 'debug', one
						track_id = one.track_id
						track_shape_x = one.track_shape_x
						track_shape_y = one.track_shape_y
						track_shape_z = one.track_shape_z
						linear_velocity_x = one.linear_velocity_x
						linear_velocity_y = one.linear_velocity_y
						linear_velocity_z = one.linear_velocity_z
						linear_acceleration_x = one.linear_acceleration_x
						linear_acceleration_y = one.linear_acceleration_y
						linear_acceleration_z = one.linear_acceleration_z
						is_background = one.is_background
						time_id = one.time_id
						s_current_idx = one.s_current_idx
						s_tracked_times_threshold = one.s_tracked_times_threshold
						obs_id = one.obs_id
						tracked_times = one.tracked_times
						tracking_time = one.tracking_time
						id_tracked = one.id_tracked
						validity = one.validity
						print 'debug', track_id
						radarcsv.writerow([self.localization_id, track_id, track_shape_x, track_shape_y,track_shape_z,\
							linear_velocity_x, linear_velocity_y, linear_velocity_z, linear_acceleration_x, linear_acceleration_y, linear_acceleration_z, is_background, time_id, s_current_idx,s_tracked_times_threshold,obs_id,tracked_times,tracking_time,id_tracked,validity])

						
		mobileyefile.flush()
		mobileyefile.close()
		esrfile.flush()
		esrfile.close()
		ffile.flush()
		ffile.close()
		sfile.flush()
		sfile.close()
		laserfile.flush()
		laserfile.close()
		radarfile.flush()
		radarfile.close()
		print 'have finish process bag'

def main():
	reader = RosbagReader()
	# reader.processor() 
	reader.read_bags_in_folders()
if __name__ == '__main__':
    # run main function and exit
    sys.exit(main())



