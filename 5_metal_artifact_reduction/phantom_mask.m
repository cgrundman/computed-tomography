function phantom_mask(vmin, vmax)
% INPUTS
% vmin - minimum display window
% vmax - maximum display window
% 
% OUTPUTS

disp("Running: phantom_mask.m")

%% Original Data
% Load data
phantom_data = load('phantom_sino.mat');
phantom_sino = phantom_data.sino; 

% Reconstruct the Data
phantom_reconstruction = reconstruct(phantom_sino);

% Visualize Original Sinogram and Reconstruction
fig_1 = figure('units','normalized','outerposition',[0 0 1 .75]);
subplot(1,2,1)
imagesc(phantom_sino);
colormap gray(256)
img_title = "Original Sinogram";
title(img_title,'FontSize',16)
axis off

subplot(1,2,2)
imagesc(phantom_reconstruction, [vmin, vmax]);
colormap gray(256)
img_title = "Reconstruction of Original Data";
title(img_title,'FontSize',16)
axis off
saveas(fig_1,'figures/phantom_sino_original_data.jpg');

end