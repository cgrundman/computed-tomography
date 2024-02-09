function result = intersect_pixel_border(center, intersect_point)
% INPUTS
% center - coordinates of pixel centerpoint 
% intersect_point - coordinates of intersetion
% 
% OUTPUTS
% result - boolean on whether an intersection exists

% We assume width of pixel to be = 1 in the rc frame. 
p_r = intersect_point(1);
p_c = intersect_point(2);
c_min = center(2) - 0.5;
c_max = center(2) + 0.5;
r_min = center(1) - 0.5;
r_max = center(1) + 0.5;

% Set result to be false before starting to check.
result = false;

% Check if the intersect_point is in the border. 
if p_r <= r_max && p_r >= r_min
    if p_c == c_min || p_c == c_max
        result = true;
    end 
end 

if p_c <= c_max && p_c >= c_min
    if p_r == r_min || p_r == r_max
        result = true;
    end 
end 

end
