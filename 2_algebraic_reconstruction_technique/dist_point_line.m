function distance = dist_point_line(point_a, point_b, pixel)
% INPUTS
% point_a - coordinates of first point
% point_b - coordinates of second point
% pixel - coordinates of pixel
% 
% OUTPUTS
% distance - distance between points within pixel

% Extrace coordinates of points and pixel
xa = point_a(1);
ya = point_a(2);
xb = point_b(1);
yb = point_b(2);
xc = pixel(1);
yc = pixel(2);

% Find projection of C into the line

% Establish vectors beteen x and y coordinates of both points
x_vec = xb - xa;
y_vec = yb - ya;

% Trivial case 1: xb = xa
if xb == xa
    proj = [xa,yc];
    distance = norm(pixel-proj);
% Trivial case 2: yb = ya
elseif yb == ya
    proj= [xc,ya];
    distance = norm(pixel-proj);
% Otherwise, solve system of equations analytically(to find intersection)
else 
    yp = (ya*x_vec + xc*y_vec + yc*y_vec*y_vec/x_vec - xa*y_vec)/(x_vec+(y_vec*y_vec/x_vec));
    xp = xc + yc*y_vec/x_vec - yp*y_vec/x_vec;
    proj = [xp,yp];
    
    % Calculate distance between C and its projection
    distance = norm(pixel-proj);
end

end