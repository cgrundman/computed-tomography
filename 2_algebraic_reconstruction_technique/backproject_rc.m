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

% Create source and detector vectors 
source_pos = [source_r,source_c];
dexel_pos = [dexel_r,dexel_c];

% Extract data size
[r_row,c_col] = size(image);

% initialize correction_image
correction_image = zeros(r_row,c_col);


% Loop over all rows and columns of image.for each pixel in image:
for r=1:r_row
    for c=1:c_col

        % Obtain position current pixel
        current_pixel = [r,c];
        % Calculate the distance between center of pixel and line. 
        dist_to_line = dist_point_line(source_pos,dexel_pos,current_pixel);
        
        % Only check pixels where distance between center and beam is <= 
        % half pixel diagonal)
        if dist_to_line <= sqrt(2)/2 
            
            % CASE 1: detector-dexel line is vertical (r = const):
            if source_r == dexel_r
                % if distance between line and center of pixel < 0.5 (half px size):
                if dist_to_line < 0.5
                    % - No need to find intersection points and calculate distance. We
                    % know distance between intersection points is = 1 in this case. 
                    % add correction term to correction image for current
                    % coordinates
                    correction_image(r,c) = c_i;
                    continue
                end 
                % if distance between line and center of pixel is == 0.5
                % (edge case where line passes exactly in between pixels)
                if dist_to_line == 0.5
                    % Subcase 1: if the current pixel row value == max number of rows
                    % - We know distance = 1, use coordinates of current pixel
                    if r == r_row                            
                        correction_image(r,c) = c_i;
                        continue
                    end 
                    % Subcase 2: if current pixel row value < max number of rows:
                    % - Use coordinates of the next pixel 
                    % (with r value = current pixel r+1) with same c value
                    if r < r_row                            
                        correction_image(r+1,c) = c_i;
                        continue
                    end 
                end 
                % if the source-dexel line is vertical and distance to pixel centre is >
                % 0.5 for sure there is no intersection
            end
            
            % CASE 2: detector-dexel line is horizontal (c = const):
            if source_c == dexel_c
                % if distance between line and center of pixel < 0.5 (half px size):
                if dist_to_line < 0.5
                    % - No need to find intersection points and calculate distance. We
                    % know distance between intersection points is = 1 in this case. 
                    % add correction term to correction image for current
                    % coordinates
                    correction_image(r,c) = c_i;                    
                    continue
                end 
                % if distance between line and center of pixel is == 0.5
                % (edge case where line passes exactly in between pixels)
                if dist_to_line == 0.5
                    % Subcase 1: if the current pixel column value == max
                    % number of cols
                    % - We know distance = 1, use coordinates of current pixel
                    if c == c_col
                        correction_image(r,c) = c_i;                            
                        continue
                    end 
                    % Subcase 2: if current pixel col value < max number of cols:
                    % - Use coordinates of the next pixel 
                    % (with c value = current pixel c+1) with same r value
                    if r < c_col                            
                        correction_image(r,c+1) = c_i;
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
            [p1,p2] = line_cell_intersection_rc(source_pos,dexel_pos,current_pixel);
            
            % If there is an intersection(function does not return NaN), 
            % calculate distance between p1 and p2
            if any(isnan(p1)) == false && any(isnan(p2)) == false
                intersectiondistance = norm(p1-p2);
                % multiply intersection distance by current
                % correction value. Assign result to current intensity value of 
                % correction_image for current row and column
                correction_image(r,c) = intersectiondistance*c_i;
            end    
            
        end 
    end 
end 

end 
