% In first version we won't use integrals

function F = find_pressure_norm(s, n, pressure)
    ds = s/n;   % Average of length
    F = pressure*ds;
end