function [faces, vertices] = generate_3d_link(x1, x2, y1, y2, z1, z2, link_width, link_height)
%Calculates the faces and vertices of a 3D link in 3D space.
%   VERSION 1
%
%   Takes in individual XYZ co-ordinates for two points, and width and length of link.
%	Returns faces and vertices of said link. 
%   
%
%   Examples:
%   generate_3d_link(1, 14, 2, 4, -12, 12, 2, 4);
%
%   John Casey :: 14350111

if link_width < 0 || link_height < 0;
    error('Link dimensions must be greater than zero.');
end;
if ~isnumeric(x1) || ~isnumeric(x2) || ~isnumeric(y1) || ~isnumeric(y2) || ~isnumeric(z2) || ~isnumeric(z2);
    error('Co-ordinates must be numeric.');
end;

% ENVIRONMENT
% ----------------------------------------------------------------------------

	face_1 = [(x1-link_width/2) (y1-link_width/2) (z1-link_height/2);
	          (x1-link_width/2) (y1+link_width/2) (z1+link_height/2);
	          (x1+link_width/2) (y1-link_width/2) (z1-link_height/2);
	          (x1+link_width/2) (y1+link_width/2) (z1+link_height/2)];

	face_2 = [(x2-link_width/2) (y2-link_width/2) (z2-link_height/2);
	          (x2-link_width/2) (y2+link_width/2) (z2+link_height/2);
	          (x2+link_width/2) (y2-link_width/2) (z2-link_height/2);
	          (x2+link_width/2) (y2+link_width/2) (z2+link_height/2)];

	ver = [face_1; face_2];

	%  Define the faces of the unit cubic
	faces = [1 2 4 3;
	         8 7 5 6;
	         8 7 3 4;
	         5 6 2 1;
	         2 4 8 6;
	         3 1 5 7];

	vertices = [ver(:,1),ver(:,2),ver(:,3)];
end