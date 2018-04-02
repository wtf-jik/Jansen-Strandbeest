function [gain] = bjt_common_emitter_amplifier()
%Calculates the gain of a basic common-emiiter BJT amplifier.
%   Takes no input.
%   
%   Solves for:    
%
%       Base Resistance = 22,000 ohms
%       Load Resistance = 1,200 ohms
%       Bias Voltage    = 1.5V
%       Input Signal    = 1,200 Hz sine wave, amplitude 0.15V
%       Supply voltage  = 15V
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
L1 = 39.3;
L2 = 41.5;
L3 = 50;
L4 = 61.9;
L5 = 40.1;
L6 = 39.4;
L7 = 36.7;
L8 = 55.8;

ti = 1.57;
t1 = 2.62;
t2 = 1.4;
t3 = 3.73;
t4 = 2.9;
t5 = 5.26;
t6 = 4.12;
t7 = 5.14;
t8 = 2.81;

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
    F1 = Li*sin(ti) +L4*sin(t4) -a -L1*sin(t1);
    F2 = Li*cos(ti) +L4*cos(t4) -b -L1*cos(t1);
    F3 = Li*sin(ti) +L4*sin(t4) +L7*sin(t7) -a -L5*sin(t5) -L6*sin(t6);
    F4 = Li*cos(ti) +L4*cos(t4) +L7*cos(t7) -b -L5*cos(t5) -L6*cos(t6);
    F5 = Li*sin(ti) +L4*sin(t4) +L7*sin(t7) +L6*sin(t6) -a -L5*sin(t5);
    F6 = Li*cos(ti) +L4*cos(t4) +L7*cos(t7) +L6*cos(t6) -b -L5*cos(t5);
    F7 = Li*sin(ti) +L4*sin(t4) +L7*sin(t7) +L6*sin(t6) +L8*sin(t8) -a -L2*sin(t2);
    F8 = Li*cos(ti) +L4*cos(t4) +L7*cos(t7) +L6*cos(t6) +L8*cos(t8) -b -L2*cos(t2);

    dF1dt1 = L1*cos(t1);
    dF1dt2 = 0;
    dF1dt3 = 0;
    dF1dt4 = -L4*cos(t4);
    dF1dt5 = 0;
    dF1dt6 = 0;
    dF1dt7 = 0;
    dF1dt8 = 0;

    dF2dt1 = -L1*sin(t1);
    dF2dt2 = 0;
    dF2dt3 = 0;
    dF2dt4 = L4*sin(t4);
    dF2dt5 = 0;
    dF2dt6 = 0;
    dF2dt7 = 0;
    dF2dt8 = 0;

    dF3dt1 = 0;
    dF3dt2 = 0;
    dF3dt3 = 0;
    dF3dt4 = -L4*cos(t4);
    dF3dt5 = L5*cos(t5);
    dF3dt6 = L6*cos(t6);
    dF3dt7 = -L7*cos(t7);
    dF3dt8 = 0;

    dF4dt1 = 0;
    dF4dt2 = 0;
    dF4dt3 = 0;
    dF4dt4 = L4*sin(t4);
    dF4dt5 = -L5*sin(t5);
    dF4dt6 = -L6*sin(t6);
    dF4dt7 = L7*sin(t7);
    dF4dt8 = 0;

    dF5dt1 = 0;
    dF5dt2 = 0;
    dF5dt3 = 0;
    dF5dt4 = -L4*cos(t4);
    dF5dt5 = L5*cos(t5);
    dF5dt6 = -L6*cos(t6);
    dF5dt7 = -L7*cos(t7);
    dF5dt8 = 0;

    dF6dt1 = 0;
    dF6dt2 = 0;
    dF6dt3 = 0;
    dF6dt4 = L4*sin(t4);
    dF6dt5 = -L5*sin(t5);
    dF6dt6 = L6*sin(t6);
    dF6dt7 = L7*sin(t7);
    dF6dt8 = 0;

    dF7dt1 = 0;
    dF7dt2 = L2*cos(t2);
    dF7dt3 = 0;
    dF7dt4 = -L4*cos(t4);
    dF7dt5 = 0;
    dF7dt6 = -L6*cos(t6);
    dF7dt7 = -L7*cos(t7);
    dF7dt8 = -L8*cos(t8);

    dF8dt1 = 0;
    dF8dt2 = -L2*sin(t2);
    dF8dt3 = 0;
    dF8dt4 = L4*sin(t4);
    dF8dt5 = 0;
    dF8dt6 = L6*sin(t6);
    dF8dt7 = L7*sin(t7);
    dF8dt8 = L8*sin(t8);

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

    x = [t1; t2; t3; t4; t5; t6; t7; t8]; 

    % Newton-Raphson Method
    x = x -(Df\F);  % Secret Sauce.
end

t1 = x(1);
t2 = x(2);
t3 = x(3);
t4 = x(4);
t5 = x(5);
t6 = x(6);
t7 = x(7);
t8 = x(8);

% PRESENTATION
% ----------------------------------------------------------------------------
if print_results == true
    %print results
end

% VISUALISATION
% ----------------------------------------------------------------------------

% Generate signal plot
if create_plot == true


end
end

