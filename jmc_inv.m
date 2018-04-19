function [A_inv] = jmc_inv(A)
%Finds the inverse of a square matrix.
%   VERSION 1.3
%   Takes A as an input, where A is an NxN matrix.
%
%   Note this is a student's implementation of MATLAB's builtin function inv().
%   It is not recommended for use in anything other than assignment MP1, please
%   use inv().
%   
%
%   Examples:
%   jmc_inv(A)
%
%   John Casey :: 14350111

[m,n] = size(A);

% Input validation.
if m ~= n;
    error('Matrix not square.');
else
    N = n;
end;

% Create the checkerboard sign chart of size NxN, where N is the size of the
% matrix.
x = (-1).^[0:N-1];
I = (x'*x);

% If matrix is of an order greater than 2, we can calculate
% the inverse directly.
if n > 2;
    for i = 1:N;
        for j = 1:N;
            B = A;                  % We create a matrix B which is the matrix
            B(i,:) = [];            % for which we must find the determinant
            B(:,j) = [];            % to continue.
            MoM(i,j) = jmc_det(B);  % Calculate the matrix of minors for this
                                    % point. Calculate the determinant for each
                                    % sub-matrix individually.
        end
    end
    MoC = MoM.*I;                   % Calculate the matrix of cofactors.
    A_inv = MoC'./jmc_det(A);       % Calculate the inverse of matrix A using
                                    % the adjugate.
elseif n == 1;
    A_inv = 1/A;    % Case for the 1x1 matrix./
else
    % A is 2x2
    determinate = (A(1)*A(4)-A(2)*A(3));    % Determinant of a 2x2 matrix.
    tmp = [ A(4) -A(2)                      
           -A(3)  A(1)];                    
    A_inv = tmp/determinate;                % Calculate the inverse directly.
end

