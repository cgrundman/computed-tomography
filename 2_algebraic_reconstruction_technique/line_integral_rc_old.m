function [p, h] = line_integral_rc_old(data, source_r, source_c, dexel_r, dexel_c)
% INPUTS
% data - data matrix to simulate ct imaging through
% source_r - r coordinate for the x-ray beam source
% source_c - c coordinate for the x-ray beam source
% dexel_r - r coordinate for the x-ray beam detector
% dexel_c - c coordinate for the x-ray beam detector
% 
% OUTPUTS
% p - attenuation signal for the x-ray beam at the detector

% extract size of data for limits to simulation
[data_x,data_y] = size(data);

% Initiate p to iterate a summation
p = 0;

% source location
b = [source_c source_r];

% x-ray beam vector
d = [dexel_c-source_c dexel_r-source_r];

% x-ray beam vector magnitude
norm_scalar = sqrt( (dexel_c-source_c)^2 + (dexel_r-source_r)^2 );

% normalized x-ray beam vector
d_norm = d/norm_scalar;

% Iteration length 
delta_s = .05;

% Iterate value of s over entire x-ray vector
for i = 0:norm_scalar/delta_s
    c = round(b(1)); % c coordinate for the data vector at current position
    r = round(b(2)); % r coordinate for the data vector at current position
    b = b + delta_s*d_norm; % increase point b from source to detector

    % increase p only if position is within the data matrix
    if (0<c) && (c<=data_x) && (0<r) && (r<=data_y)
        p = p + delta_s*data(r,c); % iterate the value of p
    else
        continue
    end
end

h = 0;

end