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

% % % % % Extract size of data 
% % % % [pixel_r, pixel_c] = size(data);
% % % % 
% % % % % Source Location
% % % % beam_start = [source_c source_r];
% % % % 
% % % % % End Location
% % % % beam_end = [dexel_c dexel_r];
% % % % 
% % % % % Beam Vector
% % % % n_datapoints = 10000;
% % % % beam_r = [linspace(beam_start(1),beam_end(1), n_datapoints)];
% % % % beam_c = [linspace(beam_start(2),beam_end(2), n_datapoints)];
% % % % 
% % % % % Initialize attenuation variables
% % % % s = 0; % total attenuation
% % % % a = zeros(1); % row vector of pixel intersection lengths
% % % % 
% % % % counter = 0;
% % % % 
% % % % % Iterate through all pixels within the data array
% % % % for r=1:pixel_r
% % % %     for c=1:pixel_c
% % % %         i_start = false;
% % % %         % For all points along the Beam
% % % %         for i=1:size(beam_r,2)
% % % %             % If the r-values and c-values are within pixel range
% % % %             if beam_r(i)<r+0.5 && beam_r(i)>=r-0.5 && beam_c(i)<c+0.5 && beam_c(i)>=c-0.5
% % % %                 % Save the intersection points
% % % %                 % (first and last points within pixel range)
% % % %                 % If this is the first time an intersection has occured
% % % %                 if i_start == false
% % % %                     % Save the r.c coords for first point within range
% % % %                     inter_points(1,1) = beam_c(i);
% % % %                     inter_points(1,2) = beam_r(i);
% % % %                     i_start = true;
% % % %                 % If intersection has already been detected
% % % %                 elseif i_start == true
% % % %                     % Store the latest point within range
% % % %                     inter_points(2,1) = beam_c(i);
% % % %                     inter_points(2,2) = beam_r(i);
% % % %                 end
% % % % 
% % % %             % If intersection started and the point is not within pixel
% % % %             elseif i_start == true                 
% % % %                 % Calculate Correction for resolution gap
% % % %                 corr = 3.9/n_datapoints;
% % % % 
% % % %                 % Calculate r-length of beam within pixel
% % % %                 r_length = abs(inter_points(1,2)-inter_points(2,2)) + corr;
% % % %                 % Calculate c-length of beam within pixel
% % % %                 c_length = abs(inter_points(1,1)-inter_points(2,1)) + corr;
% % % %                 % Calculate total leangth of beam within pixel
% % % %                 s_pixel = sqrt(r_length.^2 + c_length.^2);
% % % % 
% % % %                 % Find Attenuation value and add it to the running total
% % % %                 s = s + s_pixel*data(c,r);
% % % % 
% % % %                 counter = counter + 1;
% % % %                 a(counter) = s_pixel;
% % % % 
% % % %                 % Exit from calculation of current pixel
% % % %                 break
% % % %             end
% % % % 
% % % %         end
% % % %     end
% % % % end
% % % % 
% % % % % Calculate normalization term
% % % % h = a*(a.');
% % % % 
% % % % end

source_pos = [source_r,source_c];
dexel_pos = [dexel_r,dexel_c];
% from data get store number of rows and columns.
[maxrows,maxcols] = size(data);
% initialize s and h = 0. 
s = 0;
h = 0;

% Loop over all rows and columns of image.for each pixel in image:
for i=1:maxrows
    for j = 1:maxcols

        % obtain position of center of pixel
        current_center_of_pixel = [i,j];
        % calculate the distance between center of pixel and line. 
        distance_to_line = dist_point_line(source_pos,dexel_pos,current_center_of_pixel);
        % Only check pixels that can intersect with detector-dexel
        % segment (distance between center of pixel and line is <= half
        % pixel diagonal)
        if distance_to_line <= sqrt(2)/2
        
            % CASE 1: detector-dexel line is vertical (r = const):
            if source_r == dexel_r
                % if distance between line and center of pixel < 0.5 (half px size):
                if distance_to_line < 0.5
                % - No need to find intersection points and calculate distance. We
                % know distance between intersection points is = 1 in this case. 
                % - Sum pixel intensity to s and continue
                s = s + data(i,j);
                h = h+1; % because intersection distance = 1, if we square it we still get 1. 
                continue
                end 
                % if distance between line and center of pixel is == 0.5
                % (edge case where line passes exactly in between pixels)
                if distance_to_line == 0.5
                % Subcase 1: if the current pixel row value == max number of rows
                % - We know distance = 1, use intensity value of current pixel
                    if i == maxrows
                        s = s + data(i,j);
                        h = h +1;
                        continue
                    end 
                 % Subcase 2: if current pixel row value < max number of rows:
                % - Use as intensity value the one of the next pixel 
                % (with r value = current pixel r+1) with same c value
                    if i < maxrows
                        s = s + data(i+1,j);
                        h = h +1;
                        continue
                    end 
                end 
               % if the source-dexel line is vertical and distance to pixel centre is >
               % 0.5 for sure there is no intersection
            end


            % CASE 2: detector-dexel line is horizontal (c = const)
            if source_c == dexel_c
                % if distance between line and center of pixel < 0.5 (half px size):
                if distance_to_line < 0.5
                    % - No need to find intersection points and calculate distance. We
                    % know distance between intersection points is = 1 in this case. 
                    % - Sum pixel intensity to s
                    s = s + data(i,j);
                    h = h+1;
                    continue
                end 
                % if distance between line and center of pixel is == 0.5
                if distance_to_line == 0.5
                    % Subcase 1: if the current pixel column value == max number of rows
                    if j == maxcols
                        % - We know distance = 1, use intensity value of current pixel
                        s = s + data(i,j);
                        h = h +1;
                        continue
                    end 
                    % Subcase 2: if current pixel column value < max number of cols:
                    if j < maxcols
                        % - Use as intensity value the one of the next pixel 
                        % (with c value = current pixel c+1) with same r value
                        s = s + data(i,j+1);
                        h = h+1;
                        continue
                    end     
                end
                % if distance to line is > 0.5 and line is horizontal, for sure no intersection
            end 
            
            % Case 3: detector-dexel line is neither horizontal nor
            % vertical. Check if there is an intersection between pixel and segment calling the
            % "find_line_intersection_rc" function.
            [p1,p2] = find_line_cell_intersection_rc(source_pos,dexel_pos,current_center_of_pixel);
            
            % If there is an intersection(function does not return NaN), 
            % calculate distance between p1 and p2
            if any(isnan(p1)) == false && any(isnan(p2)) == false
            intersectiondistance = norm(p1-p2);
            % multiply the distance by the value of the pixel and add to s. 
            s = s + intersectiondistance*data(i,j);
            % add to normalization factor
            h = h + intersectiondistance * intersectiondistance;
            end 

        end
    end 
end 

end
