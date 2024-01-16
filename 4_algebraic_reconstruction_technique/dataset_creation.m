%% CT Data Simulation

clc
clear
close all

%% Load Dataset and Display

% Initialize directory for CT images, and file names
main_dir = "ct_images";
main_dir_for = dir(fullfile(main_dir,'*'));
file_names = {main_dir_for(~[main_dir_for.isdir]).name};

% Iterate through files, loading the files and storing data in ct_imgs
ct_imgs = zeros(200,200,size(file_names,2));
for file_idx=1:numel(file_names)
    file_dir = fullfile(main_dir,file_names{file_idx});
    image = imread(file_dir);

    % Preprocess Image
    image = image(:,:,1);
    image = double(image);
    image = image / max(max(image));
    image = image * 0.4;
    ct_imgs(:,:,file_idx) = image;
end

%% Simulate CT Machine and Save Sinograms

% CT Simulation Settings
FCD_mm = 400;
DCD_mm = 200;
n_dexel = 200;
n_pixel = size(ct_imgs, 1);
image_size_mm = 200;
detector_size_mm = 440;
dexel_size_mm = detector_size_mm / n_dexel;
pixel_size_mm = image_size_mm / n_pixel;

% Set rotation setting for CT Simulator
rotation = 360;
rot_per_view = 90;
angles_deg = 0:rot_per_view:rotation-1;

% Pass data through CT simulator
save_dir = 'sinograms_temp\';
file_name = 'sinogram_';
ct_data = zeros(rotation/rot_per_view,n_dexel,size(file_names,2));
% ct_data = zeros(rotation/rot_per_view,n_dexel,1);
for img_idx=1:size(ct_imgs,3)
    % Display start point for image simulation
    fprintf("Simulation of Image: %.0f\n", img_idx)

    % Display time feedback for simulation 
    % (simulations take a long time)
    tic
    ct_simulation = simulation(ct_imgs(:,:,img_idx), FCD_mm, DCD_mm, angles_deg, n_dexel, dexel_size_mm, pixel_size_mm);
    t = toc;
    fprintf("Simulation Time: %.0f\n", t)

    % Store data in ct_data vaiable
    ct_simulation = rescale(ct_simulation, 0, 0.4);
    ct_data(:,:,img_idx) = ct_simulation;

    % Save CT Simulation Data in .mat file
    save([save_dir,file_name,num2str(img_idx),'.mat'],'ct_simulation');

end

%% Display dataset

% Display all ct data
figure()
for file_idx=1:size(ct_imgs,3)

    % Display original CT Image
    subplot(2, 4, file_idx);
    imagesc(ct_imgs(:,:,file_idx))
    colormap gray(256)
    img_title = extractBefore(string(file_names(file_idx)), ".JPG");
    title(img_title,'FontSize',16)
    axis('square')
    % axis off
    xticklabels ''
    yticklabels ''
    if file_idx == 1
        ylabel("Original CT Images",'FontSize',16,'FontWeight','bold');
    end

    % Display Simulated CT Data
    subplot(2, 4, file_idx+4);
    imagesc(ct_data(:,:,file_idx))
    colormap gray(256)
    axis('square')
    % axis off
    xticklabels ''
    yticklabels ''
    if file_idx == 1
        ylabel("CT Simulation Results",'FontSize',16,'FontWeight','bold');
    end

end
