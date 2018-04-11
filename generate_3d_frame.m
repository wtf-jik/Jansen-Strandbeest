function [frame] = generate_frame(x, y)
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

    fig = figure('units','pixels','position',[800 800 800 800]);
    hold on;
    axis([-120 50 -120 50 -120 50]);
    view(45, 45);
    axis off;

    for i = 1:length(link)
        [faces, vertices] = generate_3d_link(x(link(i,1)),...
                            x(link(i,2)),...
                            y(link(i,1)),...
                            y(link(i,2)),...
                            0,...
                            0,...
                            1,...
                            2);
        
            
        patch('Faces',faces,'Vertices',vertices,'FaceColor','b');
    end
    
    clear fig

end