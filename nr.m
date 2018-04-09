function [t] = nr(t, ti)
%Calculates the gain of a basic common-emiiter BJT amplifier.
%   Takes no input.
%   
%   Examples:
%   bjt_common_emitter_amplifier()
%
%   John Casey :: 14350111

% ENVIRONMENT
% ----------------------------------------------------------------------------

print_results = false;
verbose = false;

% COMPUTATION SETTINGS
% ----------------------------------------------------------------------------

max_iter    = 10;           % Maximum allowed number of iterations.
tolerance   = 1e-12;        % Defined tolerance for value of F.

% INPUT PARAMETERS
% ----------------------------------------------------------------------------


% LINKAGE PARAMETERS
% ----------------------------------------------------------------------------

a = 7.8;
b = 38;
li = 15;

l = [50; 41.5; 55.8; 40.1; 39.4; 61.9; 39.3; 36.7; 49; 15];


% PHYSICAL QUANTITIES
% ----------------------------------------------------------------------------

% ============================================================================

% COMPUTATION
% ----------------------------------------------------------------------------

% For each crank angle, iterate Newton Raphon until an exiting condition is
% reached.

for i = 1: max_iter + 1
    % Exit and warn user if system does not converge.
    if i > max_iter
        error('Maximum Iterations exceeded\n');
    end

    % Equations modelling behaviour of circuit.
    F1 = l(10)*sin(ti) + l(1)*sin(t(1)) + a - l(2)*sin(t(2));
    F2 = l(10)*cos(ti) + l(1)*cos(t(1)) + b - l(2)*cos(t(2));
    F3 = l(10)*sin(ti) + l(1)*sin(t(1)) + l(3)*sin(t(3)) + a - l(4)*sin(t(4));
    F4 = l(10)*cos(ti) + l(1)*cos(t(1)) + l(3)*cos(t(3)) + b - l(4)*cos(t(4));
    F5 = l(10)*sin(ti) + l(6)*sin(t(6)) + a - l(7)*sin(t(7));
    F6 = l(10)*cos(ti) + l(6)*cos(t(6)) + b - l(7)*cos(t(7));
    F7 = l(10)*sin(ti) + l(1)*sin(t(1)) + l(3)*sin(t(3)) + l(5)*sin(t(5)) + a - l(7)*sin(t(7)) - l((8))*sin(t(8));
    F8 = l(10)*cos(ti) + l(1)*cos(t(1)) + l(3)*cos(t(3)) + l(5)*cos(t(5)) + b - l(7)*cos(t(7)) - l((8))*cos(t(8));

    Df(1,1) = l(1)*cos(t(1));
    Df(1,2) = -l(2)*cos(t(2));
    Df(2,1) = -l(1)*sin(t(1));
    Df(2,2) = l(2)*sin(t(2));
    Df(3,1) = l(1)*cos(t(1));
    Df(3,3) = l(3)*cos(t(3));
    Df(3,4) = -l(4)*cos(t(4));
    Df(4,1) = -l(1)*sin(t(1));
    Df(4,3) = -l(3)*sin(t(3));
    Df(4,4) = l(4)*sin(t(4));
    Df(5,6) = l(6)*cos(t(6));
    Df(5,7) = -l(7)*cos(t(7));
    Df(6,6) = -l(6)*sin(t(6));
    Df(6,7) = l(7)*sin(t(7));
    Df(7,1) = l(1)*cos(t(1));
    Df(7,2) = l(3)*cos(t(3));
    Df(7,5) = l(5)*cos(t(5));
    Df(7,7) = -l(7)*cos(t(7));
    Df(7,8) = -l(8)*cos(t(8));
    Df(8,1) = -l(1)*sin(t(1));
    Df(8,3) = -l(3)*sin(t(3));
    Df(8,5) = -l(5)*sin(t(5));
    Df(8,7) = l(7)*sin(t(7));
    Df(8,8) = l(8)*sin(t(8));

    % Assemble system of functions.
    F = [F1; F2; F3; F4; F5; F6; F7; F8];

    err = abs(F);

    if err < tolerance
        if verbose == true;
            %fprintf('Error within tolerance. Iterations: %d. Error: %e\n', j, err);
        end
        break
    end

    % Newton-Raphson Method
    t = t -(Df\F);  % Secret Sauce.
end

