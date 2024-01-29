function correction_image = backproject_rc(data, source_r, source_c, dexel_r, dexel_c, ci)
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

% Calculate the vector pointing from the source to the detector
vec_pointing = [dexel_r-source_r dexel_c-source_c];

% Use this vector to calculate the distance between source and detector
src_dex_dist = norm(vec_pointing);

% Use both information to create a normalized direction vector d
unit_vec = (vec_pointing/src_dex_dist);

% Choose a step size s
step_size = 0.05;

% Number of steps per beam 
beam_size = ones(round(src_dex_dist/step_size), 1);

% Beam start point
start_point = [source_r source_c];

% Space between the beam steps
shift = unit_vec * step_size;

% 1D vector holding the number of steps in each beam
step_values = (1:length(beam_size)).';

% The beam in rc-coordinate system is built taking the start point
% and adding the shift to each step
% Round function to find the crossed pixels
vec_beam = round(beam_size * start_point + step_values * shift);

data_size = length(data);
% The pixels outside the image boundaries are stored and later remove
error_pixel = ~(vec_beam(:, 1) <= data_size & vec_beam(:, 1) >= 1 & vec_beam(:, 2) <= data_size & vec_beam(:, 2) >= 1);

% Current beam - 1D vector. This represents a single row of A matrix
a = data_size * (vec_beam(:, 1) - 1) + vec_beam(:, 2);

% Error pixels are removed by setting its current value to 0
a(error_pixel) = 0;

% a is set to ascend order
a = sort(a,'ascend');
max_a = max(a);

current_val = 0;
cnt = 0;
cnt_index = 0;
vec_cnt = ones(1,max_a);
% The number of pixels the beam crossed are counted 
% and stored by its position respect to the image in 
% a 1D vector
for i=1:length(a)
    if a(i,1) > 0
        % Reset the counter and increase the index for a new pixel
        if current_val ~= a(i,1)
            current_val = a(i,1);
            cnt = 0;
            cnt_index = cnt_index + 1;
        end
        % If the pixel was not crossed by the beam, then it is set to 0
        if cnt_index ~= a(i,1)
           for j=cnt_index:a(i,1)
                vec_cnt(1,j) = 0;
                if j < a(i,1)
                    cnt_index = cnt_index + 1;
                end
           end
        end
        % Number of times the pixel was crossed by the beam
        cnt = cnt + 1;
        vec_cnt(1,cnt_index) = cnt;
    end
end

% If there are less pixels in the current beam a than in the image, then
% then the remaning ones are added to the end with value 0
a = vec_cnt;
missing = (data_size * data_size) - size(a, 2);
if missing > 0
    a = [a zeros(1, missing)];
end

% Backprojection vector 
correction_image = abs((a * step_size)* ci);

end
