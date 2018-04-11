function [gain] = start_animation()
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

% Set up first frame

figure();
axis=([-200 50 -100 50]);
% Get figure size
pos = get(gcf, 'Position');
width = pos(3);
height = pos(4);

% Preallocate data (for storing frame data)
mov = zeros(height, width, 1, 100, 'uint8');
