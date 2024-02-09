%% Computed Tomography Reconstruction
% The Algebraic Reconstruction Technique (ART)

clc
clear
close all

%% Load Data

% import sinogram data not as image, but as .mat file(matrix)
sinogram_data_struct = load("sinograms/head_sinogram.mat");
sinogram = sinogram_data_struct.sino;

% Visulize CT Data
fig = figure('units','normalized','outerposition',[0 0 .3 .55]);
imagesc(sinogram)
colormap gray(256)
axis square
% grid on
set(gca,'xticklabel',[], 'yticklabel', [])
ax = gca;
file_name = "figures/sinogram.png";
exportgraphics(fig, file_name); % save figure
close(fig)

%% Full Reconstruction

% Initialize variables
% Extract number of views and dexels from the sinogram
[n_views, n_dexels] = size(sinogram);

% Generate angles for views
angles = linspace(0,360,n_views+1);
angles = angles(1:end-1);

% initialize empty images
image = zeros(200,200);
n_pixel = size(image,1);
old_image = image;

% set geometry parameters
FCD_mm = 400;
DCD_mm = 200;
detector_size_mm = 440;
image_size_mm = 200;
n_dexel=200;
dexel_size_mm = detector_size_mm / n_dexel;
pixel_size_mm = image_size_mm / n_pixel;

% Set number of iterations (best between 3-20)
n_iter = 20;

% Run the reconstruction loop
for i = 1:n_iter
    
    % Generate random permutation of the angle_vector
    random_angles = angles(randperm(length(angles)));
    
    % iterate over this random permutation vector.
    for view = 1:length(random_angles)
        
        % Display Current View under calculation
        fprintf("Iteration: %g\nView: %g\n", i, view);
    
        % Obtain current random angle
        random_angle_deg = random_angles(view);

        % Forward Projection: view_xy
        [s,h] = view_xy(old_image,FCD_mm,DCD_mm,random_angle_deg,n_dexel,dexel_size_mm,pixel_size_mm);
        
        % Find index of current view
        angle_index = find(angles == random_angle_deg);

        % Extract row m of sinogram data for current view
        m = sinogram(angle_index,:);

        % Define d as difference between s and m
        d = s - m;

        % Backprojection: image = image - backproject_view()
        correction_image = backproject_view_xy(image,FCD_mm,DCD_mm,random_angle_deg,n_dexel,dexel_size_mm,pixel_size_mm,d,h);
        image = image - correction_image;
        
        % Set current reconstruction as the old reconstruction
        old_image = image;

        % Visualize Current state of Reconstruction
        fig = figure('units','normalized','outerposition',[0 0 .3 .55]);
        imagesc(old_image)
        colormap gray(256)
        axis square
        % grid on
        set(gca,'xticklabel',[], 'yticklabel', [])
        ax = gca;
        txt = {"Iteration " + i,"View " + view};
        t = annotation('textbox', [0.17 0.13 0.17 0.1], 'String', txt);
        t.BackgroundColor = [0.8 0.8 0.8];
        file_name = "figures/reconstruction/iteration_" + i + "_view_" + view + ".png";
        exportgraphics(fig, file_name); % save figure
        close(fig)

        % Save correction image
        reconstruction = image;
        save('figures/reconstruction.mat','reconstruction')
    end 
end
