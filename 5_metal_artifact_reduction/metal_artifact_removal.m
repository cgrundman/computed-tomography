%% Computed Tomography Reconstruction
% Metal Artifact Reduction (MAR)

clc
clear
close all

%% Load Data
data = load('hip_sino.mat');
hip_sino = data.sino;

% Visualize Sinogram
figure()
imagesc(hip_sino)
colormap gray(256)
img_title = "Hip Sinogram with Metal Prosthesis";
title(img_title,'FontSize',16)
axis off
