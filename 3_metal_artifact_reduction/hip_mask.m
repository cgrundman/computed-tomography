function hip_mask(vmin, vmax)
% INPUTS
% vmin - minimum display windowperform
% vmax - maximum display window
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
fig_1 = figure('units','normalized','outerposition',[0 0 1 .75]);
subplot(1,2,1)
imagesc(hip_sino);
colormap gray(256)
img_title = "Original Sinogram";
title(img_title,'FontSize',48)
axis off

subplot(1,2,2)
imagesc(hip_reconstruction, [vmin, vmax]);
colormap gray(256)
img_title = "Reconstruction";
title(img_title,'FontSize',48)
axis off
saveas(fig_1,'figures/hip_sino_original_data.jpg');

%% Create the Mask
% Dilate the reconstruction image
hip_dil = imdilate(hip_reconstruction, strel('sphere',2));
% Dilate image again to fill smaller gaps
hip_dil_2 = imdilate(hip_dil, strel('sphere',1)); 
% Remove values by threshold
hip_dil_2(hip_dil_2<=0.019) = 0;

% Forward project mask
mask_sino = forwardproject(hip_dil_2);
% Convert Mask Sinogram to logical (0 or 1)
mask_sino_logical = mask_sino;
mask_sino_logical(mask_sino_logical~=0) = 1;

% Visualization of Mask Creation
fig_2 = figure('units','normalized','outerposition',[0 0 1 .55]);
subplot(1,4,1)
imagesc(hip_dil, [vmin vmax]); % Reconstruction image
colormap gray(256);
img_title = {'Original Data';'Reconstruction'};
title(img_title,'FontSize',36)
axis off
subplot(1,4,2)
imagesc(hip_dil_2, [vmin vmax]);
colormap gray(256);
img_title = "Metal Mask";
title(img_title,'FontSize',36)
axis off
subplot(1,4,3)
imagesc(mask_sino);
colormap gray(256);
img_title = {'Metal Mask';'Sinogram'};
title(img_title,'FontSize',36)
axis off
subplot(1,4,4)
imagesc(mask_sino_logical);
colormap gray(256);
img_title = {'Metal Mask';'Logical'};
title(img_title,'FontSize',36)
axis off
saveas(fig_2,'figures/hip_sino_metal_mask_creation.jpg');

% Save the mask data
save('hip_mask.mat','mask_sino_logical');

%% Create Masked Image
% Invert the mask
mask_sino_invert = ~mask_sino_logical;
% Singram intersection with inverted mask
masked_sinogram = hip_sino.*mask_sino_invert;
% Reconstruct the masked sinogram
masked_reconstruction = reconstruct(masked_sinogram);

% Visualization of Mask and New Reconstruction
fig_3 = figure('units','normalized','outerposition',[0 0 1 .75]);
subplot(1,2,1)
imagesc(masked_sinogram)
colormap gray(256)
img_title = "Masked Sinogram";
title(img_title,'FontSize',48)
axis off
subplot(1,2,2)
imagesc(masked_reconstruction, [vmin vmax])
colormap gray(256)
img_title = "Masked Reconstruction";
title(img_title,'FontSize',48)
axis off
saveas(fig_3,'figures/hip_sino_metal_mask_results.jpg');

end