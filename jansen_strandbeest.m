function [] = jansen(varargin)
%Model the behaviour of the Jansen linkage.
% VERSION 1.3
% No input arguments requirement. The following optional arguments are available.
% Note that though input arguments are case-insensitive, they must be passed as key:value pairs.
% If no value is supplied, sane defaults are used, either derivied empirically, or supplied in
% in the problem set.
%
% LINKAGE PARAMETERS
% NOTE: Be advised that should you use this parameter, you will likely have to supply
%       somewhat accurate initial values for the angle of each link. See the
%       'InitialAngles' parameter below.
%
% 'crankangle'              : Position(s) of crank angle to evaluate for. (Rads)
%                             Can accept 1-dimensional arrays of values.
%
% COMPUTATION PARAMETERS
% 'maxiterations'           :  Maximum iterations of Newton Raphson permitted (Integer)
% 'tolerance'               :  Acceptable accuracy for results (Unitless)
%
% OUTPUT SETTINGS
% 'verbose'                 : Enables verbose mode if true. (Boolean)
% 'creategif'               : Create and output animated GIF if true. (Boolean)
% 'plotdimensions'          : Select visualisation type. (2, 3)
%
% INITIAL VALUES FOR UNKNOWNS
%
% NOTE: These parameters require that all values be entered in the correct order.
%       Please see imgur.com/TODO for more details. Alternatively details are
%       available in my report.
%
% 'initialangles'           : An 8x1 vector containing initial angles. (Rads)
% 'linklengths'             : An 8x1 vector containing link lengths. (Unitless)
%   
% Examples:
%   jansen()
%   jansen('tolerance', 1e-10)
%   jansen('creategif', true)
%   jansen('plotdimensions', 3)
%
% John Casey :: 14350111

% Default Values
% -----------------------------------------------------------------------------

DEFAULT_L = [50; 41.5; 55.8; 40.1; 39.4; 61.9; 39.3; 36.7; 49; 15];
DEFAULT_T = [2.5; 2; 4.3; 3.5; 4; 3.8; 3.9; 3.7];

% Input Validation
% -----------------------------------------------------------------------------

args = struct('maxiterations', 10,'tolerance', 1e-10, 'resolution', 1e-5,...
              'verbose', false, 'creategif', true, 'crankangle', ...
              [pi:0.01:3*pi], 'plotdimensions', 2, 'initialangles', ...
              DEFAULT_T, 'linklengths', DEFAULT_L);
arg_names = fieldnames(args);

nargin = length(varargin);
    % Ensure that there is an even number of arguments.
    if mod(nargin,2) ~= 0
        error(sprintf('This function requires propertyName/propertyValue pairs.\nSee the help file for more info.\n'));
    end

for tuple = reshape(varargin,2,[])  % pair is {propName;propValue}
   argin_name = lower(tuple{1});    % make case insensitive

   if any(strcmp(argin_name,arg_names))
        args.(argin_name) = tuple{2};
   else
        error('%s is not a recognized parameter name',string(argin_name));
   end
end

% COMPUTATION SETTINGS
% -----------------------------------------------------------------------------

max_iter    = args.maxiterations;    % Maximum allowed number of iterations.
tolerance   = args.tolerance;        % Defined tolerance for value of F.

% LINKAGE PARAMETERS
% -----------------------------------------------------------------------------

a = 7.8;        % Fixed Joint 1. (0, 7.8)
b = 38;         % Fixed Joint 0. (-38, 0)

l = args.linklengths;
t = args.initialangles;

crank = args.crankangle;

% =============================================================================

% COMPUTATION
% -----------------------------------------------------------------------------

for i = 1: length(crank)
    % For each crank angle, iterate Newton Raphon until an exiting condition is
    % reached.
    if args.verbose == true;
      fprintf('Crank angle: %f\n', crank(i));
    end

    t = nr(l, a, b, t, crank(i), max_iter, tolerance, args.verbose);
    [x, y] = joint_coords(l, t, crank(i), a, b); % Generate a set of tuples
                                                    % which hold paired x,y 
                                                    % values for the locations
                                                    % of each joint.
    % VISUALISATION
    % ----------------------------------------------------------------------------

    % Generate an animation of results.
    if args.creategif == true
        if args.plotdimensions == 2
            frame = generate_frame(x, y);       % 2D Visualisation of linkage.
        else
            frame = generate_3d_frame(x, y);    % 3D Visualisation of linkage.
        end
        
        % Convert frame to image for use in GIF creation.
        im = frame2im(frame); 
        [imind,cm] = rgb2ind(im,256); 


        %% Write to the GIF File 
        if i == 1 
          imwrite(imind,cm,'filename','gif','Loopcount',inf); 
        else 
          imwrite(imind,cm,'filename','gif','WriteMode','append','DelayTime', 0); 
        end
    end
end