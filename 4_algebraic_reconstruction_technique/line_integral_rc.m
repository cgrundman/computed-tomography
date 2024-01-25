function [s, h] = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c)
% INPUTS
% data - data matrix to simulate ct imaging through
% source_r - r coordinate for the x-ray beam source
% source_c - c coordinate for the x-ray beam source
% dexel_r - r coordinate for the x-ray beam detector
% dexel_c - c coordinate for the x-ray beam detector
% 
% OUTPUTS
% s - attenuation signal for the x-ray beam at the detector
% h - normalization factor

% Extract size of data 
[pixel_r, pixel_c] = size(data);

% Source Location
beam_start = [source_c source_r];

% End Location
beam_end = [dexel_c dexel_r];

% Beam Vector
n_datapoints = 10000;
beam_r = [linspace(beam_start(1),beam_end(1), n_datapoints)];
beam_c = [linspace(beam_start(2),beam_end(2), n_datapoints)];

% Initialize attenuation variables
s = 0; % total attenuation
a = zeros(1); % row vector of pixel intersection lengths

counter = 0;

% Iterate through all pixels within the data array
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
                s_pixel = sqrt(r_length.^2 + c_length.^2);

                % Find Attenuation value and add it to the running total
                s = s + s_pixel*data(c,r);

                counter = counter + 1;
                a(counter) = s_pixel;

                % Exit from calculation of current pixel
                break
            end
        
        end
    end
end

h = a*(a.');
% disp("line_integral_rc - h")
% disp(h)

end

