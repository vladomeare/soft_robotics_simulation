function A = find_area(points, triangles, point_inside)
    A = 0;
    s = size(triangles);
    triangles_A = zeros(s(1),1);
    for i = 1:1:s(1)
       a = points(triangles(i,1),:);
       b = points(triangles(i,2),:);
       c = points(triangles(i,3),:);
       v1 = b - a;
       v2 = c - a;
       v3 = cross(v1, v2);
       box = [v1; v2; v3];
       triangles_A(i) = det(box)/(2*norm(v3));
    end
    A = sum(triangles_A);
end