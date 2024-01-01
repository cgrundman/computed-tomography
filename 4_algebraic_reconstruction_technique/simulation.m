function sinogram = simulation(image_data, FCD_mm, DCD_mm, angles_deg, ...
                               n_dexel, dexel_size_mm, pixel_size_mm)
% INPUTS
% image_data - image matrix
% FCD_mm - distance from x-ray source to center
% DCD_mm - distance from x-ray source to center
% angles_deg - array of angles of rotation for source and detectors
% n_dexel - number of detectors
% dexel_size_mm - size of each detector in mm
% pixel_size_mm - size of the pixels in mm
% 
% OUTPUTS
% P - attenuation signals for the x-ray beam across all detectors

% define number of iterations
[~,n_angles] = size(angles_deg);

% initiate final sinogram matrix
sinogram = zeros(n_angles,n_dexel);

% loop over all angles and create sinogram matrix
for i = 1:n_angles
    sinogram(i,:) = view(image_data, FCD_mm, DCD_mm, angles_deg(i), ...
                       n_dexel, dexel_size_mm, pixel_size_mm);
end

end