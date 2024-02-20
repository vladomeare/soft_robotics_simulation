%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% Vladomeare Obolonskyy
%%% 
%%% Here we are making a simulation of a soft system as a part of a
%%% simualtion of a soft robot. 
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
close

n = 100;
r = 1;
iter = 10;
lambda = 0.9;
pressure = 30;

[x,y] = random_points_on_circle(n,r);   % Een vorm maken met geordende punten
%[x,y] = square(n,r);
p = [x'; y'];
L_1D = laplace_matrix(n);
L = [L_1D, zeros(n); zeros(n), L_1D];   % Laplaciaan maken voor 2D

figure(1);

subplot(2,2,1);
full_round_x = [x'; x(1)];
full_round_y = [y'; y(1)];
f1 = plot(full_round_x,full_round_y);   % Plot originele figuur (tittels toevoegen!)
subplot(2,2,2);
f2 = plot(x',y','.');                   % Plot van punten die figuur benaderen
subplot(2,2,3);
for i = 1:1:iter
   A = polyarea([p(1:n)],[p(n+1:2*n)]);
   s = find_length([p(1:n)],[p(n+1:2*n)]);
   pressure_norm = find_pressure_norm(s,n,pressure);
   norm_vector = find_normal_direction(p,0, pressure_norm); % Find force created by pressure in each point
   
   temp_vector = L*p;
   
   p = p + lambda*L*p; 
   f3 = plot([p(1:n);p(1)], [p(n+1:2*n);p(n+1)]);
   hold on
   quiver([p(1:n)],[p(n+1:2*n)],[norm_vector(1:n)],[norm_vector(n+1:2*n)],0)
   quiver([p(1:n)],[p(n+1:2*n)],[temp_vector(1:n)],[temp_vector(n+1:2*n)],0)
   title("iteratie " + string(i));
   pause(5)
   hold off
end