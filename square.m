function [x,y]=square(n,s)
    x = zeros(1,n);
    y = zeros(1,n);
    t = (4*s)/n;
    for i = 1:1:fix(n/4)
       x(i) = i*t;
       y(i) = 0;
       x(fix(n/4)+i) = s;
       y(fix(n/4)+i) = i*t;
       x(2*fix(n/4)+i) = s-i*t;
       y(2*fix(n/4)+i) = s;
       x(3*fix(n/4)+i) = 0;
       y(3*fix(n/4)+i) = s-i*t;
    end
%     for i = fix(n/4):1:2*fix(n/4)
%        x(i) = s;
%        y(i) = i*t;
%     end
%     for i = 2*fix(n/4):1:3*fix(n/4)
%        x(i) = s-i*t;
%        y(i) = s;
%     end
%     for i = 3*fix(n/4):1:4*fix(n/4)
%        x(i) = 0;
%        y(i) = s-i*t;
%     end
    for i = 4*fix(n/4):1:n
       x(i) = (i-4*fix(n/4))*t;
       y(i) = 0;
    end
end