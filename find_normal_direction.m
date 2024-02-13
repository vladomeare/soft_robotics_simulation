% This function returns an array of normal vectors in a form of norm_vector = [U,V] for
% an input array of points P = [X,Y]

function norm_vector = find_normal_direction(P,pressure_inside_flag)
s = size(P);
len = s(1)/2;
X = P(1:len);           % splitting P in parts
Y = P((len+1):(2*len)); 
X = [X(len);X;X(1)];    % We want to have a circle array, so we extend it by last and first element
Y = [Y(len);Y;Y(1)];
norm_vector = zeros(s(1),1);    % Defines vector array of form [U,V] 

% We get a normal vector for each point

for i=1:1:len
   ximin1 = X(i);
   xiplus1 = X(i+2);
   yimin1 = Y(i);
   yiplus1 = Y(i+2);
   deltax = xiplus1 - ximin1;   % Create a vector [deltax,deltay] between points i-1 and i+1 
   deltay = yiplus1 - yimin1;
   norm_vector(i) = deltay;     % To find fast an orthogonal vector we replace values of the original one  
   norm_vector(len+i) = -deltax;% othogonal vector is now [deltay,-deltax], the normalization happens later        
end

% We choose the right direction

if pressure_inside_flag == 1    % The pressure goes in other direction
    norm_vector = -norm_vector;
end

% We now need to scale the vectors


end
