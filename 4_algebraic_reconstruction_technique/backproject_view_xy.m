function correction_image = backproject_view_xy(image, FCD_mm, DCD_mm, ...
    angle_deg, n_dexel, dexel_size_mm, pixel_size_mm, d, h)
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

% Calculate position of x-ray source
[source_x,source_y] = tube_position_xy(FCD_mm, angle_deg);

% Find positions for detector elements
[dexel_x,dexel_y] = detector_position_xy(DCD_mm, angle_deg, ...
                                     n_dexel, dexel_size_mm);

% Initialize correction_image
correction_image = zeros(n_dexel,size(image,1),size(image,2)); % Create vector having the size of the Dexel amount

% Iterate over all detectors to calculate attenuation array
for i = 1:n_dexel
    backproject = backproject_xy(image,source_x, source_y, dexel_x(i), dexel_y(i),pixel_size_mm, d(i), h(i)); % Create correcton data for one dexel
    
    % Reshape Correction Image
    backproject = reshape(backproject, size(image));

    % Store current iteration
    correction_image(i,:,:) = backproject; % Fill vector at dexel position idx
end

correction_image = squeeze(sum(correction_image, 1));

end
