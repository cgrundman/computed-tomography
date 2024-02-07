function P = sim_view(image_data, FCD_mm, DCD_mm, angle_deg, n_dexel, ...
                  dexel_size_mm, pixel_size_mm)
% INPUTS
% image_data - image matrix
% FCD_mm - distance from x-ray source to center
% DCD_mm - distance from x-ray source to center
% angle_deg - angle of rotation for source and detectors
% n_dexel - number of detectors
% dexel_size_mm - size of each detector in mm
% pixel_size_mm - size of the pixels in mm
% 
% OUTPUTS
% P - attenuation signals for the x-ray beam across all detectors

% store image data
data = image_data;

% calculate position of tube and all detectors
[source_x,source_y] = tube_position_xy(FCD_mm, angle_deg);

% find positions for detector elements
[det_x,det_y] = detector_position_xy(DCD_mm, angle_deg, ...
                                     n_dexel, dexel_size_mm);

% iterate over all detectors to calculate attenuation array

% initiate attenuation array
P = zeros(n_dexel,1);

for i = 1:n_dexel
    % store each single measuerment in P
    P(i) = line_integral_xy(data, pixel_size_mm, source_x, source_y, ...
                            det_x(i), det_y(i));
end

end
