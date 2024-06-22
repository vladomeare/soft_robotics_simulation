function L_1D = laplace_matrix(n)
    e = ones(n,1);
    L_1D = (1/2)*spdiags([e -2*e e],-1:1,n,n);
    L_1D(n,1) = 1/2;
    L_1D(1,n) = 1/2;
end