function correction_image = backproject_rc(image, source_r, source_c, ...
    dexel_r, dexel_c, c_i)
% INPUTS
% image - image matrix to backproject
% source_r - r coordinate for the x-ray beam source
% source_c - c coordinate for the x-ray beam source
% dexel_r - r coordinate for the x-ray beam detector
% dexel_c - c coordinate for the x-ray beam detector
% c_i - correction term
% 
% OUTPUTS
% correction_image - output of backprojection for beam

% Extract size of data 
[pixel_r, pixel_c] = size(image);

correction_image = zeros(pixel_r, pixel_c);

% Source Location
beam_start = [source_c source_r];

% End Location
beam_end = [dexel_c dexel_r];

% Beam Vector
n_datapoints = 10000;
beam_r = [linspace(beam_start(1),beam_end(1), n_datapoints)];
beam_c = [linspace(beam_start(2),beam_end(2), n_datapoints)];

% Iterate through all pixels within the image
for r=1:pixel_r
    for c=1:pixel_c
        i_start = false;
        % For all points along the Beam
        for i=1:size(beam_r,2)
            % If the r-values and c-values are within pixel range
            if beam_r(i)<r+0.5 && beam_r(i)>=r-0.5 && beam_c(i)<c+0.5 && beam_c(i)>=c-0.5
                % Save the intersection points
                % (first and last points within pixel range)
                % If this is the first time an intersection has occured
                if i_start == false
                    % Save the r.c coords for first point within range
                    inter_points(1,1) = beam_c(i);
                    inter_points(1,2) = beam_r(i);
                    i_start = true;
                % If intersection has already been detected
                elseif i_start == true
                    % Store the latest point within range
                    inter_points(2,1) = beam_c(i);
                    inter_points(2,2) = beam_r(i);
                end

            % If intersection started and the point is not within pixel
            elseif i_start == true
                % Calculate Correction for resolution gap
                corr = 3.9/n_datapoints;
                
                % Calculate r-length of beam within pixel
                r_length = abs(inter_points(1,2)-inter_points(2,2)) + corr;
                % Calculate c-length of beam within pixel
                c_length = abs(inter_points(1,1)-inter_points(2,1)) + corr;
                % Calculate total leangth of beam within pixel
                a_pixel = sqrt(r_length.^2 + c_length.^2);

                % Calculate New Pixel Value
                correction_image(c,r) = round(-a_pixel*c_i,2);

                % Exit from calculation of current pixel
                break
            end

        end
    end
end
