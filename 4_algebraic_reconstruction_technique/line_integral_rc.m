function s = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c)
% INPUTS
% data - data matrix to simulate ct imaging through
% source_r - r coordinate for the x-ray beam source
% source_c - c coordinate for the x-ray beam source
% dexel_r - r coordinate for the x-ray beam detector
% dexel_c - c coordinate for the x-ray beam detector
% 
% OUTPUTS
% s - attenuation signal for the x-ray beam at the detector


%% Old Code
% % extract size of data for limits to simulation
% [data_x,data_y] = size(data);
% 
% % Initiate p to iterate a summation
% p = 0;
% 
% % source location
% b = [source_c source_r];
% 
% % x-ray beam vector
% d = [dexel_c-source_c dexel_r-source_r];
% 
% % x-ray beam vector magnitude
% norm_scalar = sqrt( (dexel_c-source_c)^2 + (dexel_r-source_r)^2 );
% 
% % normalized x-ray beam vector
% d_norm = d/norm_scalar;
% 
% % iteration 
% delta_s = .05;
% 
% % for loop to iterate value of p over entire d vector
% for i = 0:norm_scalar/delta_s
%     c = round(b(1)); % c coordinate for the data vector at current position
%     r = round(b(2)); % r coordinate for the data vector at current position
%     b = b + delta_s*d_norm; % increase point b from source to detector
% 
%     % increase p only if position is within the data matrix
%     if (0<c) && (c<=data_x) && (0<r) && (r<=data_y)
%         p = p + delta_s*data(r,c); % iterate the value of p
%     else
%         continue
%     end
% end

%%
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

% initialize line total attenuation
s = 0;

% Iterate through all pixels within the data array
for r=1:pixel_r
    for c=1:pixel_c
        i_start = false;
        % For all points along the Beam
        for i=1:size(beam_r,2)
            % If the r-values are within pixel range
            if beam_r(i)<r+0.5 && beam_r(i)>=r-0.5 && beam_c(i)<c+0.5 && beam_c(i)>=c-0.5
                % And if the c-value are within pixel range
                
                % Save the intersection points
                % (first and last points within pixel range)
                % If this is the first time an intersection has occured
                if i_start == false
                    % Save the r.c coords for first point within range
                    inter_points(1,1) = beam_c(i);
                    inter_points(1,2) = beam_r(i);
                    i_start = true;
                elseif i_start == true
                    inter_points(2,1) = beam_c(i);
                    inter_points(2,2) = beam_r(i);
                end
                

            % TODO Fix the trigger for calculation
            % If intersection started and the point is not within pixel
            elseif i_start == true 
                %&& ((beam_r(i)>=r+0.5 || beam_r(i)<r-0.5) || (beam_c(i)>=c+0.5 || beam_c(i)<c-0.5))
                % Trigger for the end of calculation
                
                % Calculate Corection for resolution gap
                corr = 3.9/n_datapoints;

                % Calculate r-length of beam within pixel
                r_length = abs(inter_points(1,2)-inter_points(2,2)) + corr;
                % Calculate c-length of beam within pixel
                c_length = abs(inter_points(1,1)-inter_points(2,1)) + corr;
                % Calculate total leangth of beam within pixel
                s_pixel = sqrt(r_length.^2 + c_length.^2);

                % Find Attenuation value and add it to the running total
                s = s + s_pixel*data(c,r);

                % Exit from calculation of current pixel
                break
            end

        
        end
    end
end

end