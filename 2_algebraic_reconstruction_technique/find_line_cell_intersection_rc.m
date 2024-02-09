function [intersec1,intersec2] = find_line_cell_intersection_rc(linestart,lineend,cell_center)

%FIND_LINE_CELL_INTERSECTION_RC PLEASE READ CAREFULLY
% given the 2d LINE (NOT VERTICAL OR HORIZONTAL)
% passing through linestart and lineend;
% given the square pixel of size 1 centered in cell_center; 
% 1) check if the line intersects the square. If so: 
% return the 2 intersection points of the line with the cell. Otherwise
% return two NaN values. 
% 
% IMPORTANT: checking if the line intersects the square !=
% checking if the segment between the two points intersects the square.
%
% HOWEVER, in the specific CT case where the image grid is between source
% and dexel, this function is used to check for pixel-segment intersection.
% IN THIS PARTICULAR CASE, pixel-line intersection points correspond to
% pixel-segment intersection points. 
% 
% WHY DOING THAT? Checking for pixel-line
% intersection is less elaborate (and faster) than checking for the pixel-segment
% intersection using a proper pixel-segment algorithm. For proper
% pixel-segment intersection detection, a segment-segment intersection
% algorithm like the one in the link is needed. 
% https://martin-thoma.com/how-to-check-if-two-line-segments-intersect/#cross-product
% 
% 
% EXPLANATION OF ALGORITHM: The intersection is found in the following way: 
% consider the 4 lines passing through the 4 cell
% borders("borderlines"). Intersect each borderline with the line 
% from linestart to lineend by implementing analytical solution of a 2x2
% system of equations. 
% For every solution found, check if the intersection point lies in the border of 
% the cell using the function "is_in_pixel_border".
%
% If the solution is the first point you found actually in the border:
% store its position in the variable intersec1. If you previously found
% another valid intersection point, store this one in the variable intersec2.
% There can't be more than 2 intersection points. 

r_center = cell_center(1);
c_center = cell_center(2);

% set intersec1, intersec2 to NaN. 
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
intersectionpoint = [(c_center+0.5 - q)/m,c_center+0.5];

if is_in_pixel_border(cell_center,intersectionpoint)
    if first_intersection_found == false
        intersec1 = intersectionpoint;
        first_intersection_found = true;
    elseif second_intersection_found == false
        intersec2 = intersectionpoint;
        second_intersection_found = true;
    end 
end 

% Case2: border of the pixel with equation c = c_center - 0.5;
% solve system analytically and implement solution here
intersectionpoint = [(c_center- 0.5 - q)/m,c_center-0.5];

if is_in_pixel_border(cell_center,intersectionpoint)
    if first_intersection_found == false
        intersec1 = intersectionpoint;
        first_intersection_found = true;
    elseif second_intersection_found == false
        intersec2 = intersectionpoint;
        second_intersection_found = true;
    end 
end 

% There is a chance that you already found two points from the first two
% cases. In order not to overwrite values because of intersection points at
% the corners, check if you have found two valid intersection points. if
% not, go on and look for the missing points in the next lines. 

% Case3: border of the pixel with equation r = r_center + 0.5;
% solve system analytically and implement solution here
intersectionpoint = [r_center+0.5, m*(r_center+0.5)+q];

if is_in_pixel_border(cell_center,intersectionpoint)
    if first_intersection_found == false
        intersec1 = intersectionpoint;
        first_intersection_found = true;
    elseif second_intersection_found == false
        intersec2 = intersectionpoint;
        second_intersection_found = true;
    end 
end

% Case4: border of the pixel with equation r = r_center - 0.5;
% solve system analytically and implement solution here
intersectionpoint = [r_center-0.5, m*(r_center-0.5)+q];

if is_in_pixel_border(cell_center,intersectionpoint)
    if first_intersection_found == false
        intersec1 = intersectionpoint;
        first_intersection_found = true;
    elseif second_intersection_found == false 
        intersec2 = intersectionpoint;
        second_intersection_found = true;
    end 
end

end