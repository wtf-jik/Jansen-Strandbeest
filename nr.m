function [t] = nr(l, a, b, t, ti, max_iter, tolerance, verbose)
%Calculates the angles of links in the Jansen linkage by iteration of the
%Newton Raphson Method.
%   VERSION 1.2
%   Takes the following input:
%   nr(l, a, b, t, ti, max_iter, tolerance, verbose)
%       l           :   1D vertical array of 10 link lengths.
%       a           :   Fixed joint on the Y axis co-ordinate.
%       b           :   Fixed joint on the X axis co-ordinate.
%       t           :   1D array of initial estimates for angles.
%       ti          :   Current crank angle.
%       max_iter    :   Maximum number of iterations permitted.
%       tolerance   :   Acceptable accuracy for results.
%       verbose     :   Verbose mode flag.
%   
%   Examples:
%   nr( [50; 41.5; 55.8; 40.1; 39.4; 61.9; 39.3; 36.7; 49; 15],
%       7.8,
%       38,
%       [2.5; 2; 4.3; 3.5; 4; 3.8; 3.9; 3.7],
%       3.14,
%       20,
%       1e-10,
%       false)
%
%   John Casey :: 14350111

% COMPUTATION
% ----------------------------------------------------------------------------

ispositiveinteger = @(n) (mod(n,1) == 0) && (n > 0);
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
if ~ispositiveinteger(max_iter);
    error('Maximum number of iterations must be a positive integer.');
end;
if ~isnumeric(tolerance);
    error('Acceptable tolerance must be numberic.');
end;
if ~islogical(verbose);
    error('Verbose flag can only be true or false.');
end;

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

    % Calculate non-zero components of the Jacobian.
    Df(1,1) =  l(1)*cos(t(1));
    Df(1,2) = -l(2)*cos(t(2));
    Df(2,1) = -l(1)*sin(t(1));
    Df(2,2) =  l(2)*sin(t(2));
    Df(3,1) =  l(1)*cos(t(1));
    Df(3,3) =  l(3)*cos(t(3));
    Df(3,4) = -l(4)*cos(t(4));
    Df(4,1) = -l(1)*sin(t(1));
    Df(4,3) = -l(3)*sin(t(3));
    Df(4,4) =  l(4)*sin(t(4));
    Df(5,6) =  l(6)*cos(t(6));
    Df(5,7) = -l(7)*cos(t(7));
    Df(6,6) = -l(6)*sin(t(6));
    Df(6,7) =  l(7)*sin(t(7));
    Df(7,1) =  l(1)*cos(t(1));
    Df(7,2) =  l(3)*cos(t(3));
    Df(7,5) =  l(5)*cos(t(5));
    Df(7,7) = -l(7)*cos(t(7));
    Df(7,8) = -l(8)*cos(t(8));
    Df(8,1) = -l(1)*sin(t(1));
    Df(8,3) = -l(3)*sin(t(3));
    Df(8,5) = -l(5)*sin(t(5));
    Df(8,7) =  l(7)*sin(t(7));
    Df(8,8) =  l(8)*sin(t(8));

    % Assemble system of functions.
    F = [F1; F2; F3; F4; F5; F6; F7; F8];
    err = max(F);

    if abs(err) < tolerance
        if verbose == true;
            disp(t);
            fprintf('Error within tolerance. Iterations: %d Error: %e\n', i, err);
        end
        break
    end

    % Newton-Raphson Method
    t = t -(jmc_inv(Df)*F);  % Secret Sauce.
end