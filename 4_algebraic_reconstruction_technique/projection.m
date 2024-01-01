function sinogram = projection(image)
% INPUTS
% image - desired image to create sinograms
% 
% OUTPUTS
% sinogram - matrix of sinograms generated from rotations

% number of angles to iterate over
angles = 180;

% setting initial conditions for sinogram
[~,c,~] = size(image);
sinogram = zeros(c, angles);

% for loop for sinogram
for i= 1:angles
    image_r = imrotate(image, i, 'crop');
    sinogram(:,i) = sum(image_r);
end

sinogram = sinogram';

end