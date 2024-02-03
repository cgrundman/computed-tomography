%% Computed Tomography Reconstruction
% Metal Artifact Reduction (MAR)

clc
clear
close all

%% Metal Pask Creation

% Run hip_mask.m
hip_mask();

% Run phantom_mask.m
phantom_mask();

%% Noise Reduction

%% Missing Information Interpolation
