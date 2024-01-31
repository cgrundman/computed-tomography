%% Computed Tomography Reconstruction
% Metal Artifact Reduction (MAR)

clc
clear
close all

%% Load Data
% Load Sinogram
data = load('hip_sino.mat');
data_sino = data.sino;

% Visualize Sinogram
fig = figure('units','normalized','outerposition',[0 0 .6 .75]);
imagesc(data_sino)
colormap gray(256)
img_title = "Hip with Metal Prosthesis - Sinogram";
title(img_title,'FontSize',16)
axis off
saveas(fig,'figures/hip_sino.jpg');

%% 1) Creation of Metal Masks 
% 1a. Reconstruct the Data
% Perform reconstruction
data_reco = reconstruct(data_sino);

% Set thresholds for visualization
level = 0.014;
window = 0.007;
cmin = level - window/2;
cmax = level + window/2;

% Visualize Reconstruction
fig_2 = figure('units','normalized','outerposition',[0 0 .4 .75]);
imagesc(data_reco, [cmin cmax]);
colormap gray(256)
img_title = "Hip with Metal Prosthesis - CT Image";
title(img_title,'FontSize',16)
axis('square')
% axis off
xticklabels ''
yticklabels ''
saveas(fig_2,'figures/data_reco.jpg');

% 1b. Create Metal Mask
% Adjust image for les saturation
img = imadjust(data_reco);

% Perform Canny Edge Detection (shows borders of metal)
canny = edge(data_reco, "canny", 0.02, 2);

% Fill closed regions within image (areas that are metal)
canny_regions = imfill(canny,'holes'); % fill closed areas on the image

% Remove remaining edges from Canny Edge Detection (false readings)
kernel = strel('disk',1);
canny_clean = imopen(canny_regions, kernel);

% Visualize Metal Artifact Detection
fig_3 = figure('units','normalized','outerposition',[0 0 1 .66]);
subplot(1, 3, 1);
imagesc(canny);
colormap gray(256)
img_title = "Canny Edge Detection";
title(img_title,'FontSize',16)
axis('square')
xticklabels ''
yticklabels ''

subplot(1, 3, 2);
imagesc(canny_regions);
colormap gray(256)
img_title = "Filled Regions";
title(img_title,'FontSize',16)
axis('square')
xticklabels ''
yticklabels ''

subplot(1, 3, 3);
imagesc(canny_clean);
colormap gray(256)
img_title = "Isolated Metal Regions";
title(img_title,'FontSize',16)
axis('square')
xticklabels ''
yticklabels ''
saveas(fig_3,'figures/canny_detection.jpg');

% 1c. Mask the full dataset with the metal mask
% Create Sinogram of mask with forward projection
mask_sino = forwardproject(canny_clean);

% Filter full sinogram with metal mask
data_masked = bsxfun(@minus, data_sino, mask_sino);

% Visualize Metal Mask Sinogram and Filtered Sinogram of data
fig_4 = figure('units','normalized','outerposition',[0 0 1 .5]);
subplot(1, 3, 1);
imagesc(mask_sino);
colormap gray(256)
img_title = "Isolated Metal Regions - Sinogram";
title(img_title,'FontSize',16)
axis off

subplot(1, 3, 2);
imagesc(mask_sino, [cmin cmax]);
colormap gray(256)
img_title = "Isolated Metal Regions - Sinogram (Thresholds)";
title(img_title,'FontSize',16)
axis off

subplot(1, 3, 3);
imagesc(data_masked, [0 max(data_masked, [], 'all')]);
colormap gray(256)
img_title = "Data Sinogram with Mask Applied";
title(img_title,'FontSize',16)
axis off
saveas(fig_4,'figures/mask_sino.jpg');

% 1d. Reconstruction of Masked Sinogram
reco_masked = reconstruct(data_masked);

% Visualize Reconstruction
fig_5 = figure('units','normalized','outerposition',[0 0 .4 .75]); 
imshow(reco_masked, [cmin cmax]);
colormap gray(256)
img_title = "Masked Reconstruction";
title(img_title,'FontSize',16)
axis('square')
xticklabels ''
yticklabels ''
saveas(fig_5,'figures/mask_reco.jpg');

%% 2) Reduce the Noise
% 2a. Reduction of noise is through bluring

% Technique 1
blur_rad = 20;
blurred_sino_1 = blur(data_sino, blur_rad);

% Technique 2
kernel = fspecial('disk', 10);
blurred_sino_2 = imfilter(data_sino, kernel, 'replicate');

% Visualize Blurred Sinograms
fig_6 = figure('units','normalized','outerposition',[0 0 1 .75]);
subplot(1,2,1)
imagesc(blurred_sino_1, [0 9]);
colormap gray(256)
img_title = "Blurring Technique 1";
title(img_title,'FontSize',16)
axis off

subplot(1,2,2)
imagesc(blurred_sino_2, [0 9]);
colormap gray(256)
img_title = "Blurring Technique 2";
title(img_title,'FontSize',16)
axis off
saveas(fig_6,'figures/blurred_sinos.jpg');

% 2b. Apply the mask to the blurred images
%% TODO FIX MERGING OF BLURRED SINOGRAM
% Mask Original Sinogram
masked_2 = bsxfun(@minus, data_sino, mask_sino); % data_masked
% masked_2 = rescale(masked_2,0,1);
% mask the blurred sinogram - leave only blurred metal traces
masked_blurred = bsxfun(@and, im2uint8(blurred_sino_1), im2uint8(mask_sino));
masked_blurred = rescale(masked_blurred,0,1);
% mix the above sinograms
sino_mix = imfuse(data_masked, masked_blurred, 'blend');

% Visualize
fig_7 = figure('units','normalized','outerposition',[0 0 1 .5]);
subplot(1,3,1)
imagesc(masked_2)%, [min(masked_2, [], 'all'), max(masked_2, [], 'all')]);
colormap gray(256)
img_title = "masked_2";
title(img_title,'FontSize',16)
axis off

subplot(1,3,2)
imagesc(masked_blurred)%, [min(masked_blurred, [], 'all'), max(masked_blurred, [], 'all')]);
colormap gray(256)
img_title = "masked_blurred";
title(img_title,'FontSize',16)
axis off

subplot(1,3,3)
imagesc(sino_mix, [min(sino_mix, [], 'all'), max(sino_mix, [], 'all')]);
colormap gray(256)
img_title = "sino_mix";
title(img_title,'FontSize',16)
axis off
saveas(fig_7,'figures/noise_reduction.jpg');

% 2c. Reconstruct blurred sinogram
reconstructed_mix = reconstruct(sino_mix); 

% Vizualize
fig_8 = figure('units','normalized','outerposition',[0 0 .4 .75]);
imagesc(reconstructed_mix, [min(reconstructed_mix, [], 'all'), max(reconstructed_mix, [], 'all')]); 
colormap gray(256)
img_title = "Reconstruction - Noise Reduction";
title(img_title,'FontSize',16)
axis('square')
xticklabels ''
yticklabels ''
saveas(fig_8,'figures/recon_noise_reduction.jpg');
