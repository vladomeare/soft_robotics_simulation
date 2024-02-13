function s = find_length(x,y)
    x_temp = [x;x(1)];
    y_temp = [y;y(1)];
%     for i = 1:1:size_vector(1) 
%        s = s + sqrt((x_temp(i)-x_temp(i+1))^2+(y_temp(i)-y_temp(i+1))^2);
%     end
    s = sum(vecnorm(diff([x_temp(:),y_temp(:)]),2,2));
end