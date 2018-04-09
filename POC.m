function [gain] = bjt_common_emitter_amplifier()
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

clear all;
format long;
print_results = false;
verbose = true;
create_plot = true;

% COMPUTATION SETTINGS
% ----------------------------------------------------------------------------

max_iter    = 20;           % Maximum allowed number of iterations.
tolerance   = 1e-10;        % Defined tolerance for value of F.

% INPUT PARAMETERS
% ----------------------------------------------------------------------------


% LINKAGE PARAMETERS
% ----------------------------------------------------------------------------

a = 7.8;
b = 38;
c = 1.729556;
li = 15;

l = [50; 41.5; 55.8; 40.1; 39.4; 61.9; 39.3; 36.7; 49];

crank = [pi:0.1:2*pi];
Df = zeros(8,8);

t = [2.5; 2; 4.3; 3.5; 4; 3.8; 3.9; 3.7];

% PHYSICAL QUANTITIES
% ----------------------------------------------------------------------------

% ============================================================================

% COMPUTATION
% ----------------------------------------------------------------------------

pos = get(gcf, 'Position');
width = pos(3);
height = pos(4);
mov = zeros(height, width, 1, length(crank), 'uint8');

for j = 1: length(crank)
    % For each crank angle, iterate Newton Raphon until an exiting condition is
    % reached.
    ti = crank(j);
    t = nr(t, ti);
    end
        % Generate signal plot
    if create_plot == true
        % Joint A
        positions(1, 1)  = li*cos(ti);
        positions(1, 2)  = li*sin(ti);

        % Joint B
        positions(2, 1)  = l(1)*cos(t(1)) + positions(1, 1);
        positions(2, 2)  = l(1)*sin(t(1)) + positions(1, 2);

        % Joint C
        positions(3, 1)  = l(3)*cos(t(3)) + positions(2, 1);
        positions(3, 2)  = l(3)*sin(t(3)) + positions(2, 2);

        % Joint D
        positions(4, 1)  = -(b) + l(7)*cos(t(7));
        positions(4, 2)  = -(a) + l(7)*sin(t(7));

        % Joint E
        positions(5, 1)  = l(8)*cos(t(8)) + positions(4, 1);
        positions(5, 2)  = l(8)*sin(t(8)) + positions(4, 2);

        % Joint F
        positions(6, 1)  = l(9)*cos(t(8) + c) + positions(4, 1);
        positions(6, 2)  = l(9)*sin(t(8) + c) + positions(4, 2);

        % Joint 0
        positions(7, 1) = 0;
        positions(7, 2) = 0;

        % Joint 1
        positions(8, 1) = -b;
        positions(8, 2) = -a;

        figure;
        axis([-100 100 -100 100]);
        hold on;

        A = [positions(1,1) positions(1,2)];
        B = [positions(2,1) positions(2,2)];
        C = [positions(3,1) positions(3,2)];
        D = [positions(4,1) positions(4,2)];
        E = [positions(5,1) positions(5,2)];
        F = [positions(6,1) positions(6,2)];
        Z = [positions(7,1) positions(7,2)];
        O = [positions(8,1) positions(8,2)];

        line([A(1) B(1)], [A(2) B(2)]);
        line([B(1) C(1)], [B(2) C(2)]);
        line([C(1) E(1)], [C(2) E(2)]);
        line([E(1) D(1)], [E(2) D(2)]);
        line([D(1) A(1)], [D(2) A(2)]);
        line([Z(1) A(1)], [Z(2) A(2)]);
        line([O(1) D(1)], [O(2) D(2)]);
        line([O(1) B(1)], [O(2) B(2)]);
        line([O(1) C(1)], [O(2) C(2)]);
        line([O(1) C(1)], [O(2) C(2)]);
        line([F(1) D(1)], [F(2) D(2)]);
        line([F(1) E(1)], [F(2) E(2)]);
        plot(F(1), F(2), 'or');
        %f = getframe(gcf);
    end
end


