%% CT Data Simulation

clc
clear
close all

%% Load Data and View Data

% Load dataset
main_dir = "dicom_data";
main_dir_for = dir(fullfile(main_dir,'*'));
file_names = {main_dir_for(~[main_dir_for.isdir]).name};
ct_imgs = zeros(512,512,size(file_names,2));
for file_idx=1:numel(file_names)
    file_name = fullfile(main_dir,file_names{file_idx});
    [ct_imgs(:,:,file_idx), ~] = dicomread(file_name);
end

% Display dataset
figure()
for file_idx=1:size(ct_imgs,3)
    pos = [0.1 0.1 0.1 0.1];
    subplot(2,2,file_idx)
    imagesc(ct_imgs(:,:,file_idx))
    colormap gray(256)
    title('Image ' + string(file_idx))
    axis('square')
    axis off
end

%% Simulate CT Machine

% CT Simulation Settings
FCD_mm = 400;
DCD_mm = 200;
n_dexel = 4;
n_pixel = size(ct_imgs, 1);
image_size_mm = 200;
detector_size_mm = 400;
dexel_size_mm = detector_size_mm / n_dexel;
pixel_size_mm = image_size_mm / n_pixel;

rotation = 360;
rot_per_view = 90;

% % Pass data through CT simulator
% % ct_data = zeros(rotation/rot_per_view,n_dexel,size(file_names,2));
% ct_data = zeros(rotation/rot_per_view,n_dexel,1);
% for img_idx=1:size(ct_imgs,3)
%     disp("Simulation of Image:")
%     disp(img_idx)
%     angles_deg = 0:rot_per_view:rotation-1;
%     ct_data(:,:,img_idx) = simulation(ct_imgs(:,:,img_idx), FCD_mm, DCD_mm, angles_deg, n_dexel, dexel_size_mm, pixel_size_mm);
% end
% 
% % Display dataset
% figure()
% for file_idx=1:size(ct_imgs,3)
%     pos = [0.1 0.1 0.1 0.1];
%     subplot(2,4,file_idx)
%     imagesc(ct_data(:,:,file_idx))
%     colormap gray(256)
%     title('Image ' + string(file_idx))
%     axis('square')
%     axis off
% end

%% Save New Sinogram Data

% % Save Sinogram Data
% file_name = 'sinograms/delete.mat';
% save(file_name)
% close(file_name)
% 
% % Load Sinogram Data
% ct_load = struct2cell(load(file_name));
% ct_load = ct_load{1,1};
% disp(ct_load)
