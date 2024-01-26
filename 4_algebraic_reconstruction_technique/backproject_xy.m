function correction_image = backproject_xy(image, source_x, source_y, ...
    dexel_x, dexel_y, pixel_size_mm, d_i, h_i)
% INPUTS
% image - image matrix to backproject
% source_x - x coordinate for the x-ray beam source
% source_y - y coordinate for the x-ray beam source
% dexel_x - x coordinate for the x-ray beam detector
% dexel_y - y coordinate for the x-ray beam detector
% pixel_size_mm - pixel width/height in mm
% d_i - difference between the simulated and measures projection values
% h_i - normalization value
% 
% OUTPUTS
% correction_image - output of backprojection for beam


% Convert the source coordinates from x,y to r,c
source_c = x_to_c(source_x, image, pixel_size_mm);
source_r = y_to_r(source_y, image, pixel_size_mm);

% Convert the detector coordinates from x,y to r,c
dexel_c = x_to_c(dexel_x, image, pixel_size_mm);
dexel_r = y_to_r(dexel_y, image, pixel_size_mm);

% disp("backproject_xy h_i")
% disp(h_i)

% Calculate correction value for backprojection
c_i = d_i/h_i;

% disp("backproject_xy c_i")
% disp(c_i)

% Calculate correction_image
correction_image = backproject_rc(image, source_r, source_c, dexel_r, ...
    dexel_c, c_i);

disp("backproject_xy")
% disp(correction_image)

end
