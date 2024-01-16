function [s, h] = line_integral_rc(data, source_r, source_c, dexel_r, dexel_c)
% INPUTS
% data - image matrix to simulate ct imaging through
% source_r - r coordinate for the x-ray beam source
% source_c - c coordinate for the x-ray beam source
% dexel_r - r coordinate for the x-ray beam detector
% dexel_c - c coordinate for the x-ray beam detector
% 
% OUTPUTS
% s - attenuation signal for the x-ray beam at the detector
% h - normalization factor

% Extract size of image
[data_x,data_y] = size(data);

% Initiate attenuation variables to iterate a summation
s = 0; % total attenuation
a = zeros(1); % row vector of pixel intersection lengths

% Calculation point
calc_p = [source_c source_r];

% X-ray beam vector
xray_vec = [dexel_c-source_c dexel_r-source_r];

% X-ray beam vector magnitude
norm_scalar = sqrt( (dexel_c-source_c)^2 + (dexel_r-source_r)^2 );

% Normalized x-ray beam vector
d_norm = xray_vec/norm_scalar;

% Iteration length
% delta_s = .05;
delta_s = .05;

counter = 1;
length = 0;

c_old = 0;
r_old = 0;

% Iterate value of s over entire d vector
for i = 0:norm_scalar/delta_s
    c = round(calc_p(1)); % c value for the data vector at itaration position
    r = round(calc_p(2)); % r value for the data vector at itaration position
    calc_p = calc_p + delta_s*d_norm; % increase iteration point toward detector

    % increase s only if position is within the data matrix
    if (0<c) && (c<=data_x) && (0<r) && (r<=data_y)
        % length = length + delta_s;
        s = s + delta_s*data(r,c); % iterate the value of s
        % a(counter) = s_pixel;
        length = length + delta_s;
    end

    % Calculate length of beam within current pixel
    if (c_old~=c || r~=r_old)
        % If within data array
        if (c_old<=data_x && r_old<=data_y) && (c_old~=0 && r_old~=0)
            a(counter) = length; % *data(r_old,c_old);
            length = 0;
            counter = counter + 1;
        end
    end

    % Save old values of c and r
    c_old = c;
    r_old = r;

end

% Calculate normalization value
h = a*(a.');

end
