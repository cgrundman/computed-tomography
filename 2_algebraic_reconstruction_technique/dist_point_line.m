function distance = dist_point_line(A,B,C)
%DIST_POINT_LINE returns the euclidean distance between point C and line passing
%through A and B. A = [xa,ya]

%   The function first calculates the projection of C onto the line
%   proj = [xp,yp]. Later, it calculates the euclidan distance
%   between projection and C. 
%   The projection of C onto the line is obtained with solution
%   of the system of two equations: 
%   1) imposing dot product of [C-proj] and [B-A] = 0
%   2) equation of line passing through A and B

xa = A(1);
ya = A(2);
xb = B(1);
yb = B(2);
xc = C(1);
yc = C(2);

%% find projection of C into the line

K = xb - xa;
L = yb - ya;

% % trivial case 1: xb = xa
if xb == xa
proj = [xa,yc];
distance = norm(C-proj);
% trivial case 2: yb = ya
elseif yb == ya
proj= [xc,ya];
distance = norm(C-proj);
% otherwise, solve system of equations analytically(to find intersection)
% and implement solution here
else 
yp = (ya*K + xc*L + yc*L*L/K - xa*L)/(K+(L*L/K));
xp = xc + yc*L/K - yp*L/K;

proj = [xp,yp];
% calculate distance between C and its projection
distance = norm(C-proj);
end