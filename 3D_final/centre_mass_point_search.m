function center_mass_point = centre_mass_point_search(points, n)
    center_mass_point = [sum(points(1,:))/n sum(points(2,:))/n sum(points(3,:))/n];    
end