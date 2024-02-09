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

% % Extract size of data 
% [pixel_r, pixel_c] = size(image);
% 
% % Initialize correction image
% correction_image = zeros(pixel_r, pixel_c);
% 
% % Source Location
% beam_start = [source_c source_r];
% 
% % End Location
% beam_end = [dexel_c dexel_r];
% 
% % Beam Vector
% n_datapoints = 10000;
% beam_r = [linspace(beam_start(1),beam_end(1), n_datapoints)];
% beam_c = [linspace(beam_start(2),beam_end(2), n_datapoints)];
% 
% % Iterate through all pixels within the image
% for r=1:pixel_r
%     for c=1:pixel_c
%         i_start = false;
%         % For all points along the Beam
%         for i=1:size(beam_r,2)
%             % If the r-values and c-values are within pixel range
%             if beam_r(i)<r+0.5 && beam_r(i)>=r-0.5 && beam_c(i)<c+0.5 && beam_c(i)>=c-0.5
%                 % Save the intersection points
%                 % (first and last points within pixel range)
%                 % If this is the first time an intersection has occured
%                 if i_start == false
%                     % Save the r.c coords for first point within range
%                     inter_points(1,1) = beam_c(i);
%                     inter_points(1,2) = beam_r(i);
%                     i_start = true;
%                 % If intersection has already been detected
%                 elseif i_start == true
%                     % Store the latest point within range
%                     inter_points(2,1) = beam_c(i);
%                     inter_points(2,2) = beam_r(i);
%                 end
% 
%             % If intersection started and the point is not within pixel
%             elseif i_start == true
%                 % Calculate Correction for resolution gap
%                 corr = 3.9/n_datapoints;
% 
%                 % Calculate r-length of beam within pixel
%                 r_length = abs(inter_points(1,2)-inter_points(2,2)) + corr;
%                 % Calculate c-length of beam within pixel
%                 c_length = abs(inter_points(1,1)-inter_points(2,1)) + corr;
%                 % Calculate total leangth of beam within pixel
%                 a_pixel = sqrt(r_length.^2 + c_length.^2);
% 
%                 % Calculate New Pixel Value
%                 correction_image(c,r) = -a_pixel.*c_i;
% 
%                 % Exit from calculation of current pixel
%                 break
%             end
% 
%         end
%     end
% end
% 
% end

source_pos = [source_r,source_c];
dexel_pos = [dexel_r,dexel_c];
% from data get store number of rows and columns.
[maxrows,maxcols] = size(image);
% initialize empty correction_image
correction_image = zeros(maxrows,maxcols);


    % loop over all rows and columns of image
    for i = 1:maxrows
        for j = 1:maxcols

            % obtain position of center of pixel
            current_center_of_pixel = [i,j];
            % calculate the distance between center of pixel and line. 
            distance_to_line = dist_point_line(source_pos,dexel_pos,current_center_of_pixel);
            
            % Only check pixels that can intersect with detector-dexel
            % segment (distance between center of pixel and line is <= half
            % pixel diagonal)
            if distance_to_line <= sqrt(2)/2 
                % check for intersection
                
                % CASE 1: detector-dexel line is vertical (r = const):
                if source_r == dexel_r
                    % if distance between line and center of pixel < 0.5 (half px size):
                    if distance_to_line < 0.5
                    % - No need to find intersection points and calculate distance. We
                    % know distance between intersection points is = 1 in this case. 
                    % add correction term to correction image for current
                    % coordinates
                    correction_image(i,j) = c_i;
                    continue
                    end 
                    % if distance between line and center of pixel is == 0.5
                    % (edge case where line passes exactly in between pixels)
                    if distance_to_line == 0.5
                    % Subcase 1: if the current pixel row value == max number of rows
                    % - We know distance = 1, use coordinates of current pixel
                        if i == maxrows                            
                            correction_image(i,j) = c_i;
                            continue
                        end 
                    % Subcase 2: if current pixel row value < max number of rows:
                    % - Use coordinates of the next pixel 
                    % (with r value = current pixel r+1) with same c value
                        if i < maxrows                            
                            correction_image(i+1,j) = c_i;
                            continue
                        end 
                    end 
                    % if the source-dexel line is vertical and distance to pixel centre is >
                    % 0.5 for sure there is no intersection
                end
                
                % CASE 2: detector-dexel line is horizontal (c = const):
                if source_c == dexel_c
                    % if distance between line and center of pixel < 0.5 (half px size):
                    if distance_to_line < 0.5
                    % - No need to find intersection points and calculate distance. We
                    % know distance between intersection points is = 1 in this case. 
                    % add correction term to correction image for current
                    % coordinates
                    correction_image(i,j) = c_i;                    
                    continue
                    end 
                    % if distance between line and center of pixel is == 0.5
                    % (edge case where line passes exactly in between pixels)
                    if distance_to_line == 0.5
                    % Subcase 1: if the current pixel column value == max
                    % number of cols
                    % - We know distance = 1, use coordinates of current pixel
                        if j == maxcols
                            correction_image(i,j) = c_i;                            
                            continue
                        end 
                    % Subcase 2: if current pixel col value < max number of cols:
                    % - Use coordinates of the next pixel 
                    % (with c value = current pixel c+1) with same r value
                        if i < maxcols                            
                            correction_image(i,j+1) = c_i;
                            continue
                        end 
                    end 
                    % if the source-dexel line is vertical and distance to pixel centre is >
                    % 0.5 for sure there is no intersection
                end
                
                % CASE 3: detector-dexel line neither vertical nor
                % horizontal               

                % Check if there is an intersection between pixel and segment calling the
                % "find_line_intersection_rc" function.
                [p1,p2] = find_line_cell_intersection_rc(source_pos,dexel_pos,current_center_of_pixel);
                
                % If there is an intersection(function does not return NaN), 
                % calculate distance between p1 and p2
                if any(isnan(p1)) == false && any(isnan(p2)) == false
                intersectiondistance = norm(p1-p2);
                % multiply intersection distance by current
                % correction value. Assign result to current intensity value of 
                % correction_image for current row and column
                correction_image(i,j) = intersectiondistance*c_i;
                end    
                
            end 
        end 
    end 
end 

 
