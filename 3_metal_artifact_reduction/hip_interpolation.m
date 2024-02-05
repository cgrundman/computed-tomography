function hip_interpolation(vmin, vmax)
% INPUTS
% vmin - minimum display window
% vmax - maximum display window
% 
% OUTPUTS

disp("Running: hip_interpolation.m")

%% Original Data and Mask
% Load Data
hip_data = load('hip_sino.mat');
hip_sino = hip_data.sino;
% Load Mask
mask = load('hip_mask.mat');
mask_sino_logical = mask.mask_sino_logical;

%% Interpolation
% Interpolate the hip sinogram and mask data using regionfill()
hip_interpolate_sino = regionfill(hip_sino, mask_sino_logical);
% Reconstruct the interpolation
hip_interpolate_reconstruct = reconstruct(hip_interpolate_sino);

% Visualize the Interpolation Sinograma and Reconstruction
fig_1 = figure('units','normalized','outerposition',[0 0 1 .85]);
% Plot the Interpolated Sinogram
subplot(1,2,1)
imagesc(hip_interpolate_sino, [0 9]);
colormap gray(256);
img_title = {'Interpolation';'Sinogram'};
title(img_title,'FontSize',48)
axis off
% Plot the Interpolated Reconstruction
subplot(1,2,2)
imshow(hip_interpolate_reconstruct, [vmin vmax]);
colormap gray(256);
img_title = {'Interpolation';'Reconstruction'};
title(img_title,'FontSize',48)
axis off
saveas(fig_1,'figures/hip_interpolation_results.jpg'); % save image

end