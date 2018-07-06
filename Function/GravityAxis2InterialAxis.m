function [ p_x_IN, p_y_IN ] = GravityAxis2InterialAxis( p_x_g, p_y_g, x_g_n, y_g_n, phi_IN)
%AXIS_CHANGE 此处显示有关此函数的摘要
%   此处显示详细说明
T = [cos(phi_IN), -sin(phi_IN); 
     sin(phi_IN), cos(phi_IN)];
G_tran = [ p_x_g ;
           p_y_g ];
p_IN = T*G_tran;
p_x_IN = p_IN(1) + x_g_n;
p_y_IN = p_IN(2) + y_g_n;

 

