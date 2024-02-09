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

% Create source and detector vectors
source_pos = [source_r,source_c];
dexel_pos = [dexel_r,dexel_c];

% Extract data size
[r_row, c_col] = size(data);

% initialize s and h 
s = 0;
h = 0;

% Loop over all rows and columns of image.for each pixel in image:
for r=1:r_row
    for c = 1:c_col

        % Obtain position current pixel
        current_pixel = [r,c];
        % Calculate the distance between center of pixel and line. 
        dist_to_line = dist_point_line(source_pos, dexel_pos, current_pixel);

        % Only check pixels where distance between center and beam is <= 
        % half pixel diagonal)
        if dist_to_line <= sqrt(2)/2
        
            % CASE 1: detector-dexel line is vertical (r = const):
            if source_r == dexel_r
                % If distance between line and center of pixel < 0.5 (half px size):
                if dist_to_line < 0.5
                    % - No need to find intersection points and calculate 
                    % distance. We know distance between intersection 
                    % points is = 1 in this case. 
                    % - Sum pixel intensity to s and continue
                    s = s + data(r,c);
                    h = h + 1; % because intersection distance = 1, if we square it we still get 1. 
                    continue
                end 
                % if distance between line and center of pixel is == 0.5
                % (edge case where line passes exactly in between pixels)
                if dist_to_line == 0.5
                % Subcase 1: if the current pixel row value == max number of rows
                % - We know distance = 1, use intensity value of current pixel
                    if r == r_row
                        s = s + data(r,c);
                        h = h +1;
                        continue
                    end 
                 % Subcase 2: if current pixel row value < max number of rows:
                % - Use as intensity value the one of the next pixel 
                % (with r value = current pixel r+1) with same c value
                    if r < r_row
                        s = s + data(r+1,c);
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
                if dist_to_line < 0.5
                    % - No need to find intersection points and calculate distance. We
                    % know distance between intersection points is = 1 in this case. 
                    % - Sum pixel intensity to s
                    s = s + data(r,c);
                    h = h + 1;
                    continue
                end 
                % if distance between line and center of pixel is == 0.5
                if dist_to_line == 0.5
                    % Subcase 1: if the current pixel column value == max number of rows
                    if c == c_col
                        % - We know distance = 1, use intensity value of current pixel
                        s = s + data(r,c);
                        h = h + 1;
                        continue
                    end 
                    % Subcase 2: if current pixel column value < max number of cols:
                    if c < c_col
                        % - Use as intensity value the one of the next pixel 
                        % (with c value = current pixel c+1) with same r value
                        s = s + data(r,c+1);
                        h = h + 1;
                        continue
                    end     
                end
                % if distance to line is > 0.5 and line is horizontal, for sure no intersection
            end 
            
            % Case 3: detector-dexel line is neither horizontal nor
            % vertical. Check if there is an intersection between pixel and segment calling the
            % "find_line_intersection_rc" function.
            [p1,p2] = line_cell_intersection_rc(source_pos,dexel_pos,current_pixel);
            
            % If there is an intersection(function does not return NaN), 
            % calculate distance between p1 and p2
            if any(isnan(p1)) == false && any(isnan(p2)) == false
            intersectiondistance = norm(p1-p2);
            % multiply the distance by the value of the pixel and add to s. 
            s = s + intersectiondistance*data(r,c);
            % add to normalization factor
            h = h + intersectiondistance * intersectiondistance;
            end 

        end
    end 
end 

end
