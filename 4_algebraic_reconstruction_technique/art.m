%% Signals and Systems - Advanced Simulation of CT

clc
clear
close all

% %% Part 1 - Forward Projection
% 
% fprintf("<strong>Part 1: Forward Projection</strong>\n")
% data = [0, 0, 0, 0
%         0, 5, 2, 0
%         0, 1, 3, 0
%         0, 0, 0, 0];
% 
% % Example 1
% source_r=0; source_c=2; dexel_r=5; dexel_c=2; % s -> 6
% tic
% [s1,~] = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);
% t1(1) = toc;
% tic
% s1_old = line_integral_rc_old(data, source_r, source_c, dexel_r, dexel_c);
% t1(2) = toc;
% disp("Example 1:")
% fprintf('Method 1: %.4f msec\nMethod 2: %.4f msec\nSpeedup: %.2f x\n', t1*10, t1(1)/t1(2));
% fprintf("Answer: %.2f\n", s1)
% fprintf("\n")
% 
% % Example 2
% source_r=2; source_c=0; dexel_r=2; dexel_c=6; % s -> 7
% tic
% [s2,~] = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);
% t2(1) = toc;
% tic
% s2_old = line_integral_rc_old(data, source_r, source_c, dexel_r, dexel_c);
% t2(2) = toc;
% disp("Example 2:")
% fprintf('Method 1: %.4f msec\nMethod 2: %.4f msec\nSpeedup: %.2f x\n', t2*10, t2(1)/t2(2));
% fprintf("Answer: %.2f\n", s2)
% fprintf("\n")
% 
% % Example 3
% source_r=0; source_c=0; dexel_r=6; dexel_c=6; % s -> ~11.31
% tic
% [s3,~] = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);
% t3(1) = toc;
% tic
% s3_old = line_integral_rc_old(data, source_r, source_c, dexel_r, dexel_c);
% t3(2) = toc;
% disp("Example 3:")
% fprintf('Method 1: %.4f msec\nMethod 2: %.4f msec\nSpeedup: %.2f x\n', t3*10, t3(1)/t3(2));
% fprintf("Answer: %.2f\n", s3)
% fprintf("\n")
% 
% % Example 4
% source_r=0; source_c=0; dexel_r=5; dexel_c=4; % s -> ~6.24
% tic
% [s4,~] = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);
% t4(1) = toc;
% tic
% s4_old = line_integral_rc_old(data, source_r, source_c, dexel_r, dexel_c);
% t4(2) = toc;
% disp("Example 4:")
% fprintf('Method 1: %.4f msec\nMethod 2: %.4f msec\nSpeedup: %.2f x\n', t4*10, t4(1)/t4(2));
% fprintf("Answer: %.2f\n", s4)
% fprintf("\n")
% 
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

%% Part 7 - The Complete Reconstruction

% Load Sinogram Data
load_dir = 'sinograms_temp\';
load_dir_for = dir(fullfile(load_dir,'*'));
file_names = {load_dir_for(~[load_dir_for.isdir]).name};

% Iterate through files, loading the files and storing data in ct_imgs
ct_data = zeros(4,200,size(file_names,2));
ct_data = ct_data./10; % cast(ct_data,"uint8");
for file_idx=1:numel(file_names)

    file_dir = fullfile(load_dir,file_names{file_idx});
    data = load(file_dir, "ct_simulation");

    ct_data(:,:,file_idx) = data.ct_simulation;

end



% load([save_dir,file_name,num2str(img_idx),'.mat'],'ct_simulation');
% ct_data = struct2cell(load(file_name));
% ct_data = ct_data{1,1};
% disp(ct_data)




% main_dir = "ct_images";
% main_dir_for = dir(fullfile(main_dir,'*'));
% file_names = {main_dir_for(~[main_dir_for.isdir]).name};



% Initialize Image Reconstruction
image = zeros(1);

% Store image as the older version of itself
old_image = image;

% % CT machine geometry
% FCD_mm = 400;
% DCD_mm = 200;
% detector_width_mm = 400;
% image_width = 200;
% 
% % Iterate backprojections to reconstruct image 
% for iter=1:n_iter
%     for view=1:100 % select a random view, change 1:100
%         % Calculate  and normalization values
%         [s,h] = view_xy(old_image, FCD_mm);
% 
%         % Calculate measures projection values for one view
%         m = sinogram(view);
% 
%         % Calculate the difference between simulated and measured 
%         % projection values
%         d = s - m;
% 
%         % Backproject new image
%         backproject = backproject_view_xy(image_data, FCD_mm, DCD_mm, ...
%             angle_deg, n_dexel, dexel_size_mm, pixel_size_mm, d, h);
% 
%         % Find new image with back projection
%         image = image - backproject;
%     end
%     % Replace old image with current reconstruction
%     old_image = image;
% end
% 
% % Create Dual Plot of Original Image and Backprojection
% figure()
% % Plot original CT data
% subplot(1,2,1)
% imagesc(ct_data)
% colormap gray(256)
% title('CT Data')
% axis('square')
% axis off
% 
% % Plot Reconstruction
% subplot(1,2,2)
% sinogram_array = projection(image);
% imagesc(image)
% colormap gray(256) 
% title('Reconstruction')
% axis('square')
% axis off
