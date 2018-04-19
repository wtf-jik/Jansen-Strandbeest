function [d] = jmc_det(A)
%Finds the determinant of a square matrix.
%   VERSION 1.2
%   Takes A as an input, where A is an NxN matrix.
%   
%   Note this is a student's implementation of MATLAB's builtin function det().
%   It is not recommended for use in anything other than assignment MP1, please
%   use det().
%
%   Examples:
%   jmc_det(A)
%   jmc_det([1 2; -3 1])
%
%   John Casey :: 14350111

[m,n] = size(A);

% Input validation.
if m ~= n;
    error('Matrix not square.');
else
    N = n;
end;

% Initialise the determinant to zero.
d = 0;

% If matrix is of an order greater than 2, we can calculate
% the inverse directly.
if N > 2;
    for i = 1:N;
        B = A;                      % We create a matrix B which is the matrix
        B(i,:) = [];                % for which we must find the determinant
        B(:,1) = [];                % to continue.
        if mod(i,2) == 0
            d = d - A(i)*det(B);    % Iteratively develop the correct value
        else                        % for the determinant by adding/subtracting
            d = d + A(i)*det(B);    % as appropriate each term as they are
        end                         % calculated.
    end
else
    % A is 2x2
    d = (A(1)*A(4)-A(2)*A(3));      % Calculate the determinant directly.
end
