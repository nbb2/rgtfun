function y = zblderivative(z1,z2,r)
%ZBLDERIVATIVE    Outputs the derivative of a ZBL potential.
%   Y=ZBLDERIVATIVE(Z1,Z2,R) generates a float array containing
%   the derivative of the potential energy for each r value using the ZBL potential.
%   Units of potential energy are eV.
%
%   -- Z1 must be the integer atomic number of species 1.
%   -- Z2 must be the integer atomic number of species 2.
%   -- R must be the numerical array containing r values in units of 
%   Angstrom.
%
%   See also RUN_CALCPOTENTIAL
    eps_naught = 0.005526349406; %e^2 * eV^-1 * Angstrom^-1
    k = 1/(4*pi*eps_naught);
    a = (0.46850)/(z1^(0.23) + z2^(0.23));
    y = (-k*z1*z2./(r.^2))*(0.18175*exp(-3.19980*r/a) + 0.50986*exp(-0.94229*r/a) + ...
        0.28022*exp(-0.40290*r/a) + 0.02817*exp(-0.20162*r/a)) + ...
        (k*z1*z2./(r*a))*((0.18175*-3.19980)*exp(-3.19980*r/a) + (0.50986*-0.94229)*exp(-0.94229*r/a) + ...
        (0.28022*-0.40290)*exp(-0.40290*r/a) + (0.02817*-0.20162)*exp(-0.20162*r/a));
end

