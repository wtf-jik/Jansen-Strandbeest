function [x, y] = joint_coords(l, t, ti, a, b)
%Calculates the x,y positions of each joint in the Jansen linkage in 2D space.
%   VERSION 1.2
%   Takes the following input:
%   nr(l, a, b, t, ti, max_iter, tolerance, verbose)
%       l           :   1D vertical array of 10 link lengths.
%       t           :   1D array of initial estimates for angles.
%       ti          :   Current crank angle.
%       a           :   Fixed joint on the Y axis co-ordinate.
%       b           :   Fixed joint on the X axis co-ordinate.
%   
%   Examples:
%   joint_coords( [50; 41.5; 55.8; 40.1; 39.4; 61.9; 39.3; 36.7; 49; 15],
%       		  [2.5; 2; 4.3; 3.5; 4; 3.8; 3.9; 3.7],
%       		   3.14,
%       		   7.8,
%       		   38,
%
%   John Casey :: 14350111

% INPUT VALIDATION
% -----------------------------------------------------------------------------

[m,n] = size(l);
[o,p] = size(t);
if m ~= 10 || n ~= 1;
    error('Incorrect size for argument l. Array must be 10x1.');
end;
if o ~= 8 || p ~= 1;
    error('Incorrect size for argument t. Array must be 8x1.');
end;
if ~isnumeric(a) || ~isnumeric(b);
    error('Fixed joints at positions a and b must be numeric.');
end;
if ~isnumeric(t) || ~isnumeric(ti);
    error('All angles must be numberic or an array of numbers.');
end;

% COMPUTATION
% -----------------------------------------------------------------------------

l_10 = 65.7;

t_MNL = acos((l(8)^2+l(9)^2-l_10^2)/(2*l(8)*l(9)));

% Joint 0
x(7) = b;
y(7) = a;

% Joint 1
x(8) = 0;
y(8) = 0;

% Joint I
x(1)  = b + l(10)*cos(ti);
y(1)  = a + l(10)*sin(ti);

% Joint J
x(2)  = l(1)*cos(t(1)) + x(1);
y(2)  = l(1)*sin(t(1)) + y(1);

% Joint K
x(3)  = l(3)*cos(t(3)) + x(2);
y(3)  = l(3)*sin(t(3)) + y(2);

% Joint L
x(4)  = l(7)*cos(t(7));
y(4)  = l(7)*sin(t(7));

% Joint M
x(5)  = l(8)*cos(t(8)) + x(4);
y(5)  = l(8)*sin(t(8)) + y(4);

% Joint N
x(6)  = l(9)*cos(t(8) + t_MNL) + x(4);
y(6)  = l(9)*sin(t(8) + t_MNL) + y(4);

end