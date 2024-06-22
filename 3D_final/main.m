%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% Here we are making a simulation of a soft system as a part of a
%%% simualtion of a soft robot. 
%%% 
%%% 3D version 1.0
%%%
%%% Written by Vladomeare Obolonskyy
%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
close

iter = 3000;
lambda = 0.5;
pressure = 10;

%fig_m = create_mesh_sphere();   % figure mesh
fig_m = create_mesh_cube();   % figure mesh 
neighbours_data = find_neighbours(fig_m.nbNod, fig_m.LINES, fig_m.TRIANGLES); 
fig_m.VERT_POS = [fig_m.POS(:,1);fig_m.POS(:,2);fig_m.POS(:,3)];

Volume = zeros(1,iter);

% Make 3D Laplacian

L_1D = laplace_matrix_v2(fig_m.nbNod,neighbours_data.AMOUNT_NEIGHBOURS,neighbours_data.NEIGHBOURS); % Laplacian matrix in one dimension
L = [L_1D, zeros(fig_m.nbNod), zeros(fig_m.nbNod);
     zeros(fig_m.nbNod), L_1D, zeros(fig_m.nbNod);
     zeros(fig_m.nbNod), zeros(fig_m.nbNod), L_1D
     ];

for i = 1:1:iter
   % problem convex ==> centre mass point can be meausured and will be
   % inside
   
   fig_m.centre_mass = centre_mass_point_search(fig_m.POS, fig_m.nbNod);      % point inside
   V = mesh_volume(fig_m.POS, fig_m.TRIANGLES, fig_m.centre_mass);                       % Area/Volume 
   Volume(1,i) = V;
   A = find_area(fig_m.POS, fig_m.TRIANGLES, fig_m.centre_mass);                     % Find length/area of surface
   norm_vector = find_normal_direction_v3(fig_m.nbNod, fig_m.POS, fig_m.TRIANGLES, 0, pressure/A); % Find force created by pressure in each point
   
   temp_vector = L*fig_m.VERT_POS;
   norm_vector_vert = [norm_vector(:,1); norm_vector(:,2); norm_vector(:,3)];
   result_vector = temp_vector + norm_vector_vert;
   
   % plot
   
   figure(1); 
   subplot(2,2,1)
   trisurf(fig_m.TRIANGLES(:,1:3),fig_m.POS(:,1),fig_m.POS(:,2),fig_m.POS(:,3));
   hold on
   quiver3([fig_m.VERT_POS(1:fig_m.nbNod)],[fig_m.VERT_POS(fig_m.nbNod+1:2*fig_m.nbNod)],[fig_m.VERT_POS(2*fig_m.nbNod+1:3*fig_m.nbNod)],[norm_vector(:,1)],[norm_vector(:,2)],[norm_vector(:,3)]);
   quiver3([fig_m.VERT_POS(1:fig_m.nbNod)],[fig_m.VERT_POS(fig_m.nbNod+1:2*fig_m.nbNod)],[fig_m.VERT_POS(2*fig_m.nbNod+1:3*fig_m.nbNod)],[temp_vector(1:fig_m.nbNod)],[temp_vector(fig_m.nbNod+1:2*fig_m.nbNod)],[temp_vector(2*fig_m.nbNod+1:3*fig_m.nbNod)]);
   quiver3([fig_m.VERT_POS(1:fig_m.nbNod)],[fig_m.VERT_POS(fig_m.nbNod+1:2*fig_m.nbNod)],[fig_m.VERT_POS(2*fig_m.nbNod+1:3*fig_m.nbNod)],[result_vector(1:fig_m.nbNod)],[result_vector(fig_m.nbNod+1:2*fig_m.nbNod)],[result_vector(2*fig_m.nbNod+1:3*fig_m.nbNod)]);
   title("iteratie " + string(i));
   hold off
   subplot(2,2,2)
   plot3(fig_m.POS(:,1),fig_m.POS(:,2),fig_m.POS(:,3),'x'); 
   hold on
   quiver3([fig_m.VERT_POS(1:fig_m.nbNod)],[fig_m.VERT_POS(fig_m.nbNod+1:2*fig_m.nbNod)],[fig_m.VERT_POS(2*fig_m.nbNod+1:3*fig_m.nbNod)],[norm_vector(:,1)],[norm_vector(:,2)],[norm_vector(:,3)]);
   quiver3([fig_m.VERT_POS(1:fig_m.nbNod)],[fig_m.VERT_POS(fig_m.nbNod+1:2*fig_m.nbNod)],[fig_m.VERT_POS(2*fig_m.nbNod+1:3*fig_m.nbNod)],[temp_vector(1:fig_m.nbNod)],[temp_vector(fig_m.nbNod+1:2*fig_m.nbNod)],[temp_vector(2*fig_m.nbNod+1:3*fig_m.nbNod)]);
   quiver3([fig_m.VERT_POS(1:fig_m.nbNod)],[fig_m.VERT_POS(fig_m.nbNod+1:2*fig_m.nbNod)],[fig_m.VERT_POS(2*fig_m.nbNod+1:3*fig_m.nbNod)],[result_vector(1:fig_m.nbNod)],[result_vector(fig_m.nbNod+1:2*fig_m.nbNod)],[result_vector(2*fig_m.nbNod+1:3*fig_m.nbNod)]);
   title("iteratie " + string(i));
   hold off
   subplot(2,2,3)
   plot3(fig_m.POS(:,1),fig_m.POS(:,2),fig_m.POS(:,3),'.'); 
   hold on
   quiver3([fig_m.VERT_POS(1:fig_m.nbNod)],[fig_m.VERT_POS(fig_m.nbNod+1:2*fig_m.nbNod)],[fig_m.VERT_POS(2*fig_m.nbNod+1:3*fig_m.nbNod)],[norm_vector(:,1)],[norm_vector(:,2)],[norm_vector(:,3)]);
   title("iteratie " + string(i) + " normaalvectoren");
   hold off
   subplot(2,2,4)
   plot3(fig_m.POS(:,1),fig_m.POS(:,2),fig_m.POS(:,3),'x'); 
   hold on
   quiver3([fig_m.VERT_POS(1:fig_m.nbNod)],[fig_m.VERT_POS(fig_m.nbNod+1:2*fig_m.nbNod)],[fig_m.VERT_POS(2*fig_m.nbNod+1:3*fig_m.nbNod)],[temp_vector(1:fig_m.nbNod)],[temp_vector(fig_m.nbNod+1:2*fig_m.nbNod)],[temp_vector(2*fig_m.nbNod+1:3*fig_m.nbNod)]);
   title("iteratie " + string(i) + " Laplacianen");
   hold off
   
   % Calculate new coordinates
      
   fig_m.VERT_POS = fig_m.VERT_POS + lambda*result_vector; 
   fig_m.POS = [[fig_m.VERT_POS(1:fig_m.nbNod)],[fig_m.VERT_POS(fig_m.nbNod+1:2*fig_m.nbNod)],[fig_m.VERT_POS(2*fig_m.nbNod+1:3*fig_m.nbNod)]];
end
