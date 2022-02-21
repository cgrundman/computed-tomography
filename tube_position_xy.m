function [tube_x, tube_y] = tube_position_xy(FCD_mm, angle_deg)
% INPUTS
% FCD_mm - focus center distance (distance between the rotation center and
% the source
% angle_deg - angle to rotate through (degrees)
% 
% OUTPUTS
% tube_x - new x coordinate for xray tube
% tube_y - new y coordinate for xray tube


tube_x = FCD_mm*sind(angle_deg);
tube_y = FCD_mm*cosd(-angle_deg);

end