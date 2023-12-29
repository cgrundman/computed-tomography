%% Signals and Systems - Sinogram

clc
clear
close all

%% Part 1 - A simple projection

image = phantom(200);

figure()
subplot(1,2,1)
imagesc(image)
colormap(gray(256))
title('Image')
axis('square')

subplot(1,2,2)
sinogram_array = projection(image);
imagesc(sinogram_array)
colormap(gray(256))
title('Sinogram')
axis('square')

%% Part 2 - A Complete CT Measurement

image = imread('CTLab-Introduction2.jpg');
[image,~,~] = imsplit(image);

sinogram = projection(image);

figure()
subplot(1,2,1)
imagesc(image)
colormap(gray(256))
title('Image')
axis('square')

subplot(1,2,2)
sinogram_array = projection(image);
imagesc(sinogram_array)
colormap(gray(256))
title('Sinogram')
axis('square')

% disp(sinogram)
