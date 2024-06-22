function neighbours_structure = find_neighbours(amount_points, lines, triangles)
    s_lines = size(lines);
    s_triangles = size(triangles);
    amount_neighbours = zeros(amount_points,1);
    neighbours = cell(amount_points,1);
    
    for i = 1:1:amount_points
       for j = 1:1:s_lines(1)
           if ismember(i,lines(j,:))
               if lines(j,1) ~= i
                  neighbours{i}(end+1) = lines(j,1);
               else
                  neighbours{i}(end+1) = lines(j,2);
               end
           end
       end
       for j = 1:1:s_triangles(1)
           if ismember(i,triangles(j,:))
               for k = 1:1:3
                  if triangles(j,k) ~= i 
                      neighbours{i}(end+1) = triangles(j,k);
                  end
               end
           end
       end
       neighbours{i} = unique(neighbours{i});
       t_size = size(neighbours{i});
       amount_neighbours(i) = t_size(2);
    end
    

    
    neighbours_structure.NEIGHBOURS = neighbours;
    neighbours_structure.AMOUNT_NEIGHBOURS = amount_neighbours;
end