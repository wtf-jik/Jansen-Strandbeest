function [faces, vertices] = generate_3d_link(x1, x2, y1, y2, z1, z2, link_width, link_height)
%Calculates the gain of a basic common-emiiter BJT amplifier.
%   Takes no input.
%   
%
%   Examples:
%   generate_frame()
%
%   John Casey :: 14350111

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