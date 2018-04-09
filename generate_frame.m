function [gain] = generate_frame(l, t, ti, a, b, c)
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

% Joint A
positions(1, 1)  = l(10)*cos(ti);
positions(1, 2)  = l(10)*sin(ti);

% Joint B
positions(2, 1)  = l(1)*cos(t(1)) + positions(1, 1);
positions(2, 2)  = l(1)*sin(t(1)) + positions(1, 2);

% Joint C
positions(3, 1)  = l(3)*cos(t(3)) + positions(2, 1);
positions(3, 2)  = l(3)*sin(t(3)) + positions(2, 2);

% Joint D
positions(4, 1)  = -(b) + l(7)*cos(t(7));
positions(4, 2)  = -(a) + l(7)*sin(t(7));

% Joint E
positions(5, 1)  = l(8)*cos(t(8)) + positions(4, 1);
positions(5, 2)  = l(8)*sin(t(8)) + positions(4, 2);

% Joint F
positions(6, 1)  = l(9)*cos(t(8) + c) + positions(4, 1);
positions(6, 2)  = l(9)*sin(t(8) + c) + positions(4, 2);

% Joint 0
positions(7, 1) = 0;
positions(7, 2) = 0;

% Joint 1
positions(8, 1) = -b;
positions(8, 2) = -a;

link = [positions(:,1) positions(:,2)];
AB = line([positions(1,1) positions(2,1)],[positions(1,2) positions(2,2)]);
BC = line([positions(2,1) positions(3,1)],[positions(2,2) positions(3,2)]);
CE = line([positions(3,1) positions(5,1)],[positions(3,2) positions(5,2)]);
ED = line([positions(5,1) positions(4,1)],[positions(5,2) positions(4,2)]);
DA = line([positions(4,1) positions(1,1)],[positions(4,2) positions(1,2)]);
ZA = line([positions(7,1) positions(1,1)],[positions(7,2) positions(1,2)]);
OD = line([positions(8,1) positions(4,1)],[positions(8,2) positions(4,2)]);
OB = line([positions(8,1) positions(2,1)],[positions(8,2) positions(2,2)]);
OC = line([positions(8,1) positions(3,1)],[positions(8,2) positions(3,2)]);
FD = line([positions(6,1) positions(4,1)],[positions(6,2) positions(4,2)]);
FE = line([positions(6,1) positions(5,1)],[positions(6,2) positions(5,2)]);

%line([A(1) B(1)], [A(2) B(2)]);
%line([B(1) C(1)], [B(2) C(2)]);
%line([C(1) E(1)], [C(2) E(2)]);
%line([E(1) D(1)], [E(2) D(2)]);
%line([D(1) A(1)], [D(2) A(2)]);
%line([Z(1) A(1)], [Z(2) A(2)]);
%line([O(1) D(1)], [O(2) D(2)]);
%line([O(1) B(1)], [O(2) B(2)]);
%line([O(1) C(1)], [O(2) C(2)]);
%line([O(1) C(1)], [O(2) C(2)]);
%line([F(1) D(1)], [F(2) D(2)]);
%line([F(1) E(1)], [F(2) E(2)]);
%plot(F(1), F(2), 'or');


%% Update graphics data. This is more efficient than recreating plots.
%set(GFXNAME, PROPERTY, VALUE, PROPERTY, VALUE, ...);
%set(GFXNAME, PROPERTY, VALUE, PROPERTY, VALUE, ...);
%set(GFXNAME, PROPERTY, VALUE, PROPERTY, VALUE, ...);
%set(GFXNAME, PROPERTY, VALUE, PROPERTY, VALUE, ...);
%...

%% Capture the plot as an image 
%frame = getframe(gcf); 
%im = frame2im(frame); 
%[imind,cm] = rgb2ind(im,256); 
%
%% Write to the GIF File 
%if i == 1 
%  imwrite(imind,cm,'filename','gif', 'Loopcount',inf); 
%else 
%  imwrite(imind,cm,'filename','gif','WriteMode','append'); 
%end