function V = mesh_volume(points,triangles,point_inside)
    V = 0;
    s = size(triangles);
    for i = 1:1:s(1)
       a = points(triangles(i,1),:)-point_inside;
       b = points(triangles(i,2),:)-point_inside;
       c = points(triangles(i,3),:)-point_inside;
       box_prod = [a;b;c];
       tetra_Vol = abs(det(box_prod))/6;
       V = V + tetra_Vol;
    end
end