% Actual program.
x = [1:100];
y = [100:-1:1];

% Set up first frame
figure()
axis=([-100 100 -100 100])
hh1(1) = line([0 x(1)], [0 y(1)],'Color', 'b');
hh1(2) = line([x(1) 0], [y(1) 0],'Color', 'r');

% Get figure size
pos = get(gcf, 'Position');
width = pos(3);
height = pos(4);

% Preallocate data (for storing frame data)
mov = zeros(height, width, 1, 100, 'uint8');

% Loop through by changing XData and YData
for i = 1:100
    % Update graphics data. This is more efficient than recreating plots.
    set(GFXNAME, PROPERTY, VALUE, PROPERTY, VALUE, ...);
    set(GFXNAME, PROPERTY, VALUE, PROPERTY, VALUE, ...);
    set(GFXNAME, PROPERTY, VALUE, PROPERTY, VALUE, ...);
    set(GFXNAME, PROPERTY, VALUE, PROPERTY, VALUE, ...);
    ...

    % Capture the plot as an image 
    frame = getframe(gcf); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 

    % Write to the GIF File 
    if i == 1 
      imwrite(imind,cm,'filename','gif', 'Loopcount',inf); 
    else 
      imwrite(imind,cm,'filename','gif','WriteMode','append'); 
    end 
end