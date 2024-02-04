function [det_x, det_y] = detector_position_xy(DCD_mm, ...
                                                angle_deg, ...
                                                n_dexel, ...
                                                dexel_size_mm)
% INPUTS
% DCD_mm - detector-center-distance between detector and rotation center
% angle_deg - angle of rotation
% n_dexel - number of dexel
% dexel_size_mm - size fo each dexel in mm
% 
% OUTPUTS
% det_x - detector y coordinate
% det_y - detector y coordinate

% width of detector
det_width = n_dexel*dexel_size_mm;

% set initial conditions for x and y values
x = linspace(-det_width/2, det_width/2, n_dexel)';
y = -DCD_mm*ones(n_dexel,1);

% initiate final x and y arrays for the detectors
det_x = zeros(n_dexel,1);
det_y = zeros(n_dexel,1);

% calculate the new x and y values for the detector for the rotation angle
for i = 1:n_dexel
    [det_x(i),det_y(i)] = rotate_xy(x(i),y(i),-angle_deg);
end

end