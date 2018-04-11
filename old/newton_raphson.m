function [gain] = jansen_nr()
%
%   John Casey :: 14350111

% ENVIRONMENT
% ----------------------------------------------------------------------------

clear all;
format long;
print_results = false;
verbose = false;
create_plot = false;

% COMPUTATION SETTINGS
% ----------------------------------------------------------------------------

max_iter    = 20;           % Maximum allowed number of iterations.
tolerance   = 1e-15;        % Defined tolerance for value of F.

% INPUT PARAMETERS
% ----------------------------------------------------------------------------


% LINKAGE PARAMETERS
% ----------------------------------------------------------------------------

a = 7.8;
b = 38;
Li = 15;
L = [39.3 41.5 50 61.9 40.1 39.4 36.7 55.8];
t_i = 1.57;
t = [2.62 1.4 3.73 2.9 5.26 4.12 5.14 2.81];

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
    F1 = Li*sin(t_i) +L(4)*sin(t(4)) -a -L(1)*sin(t(1));
    F2 = Li*cos(t_i) +L(4)*cos(t(4)) -b -L(1)*cos(t(1));
    F3 = Li*sin(t_i) +L(4)*sin(t(4)) +L(7)*sin(t(7)) -a -L(5)*sin(t(5)) -L(6)*sin(t(6));
    F4 = Li*cos(t_i) +L(4)*cos(t(4)) +L(7)*cos(t(7)) -b -L(5)*cos(t(5)) -L(6)*cos(t(6));
    F5 = Li*sin(t_i) +L(4)*sin(t(4)) +L(7)*sin(t(7)) +L(6)*sin(t(6)) -a -L(5)*sin(t(5));
    F6 = Li*cos(t_i) +L(4)*cos(t(4)) +L(7)*cos(t(7)) +L(6)*cos(t(6)) -b -L(5)*cos(t(5));
    F7 = Li*sin(t_i) +L(4)*sin(t(4)) +L(7)*sin(t(7)) +L(6)*sin(t(6)) +L(8)*sin(t(8)) -a -L(2)*sin(t(2));
    F8 = Li*cos(t_i) +L(4)*cos(t(4)) +L(7)*cos(t(7)) +L(6)*cos(t(6)) +L(8)*cos(t(8)) -b -L(2)*cos(t(2));

    dF1dt1 = L(1)*cos(t((1)));
    dF1dt2 = 0;
    dF1dt3 = 0;
    dF1dt4 = -L((4))*cos(t((4)));
    dF1dt5 = 0;
    dF1dt6 = 0;
    dF1dt7 = 0;
    dF1dt8 = 0;

    dF2dt1 = -L((1))*sin(t((1)));
    dF2dt2 = 0;
    dF2dt3 = 0;
    dF2dt4 = L((4))*sin(t((4)));
    dF2dt5 = 0;
    dF2dt6 = 0;
    dF2dt7 = 0;
    dF2dt8 = 0;

    dF3dt1 = 0;
    dF3dt2 = 0;
    dF3dt3 = 0;
    dF3dt4 = -L(4)*cos(t(4));
    dF3dt5 = L(5)*cos(t(5));
    dF3dt6 = L(6)*cos(t(6));
    dF3dt7 = -L(7)*cos(t(7));
    dF3dt8 = 0;

    dF4dt1 = 0;
    dF4dt2 = 0;
    dF4dt3 = 0;
    dF4dt4 = L(4)*sin(t(4));
    dF4dt5 = -L(5)*sin(t(5));
    dF4dt6 = -L(6)*sin(t(6));
    dF4dt7 = L(7)*sin(t(7));
    dF4dt8 = 0;

    dF5dt1 = 0;
    dF5dt2 = 0;
    dF5dt3 = 0;
    dF5dt4 = -L(4)*cos(t(4));
    dF5dt5 = L(5)*cos(t(5));
    dF5dt6 = -L(6)*cos(t(6));
    dF5dt7 = -L(7)*cos(t(7));
    dF5dt8 = 0;

    dF6dt1 = 0;
    dF6dt2 = 0;
    dF6dt3 = 0;
    dF6dt4 = L(4)*sin(t(4));
    dF6dt5 = -L(5)*sin(t(5));
    dF6dt6 = L(6)*sin(t(6));
    dF6dt7 = L(7)*sin(t(7));
    dF6dt8 = 0;

    dF7dt1 = 0;
    dF7dt2 = L(2)*cos(t(2));
    dF7dt3 = 0;
    dF7dt4 = -L(4)*cos(t(4));
    dF7dt5 = 0;
    dF7dt6 = -L(6)*cos(t(6));
    dF7dt7 = -L(7)*cos(t(7));
    dF7dt8 = -L(8)*cos(t(8));

    dF8dt1 = 0;
    dF8dt2 = -L(2)*sin(t(2));
    dF8dt3 = 0;
    dF8dt4 = L(4)*sin(t(4));
    dF8dt5 = 0;
    dF8dt6 = L(6)*sin(t(6));
    dF8dt7 = L(7)*sin(t(7));
    dF8dt8 = L(8)*sin(t(8));

    % Assemble system of functions.
    F = [F1; F2; F3; F4; F5; F6; F7; F8]

    if print_results == true;
        % print results.
    end;

    if abs(F) < tolerance
        if verbose == true;
            fprintf('Error within tolerance. Iterations: %d. Error: %e\n', j, err);
        end
        break
    end

    % Jacobian of system.
    Df =    [
            dF1dt1 dF1dt2 dF1dt3 dF1dt4 dF1dt5 dF1dt6 dF1dt7 dF1dt8; 
            dF2dt1 dF2dt2 dF2dt3 dF2dt4 dF2dt5 dF2dt6 dF2dt7 dF2dt8; 
            dF3dt1 dF3dt2 dF3dt3 dF3dt4 dF3dt5 dF3dt6 dF3dt7 dF3dt8; 
            dF4dt1 dF4dt2 dF4dt3 dF4dt4 dF4dt5 dF4dt6 dF4dt7 dF4dt8; 
            dF5dt1 dF5dt2 dF5dt3 dF5dt4 dF5dt5 dF5dt6 dF5dt7 dF5dt8; 
            dF6dt1 dF6dt2 dF6dt3 dF6dt4 dF6dt5 dF6dt6 dF6dt7 dF6dt8; 
            dF7dt1 dF7dt2 dF7dt3 dF7dt4 dF7dt5 dF7dt6 dF7dt7 dF7dt8; 
            dF8dt1 dF8dt2 dF8dt3 dF8dt4 dF8dt5 dF8dt6 dF8dt7 dF8dt8; 
            ]

    % Newton-Raphson Method
    t = t -(Df\F);  % Secret Sauce.
end

end

