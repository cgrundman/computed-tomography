function [S, H] = view_xy(image_data, FCD_mm, DCD_mm, angle_deg, n_dexel, ...
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
% S - attenuation signals for the x-ray beam across all detectors
% H - normalization factors across all detectors

% Calculate position of x-ray source
[source_x,source_y] = tube_position_xy(FCD_mm, angle_deg);

% Find positions for detector elements
[det_x,det_y] = detector_position_xy(DCD_mm, angle_deg, ...
                                     n_dexel, dexel_size_mm);

% Initiate output arrays
S = zeros(1,n_dexel); % attenuation array
H = zeros(1,n_dexel); % normalization factor array


% Iterate over all detectors to calculate attenuation array
for dexel = 1:n_dexel
    % store each single measuerment in P
    [S(dexel), H(dexel)] = line_integral_xy(image_data, pixel_size_mm, source_x, source_y, det_x(dexel), det_y(dexel));

end

end
