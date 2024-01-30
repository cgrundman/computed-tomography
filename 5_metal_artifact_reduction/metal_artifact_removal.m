%% Computed Tomography Reconstruction
% Metal Artifact Reduction (MAR)

clc
clear
close all

%% Load Data
% Load Sinogram
data = load('hip_sino.mat');
hip_sino = data.sino;

% Visualize Sinogram
figure()
imagesc(hip_sino)
colormap gray(256)
img_title = "Hip Sinogram with Metal Prosthesis";
title(img_title,'FontSize',16)
axis off

%% Creation of Metal Mask
% Run the metal_mask.m file
metal_mask;

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

