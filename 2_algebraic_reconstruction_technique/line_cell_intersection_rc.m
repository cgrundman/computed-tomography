function [intersec1, intersec2] = line_cell_intersection_rc(linestart,lineend,cell_center)
% INPUTS
% linestart - start of line
% lineend - end of line
% cell_center - center of pixel
% 
% OUTPUTS
% intersec1 - intersect point 1
% intersec2 - intersect point 2

r_center = cell_center(1);
c_center = cell_center(2);

% Set intersec1, intersec2 to NaN 
intersec1 = NaN;
intersec2 = NaN;

% set first_intersection_found = false
first_intersection_found = false;
second_intersection_found = false;

% calculate the m and q coefficients for the line passing through linestart
% and lineend (c = mr+q)

r_a = linestart(1);
c_a = linestart(2);
r_b = lineend(1);
c_b = lineend(2);

m = (c_b-c_a)/(r_b-r_a);
q = -r_a*m + c_a;


% Intersect each borderline with the line passing through linestart and lineend. 
% solve 4 separate systems of equation, one for each possible intersection

% after solving equation system and finding intersection position:

% If the intersection point lies on the border of the square (valid 
% intersection point):

    % if firstintersectionfound == false
        % store intersection coordinates in value intersec1.
    % elseif store intersection coordinates in value intersec2. 

% Case1: border of the pixel with equation c = c_center + 0.5;
% solve system analytically and implement solution here
intersect_point = [(c_center+0.5 - q)/m,c_center+0.5];

if intersect_pixel_border(cell_center,intersect_point)
    if first_intersection_found == false
        intersec1 = intersect_point;
        first_intersection_found = true;
    elseif second_intersection_found == false
        intersec2 = intersect_point;
        second_intersection_found = true;
    end 
end 

% Case2: border of the pixel with equation c = c_center - 0.5;
% solve system analytically and implement solution here
intersect_point = [(c_center- 0.5 - q)/m,c_center-0.5];

if intersect_pixel_border(cell_center,intersect_point)
    if first_intersection_found == false
        intersec1 = intersect_point;
        first_intersection_found = true;
    elseif second_intersection_found == false
        intersec2 = intersect_point;
        second_intersection_found = true;
    end 
end 

% There is a chance that you already found two points from the first two
% cases. In order not to overwrite values because of intersection points at
% the corners, check if you have found two valid intersection points. if
% not, go on and look for the missing points in the next lines. 

% Case3: border of the pixel with equation r = r_center + 0.5;
% solve system analytically and implement solution here
intersect_point = [r_center+0.5, m*(r_center+0.5)+q];

if intersect_pixel_border(cell_center,intersect_point)
    if first_intersection_found == false
        intersec1 = intersect_point;
        first_intersection_found = true;
    elseif second_intersection_found == false
        intersec2 = intersect_point;
        second_intersection_found = true;
    end 
end

% Case4: border of the pixel with equation r = r_center - 0.5;
% solve system analytically and implement solution here
intersect_point = [r_center-0.5, m*(r_center-0.5)+q];

if intersect_pixel_border(cell_center,intersect_point)
    if first_intersection_found == false
        intersec1 = intersect_point;
        first_intersection_found = true;
    elseif second_intersection_found == false 
        intersec2 = intersect_point;
        second_intersection_found = true;
    end 
end

end