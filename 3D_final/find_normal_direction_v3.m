function norm_vector_on_points = find_normal_direction_v3(number_of_points, points, triangles, pressure_inside_flag, pressure_norm)
    s = size(triangles);
    norm_vector_on_triangles = zeros(s(1),3);    % Defines vector array of form [U,V] 
    norm_vector_on_points = zeros(number_of_points, 3);
    
    % We get a normal vector for each triangle

    for i=1:1:s(1)
       a = points(triangles(i,1),:);
       b = points(triangles(i,2),:);
       c = points(triangles(i,3),:);
       v1 = b - a;
       v2 = c - a;
       norm_vector_on_triangles(i,:) = cross(v1, v2); % This is an orthogonal vector
       
       box = [v1; v2; norm_vector_on_triangles(i,:)]; % copied from functionfind area
       triangles_A = det(box)/(2*norm(norm_vector_on_triangles(i,:)));
       
        % We now need to scale the vectors
       
       alfa = pressure_norm/norm(norm_vector_on_triangles(i,:)); % Correct change?
       norm_vector_on_triangles(i,:) = alfa*norm_vector_on_triangles(i,:)*triangles_A; 
       
       % add in each point the vector
       for j = 1:1:3
           norm_vector_on_points(triangles(i,j),:) = norm_vector_on_points(triangles(i,j),:) + (1/3)*norm_vector_on_triangles(i,:);
       end
       
    end
    
    % We choose the right direction

    if pressure_inside_flag == 1    % The pressure goes in other direction
        norm_vector_on_points = -norm_vector_on_points;
    end

    
end