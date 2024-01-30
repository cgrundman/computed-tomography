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
figure()
imagesc(data_sino)
colormap gray(256)
img_title = "Hip with Metal Prosthesis - Sinogram";
title(img_title,'FontSize',16)
axis off

%% Reconstruct the Data
% Perform reconstruction
data_reco = reconstruct(data_sino);

% Set thresholds for visualization
level = 0.014;
window = 0.007;
vmin = level - window/2;
vmax = level + window/2;

% Visualize Reconstruction
figure();
imagesc(data_reco, [vmin vmax]);
colormap gray(256)
img_title = "Hip with Metal Prosthesis - CT Image";
title(img_title,'FontSize',16)
axis('square')
% axis off
xticklabels ''
yticklabels ''

%% Create Metal Mask

img = imadjust(data_reco);  % contrasting
bw = edge(data_reco,"canny",0.02,2); % edge detection with Canny method
bw = imfill(bw,'holes'); % fill closed areas on the image
%  figure();
%  imshow(bw);
se = strel('disk',1); % form a structural element
bw = imopen(bw,se);  % morphological opening, lines disappear 
figure();
imshow(bw);
fp_mask = forwardproject(bw); % forwardproject the mask
% this is our mask
figure();
imshow(fp_mask);

% Set threshholds for mask
level = 0.014;
window = 0.007;

% Max and min thresholds for Mask
vmin = level - window/2;
vmax = level + window/2;

% Visulaize Mask
figure();
imagesc(fp_mask, [vmin vmax]);
colormap gray(256)
img_title = "Metal Mask";
title(img_title,'FontSize',16)
axis off

