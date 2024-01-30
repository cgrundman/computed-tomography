function sinogram = forwardproject(image)
% INPUTS
% image - image data to convert
% 
% OUTPUTS
% sinogram - sinogram of input image

% Extract size of input image
[nrows, ncols] = size(image);

% Check data for correct size
if nrows ~= 520
    error('wrong data, not 736 rows!')
elseif ncols~= 520
    error('wrong data. not 576 cols!')
end

% Set the number of views
n_views = 576;

% Define view angle theta
theta = 360 * ((1:n_views) - 1) / n_views;

% Calculation of Sinogram
sinogram = radon(image, theta);
sinogram = sinogram(2:end-2,:); % trim sinogram

end