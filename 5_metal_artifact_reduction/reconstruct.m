function reconstruction = reconstruct(sinogram)
% INPUTS
% sino - data in sinogram form
% 
% OUTPUTS
% reconstruction - reconstruction of sinogram

% Extract number of views and number of detectors from sinogram
[n_dexel, n_views] = size(sinogram);

% Test that input image is of correct dimensions
if n_dexel ~= 736
    error('wrong data, not 736 dexel!')
elseif n_views ~= 576
    error('wrong data. not 576 views!')
end

% Create list of angles in degrees
theta = 360 * ((1:n_views) - 1) / n_views;

% Create reconstruction
reconstruction = iradon(sinogram, theta);

end
