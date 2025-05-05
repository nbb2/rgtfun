function y = coulomb(z1,z2,r)
%COULOMB    Outputs Coulomb  potential data.
%   Y=COULOMB(Z1,Z2,R) generates a float array containing
%   a potential energy value for each r value using the Coulomb potential.
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
    y = z1*z2./(Ke.*r);
end

