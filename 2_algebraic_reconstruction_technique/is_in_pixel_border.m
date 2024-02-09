function result = is_in_pixel_border(centerpoint,intersectionpoint)

%IS_IN_PIXEL_BORDER takes two parameters: 1) coordinate vector(rc) of
% center point of pixel and 2) coordinate vector of another point, here called
% "intersectionpoint". The function checks if "intersectionpoint" lies in the
% border of the pixel corresponding to the center point. If so, returns
% true. Otherwise returns false. 
% 
% Detailed explanation: the function calculates the maximum and minimum r and c
% values that a point in the pixel border can have. To check if
% "intersectionpoint" lies in the border, we check two things.
% 
% 1) if r coordinate of intersection point is in range [rmin,rmax]
% (endpoints included): check if the c coordinate is either cmin or cmax. 
% If so, intersectionpoint lies in the border of pixel. result = true. 
% 2) if c coordinate of intersection point is in range [cmin,cmax]
% (endpoints included): check if the r coordinate is either rmin or rmax. 
% If so, intersectionpoint lies in the border of pixel. result = true. 


% We assume width of pixel to be = 1 in the rc frame. 
p_r = intersectionpoint(1);
p_c = intersectionpoint(2);
c_min = centerpoint(2)-0.5;
c_max = centerpoint(2)+0.5;
r_min = centerpoint(1)-0.5;
r_max = centerpoint(1)+0.5;

%set result to be false before starting to check.
result = false;

% we check if the intersectionpoint is in the border. 
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