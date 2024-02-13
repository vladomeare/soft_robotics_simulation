% In first version we won't use integrals

function F = find_pressure_norm(s, n, p)
    ds = s/n;   % Average of length
    F = p*ds;
end