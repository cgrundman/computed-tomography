function pos_c = x_to_c(pos_x, data, pixel_size_mm)
% INPUTS
% pos_x - x position coordinate
% data - image matrix
% pixel_size_mm - pixel size in mm
% 
% OUTPUTS
% pos_c - new c coordinate


% extract x-coords of data matrix
[data_x,~] = size(data);

% calculate shift in coordinate systems
shift = (data_x/2) + 0.5;

% calculate new coordinate, negative for inversion between coordinates
pos_c = pos_x/pixel_size_mm + shift;

end