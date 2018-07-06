function [ p_x_g, p_y_g ] = InterialAxis2GravityAxis( p_x_IN, p_y_IN, x_g_n, y_g_n, phi_IN)

T = [cos(phi_IN), sin(phi_IN); 
     -sin(phi_IN), cos(phi_IN)];
G_tran = [ p_x_IN - x_g_n;
           p_y_IN - y_g_n];
p_IN = T*G_tran;
p_x_g = p_IN(1);
p_y_g = p_IN(2);