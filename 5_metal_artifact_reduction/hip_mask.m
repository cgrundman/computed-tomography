function hip_mask(vmin, vmax)
% INPUTS
% 
% OUTPUTS

disp("Running: hip_mask.m")

%% Original Data
% Load data
hip_data = load('hip_sino.mat');
hip_sino = hip_data.sino; 

% Reconstruct the Data
hip_reconstruction = reconstruct(hip_sino);

% Visualize Original Sinogram and Reconstruction
fig_6 = figure('units','normalized','outerposition',[0 0 1 .75]);
subplot(1,2,1)
imagesc(hip_sino);
colormap gray(256)
img_title = "Original Sinogram";
title(img_title,'FontSize',16)
axis off

subplot(1,2,2)
imagesc(hip_reconstruction, [vmin, vmax]);
colormap gray(256)
img_title = "Reconstruction of Original Data";
title(img_title,'FontSize',16)
axis off
saveas(fig_6,'figures/hip_sino_orignial_data.jpg');

end