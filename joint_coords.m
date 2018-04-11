function [x, y] = joint_coords(l, t, ti, a, b, c)
%Calculates the gain of a basic common-emiiter BJT amplifier.
%   Takes no input.
%   
%
%   Examples:
%   bjt_common_emitter_amplifier()
%
%   John Casey :: 14350111

% ENVIRONMENT
% ----------------------------------------------------------------------------

% Joint A
x(1)  = l(10)*cos(ti);
y(1)  = l(10)*sin(ti);

% Joint B
x(2)  = l(1)*cos(t(1)) + x(1);
y(2)  = l(1)*sin(t(1)) + y(1);

% Joint C
x(3)  = l(3)*cos(t(3)) + x(2);
y(3)  = l(3)*sin(t(3)) + y(2);

% Joint D
x(4)  = -(b) + l(7)*cos(t(7));
y(4)  = -(a) + l(7)*sin(t(7));

% Joint E
x(5)  = l(8)*cos(t(8)) + x(4);
y(5)  = l(8)*sin(t(8)) + y(4);

% Joint F
x(6)  = l(9)*cos(t(8) + c) + x(4);
y(6)  = l(9)*sin(t(8) + c) + y(4);

% Joint 0
x(7) = 0;
y(7) = 0;

% Joint 1
x(8) = -b;
y(8) = -a;