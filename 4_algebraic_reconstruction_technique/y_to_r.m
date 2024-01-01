function pos_r = y_to_r(pos_y, data, pixel_size_mm)
% INPUTS
% pos_y - y position coordinate
% data - image matrix
% pixel_size_mm - pixel size in mm
% 
% OUTPUTS
% pos_r - new r coordinate


% extract y-coords of data matrix
[~,data_y] = size(data);

% calculate shift in coordinate systems
shift = (data_y/2) + 0.5;

% calculate new coordinate
pos_r = pos_y/-pixel_size_mm + shift;

end