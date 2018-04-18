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

    persistent g;

    if isempty(g)
        g(12) = figure('units','pixels','position',[800 800 800 800]);
        hold on;
        axis([-120 50 -120 50]);
        axis off;
        g(1) = line([x(1) x(2)],[y(1) y(2)],'Color','k','LineWidth',8);
        g(2) = line([x(2) x(3)],[y(2) y(3)],'Color','k','LineWidth',8);
        g(3) = line([x(3) x(5)],[y(3) y(5)],'Color','k','LineWidth',8);
        g(4) = line([x(5) x(4)],[y(5) y(4)],'Color','k','LineWidth',8);
        g(5) = line([x(4) x(1)],[y(4) y(1)],'Color','k','LineWidth',8);
        g(6) = line([x(7) x(1)],[y(7) y(1)],'Color','g','LineWidth',8);
        g(7) = line([x(8) x(4)],[y(8) y(4)],'Color','k','LineWidth',8);
        g(8) = line([x(8) x(2)],[y(8) y(2)],'Color','k','LineWidth',8);
        g(9) = line([x(8) x(3)],[y(8) y(3)],'Color','k','LineWidth',8);
        g(10) = line([x(6) x(4)],[y(6) y(4)],'Color','k','LineWidth',8);
        g(11) = line([x(6) x(5)],[y(6) y(5)],'Color','k','LineWidth',8);
        for i = 1: length(x)
            g(i + 12) = plot(x(i), y(i), '.k', 'MarkerSize', 50);
        end

    else
        set(g(1), 'XData', [x(1) x(2)], 'YData', [y(1) y(2)]);
        set(g(2), 'XData', [x(2) x(3)], 'YData', [y(2) y(3)]);
        set(g(3), 'XData', [x(3) x(5)], 'YData', [y(3) y(5)]);
        set(g(4), 'XData', [x(5) x(4)], 'YData', [y(5) y(4)]);
        set(g(5), 'XData', [x(4) x(1)], 'YData', [y(4) y(1)]);
        set(g(6), 'XData', [x(7) x(1)], 'YData', [y(7) y(1)]);
        set(g(7), 'XData', [x(8) x(4)], 'YData', [y(8) y(4)]);
        set(g(8), 'XData', [x(8) x(2)], 'YData', [y(8) y(2)]);
        set(g(9), 'XData', [x(8) x(3)], 'YData', [y(8) y(3)]);
        set(g(10), 'XData', [x(6) x(4)], 'YData', [y(6) y(4)]);
        set(g(11), 'XData', [x(6) x(5)], 'YData', [y(6) y(5)]);
        for i = 1: length(x)
            if i == 6
                plot(x(i), y(i), '.b');
            end
            set(g(i + 12), 'XData', x(i), 'YData', y(i));
        end
    end


    % Capture the current figure as a frame and return.
    frame = getframe(gcf); 
end