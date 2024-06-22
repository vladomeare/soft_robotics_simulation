function L_1D = laplace_matrix_v2(n, number_of_neighbours, neighbours)
    L_1D = diag(diag(-ones(n)));
    for i = 1:1:n
       dividing = 1/number_of_neighbours(i);
       for j = 1:1:number_of_neighbours(i)
           L_1D(i,neighbours{i}(j)) = dividing;
           %L_1D(neighbours{i}(j),i) = -dividing;
       end
    end
    L_1D = sparse(L_1D);
end