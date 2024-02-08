%% Signals and Systems - Advanced Simulation of CT

clc
clear
close all

%% Load Relevent Data

% Load image to input into visualizer
image = imread('figures/head_scan.jpg');
image = image(:,:,1);
x_img = [-100 100];
y_img = [-100 100];
plot_min = -400;
plot_max = 400;

% Prerocess the image
image = double(image);
image = image / max(max(image));
image = image * 0.4;

% Visualize Machine component position
fig = figure('units','normalized','outerposition',[0 0 .3 .55]);
set(fig,'defaultfigurecolor',[.25 .25 .25])
imagesc(x_img,y_img,image)
colormap gray(256)
xlim([-200, 200])
ylim([-200, 200])
axis square
grid on
set(gca,'xticklabel',[], 'yticklabel', [])
set(gca,'Color','k')
ax = gca;
ax.GridColor = [0.9, 0.9, 0.9];
set(gca,'Xtick',plot_min:100:plot_max)
set(gca,'Ytick',plot_min:100:plot_max)
clim([0 0.5]);
file_name = "figures/initial_image.png";
exportgraphics(fig, file_name); % save figure
close(fig)

% Load sinogram data
sino = load('figures/head_sinogram.mat');
sinogram = sino.sino;

%% Define the CT Machine

% Machine geometry
FCD_mm = 300;
DCD_mm = 300;
angles_deg = linspace(0,358,180);

% Machine Properties for Simulation
n_dexel = 200;
detector_size_mm = 440;
dexel_size_mm = detector_size_mm / n_dexel;
% n_pixel = size(image,2);
n_pixel = 200;
image_size_mm = 200;
pixel_size_mm = image_size_mm / n_pixel;
n_dexel_small = 10;
detector_size_mm = 440;
dexel_size_mm_small = detector_size_mm / n_dexel_small;

%% Description of Problem

% X-rays are used because they can pass through solid materials while they 
% are affected by these materials. Harder tissues like bone block more
% x-rays than solfter material conprising organs. However it is only
% possible to send a beam through multiple materials. In some cases, an
% x-ray image is not enough to diagnose or understand what is happening
% inside of the body. CT-Images create cross-sections that are much more
% detailed and reveal what is happening inside the body.

% Because, of their nature, the x-ray readings have to be collected and
% then reconstructed into images. This code reviews how a ct machine works
% and creates ct data, refered to as sinograms because of the structures
% the create.

%% Transforming Coordinate Systems

% The First step is to transform into image coordinate space. The system is
% built in the real world in xy-space, the image is in rc-space. This
% results in the need for coordinate system translation. 
data = zeros(5,5);
x_to_c = x_to_c(-7.5, data, 3.0);
y_to_r = y_to_r(15.0, data, 6.0);

%% Calculation of Component Positioning

% The next step is to build functionality to calculate position
% ofcomponents in the current angle of the machine. The following funtions
% perform this.

% Calculate position of all detectors
[x_dexel,y_dexel] = detector_position_xy(DCD_mm, ...
                                         angles_deg(1), ...
                                         n_dexel_small, ...
                                         dexel_size_mm_small);
% Calculate position of x-ray source
[x_source,y_source] = tube_position_xy(FCD_mm, angles_deg(1));

%% Description of Attenuation

% Attenuation is the amount of X-rays blocks. This is an inverse of how
% many x-rays strike a detector. The fewer x-rays that strike, the higher
% the attenuation. This means that bone and harder structures in the human
% baody have the highest attenuation. This code creates a
% single attentuation value for a single detector. 

% Data for single attenuation
data = [0, 0, 0, 0
        0, 5, 2, 0
        0, 1, 3, 0
        0, 0, 0, 0];
source_r=4.5; source_c=3.5; dexel_r=0.5; dexel_c=1.5; % p -> 9.05

% Create a single attenuation data_point (rc-space)
p_single = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);

x_img = [-100 100];
y_img = [100 -100];

% Visualize Machine component position
fig = figure('units','normalized','outerposition',[0 0 .3 .55]);
% Plot Machine View
set(fig,'defaultfigurecolor',[.25 .25 .25])
plot(x_dexel(5),y_dexel(5),'.','MarkerSize',60,'Color',[0 0.4470 0.7410])
hold on
plot(x_source,y_source,'.','MarkerSize',60,'Color',[0.6350 0.0780 0.1840])
hold on
imagesc(x_img,y_img,image)
colormap gray(256)
hold on
plot([x_source x_dexel(5)],[y_source y_dexel(5)],'Color',[0.4940 0.1840 0.5560],'LineWidth',2)
hold on
plot(x_dexel(5),y_dexel(5),'.','MarkerSize',60,'Color',[0 0.4470 0.7410])
hold on
plot(x_source,y_source,'.','MarkerSize',60,'Color',[0.6350 0.0780 0.1840])
hold off
xlim([plot_min, plot_max])
ylim([plot_min, plot_max])
axis square
grid on
set(gca,'xticklabel',[], 'yticklabel', [])
set(gca,'Color','k')
ax = gca;
ax.GridColor = [0.9, 0.9, 0.9];
set(gca,'Xtick',plot_min:100:plot_max)
set(gca,'Ytick',plot_min:100:plot_max)
legend('Detector','X-ray Source','X-rays','Color',[.9 .9 .9])
file_name = "figures/single_beam.png";
exportgraphics(fig, file_name); % save figure
close(fig)

% This function is called in line_integral_xy, with pixel information going
% into that function for xy to rc conversion.

%% Description of view of Attenuation

% With the attenuation calculated, now an entire view can be calculated.
% This is all of the data from every detector from one moment of
% collection.

% Create a single view of the sinogram
p = sim_view(image, FCD_mm, DCD_mm, angles_deg(1), n_dexel, ...
             dexel_size_mm, pixel_size_mm);

% Plot Single View of Sinogram
fig = figure('units','normalized','outerposition',[0 0 .4 .55]);
bar(p,'BarWidth', 1, FaceColor=[0.8 0.8 0.8]);
set(gca, 'yticklabel', [])
ylim([0, 41])
xlabel("Detector Array")
ylabel("Attenuation")
title('Single View of Sinogram',FontSize=20)
set(gca,'Color','k')
ax = gca;
ax.GridColor = [0.95, 0.95, 0.95];
file_name = "figures/sino_view.png";
exportgraphics(fig, file_name); % save figure
close(fig)

%% Description of Sinogram

% This is the full simulation of the sinogram. simulation() calls all the
% subsequent subfunctions and sub outines. The github is a more
% comprehensive overview of the implemented functionality.

% Simulate the CT Machine
sino = simulation(image, FCD_mm, DCD_mm, angles_deg, n_dexel, ...
                  dexel_size_mm, pixel_size_mm);
% save('figures/head_sinogram.mat','sino') % save simulation array

%% Visualization of CT Machine Simulation

% Code for Plotting
x_img = [-100 100];
y_img = [100 -100];

current_sino = zeros(size(sinogram,1),size(sinogram,2));

for angle=1:length(angles_deg)
    % Calculate position of all detectors
    [x_dexel,y_dexel] = detector_position_xy(DCD_mm, angles_deg(angle), n_dexel_small, dexel_size_mm_small);
    % Calculate position of x-ray source
    [x_source,y_source] = tube_position_xy(FCD_mm, angles_deg(angle));

    % Visualize Machine component position
    fig = figure('units','normalized','outerposition',[0 0 .9 .55]);
    % Plot Machine View
    subplot(1,3,1)
    set(fig,'defaultfigurecolor',[.25 .25 .25])
    plot([x_dexel(1) x_dexel(end)],[y_dexel(1) y_dexel(end)],'LineWidth',6,'Color',[0 0.4470 0.7410])
    hold on
    plot(x_source,y_source,'.','MarkerSize',60,'Color',[0.6350 0.0780 0.1840])
    hold on
    imagesc(x_img,y_img,image)
    colormap gray(256)
    clim([0 0.5]);
    hold on
    for i=1:length(x_dexel)
        plot([x_source x_dexel(i)],[y_source y_dexel(i)],'Color',[0.4940 0.1840 0.5560],'LineWidth',2)
        hold on
    end
    plot([x_dexel(1) x_dexel(end)],[y_dexel(1) y_dexel(end)],'LineWidth',6,'Color',[0 0.4470 0.7410])
    hold on
    plot(x_source,y_source,'.','MarkerSize',60,'Color',[0.6350 0.0780 0.1840])
    hold off
    xlim([plot_min, plot_max])
    ylim([plot_min, plot_max])
    grid on
    set(gca,'xticklabel',[], 'yticklabel', [])
    set(gca,'Color','k')
    ax = gca;
    ax.GridColor = [0.9, 0.9, 0.9];
    set(gca,'Xtick',plot_min:100:plot_max)
    set(gca,'Ytick',plot_min:100:plot_max)
    title('CT Machine Position',FontSize=20)

    subplot(1,3,2)
    bar(sinogram(angle,:),'BarWidth', 1, FaceColor=[0.8 0.8 0.8]);
    set(gca,'xticklabel',[],'yticklabel',[])
    ylim([0, 41])
    title('Sinogram of Current View',FontSize=20)
    set(gca,'Color','k')
    ax = gca;
    ax.GridColor = [0.95, 0.95, 0.95];

    subplot(1,3,3)
    current_sino(angle,:) = sinogram(angle,:);
    imagesc(current_sino)
    title('Full Sinogram',FontSize=20)
    clim([0 max(sinogram,[],'all')]);
    colormap gray(256)
    axis off

    file_name = "figures/ct_machine_geometry/angle_" + angles_deg(angle) + ".png";
    exportgraphics(fig, file_name); % save figure
    close(fig)
end
