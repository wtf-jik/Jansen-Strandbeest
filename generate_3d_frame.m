function [frame] = generate_3D_frame(x, y)
%Calculates the gain of a basic common-emiiter BJT amplifier.
%   VERSION 1
%   Takes no input.
%   
%
%   Examples:
%   generate_frame()
%
%   John Casey :: 14350111

[m,n] = size(x);
[o,p] = size(y);
if m ~= 1;
    error('Incorrect size for argument x. Array must be a 1D array.');
end;
if o ~= 1;
    error('Incorrect size for argument y. Array must be a 1D array.');
end;
if n ~= p;
    error('Arguments x and y must be the same length.');
end;
if ~isnumeric(x) || ~isnumeric(y);
    error('Co-ordinates must be numeric.');
end;

% ENVIRONMENT
% ----------------------------------------------------------------------------
    frame_thickness = 2;
    surface_resolution = 100;
    figure_resolution = [1600 1600 1600 1600];
    axis_size = [-120 50 -120 50 -120 50];
    light_angle = [45 70];
    figure_view = [-30 80];
    %Z_pos = 0;

    r = frame_thickness; n = surface_resolution;   
    [X,Y,Z] = cylinder(r,n);
    Z(2, :) = frame_thickness*2;

    persistent g;

    link = [1 2;
            2 3;
            3 5;
            5 4;
            4 1;
            7 1;
            8 4;
            8 2;
            8 3;
            6 4;
            6 5];

    if isempty(g)
        g(45) = figure('units','pixels','position',figure_resolution);
        hold on;
        axis(axis_size);
        view(figure_view);
        shading interp
        lightangle(light_angle(1), light_angle(2));
        axis off;

        for i = 1:length(link)
            [faces, vertices] = generate_3d_link(x(link(i,1)),...
                                x(link(i,2)),...
                                y(link(i,1)),...
                                y(link(i,2)),...
                                Z_pos,...
                                Z_pos,...
                                frame_thickness,...
                                frame_thickness);
            
                
            g(i) = patch('Faces',faces,'Vertices',vertices,'FaceColor','b','LineStyle','none');
        end
        for i = 1: length(x)
            g(i+length(link)*1) = surf(X+x(i),Y+y(i),Z-frame_thickness,'facecolor','g','LineStyle','none');
            g(i+length(link)*2) = fill3(X(1,:)+x(i),Y(1,:)+y(i),Z(1,:)-frame_thickness,'g','LineStyle','none');
            g(i+length(link)*3) = fill3(X(2,:)+x(i),Y(2,:)+y(i),Z(2,:)-frame_thickness,'g','LineStyle','none');
        end
    else
        for i = 1:length(link)
            [faces, vertices] = generate_3d_link(x(link(i,1)),...
                                x(link(i,2)),...
                                y(link(i,1)),...
                                y(link(i,2)),...
                                Z_pos,...
                                Z_pos,...
                                frame_thickness,...
                                frame_thickness);

            set(g(i), 'Vertices', vertices);
        end
        for i = 1: length(x)
            set(g(i+length(link)*1),'XData',X+x(i),'YData',Y+y(i));
            set(g(i+length(link)*2),'XData',X(1,:)+x(i),'YData',Y(1,:)+y(i));
            set(g(i+length(link)*3),'XData',X(2,:)+x(i),'YData',Y(2,:)+y(i));
        end
    end
    drawnow;
    frame = getframe(gcf);
end