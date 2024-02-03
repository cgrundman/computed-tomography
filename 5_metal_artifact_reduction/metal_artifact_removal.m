%% Computed Tomography Reconstruction
% Metal Artifact Reduction (MAR)

clc
clear
close all

%% Load Data
% Load Sinogram
data = load('hip_sino.mat');
data_sino = data.sino;
% data_sino = rescale(data_sino, 0, 12);


disp("data_sino")
disp(max(data_sino, [], 'all'))
disp(min(data_sino, [], 'all'))

% % Visualize Sinogram
% fig = figure('units','normalized','outerposition',[0 0 .6 .75]);
% imagesc(data_sino)
% colormap gray(256)
% img_title = "Hip with Metal Prosthesis - Sinogram";
% title(img_title,'FontSize',16)
% axis off
% saveas(fig,'figures/hip_sino.jpg');

%% 1) Creation of Metal Masks 
% 1a. Reconstruct the Data
% Perform reconstruction
data_reco = reconstruct(data_sino);
% data_reco = rescale(data_reco, 0, 0.4);

disp("data_reco")
disp(max(data_reco, [], 'all'))
disp(min(data_reco, [], 'all'))

% Set thresholds for visualization
level = 0.0135;
window = 0.0075;
cmin = level - window/2
cmax = level + window/2

% % Visualize Reconstruction
% fig_2 = figure('units','normalized','outerposition',[0 0 .4 .75]);
% imagesc(data_reco, [cmin cmax]);
% colormap gray(256)
% img_title = "Hip with Metal Prosthesis - CT Image";
% title(img_title,'FontSize',16)
% axis('square')
% % axis off
% xticklabels ''
% yticklabels ''
% saveas(fig_2,'figures/data_reco.jpg');

% 1b. Create Metal Mask
% Adjust image for less saturation
img = imadjust(data_reco);

% Perform Canny Edge Detection (shows borders of metal)
canny = edge(data_reco, "canny", 0.02, 2);

% Fill closed regions within image (areas that are metal)
canny_regions = imfill(canny,'holes'); % fill closed areas on the image

% Remove remaining edges from Canny Edge Detection (false readings)
kernel = strel('disk',1);
canny_clean = imopen(canny_regions, kernel);

disp("canny_clean")
disp(max(canny_clean, [], 'all'))
disp(min(canny_clean, [], 'all'))

% % Visualize Metal Artifact Detection
% fig_3 = figure('units','normalized','outerposition',[0 0 1 .66]);
% subplot(1, 3, 1);
% imagesc(canny);
% colormap gray(256)
% img_title = "Canny Edge Detection";
% title(img_title,'FontSize',16)
% axis('square')
% xticklabels ''
% yticklabels ''
% 
% subplot(1, 3, 2);
% imagesc(canny_regions);
% colormap gray(256)
% img_title = "Filled Regions";
% title(img_title,'FontSize',16)
% axis('square')
% xticklabels ''
% yticklabels ''
% 
% subplot(1, 3, 3);
% imagesc(canny_clean);
% colormap gray(256)
% img_title = "Isolated Metal Regions";
% title(img_title,'FontSize',16)
% axis('square')
% xticklabels ''
% yticklabels ''
% saveas(fig_3,'figures/canny_detection.jpg');

% 1c. Mask the full dataset with the metal mask
% Create Sinogram of mask with forward projection
mask_sino = forwardproject(canny_clean);

disp("mask_sino")
disp(max(mask_sino, [], 'all'))
disp(min(mask_sino, [], 'all'))

% Filter full sinogram with metal mask
data_masked = bsxfun(@minus, data_sino, mask_sino);

data_masked(data_masked<-2)=-2;

disp("data_masked")
disp(max(data_masked, [], 'all'))
disp(min(data_masked, [], 'all'))

% % Visualize Metal Mask Sinogram and Filtered Sinogram of data
% fig_4 = figure('units','normalized','outerposition',[0 0 1 .5]);
% subplot(1, 3, 1);
% imagesc(mask_sino);
% colormap gray(256)
% img_title = "Isolated Metal Regions - Sinogram";
% title(img_title,'FontSize',16)
% axis off
% 
% subplot(1, 3, 2);
% imagesc(mask_sino, [cmin cmax]);
% colormap gray(256)
% img_title = "Isolated Metal Regions - Sinogram (Thresholds)";
% title(img_title,'FontSize',16)
% axis off
% 
% subplot(1, 3, 3);
% imagesc(data_masked, [0 max(data_masked, [], 'all')]);
% colormap gray(256)
% img_title = "Data Sinogram with Mask Applied";
% title(img_title,'FontSize',16)
% axis off
% saveas(fig_4,'figures/mask_sino.jpg');

% 1d. Reconstruction of Masked Sinogram
reco_masked = reconstruct(data_masked);

% % Visualize Reconstruction
% fig_5 = figure('units','normalized','outerposition',[0 0 .4 .75]); 
% imshow(reco_masked, [cmin cmax]);
% colormap gray(256)
% img_title = "Masked Reconstruction";
% title(img_title,'FontSize',16)
% axis('square')
% xticklabels ''
% yticklabels ''
% saveas(fig_5,'figures/mask_reco.jpg');

%% 2) Reduce the Noise
% 2a. Reduction of noise is through bluring

% Technique 1
blur_rad = 20;
blurred_sino_1 = blur(data_sino, blur_rad);

% Technique 2
kernel = fspecial('disk', 10);
blurred_sino_2 = imfilter(data_sino, kernel, 'replicate');

% Visualize Blurred Sinograms
% fig_6 = figure('units','normalized','outerposition',[0 0 1 .75]);
% subplot(1,2,1)
% imagesc(blurred_sino_1, [0 9]);
% colormap gray(256)
% img_title = "Blurring Technique 1";
% title(img_title,'FontSize',16)
% axis off
% 
% subplot(1,2,2)
% imagesc(blurred_sino_2, [0 9]);
% colormap gray(256)
% img_title = "Blurring Technique 2";
% title(img_title,'FontSize',16)
% axis off
% saveas(fig_6,'figures/blurred_sinos.jpg');

disp("mask_sino")
disp(max(mask_sino, [], 'all'))
disp(min(mask_sino, [], 'all'))

% 2b. Apply the mask to the blurred images
% Mask Original Sinogram
masked_2 = bsxfun(@minus, data_sino, mask_sino); % data_masked
% masked_2 = rescale(masked_2,0,1);
masked_2(masked_2<-2)=-2;

disp("masked_2")
disp(max(masked_2, [], 'all'))
disp(min(masked_2, [], 'all'))

% Mask the blurred sinogram - leave only blurred metal traces
masked_blurred = bsxfun(@and, blurred_sino_1, mask_sino);%bsxfun(@and, im2uint8(blurred_sino_1), im2uint8(mask_sino));
% masked_blurred = rescale(masked_blurred,0,1);
disp("masked_blurred")
disp(max(masked_blurred, [], 'all'))
disp(min(masked_blurred, [], 'all'))

% Mix the above sinograms
sino_clean = imfuse(data_masked, masked_blurred, 'blend');
disp("sino_clean")
disp(max(sino_clean, [], 'all'))
disp(min(sino_clean, [], 'all'))



% Visualize everything
figure('units','normalized','outerposition',[0 0 1 1]);
subplot(3,7,1)
imagesc(data_sino)
colormap gray(256)
title("data_sino",'FontSize',16)
subplot(3,7,2)
imagesc(data_reco, [cmin cmax])
colormap gray(256)
title("data_reco",'FontSize',16)
subplot(3,7,3)
imagesc(canny_clean)
colormap gray(256)
title("canny_clean",'FontSize',16)
subplot(3,7,4)
imagesc(mask_sino)
colormap gray(256)
title("mask_sino",'FontSize',16)
subplot(3,7,5)
imagesc(data_masked)
colormap gray(256)
title("data_masked",'FontSize',16)
subplot(3,7,6)
imagesc(reco_masked, [cmin cmax])
colormap gray(256)
title("reco_masked",'FontSize',16)



subplot(3,7,8)
imagesc(data_sino)
colormap gray(256)
title("data_sino",'FontSize',16)
subplot(3,7,9)
imagesc(blurred_sino_1)
colormap gray(256)
title("blurred_sino_1",'FontSize',16)

mask_sino_logical = mask_sino;
mask_sino_logical(mask_sino_logical>0)=1;
subplot(3,7,10)
imagesc(mask_sino_logical)
colormap gray(256)
title("mask_sino_logical",'FontSize',16)

blurred_mask = mask_sino_logical.*blurred_sino_1;
blurred_mask = rescale(blurred_mask, min(blurred_mask, [], 'all'), max(blurred_mask, [], 'all')/2);
disp("blurred_mask")
disp(max(blurred_mask, [], 'all'))
disp(min(blurred_mask, [], 'all'))
subplot(3,7,11)
imagesc(blurred_mask)
colormap gray(256)
title("blurred_mask",'FontSize',16)

original_mask = data_sino - mask_sino_logical.*data_sino;
disp("original_mask")
disp(max(original_mask, [], 'all'))
disp(min(original_mask, [], 'all'))
subplot(3,7,12)
imagesc(original_mask)
colormap gray(256)
title("original_mask",'FontSize',16)

blurred_original_mix = original_mask + blurred_mask;
subplot(3,7,13)
imagesc(blurred_original_mix)
colormap gray(256)
title("blurred_original_mix",'FontSize',16)

blurred_original_mix_reco = reconstruct(blurred_original_mix);
% blurred_original_mix_reco(blurred_original_mix_reco<0)=0;
% blurred_original_mix_reco = rescale(blurred_original_mix_reco,0,0.4);
disp("blurred_original_mix_reco")
disp(max(blurred_original_mix_reco, [], 'all'))
disp(min(blurred_original_mix_reco, [], 'all'))
subplot(3,7,14)
imagesc(blurred_original_mix_reco)
colormap gray(256)
title("blurred_original_mix_reco",'FontSize',16)







A = data_reco - data_reco.*canny_clean;
subplot(3,6,15)
imagesc(A, [cmin cmax])
colormap gray(256)
title("A",'FontSize',16)



% % Visualize
% fig_7 = figure('units','normalized','outerposition',[0 0 1 .5]);
% subplot(1,3,1)
% imagesc(masked_2)%, [min(masked_2, [], 'all'), max(masked_2, [], 'all')]);
% colormap gray(256)
% img_title = "masked_2";
% title(img_title,'FontSize',16)
% axis off
% 
% subplot(1,3,2)
% imagesc(masked_blurred)%, [min(masked_blurred, [], 'all'), max(masked_blurred, [], 'all')]);
% colormap gray(256)
% img_title = "masked_blurred";
% title(img_title,'FontSize',16)
% axis off
% 
% subplot(1,3,3)
% imagesc(sino_clean, [min(sino_clean, [], 'all'), max(sino_clean, [], 'all')]);
% colormap gray(256)
% img_title = "sino_clean";
% title(img_title,'FontSize',16)
% axis off
% saveas(fig_7,'figures/noise_reduction.jpg');

% 2c. Reconstruct blurred sinogram
recon_clean = reconstruct(sino_clean); 

% % Vizualize
% fig_8 = figure('units','normalized','outerposition',[0 0 .4 .75]);
% imagesc(recon_clean, [min(recon_clean, [], 'all'), max(recon_clean, [], 'all')]); 
% colormap gray(256)
% img_title = "Reconstruction - Noise Reduction";
% title(img_title,'FontSize',16)
% axis('square')
% xticklabels ''
% yticklabels ''
% saveas(fig_8,'figures/recon_noise_reduction.jpg');


