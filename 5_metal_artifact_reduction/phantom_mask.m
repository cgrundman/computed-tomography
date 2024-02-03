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

%% Create the Mask
% Dialate the reconstruction image
phantom_dial = imdilate(phantom_reconstruction, strel('sphere',2));
% Dialate image again to fill smaller gaps
phantom_dial_2 = imdilate(phantom_dial, strel('sphere',1)); 
% Remove values by threshold
phantom_dial_2(phantom_dial_2<=0.029) = 0;

% Forward project mask
mask_sino = forwardproject(phantom_dial_2);
% Convert Mask Sinogram to logical (0 or 1)
mask_sino_logical = mask_sino;
mask_sino_logical(mask_sino_logical~=0) = 1;

% Visualization of Mask
fig_2 = figure('units','normalized','outerposition',[0 0 1 .5]);
subplot(1,4,1)
imagesc(phantom_reconstruction, [vmin vmax]); % Reconstruction image
colormap gray(256);
img_title = "Original Data Reconstruction";
title(img_title,'FontSize',16)
axis off
subplot(1,4,2)
imagesc(phantom_dial_2, [vmin vmax]);
colormap gray(256);
img_title = "Metal Mask";
title(img_title,'FontSize',16)
axis off
subplot(1,4,3)
imagesc(mask_sino);
colormap gray(256);
img_title = "Metal Mask - Sinogram";
title(img_title,'FontSize',16)
axis off
subplot(1,4,4)
imagesc(mask_sino_logical);
colormap gray(256);
img_title = "Metal Mask - Sinogram Logical";
title(img_title,'FontSize',16)
axis off
saveas(fig_2,'figures/phantom_sino_metal_mask_creation.jpg');

%% Save the mask data
save('phantom_mask.mat','mask_sino_logical');

end