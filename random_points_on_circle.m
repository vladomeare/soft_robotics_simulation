function [x,y]=random_points_on_circle(n,r)
    theta = 0;
    noise = 50;
    delta = 2*pi/n;
    x = zeros(1,n);
    y = zeros(1,n);
    for i = 1:1:n
       x(i) = r*cos(theta) + 0.001*randi(noise)*r*(-1)^randi(4);
       y(i) = r*sin(theta) + 0.001*randi(noise)*r*(-1)^randi(4);
       theta = theta + delta;
    end
end