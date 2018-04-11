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
close all;
format long;
print_results = false;
verbose = true;
create_plot = false;

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

crank = [pi:0.1:3*pi];
Df = zeros(8,8);

% PHYSICAL QUANTITIES
% ----------------------------------------------------------------------------

% ============================================================================

% COMPUTATION
% ----------------------------------------------------------------------------



for i = 1: length(crank)
    % For each crank angle, iterate Newton Raphon until an exiting condition is
    % reached.
    ti = crank(i);
    t = nr(t, ti);
    [x, y] = joint_coords(l, t, ti, a, b, c);
    generate_3d_frame(x, y);
    if create_plot == true
        frame = generate_3d_frame(x, y);  
        im = frame2im(frame); 
        [imind,cm] = rgb2ind(im,256); 
        
        %% Write to the GIF File 
        if i == 1 
          imwrite(imind,cm,'filename','gif','Loopcount',inf); 
        else 
          imwrite(imind,cm,'filename','gif','WriteMode','append','DelayTime', 0.01); 
        end
    end
end
%end_animation()


