r = 2; n = 100;   
[X,Y,Z] = cylinder(r,n);
Z(2, :) = 4;

figure
axis([-120 50 -120 50 -120 50]);
hold on;
grid on
view(45,45);

x = 1:10;
y = 10:-1:1;

g(1) = surf(X+x(i),Y+y(i),Z,'facecolor','r','LineStyle','none');
g(1+1) = fill3(X(1,:)+x(i),Y(1,:)+y(i),Z(1,:),'r','LineStyle','none');
g(1+2) = fill3(X(2,:)+x(i),Y(2,:)+y(i),Z(2,:),'r','LineStyle','none');

for i = 1: length(x)
    set(g(1),'XData',X+i,'YData',Y+i);
    set(g(1+1),'XData',X(1,:)+i,'YData',Y(1,:)+i);
    set(g(1+2),'XData',X(2,:)+i,'YData',Y(2,:)+i);
    pause(0.5);
end