%% Signals and Systems - Advanced Simulation of CT

clc
clear
close all

%% Part 1 - Visualization of CT Machine

% Load image to input into visualizer
image = imread('figures/head_scan.jpg');
image = image(:,:,1);
x_img = [-100 100];
y_img = [100 -100];
plot_min = -400;
plot_max = 400;

% Machine geometry
FCD_mm = 300;
DCD_mm = 300;
angles_deg = linspace(0,358,180);

% % Code for Plotting
% n_dexel = 10;
% detector_size_mm = 440;
% dexel_size_mm = detector_size_mm / n_dexel;
% n_pixel = size(image,2);
% image_size_mm = 200;
% pixel_size_mm = image_size_mm / n_pixel;
% for angle=1:length(angles_deg)
%     % Calculate position of all detectors
%     [x_dexel,y_dexel] = detector_position_xy(DCD_mm, angles_deg(angle), n_dexel, dexel_size_mm);
%     % Calculate position of x-ray source
%     [x_source,y_source] = tube_position_xy(FCD_mm, angles_deg(angle));
% 
%     % Visualize Machine component position
%     fig = figure('units','normalized','outerposition',[0 0 .3 .55]);
%     set(fig,'defaultfigurecolor',[.25 .25 .25])
%     % plot(x_dexel,y_dexel,'.','MarkerSize',30,'Color',[0 0.4470 0.7410])
%     plot([x_dexel(1) x_dexel(end)],[y_dexel(1) y_dexel(end)],'LineWidth',6,'Color',[0 0.4470 0.7410])
%     hold on
%     plot(x_source,y_source,'.','MarkerSize',60,'Color',[0.6350 0.0780 0.1840])
%     hold on
%     imagesc(x_img,y_img,image)
%     colormap gray(256)
%     hold on
%     for i=1:length(x_dexel)
%         plot([x_source x_dexel(i)],[y_source y_dexel(i)],'Color',[0.4940 0.1840 0.5560],'LineWidth',2)
%         hold on
%     end
%     % plot(x_dexel,y_dexel,'.','MarkerSize',30,'Color',[0 0.4470 0.7410])
%     plot([x_dexel(1) x_dexel(end)],[y_dexel(1) y_dexel(end)],'LineWidth',6,'Color',[0 0.4470 0.7410])
%     hold on
%     plot(x_source,y_source,'.','MarkerSize',60,'Color',[0.6350 0.0780 0.1840])
%     hold off
%     xlim([plot_min, plot_max])
%     ylim([plot_min, plot_max])
%     axis square
%     grid on
%     set(gca,'xticklabel',[], 'yticklabel', [])
%     set(gca,'Color','k')
%     ax = gca;
%     ax.GridColor = [0.9, 0.9, 0.9];
%     set(gca,'Xtick',plot_min:100:plot_max)
%     set(gca,'Ytick',plot_min:100:plot_max)
%     legend('Detectors','X-ray Source','X-rays','Color',[.9 .9 .9])
%     file_name = "figures/ct_machine_geometry/angle_" + angles_deg(angle) + ".png";
%     exportgraphics(fig, file_name); % save figure
%     close(fig)
% end

%% Part 2 - Description of a single View

% Load sinogram data
sino = load('figures/head_sinogram.mat');
sinogram = sino.sino;

% Reset Machine Properties for actual Simulation
n_dexel = 200;
detector_size_mm = 440;
dexel_size_mm = detector_size_mm / n_dexel;
n_pixel = size(image,2);
image_size_mm = 200;
pixel_size_mm = image_size_mm / n_pixel;

% Prerocess the image
image = double(image);
image = image / max(max(image));
image = image * 0.4;

% Create a single view of the sinogram
p = view(image, FCD_mm, DCD_mm, angles_deg(1), n_dexel, dexel_size_mm, pixel_size_mm);

fig = figure('units','normalized','outerposition',[0 0 .5 .55]);
subplot(1,2,1)
plot(p)
set(gca,'xticklabel',[], 'yticklabel', [])
title('Single View of Sinogram',FontSize=20)
subplot(1,2,2)
plt_sino = zeros(size(sinogram,1),size(sinogram,2));
plt_sino(1,:) = sinogram(1,:);
imagesc(plt_sino)
colormap gray(256)
set(gca,'xticklabel',[], 'yticklabel', [])
title('Plot of View as Sinogram',FontSize=20)
file_name = "figures/sino_view.png";
exportgraphics(fig, file_name); % save figure
close(fig)

%% Part 3 - Simulation

% % Simulate the CT Machine
% sino = simulation(image, FCD_mm, DCD_mm, angles_deg, n_dexel, dexel_size_mm, pixel_size_mm);
% save('figures/head_sinogram.mat','sino') % save simulation array

%% Part 4 - Visualization of Sinogram Collection

% Load sinogram data
sino = load('figures/head_sinogram.mat');
sinogram = sino.sino;

plot_img = zeros(size(sinogram,1),size(sinogram,2));

% for view=1:size(sinogram,1)
%     plot_img(1:view,:) = sinogram(1:view,:);
% 
%     fig = figure();
%     imagesc(plot_img)
%     colormap gray(256)
%     axis off
%     file_name = "figures/sinogram_creation/sino_view_" + view + ".png";
%     exportgraphics(fig, file_name); % save figure
%     close(fig)
% end

%% 
% %% Part 5 - Line integral through an array
% 
% data = [0, 0, 0, 0
%         0, 5, 2, 0
%         0, 1, 3, 0
%         0, 0, 0, 0];
% 
% source_r=1.7; source_c=4.5; dexel_r=1.7; dexel_c=0.5; % p -> 7.15
% % source_r=3.0; source_c=0.5; dexel_r=3.0; dexel_c=4.5; % p -> 4.15
% % source_r=4.5; source_c=0.5; dexel_r=0.5; dexel_c=4.5; % p -> 4.20
% % source_r=4.5; source_c=3.5; dexel_r=0.5; dexel_c=1.5; % p -> 9.05
% 
% p = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);
% disp(p)
% 
% %% Part 6 - Extend the integration function
% 
% data = [0, 0, 0, 0
%         0, 5, 2, 0
%         0, 1, 3, 0
%         0, 0, 0, 0];
% 
% source_x=7.5; source_y=1.7; dexel_x=-7.5; dexel_y=1.7; pixel_size_mm = 3; 
%     % p -> 7.15
% 
% % p2 = line_integral_xy(data, pixel_size_mm,source_x, source_y, dexel_x, dexel_y);
% 
% % convert the source coordinates from x,y to r,c
% source_c = x_to_c(source_x, data, pixel_size_mm);
% source_r = y_to_r(source_y, data, pixel_size_mm);
% 
% % convert the detector coordinates from x,y to r,c
% dexel_c = x_to_c(dexel_x, data, pixel_size_mm);
% dexel_r = y_to_r(dexel_y, data, pixel_size_mm);
% 
% % perform line integration
% p2 = line_integral_rc(data,source_r, source_c, dexel_r, dexel_c);
% 
% %% Part 7 - Simulation for one view
% 
% image = imread('CTLab-Introduction3.jpg');
% 
% image = image(:,:,1);
% 
% image = double(image);
% image = image / max(max(image));
% image = image * 0.4;
% 
% [n_r, ~] = size(image);
% n_pixel = n_r;
% 
% FCD_mm = 300;
% DCD_mm = 300;
% 
% angle_deg=45;
% 
% n_dexel=200;
% 
% image_size_mm = 300;
% 
% detector_size_mm = 600;
% 
% dexel_size_mm = detector_size_mm / n_dexel;
% pixel_size_mm = image_size_mm / n_pixel;
% 
% p = view(image, FCD_mm, DCD_mm, angle_deg, n_dexel, dexel_size_mm, pixel_size_mm);
% 
% figure()
% plot(p)
% title('Projection')
% 
% figure()
% imagesc(image)
% title('Initial Image')
% colormap gray(256)
% axis off
% 
% %% Part 8 - Complete Simulation
% 
% image = imread('CTLab-Introduction3.jpg');
% 
% image = image(:,:,1);
% 
% image = double(image);
% image = image / max(max(image));
% image = image * 0.4;
% 
% [n_r, n_x] = size(image);
% n_pixel = n_r;
% 
% FCD_mm = 300;
% DCD_mm = 300;
% 
% n_dexel=200;
% 
% image_size_mm = 300;
% 
% detector_size_mm = 600;
% 
% dexel_size_mm = detector_size_mm / n_dexel;
% pixel_size_mm = image_size_mm / n_pixel;
% 
% angles_deg = 0:2:359;
% 
% sino = simulation(image, FCD_mm, DCD_mm, angles_deg, n_dexel, dexel_size_mm, pixel_size_mm);
% 
% figure()
% subplot(1,2,1)
% imagesc(image)
% colormap gray(256)
% title('Image')
% axis('square')
% axis off
% 
% subplot(1,2,2)
% sinogram_array = projection(image);
% imagesc(sino)
% colormap gray(256) 
% title('Sinogram')
% axis('square')
% axis off
