function s = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c)
% INPUTS
% data - data matrix to simulate ct imaging through
% source_r - r coordinate for the x-ray beam source
% source_c - c coordinate for the x-ray beam source
% dexel_r - r coordinate for the x-ray beam detector
% dexel_c - c coordinate for the x-ray beam detector
% 
% OUTPUTS
% p - attenuation signal for the x-ray beam at the detector


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
% extract size of data for limits to simulation 
[data_x,data_y] = size(data);

% source location
beam_start = [source_c source_r];

% end location
beam_end = [dexel_c dexel_r];

min_r = min(source_r, dexel_r);
max_r = max(source_r, dexel_r);
min_c = min(source_c, dexel_c);
max_c = max(source_c, dexel_c);

% % x-ray beam vector magnitude
% norm_scalar = sqrt( (dexel_c-source_c)^2 + (dexel_r-source_r)^2 );
% 
% % normalized x-ray beam vector
% d_norm = d/norm_scalar;

% initialize line integral
s = 0;

for r=1:size(data, 1)
    for c=1:size(data, 2)
        % if (0<c) && (c<=data_x) && (0<r) && (r<=data_y)
        %     s = s + 1;
        % end
        if r>=min_r && r<=max_r
            if c>=min_c && c<=max_c
                % disp(data(r,c))
                s = s + data(r,c);
            end
        end

    end
end

end