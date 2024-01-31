function blurred_img = blur(image, kernel_rad)
% INPUTS
% image - image data to convert
% kernel_rad - radius of kernel used for image blurring
% 
% OUTPUTS
% blurred_img - blurred image

% Change input image type to double
img_doub = double(image);

% Store size of input image
[img_x, img_y] = size(img_doub);

% Calculate neiborhood range for blurring
blur_kernel = 2*kernel_rad + 1;

blur_raw_mean = zeros(size(image,1), size(image,2));

for r = 1:img_x
    for c = 1:img_y
        
        % Iterate thorugh pixel neighborhood
        x_min = r - fix(blur_kernel/2);
        x_max = r + fix(blur_kernel/2);
        y_min = c - fix(blur_kernel/2);
        y_max = c + fix(blur_kernel/2);

        if x_min<1
            x_min = 1;
        end
        if x_max>img_x
            x_max = img_x;
        end
        if y_min<1
            y_min = 1;
        end
        if y_max>img_y
            y_max = img_y;
        end

        % Store new pixel value in blurred image
        blur_raw = img_doub(x_min:x_max,y_min:y_max);
        blur_raw_mean(r,c) = mean(blur_raw(:));

    end
end

% Change Data Type to double
blurred_img = double(blur_raw_mean);

end
