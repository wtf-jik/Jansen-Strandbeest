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

l = [50; 41.5; 55.8; 40.1; 39.4; 61.9; 39.3; 36.7; 49; 15];
t = [2.5; 2; 4.3; 3.5; 4; 3.8; 3.9; 3.7];

crank = pi;
Df = zeros(8,8);



% PHYSICAL QUANTITIES
% ----------------------------------------------------------------------------

% ============================================================================

% COMPUTATION
% ----------------------------------------------------------------------------

open_animation()

for j = 1: length(crank)
    % For each crank angle, iterate Newton Raphon until an exiting condition is
    % reached.
    ti = crank(j);
    t = nr(t, ti);
    generate_frame(l, t, ti, a, b, c);

end
%close_animation()


