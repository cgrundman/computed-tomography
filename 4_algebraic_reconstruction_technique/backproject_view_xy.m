function correction_image = backproject_view_xy(image_data, FCD_mm, ...
    DCD_mm, angle_deg, n_dexel, dexel_size_mm, pixel_size_mm, d, h)
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
% correction_image - backprojected image from above


% Store image data
image = image_data;

% Calculate position of x-ray source
[source_x,source_y] = tube_position_xy(FCD_mm, angle_deg);

% Find positions for detector elements
[dexel_x,dexel_y] = detector_position_xy(DCD_mm, angle_deg, ...
                                     n_dexel, dexel_size_mm);

% Initialize correction_image
correction_image = zeros(size(image));

% disp("backproject_view_xy h")
% disp(h)

% Iterate over all detectors to calculate attenuation array
for i = 1:n_dexel
    % store each single measuerment in P
    correction_image(:,:) = backproject_xy(image, source_x, source_y, ...
    dexel_x(n_dexel), dexel_y(n_dexel), pixel_size_mm, d(i), h(i));
    
end

% disp("backproject_view_xy")
% disp(correction_image)

end
