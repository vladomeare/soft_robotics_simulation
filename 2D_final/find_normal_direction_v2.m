function norm_vector = find_normal_direction_v2(P,pressure_inside_flag, pressure_norm)
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
       xi = X(i+1);
       xiplus1 = X(i+2);
       yimin1 = Y(i);
       yi = Y(1);
       yiplus1 = Y(i+2);
       deltaximin = xi - ximin1;   % Create a vector [deltax,deltay] between points i-1 and i+1 
       deltayimin = yi - yimin1;
       deltaxiplus = xiplus1 - xi;
       deltayiplus = yiplus1 - yi;
       normalxmin = deltayimin;
       normalymin = -deltaximin;
       normalxplus = deltayiplus;
       normalyplus = -deltaxiplus;
       norm_vector(i) = normalxplus + normalxmin;     % To find fast an orthogonal vector we replace values of the original one  
       norm_vector(len+i) = normalyplus + normalymin;% othogonal vector is now [deltay,-deltax], the normalization happens later        
    end

    %NOT CHANGED FROM V1
        % We choose the right direction

    if pressure_inside_flag == 1    % The pressure goes in other direction
        norm_vector = -norm_vector;
    end

    % We now need to scale the vectors

    for i = 1:1:len
        alfa = pressure_norm/sqrt(norm_vector(i)^2+norm_vector(len+i)^2);
        length = find_length([X(i); X(i+1)], [Y(i);Y(i+1)]);
        norm_vector(i) = alfa*norm_vector(i)*length;
        norm_vector(len+i) = alfa*norm_vector(len+i)*length;
    end
    % alfa = pressure_norm/norm(norm_vector)
    % norm_vector = alfa*norm_vector;
    %S = find_pressure_norm(P(1:len),P((len+1):(2*len)));

    
end