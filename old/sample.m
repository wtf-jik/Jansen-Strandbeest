function [t1, t2, t3, t4, t5, t6, t7, t8] = Jansen_Newton_Raphson(ti, t1_0, t2_0, t3_0, t4_0, t5_0, t6_0, t7_0, t8_0)

% Check input and output arguments
if (nargin ~= 9), error('Incorrect number of input arguments.'); end
if (nargout ~= 8), error('Incorrect number of output arguments.'); end

% -------------------------------------------------------------------------

% Internal parameter ITERATION_LIMIT = maximum number of steps permitted.
% Internal parameter TOLERANCE = minimum acceptable value for |f_dash(x)|
%                                evaluated at the approximate roots.
% Internal parameters li, l1, l2, l3, l4, l5, l6, l7, l8 = linkage lengths (unitless)
% Internal parameter a = fixed joint vertical separation
% Internal parameter b = fixed joint horizontal separation

ITERATION_LIMIT = 10;
TOLERANCE = 10^-5;

li = 15;
l1 = 50;
l2 = 41.5;
l3 = 55.8;
l4 = 40.1;
l5 = 39.4;
l6 = 61.9;
l7 = 39.3;
l8 = 36.7;

a = 7.8;
b = 38;

% -------------------------------------------------------------------------

% System of equations to be used in NR
f1 = @(ti, t1, t2, t3, t4, t5, t6, t7, t8) ( 
f2 = @(ti, t1, t2, t3, t4, t5, t6, t7, t8) ( 
f3 = @(ti, t1, t2, t3, t4, t5, t6, t7, t8) ( 
f4 = @(ti, t1, t2, t3, t4, t5, t6, t7, t8) ( 
f5 = @(ti, t1, t2, t3, t4, t5, t6, t7, t8) ( 
f6 = @(ti, t1, t2, t3, t4, t5, t6, t7, t8) ( 
f7 = @(ti, t1, t2, t3, t4, t5, t6, t7, t8) ( 
f8 = @(ti, t1, t2, t3, t4, t5, t6, t7, t8) ( 

% Jacobian of non-linear system of equations to be used in NR
d_f1_t1 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( l1*cos(t1) );
d_f1_t2 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( -l2*cos(t2) );
d_f1_t3 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f1_t4 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f1_t5 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f1_t6 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f1_t7 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f1_t8 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );

d_f2_t1 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( -l1*sin(t1) );
d_f2_t2 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( l2*sin(t2) );
d_f2_t3 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f2_t4 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f2_t5 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f2_t6 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f2_t7 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f2_t8 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );

d_f3_t1 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( l1*cos(t1) );
d_f3_t2 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f3_t3 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( l3*cos(t3) );
d_f3_t4 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( -l4*cos(t4) );
d_f3_t5 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f3_t6 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f3_t7 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f3_t8 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );

d_f4_t1 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( -l1*sin(t1) );
d_f4_t2 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f4_t3 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( -l3*sin(t3) );
d_f4_t4 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( l4*sin(t4) );
d_f4_t5 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f4_t6 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f4_t7 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f4_t8 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );

d_f5_t1 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f5_t2 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f5_t3 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f5_t4 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f5_t5 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f5_t6 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( l6*cos(t6) );
d_f5_t7 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( -l7*cos(t7) );
d_f5_t8 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );

d_f6_t1 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f6_t2 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f6_t3 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f6_t4 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f6_t5 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f6_t6 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( -l6*sin(t6) );
d_f6_t7 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( l7*sin(t7) );
d_f6_t8 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );

d_f7_t1 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( l1*cos(t1) );
d_f7_t2 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f7_t3 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( l3*cos(t3) );
d_f7_t4 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f7_t5 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( l5*cos(t5) );
d_f7_t6 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f7_t7 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( -l7*cos(t7) );
d_f7_t8 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( -l8*cos(t8) );

d_f8_t1 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( -l1*sin(t1) );
d_f8_t2 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f8_t3 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( -l3*sin(t3) );
d_f8_t4 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f8_t5 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( -l5*sin(t5) );
d_f8_t6 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( 0 );
d_f8_t7 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( l7*sin(t7) );
d_f8_t8 = @(t1, t2, t3, t4, t5, t6, t7, t8) ( l8*sin(t8) );

% -------------------------------------------------------------------------

X = [t1_0; t2_0; t3_0; t4_0; t5_0; t6_0; t7_0; t8_0];       % Initialize initial guess
iterations = 0;                                             % Initialize iterations counter

for count = 1:ITERATION_LIMIT + 1
    if count == ITERATION_LIMIT + 1
        error('The Iteration limit has been reached and did not converge')
        break
    end
    
    % Update root estimate
    t1 = X(1);
    t2 = X(2);
    t3 = X(3);
    t4 = X(4);
    t5 = X(5);
    t6 = X(6);
    t7 = X(7);
    t8 = X(8);
    
    % Check if we have met the desired tolerance
    if  abs(f1(ti, t1, t2, t3, t4, t5, t6, t7, t8)) < TOLERANCE &&...
        abs(f2(ti, t1, t2, t3, t4, t5, t6, t7, t8)) < TOLERANCE &&...
        abs(f3(ti, t1, t2, t3, t4, t5, t6, t7, t8)) < TOLERANCE &&...
        abs(f4(ti, t1, t2, t3, t4, t5, t6, t7, t8)) < TOLERANCE &&...
        abs(f5(ti, t1, t2, t3, t4, t5, t6, t7, t8)) < TOLERANCE &&...
        abs(f6(ti, t1, t2, t3, t4, t5, t6, t7, t8)) < TOLERANCE &&...
        abs(f7(ti, t1, t2, t3, t4, t5, t6, t7, t8)) < TOLERANCE &&...
        abs(f8(ti, t1, t2, t3, t4, t5, t6, t7, t8)) < TOLERANCE
        break
    end
    
    % Calculate f(x)
    f = [f1(ti, t1, t2, t3, t4, t5, t6, t7, t8); f2(ti, t1, t2, t3, t4, t5, t6, t7, t8); f3(ti, t1, t2, t3, t4, t5, t6, t7, t8); f4(ti, t1, t2, t3, t4, t5, t6, t7, t8); f5(ti, t1, t2, t3, t4, t5, t6, t7, t8); f6(ti, t1, t2, t3, t4, t5, t6, t7, t8); f7(ti, t1, t2, t3, t4, t5, t6, t7, t8); f8(ti, t1, t2, t3, t4, t5, t6, t7, t8)];
    
    % Calculate D_f_dash(x)
    D_f =      [[d_f1_t1(t1, t2, t3, t4, t5, t6, t7, t8) d_f1_t2(t1, t2, t3, t4, t5, t6, t7, t8) d_f1_t3(t1, t2, t3, t4, t5, t6, t7, t8) d_f1_t4(t1, t2, t3, t4, t5, t6, t7, t8) d_f1_t5(t1, t2, t3, t4, t5, t6, t7, t8) d_f1_t6(t1, t2, t3, t4, t5, t6, t7, t8) d_f1_t7(t1, t2, t3, t4, t5, t6, t7, t8) d_f1_t8(t1, t2, t3, t4, t5, t6, t7, t8)];
                [d_f2_t1(t1, t2, t3, t4, t5, t6, t7, t8) d_f2_t2(t1, t2, t3, t4, t5, t6, t7, t8) d_f2_t3(t1, t2, t3, t4, t5, t6, t7, t8) d_f2_t4(t1, t2, t3, t4, t5, t6, t7, t8) d_f2_t5(t1, t2, t3, t4, t5, t6, t7, t8) d_f2_t6(t1, t2, t3, t4, t5, t6, t7, t8) d_f2_t7(t1, t2, t3, t4, t5, t6, t7, t8) d_f2_t8(t1, t2, t3, t4, t5, t6, t7, t8)];
                [d_f3_t1(t1, t2, t3, t4, t5, t6, t7, t8) d_f3_t2(t1, t2, t3, t4, t5, t6, t7, t8) d_f3_t3(t1, t2, t3, t4, t5, t6, t7, t8) d_f3_t4(t1, t2, t3, t4, t5, t6, t7, t8) d_f3_t5(t1, t2, t3, t4, t5, t6, t7, t8) d_f3_t6(t1, t2, t3, t4, t5, t6, t7, t8) d_f3_t7(t1, t2, t3, t4, t5, t6, t7, t8) d_f3_t8(t1, t2, t3, t4, t5, t6, t7, t8)];
                [d_f4_t1(t1, t2, t3, t4, t5, t6, t7, t8) d_f4_t2(t1, t2, t3, t4, t5, t6, t7, t8) d_f4_t3(t1, t2, t3, t4, t5, t6, t7, t8) d_f4_t4(t1, t2, t3, t4, t5, t6, t7, t8) d_f4_t5(t1, t2, t3, t4, t5, t6, t7, t8) d_f4_t6(t1, t2, t3, t4, t5, t6, t7, t8) d_f4_t7(t1, t2, t3, t4, t5, t6, t7, t8) d_f4_t8(t1, t2, t3, t4, t5, t6, t7, t8)];
                [d_f5_t1(t1, t2, t3, t4, t5, t6, t7, t8) d_f5_t2(t1, t2, t3, t4, t5, t6, t7, t8) d_f5_t3(t1, t2, t3, t4, t5, t6, t7, t8) d_f5_t4(t1, t2, t3, t4, t5, t6, t7, t8) d_f5_t5(t1, t2, t3, t4, t5, t6, t7, t8) d_f5_t6(t1, t2, t3, t4, t5, t6, t7, t8) d_f5_t7(t1, t2, t3, t4, t5, t6, t7, t8) d_f5_t8(t1, t2, t3, t4, t5, t6, t7, t8)];
                [d_f6_t1(t1, t2, t3, t4, t5, t6, t7, t8) d_f6_t2(t1, t2, t3, t4, t5, t6, t7, t8) d_f6_t3(t1, t2, t3, t4, t5, t6, t7, t8) d_f6_t4(t1, t2, t3, t4, t5, t6, t7, t8) d_f6_t5(t1, t2, t3, t4, t5, t6, t7, t8) d_f6_t6(t1, t2, t3, t4, t5, t6, t7, t8) d_f6_t7(t1, t2, t3, t4, t5, t6, t7, t8) d_f6_t8(t1, t2, t3, t4, t5, t6, t7, t8)];
                [d_f7_t1(t1, t2, t3, t4, t5, t6, t7, t8) d_f7_t2(t1, t2, t3, t4, t5, t6, t7, t8) d_f7_t3(t1, t2, t3, t4, t5, t6, t7, t8) d_f7_t4(t1, t2, t3, t4, t5, t6, t7, t8) d_f7_t5(t1, t2, t3, t4, t5, t6, t7, t8) d_f7_t6(t1, t2, t3, t4, t5, t6, t7, t8) d_f7_t7(t1, t2, t3, t4, t5, t6, t7, t8) d_f7_t8(t1, t2, t3, t4, t5, t6, t7, t8)];
                [d_f8_t1(t1, t2, t3, t4, t5, t6, t7, t8) d_f8_t2(t1, t2, t3, t4, t5, t6, t7, t8) d_f8_t3(t1, t2, t3, t4, t5, t6, t7, t8) d_f8_t4(t1, t2, t3, t4, t5, t6, t7, t8) d_f8_t5(t1, t2, t3, t4, t5, t6, t7, t8) d_f8_t6(t1, t2, t3, t4, t5, t6, t7, t8) d_f8_t7(t1, t2, t3, t4, t5, t6, t7, t8) d_f8_t8(t1, t2, t3, t4, t5, t6, t7, t8)]];

    % Calculate next approximation
    X = X - (D_f)\f;
   
    iterations = iterations + 1;
end
end