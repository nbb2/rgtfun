function th = my_GMquadScatteringAngle(V,Ec,b,rm,n)
%MY_GMQUADSCATTERINGANGLE    Outputs float scattering angle.
%   Y=MY_GMQUADSCATTERINGANGLE(V,EC,B,RM,N) generates a float value for the
%   scattering angle. 
%
%   -- V must be the potential function handle.
%   -- EC must be the the energy in eV.
%   -- B must be the impact paramter in Angstrom.
%   -- RM is the distance of closest approach in Angstrom.
%   -- N is the number of trapezoids to use.
%
%   See also MY_DOCAROOT RUN_SCATTERINGINTEGRALS
    sum = 0;
    for j = 1:(n/2)
        anj = cos(((2*((n/2) - j + 1) - 1)/(2*n))*pi);
        aj = cos(((2*j - 1)/(2*n))*pi);
        gj = (   1 - (V(rm/aj)/Ec) - ((b^2 * aj^2)/(rm^2)))^(-1/2);
        sum = sum + (anj * gj); 
    end
    th = pi * (1 - ((2*b*sum)/(n*rm)));
end