function y = zbl(z1,z2,r)
%ZBL    Outputs ZBL potential data.
%   Y=ZBL(Z1,Z2,R) generates a float array containing
%   a potential energy value for each r value using the ZBL potential.
%   Units of potential energy are eV.
%
%   -- Z1 must be the integer atomic number of species 1.
%   -- Z2 must be the integer atomic number of species 2.
%   -- R must be the numerical array containing r values in units of 
%   Angstrom.
%
%   See also RUN_CALCPOTENTIAL
    eps_naught = 0.005526349406; %e^2 * eV^-1 * Angstrom^-1
    Ke = 4*pi*eps_naught;
    a = (0.46850)/(z1^(0.23) + z2^(0.23));
    y = phi(r/a).*z1*z2./(Ke.*r);
end

function y = phi(x)
    y = 0.18175*exp(-3.19980*x) + 0.50986*exp(-0.94229*x) + ...
        0.28022*exp(-0.40290*x) + 0.02817*exp(-0.20162*x);
end