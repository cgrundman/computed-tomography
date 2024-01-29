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

% Initialize empty variable
s = 0;
h = 0;
a = zeros(1);

% X-ray beam vector
d = [(dexel_r - source_r); (dexel_c - source_c)]; 

% Length vector
norm_scalar = norm(d);

% Direction vector, normalized
d_norm = (d/norm_scalar);
disp(sum(d_norm))

% Source location
beam_start = [source_r; source_c];

% Step size
delta_s = 0.05;

counter = 0;

% Iterate through the length of the beam
for i = 0:delta_s:norm_scalar

    % Increase current position on the beam
    % beam_pos = beam_pos + i * d_norm;
    beam_pos = beam_start + i *d_norm; % Movement along the Beam

    % If current beam position is within image
    if (beam_pos(1) <= pixel_r) && (beam_pos(2) <= pixel_c && beam_pos(1) > 1 && beam_pos(2) > 1)

        % Get Pixel value
        x = data(round(beam_pos(1)), round(beam_pos(2)));

        % If the sum of Pixel values equals zero, skip
        if(sum(x, 'default') == 0) 
            continue;
        else
            % Add the intensity value, multiply by step
            s = s + data(round(beam_pos(1)),round(beam_pos(2)))*delta_s;
        end
    else
        continue;
    end
end

h=0;

end
