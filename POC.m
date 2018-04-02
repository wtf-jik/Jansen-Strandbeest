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
l1 = 50;
l2 = 41.5;
l3 = 55.8;
l4 = 40.1;
l5 = 39.4;
l6 = 61.9;
l7 = 39.3;
l8 = 36.7;
l9 = 49;

crank = [pi:0.1:2*pi];
t1 = 2.5;
t2 = 2;
t3 = 4.3;
t4 = 3.5;
t5 = 4;
t6 = 3.8;
t7 = 3.9;
t8 = 3.7;

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
        for i = 1: max_iter + 1
            % Exit and warn user if system does not converge.
            if i > max_iter
                error('Maximum Iterations exceeded\n');
            end

            % Equations modelling behaviour of circuit.
            F1 = li*sin(ti) + l1*sin(t1) + a - l2*sin(t2);
            F2 = li*cos(ti) + l1*cos(t1) + b - l2*cos(t2);
            F3 = li*sin(ti) + l1*sin(t1) + l3*sin(t3) + a - l4*sin(t4);
            F4 = li*cos(ti) + l1*cos(t1) + l3*cos(t3) + b - l4*cos(t4);
            F5 = li*sin(ti) + l6*sin(t6) + a - l7*sin(t7);
            F6 = li*cos(ti) + l6*cos(t6) + b - l7*cos(t7);
            F7 = li*sin(ti) + l1*sin(t1) + l3*sin(t3) + l5*sin(t5) + a - l7*sin(t7) - l8*sin(t8);
            F8 = li*cos(ti) + l1*cos(t1) + l3*cos(t3) + l5*cos(t5) + b - l7*cos(t7) - l8*cos(t8);

            dF1dt1 = l1*cos(t1);
            dF1dt2 = -l2*cos(t2);
            dF1dt3 = 0;
            dF1dt4 = 0;
            dF1dt5 = 0;
            dF1dt6 = 0;
            dF1dt7 = 0;
            dF1dt8 = 0;

            dF2dt1 = -l1*sin(t1);
            dF2dt2 = l2*sin(t2);
            dF2dt3 = 0;
            dF2dt4 = 0;
            dF2dt5 = 0;
            dF2dt6 = 0;
            dF2dt7 = 0;
            dF2dt8 = 0;

            dF3dt1 = l1*cos(t1);
            dF3dt2 = 0;
            dF3dt3 = l3*cos(t3);
            dF3dt4 = -l4*cos(t4);
            dF3dt5 = 0;
            dF3dt6 = 0;
            dF3dt7 = 0;
            dF3dt8 = 0;

            dF4dt1 = -l1*sin(t1);
            dF4dt2 = 0;
            dF4dt3 = -l3*sin(t3);
            dF4dt4 = l4*sin(t4);
            dF4dt5 = 0;
            dF4dt6 = 0;
            dF4dt7 = 0;
            dF4dt8 = 0;

            dF5dt1 = 0;
            dF5dt2 = 0;
            dF5dt3 = 0;
            dF5dt4 = 0;
            dF5dt5 = 0;
            dF5dt6 = l6*cos(t6);
            dF5dt7 = -l7*cos(t7);
            dF5dt8 = 0;

            dF6dt1 = 0;
            dF6dt2 = 0;
            dF6dt3 = 0;
            dF6dt4 = 0;
            dF6dt5 = 0;
            dF6dt6 = -l6*sin(t6);
            dF6dt7 = l7*sin(t7);
            dF6dt8 = 0;

            dF7dt1 = l1*cos(t1);
            dF7dt2 = 0;
            dF7dt3 = l3*cos(t3);
            dF7dt4 = 0;
            dF7dt5 = l5*cos(t5);
            dF7dt6 = 0;
            dF7dt7 = -l7*cos(t7);
            dF7dt8 = -l8*cos(t8);

            dF8dt1 = -l1*sin(t1);
            dF8dt2 = 0;
            dF8dt3 = -l3*sin(t3);
            dF8dt4 = 0;
            dF8dt5 = -l5*sin(t5);
            dF8dt6 = 0;
            dF8dt7 = l7*sin(t7);
            dF8dt8 = l8*sin(t8);

            % Assemble system of functions.
            F = [F1; F2; F3; F4; F5; F6; F7; F8];

            err = abs(F);

            if err < tolerance
                if verbose == true;
                    %fprintf('Error within tolerance. Iterations: %d. Error: %e\n', j, err);
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
                    ];

            x = [t1; t2; t3; t4; t5; t6; t7; t8]; 

            % Newton-Raphson Method
            x = x -(Df\F);  % Secret Sauce.

            t1 = x(1);
            t2 = x(2);
            t3 = x(3);
            t4 = x(4);
            t5 = x(5);
            t6 = x(6);
            t7 = x(7);
            t8 = x(8);
        end
            % Generate signal plot
        if create_plot == true
            % Joint A
            positions(1, 1)  = li*cos(ti);
            positions(1, 2)  = li*sin(ti);

            % Joint B
            positions(2, 1)  = l1*cos(t1) + positions(1, 1);
            positions(2, 2)  = l1*sin(t1) + positions(1, 2);

            % Joint C
            positions(3, 1)  = l3*cos(t3) + positions(2, 1);
            positions(3, 2)  = l3*sin(t3) + positions(2, 2);

            % Joint D
            positions(4, 1)  = -b + l7*cos(t7);
            positions(4, 2)  = -a + l7*sin(t7);

            % Joint E
            positions(5, 1)  = l8*cos(t8) + positions(4, 1);
            positions(5, 2)  = l8*sin(t8) + positions(4, 2);

            % Joint F
            positions(6, 1)  = l9*cos(t8 + c) + positions(4, 1);
            positions(6, 2)  = l9*sin(t8 + c) + positions(4, 2);

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
            f = getframe(gcf);
        end
    end
end

