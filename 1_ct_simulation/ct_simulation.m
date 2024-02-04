%% Signals and Systems - Advanced Simulation of CT

clc
clear
close all

%% Part 1 - Basic coordinate system and its orientation

%% Part 2 - Adding x/y system

data = zeros(5,5);
x_to_c( 6.0, data, 3.0); % result: 5
x_to_c( 0.0, data, 3.0); % result: 3
x_to_c(-7.5, data, 3.0); % result: 0.5
y_to_r( 0.0, data, 6.0); % result: 3
y_to_r(15.0, data, 6.0); % result: 0.5

%% Part 3 - Create x-ray source

[new_x,new_y] = rotate_xy(0,1,270);

FCD_mm = 10;
[x,y] = tube_position_xy(FCD_mm, 0);
disp(x), disp(y)
[x,y] = tube_position_xy(FCD_mm, 135);
disp(x), disp(y)
[x,y] = tube_position_xy(FCD_mm, -45);
disp(x), disp(y)

%% Part 4 - Create the detector

DCD_mm = 100;
angle_deg = 45;
n_dexel = 10;
dexel_size_mm = 10;

[x,y] = detector_position_xy(DCD_mm, angle_deg, n_dexel, dexel_size_mm);
plot(x,y,'r*')
xlim([-150, 150])
ylim([-150, 150])
title('Detector Array')

%% Part 5 - Line integral through an array

data = [0, 0, 0, 0
        0, 5, 2, 0
        0, 1, 3, 0
        0, 0, 0, 0];

source_r=1.7; source_c=4.5; dexel_r=1.7; dexel_c=0.5; % p -> 7.15
% source_r=3.0; source_c=0.5; dexel_r=3.0; dexel_c=4.5; % p -> 4.15
% source_r=4.5; source_c=0.5; dexel_r=0.5; dexel_c=4.5; % p -> 4.20
% source_r=4.5; source_c=3.5; dexel_r=0.5; dexel_c=1.5; % p -> 9.05

p = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c);
disp(p)

%% Part 6 - Extend the integration function

data = [0, 0, 0, 0
        0, 5, 2, 0
        0, 1, 3, 0
        0, 0, 0, 0];

source_x=7.5; source_y=1.7; dexel_x=-7.5; dexel_y=1.7; pixel_size_mm = 3; 
    % p -> 7.15

% p2 = line_integral_xy(data, pixel_size_mm,source_x, source_y, dexel_x, dexel_y);

% convert the source coordinates from x,y to r,c
source_c = x_to_c(source_x, data, pixel_size_mm);
source_r = y_to_r(source_y, data, pixel_size_mm);

% convert the detector coordinates from x,y to r,c
dexel_c = x_to_c(dexel_x, data, pixel_size_mm);
dexel_r = y_to_r(dexel_y, data, pixel_size_mm);

% perform line integration
p2 = line_integral_rc(data,source_r, source_c, dexel_r, dexel_c);

%% Part 7 - Simulation for one view

image = imread('CTLab-Introduction3.jpg');

image = image(:,:,1);

image = double(image);
image = image / max(max(image));
image = image * 0.4;

[n_r, ~] = size(image);
n_pixel = n_r;

FCD_mm = 300;
DCD_mm = 300;

angle_deg=45;

n_dexel=200;

image_size_mm = 300;

detector_size_mm = 600;

dexel_size_mm = detector_size_mm / n_dexel;
pixel_size_mm = image_size_mm / n_pixel;

p = view(image, FCD_mm, DCD_mm, angle_deg, n_dexel, dexel_size_mm, pixel_size_mm);

figure()
plot(p)
title('Projection')

figure()
imagesc(image)
title('Initial Image')
colormap gray(256)
axis off

%% Part 8 - Complete Simulation

image = imread('CTLab-Introduction3.jpg');

image = image(:,:,1);

image = double(image);
image = image / max(max(image));
image = image * 0.4;

[n_r, n_x] = size(image);
n_pixel = n_r;

FCD_mm = 300;
DCD_mm = 300;

n_dexel=200;

image_size_mm = 300;

detector_size_mm = 600;

dexel_size_mm = detector_size_mm / n_dexel;
pixel_size_mm = image_size_mm / n_pixel;

angles_deg = 0:2:359;

sino = simulation(image, FCD_mm, DCD_mm, angles_deg, n_dexel, dexel_size_mm, pixel_size_mm);

figure()
subplot(1,2,1)
imagesc(image)
colormap gray(256)
title('Image')
axis('square')
axis off

subplot(1,2,2)
sinogram_array = projection(image);
imagesc(sino)
colormap gray(256) 
title('Sinogram')
axis('square')
axis off
