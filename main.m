%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% Vladomeare Obolonskyy
%%%
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
close

n = 400;
r = 20;
iter = 500;
lambda = 0.5;

[x,y] = random_points_on_circle(n,r);
p = [x'; y'];
L_1D = laplace_matrix(n);
L = [L_1D, zeros(n); zeros(n), L_1D];

figure(1);

subplot(2,2,1);
full_round_x = [x'; x(1)];
full_round_y = [y'; y(1)];
f1 = plot(full_round_x,full_round_y);
subplot(2,2,2);
f2 = plot(x',y','.');
subplot(2,2,3);
for i = 1:1:iter
   p = p + lambda*L*p; 
   f3 = plot(p(1:n),p(n+1:2*n));
   title("iteratie " + string(i));
   pause(1)
end