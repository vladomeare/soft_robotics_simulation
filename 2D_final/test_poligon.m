clear
clc

f = @(x) x + 2;
f(3)
f(2)

x = [0, 1, 1,0];
y = [0, 0, 1, 1];
u = [1, 1, 3, -3];
v = [0, 3, -1, 1];
xn = x+u;
yn = y+v;
plot(x,y,"x")
hold on
grid on
plot(xn,yn,"o")
quiver(x,y,u,v,0);
ylim([-5,5]);
axis equal
%xlim([-5,5]);
hold off
polyarea(x,y)
