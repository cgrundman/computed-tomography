function [new_x, new_y] = rotate_xy(x, y, angle_deg)
% INPUTS
% x - x position coordinate
% y - y position coordinate
% angle_deg - angle to rotate through (degrees)
% 
% OUTPUTS
% pos_r - new r coordinate

% calculate sin and cos for given angle
sin_angle = sind(angle_deg);
cos_angle = cosd(angle_deg);

% calculate rotation using a 2x2 rotation matrix
new_x = x*cos_angle - y*sin_angle;
new_y = x*sin_angle + y*cos_angle;

end