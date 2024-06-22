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



outside_pressure = 101325;
input_pressure = 120000;
pres_vol_model_coef = 10132.5;
n = 100;
r = 3;
iter = 10000;
lambda = 0.5;
pressure = 0.5;
%pressure_function = @(V) pres_vol_model_coef*V;
%model_pressure_volume = @(p) (1/pres_vol_model_coef) * p;     % Function to get model Volume to which we are approaching 

Volume_diff_vector = zeros(1,iter);

%[x,y] = random_points_on_circle(n,r);   % Een vorm maken met geordende punten
[x,y] = square(n,r);
p = [x'; y'];
L_1D = laplace_matrix(n);
L = [L_1D, zeros(n); zeros(n), L_1D];   % Laplaciaan maken voor 2D

figure(1);

subplot(2,2,1);
full_round_x = [x'; x(1)];
full_round_y = [y'; y(1)];
f1 = plot(full_round_x,full_round_y);
title("Originele figuur");% Plot originele figuur (tittels toevoegen!)
subplot(2,2,2);
f2 = plot(x',y','.');% Plot van punten die figuur benaderen
title("Originele puntenverzameling")
%volume = model_pressure_volume(input_pressure);             % Find the volume we are going to
for i = 1:1:iter
   A = polyarea([p(1:n)],[p(n+1:2*n)]);                        % Area/Volume 
   Volume_diff_vector(1,i) = A;
   s = find_length([p(1:n)],[p(n+1:2*n)]);                     % Find length/area of surface
   
   %pressure = (volume/A)*input_pressure-outside_pressure;        %%%%?
   %pressure_norm = find_pressure_norm(s,n,pressure);           % Set length of vector for each point
   
   norm_vector = find_normal_direction_v2(p,0, pressure/A); % Find force created by pressure in each point
   
   temp_vector = L*p;
   
%    if i >= 100
%       lambda = 0.5; 
%    end
%    lambda = 0.1*10^(-floor(log10(abs(pressure))));
%    if lambda >= 1
%       lambda = 0.5; 
%    end
   
   result_vector = L*p + norm_vector;
   
   % plot
   
   subplot(2,2,3);
   f3 = plot([p(1:n);p(1)], [p(n+1:2*n);p(n+1)]);
   hold on
   quiver([p(1:n)],[p(n+1:2*n)],[norm_vector(1:n)],[norm_vector(n+1:2*n)],0)
   quiver([p(1:n)],[p(n+1:2*n)],[temp_vector(1:n)],[temp_vector(n+1:2*n)],0)
   quiver([p(1:n)],[p(n+1:2*n)],[result_vector(1:n)],[result_vector(n+1:2*n)],0)
   title("iteratie " + string(i));
   %pause(0.1)
   hold off
   
%    Volume_diff_vector(i) = volume/A;
%    
%    subplot(2,2,4);
%    f4 = plot(Volume_diff_vector);
%    
%    if i >= 50
%      s=0;  
%    end
   
    

   p = p + lambda*(L*p+norm_vector); 
end

subplot(2,2,4);
plot(Volume_diff_vector)
title("Oppervlakte per iteratie")