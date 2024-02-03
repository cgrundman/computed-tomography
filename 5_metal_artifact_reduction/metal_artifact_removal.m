%% Computed Tomography Reconstruction
% Metal Artifact Reduction (MAR)

clc
clear
close all

%% Metal Pask Creation

% Set given windows for data values
level = 0.014;
window = 0.01;
vmin = level - window / 2;
vmax = level + window / 2;

% Run hip_mask.m
hip_mask(vmin, vmax);

% Run phantom_mask.m
phantom_mask(vmin, vmax);

%% Noise Reduction

% Run phantom_smooth.m
phantom_smooth(vmin, vmax);

%% Missing Information Interpolation

% Run hip_interpolate.m
hip_interpolation(vmin, vmax);

