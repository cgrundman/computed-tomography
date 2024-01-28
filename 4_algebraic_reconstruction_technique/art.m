%% Signals and Systems - Advanced Simulation of CT

clc
clear
close all

%% Part 1 - Forward Projection

fprintf("<strong>Part 1: Forward Projection</strong>\n")
data = [0, 0, 0, 0
        0, 5, 2, 0
        0, 1, 3, 0
        0, 0, 0, 0];

% Example 1
source_r=0; source_c=2; dexel_r=5; dexel_c=2; % s -> 6
tic
[s1,~] = new_line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);
t1(1) = toc;
tic
s1_old = line_integral_rc_old(data, source_r, source_c, dexel_r, dexel_c);
t1(2) = toc;
disp("Example 1:")
fprintf('New Method: %.4f msec\nOld Method: %.4f msec\nSpeedup: %.2f x\n', t1*10, t1(2)/t1(1))
fprintf("Answer: %.2f\n", s1)
fprintf("\n")

% Example 2
source_r=2; source_c=0; dexel_r=2; dexel_c=6; % s -> 7
tic
[s2,~] = new_line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);
t2(1) = toc;
tic
s2_old = line_integral_rc_old(data, source_r, source_c, dexel_r, dexel_c);
t2(2) = toc;
disp("Example 2:")
fprintf('New Method: %.4f msec\nOld Method: %.4f msec\nSpeedup: %.2f x\n', t2*10, t2(2)/t2(1))
fprintf("Answer: %.2f\n", s2)
fprintf("\n")

% Example 3
source_r=0; source_c=0; dexel_r=6; dexel_c=6; % s -> ~11.31
tic
[s3,~] = new_line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);
t3(1) = toc;
tic
s3_old = line_integral_rc_old(data, source_r, source_c, dexel_r, dexel_c);
t3(2) = toc;
disp("Example 3:")
fprintf('New Method: %.4f msec\nOld Method: %.4f msec\nSpeedup: %.2f x\n', t3*10, t3(2)/t3(1))
fprintf("Answer: %.2f\n", s3)
fprintf("\n")

% Example 4
source_r=0; source_c=0; dexel_r=5; dexel_c=4; % s -> ~6.24
tic
[s4,~] = new_line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);
t4(1) = toc;
tic
s4_old = line_integral_rc_old(data, source_r, source_c, dexel_r, dexel_c);
t4(2) = toc;
disp("Example 4:")
fprintf('New Method: %.4f msec\nOld Method: %.4f msec\nSpeedup: %.2f x\n', t4*10, t4(2)/t4(1))
fprintf("Answer: %.2f\n", s4)
fprintf("\n")

% %% Part 2 - Normalization
% 
% fprintf("<strong>Part 2: Normalization</strong>\n")
% 
% % Example 1
% source_r=0; source_c=2; dexel_r=5; dexel_c=2; % s -> 6
% [s1,h1] = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);
% disp("Example 1:")
% fprintf("Normalization Value: %.2f\n", h1)
% fprintf("\n")
% 
% % Example 2
% source_r=2; source_c=0; dexel_r=2; dexel_c=6; % s -> 7
% [s2,h2] = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);
% disp("Example 2:")
% fprintf("Normalization Value: %.2f\n", h2)
% fprintf("\n")
% 
% % Example 3
% source_r=0; source_c=0; dexel_r=6; dexel_c=6;% s -> ~11.31
% [s3,h3] = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);
% disp("Example 3:")
% fprintf("Normalization Value: %.2f\n", h3)
% fprintf("\n")
% 
% % Example 4
% source_r=0; source_c=0; dexel_r=5; dexel_c=4; % s -> ~6.24
% [s4,h4] = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);
% disp("Example 4:")
% fprintf("Normalization Value: %.2f\n", h4)
% fprintf("\n")
% 
% %% Part 3 - Conversion to the x/y-system
% 
% % Extended the normalization factor from line_integral_rc.m to
% % line_integral_xy.m
% 
% %% Part 4 - Forward Projection for One View
% 
% % Created view_xy.m from view.m to include normalization factors
% 
% %% Part 5 - Backprojection
% 
% fprintf("<strong>Part 5: Backprojection</strong>\n")
% 
% fprintf("<strong>Step 1: backproject_rc</strong>\n")
% 
% image = zeros(4,4);
% c_i = -0.5;
% 
% % Example 1
% source_r=0; source_c=2; dexel_r=5; dexel_c=2;
% % -> new_1 = [0 0.5 0 0; 
% %             0 0.5 0 0;
% %             0 0.5 0 0;
% %             0 0.5 0 0]
% new_image_1 = backproject_rc(image, source_r, source_c, dexel_r, ...
%     dexel_c, c_i);
% disp("Example 1:")
% disp(new_image_1)
% fprintf("\n")
% 
% % Example 2
% source_r=2; source_c=0; dexel_r=2; dexel_c=6;
% % -> new_2 = [  0   0   0   0; 
% %             0.5 0.5 0.5 0.5; 
% %               0   0   0   0; 
% %               0   0   0   0]
% new_image_2 = backproject_rc(image, source_r, source_c, dexel_r, ...
%     dexel_c, c_i);
% disp("Example 2:")
% disp(new_image_2)
% fprintf("\n")
% 
% % Example 3
% source_r=0; source_c=0; dexel_r=6; dexel_c=6;
% % -> new_3 = [0.7   0   0   0; 
% %               0 0.7   0   0; 
% %               0   0 0.7   0; 
% %               0   0   0 0.7]
% new_image_3 = backproject_rc(image, source_r, source_c, dexel_r, ...
%     dexel_c, c_i);
% disp("Example 3:")
% disp(new_image_3)
% fprintf("\n")
% 
% % Example 4
% source_r=0; source_c=0; dexel_r=5; dexel_c=4;
% % -> new_4 = [0.56   0    0    0; 
% %             0.24 0.4    0    0; 
% %                0 0.4 0.24    0; 
% %                0   0 0.56 0.08]
% new_image_4 = backproject_rc(image, source_r, source_c, dexel_r, ...
%     dexel_c, c_i);
% disp("Example 4:")
% disp(new_image_4)
% fprintf("\n")
% 
% % Step 2: backproject_xy
% % Implemented backproject_xy.m using same structure as line_integral_xy and
% % calculating c_i, calls backproject_rc
% 
% %% Part 6 - Backprojection for One View
% 
% % Created backproject_view_xy.m from view_xy.m, implemented backprojection
% % and called backproject_xy

% %% Part 7 - The Complete Reconstruction
% 
% % Load Image Data
% dataset_dir = "ct_images";
% dataset_dir_for = dir(fullfile(dataset_dir,'*'));
% file_names_imgs = {dataset_dir_for(~[dataset_dir_for.isdir]).name};
% 
% % Iterate through files, loading the files and storing data in ct_imgs
% ct_imgs = zeros(200,200,size(file_names_imgs,2));
% for file_idx=1:1%numel(file_names_imgs)
%     file_dir = fullfile(dataset_dir,file_names_imgs{file_idx});
%     image = imread(file_dir);
% 
%     % Preprocess Image
%     image = image(:,:,1);
%     image = double(image);
%     image = image / max(max(image));
%     image = image * 0.4;
%     ct_imgs(:,:,file_idx) = image;
% end
% 
% % Load Sinogram Data
% 
% % Select Dataset, comment the rest
% % load_dir = 'sinograms_tiny\';
% % data_shape = [4 4];
% load_dir = 'sinograms_mid\';
% data_shape = [4 200];
% 
% load_dir_for = dir(fullfile(load_dir,'*'));
% file_names = {load_dir_for(~[load_dir_for.isdir]).name};
% 
% % Iterate through files, loading the files and storing data in ct_imgs
% ct_data = zeros(data_shape(1),data_shape(2),size(file_names,2));
% ct_data = ct_data./10; % cast(ct_data,"uint8");
% for file_idx=1:1%numel(file_names)
% 
%     file_dir = fullfile(load_dir,file_names{file_idx});
%     data = load(file_dir, "ct_simulation");
% 
%     ct_data(:,:,file_idx) = data.ct_simulation;
% 
% end
% 
% % Store iteration ranges
% [num_views, n_dexel, num_data] = size(ct_data);
% 
% % Initialize Image Reconstruction
% n_pixels = data_shape(2);
% % n_pixels = 4;
% % image = zeros(n_pixels,n_pixels,4);
% image = zeros(n_pixels,n_pixels,num_data);
% 
% % Store image as the older version of itself
% old_image = image;
% 
% % CT machine geometry
% FCD_mm = 400;
% DCD_mm = 200;
% image_width = 200;
% 
% pixel_size_mm = image_width/n_pixels;
% dexel_size_mm = 100/n_dexel;
% angles = linspace(0,360,num_views+1);
% angles = angles(1:end-1);
% 
% % Iterate through sinograms
% for img_idx=1:1%num_data
% 
%     % Iterate backprojections to reconstruct image 
%     for iter=1:1 % num_iterations
% 
%         % TODO correct attenuation calculation - recheck the structure of
%         % line_integral_rc, new algorithm is supposed to be faster than the
%         % old one
%         % input problem, not a technical calculation
%         % TODO randomize views
%         % TODO make the iterations work
%         % TODO Save matrices into data files to be loaded later
%         % TODO make gifs
%         % TODO update the comments and code structure
%         for view=1:4 % select a random view
% 
%             fprintf("Reconstructing View: %g\n", view)
% 
%             fprintf("View: %g\n", angles(view))
% 
%             % Calculate attenuation and normalization values
%             [s,h] = view_xy(old_image(:,:,img_idx), FCD_mm, DCD_mm, ...
%                 angles(view), n_dexel, dexel_size_mm, pixel_size_mm);
% 
%             % Calculate measured projection values for one view
%             m = ct_data(view,:,img_idx);
% 
%             % Calculate the difference between simulated and measured 
%             % projection values
%             d = s.' - m;
% 
%             % backproject_view_xy(image_data,FCD_mm,DCD_mm,angle,n_dexel,dexel_size_mm,pixel_size_mm,d,h)
% 
%             % Backproject new image
%             backproject = backproject_view_xy(image(:,:,img_idx), FCD_mm, DCD_mm, ...
%                 angles(view), n_dexel, dexel_size_mm, pixel_size_mm, d, h);
% 
%             disp("Backprojection")
%             disp(backproject)
% 
%             % Find new image with back projection
%             image(:,:,img_idx) = image(:,:,img_idx) + backproject;
%         end
%         % Replace old image with current reconstruction
%         old_image(:,:,img_idx) = image(:,:,img_idx);
%     end
% 
% end
% 
% % Display all ct data
% figure('units','normalized','outerposition',[0 0 1 1])
% for file_idx=1:size(ct_data,3)
% 
%     % Display original CT Image
%     subplot(3, num_data, file_idx);
%     imagesc(ct_imgs(:,:,file_idx))
%     colormap gray(256)
%     img_title = extractBefore(string(file_names_imgs(file_idx)), ".JPG");
%     title(img_title,'FontSize',16)
%     axis('square')
%     % axis off
%     xticklabels ''
%     yticklabels ''
%     if file_idx == 1
%         ylabel("Original CT Images",'FontSize',16,'FontWeight','bold');
%     end
% 
%     % Display Simulated CT Data
%     subplot(3, num_data, file_idx+4);
%     imagesc(ct_data(:,:,file_idx))
%     colormap gray(256)
%     img_title = extractBefore(string(file_names(file_idx)), ".mat");
%     img_title = strrep(img_title, "_", " ");
%     title(img_title,'FontSize',16)
%     axis('square')
%     % axis off
%     xticklabels ''
%     yticklabels ''
%     if file_idx == 1
%         ylabel("CT Simulation Results",'FontSize',16,'FontWeight','bold');
%     end
% 
%     % Display Simulated CT Data
%     subplot(3, num_data, file_idx+8);
%     imagesc(image(:,:,file_idx))
%     colormap gray(256)
%     % img_title = "Reconstruction";
%     % title(img_title,'FontSize',16)
%     axis('square')
%     % axis off
%     xticklabels ''
%     yticklabels ''
%     if file_idx == 1
%         ylabel("Reconstruction",'FontSize',16,'FontWeight','bold');
%     end
% 
% end
