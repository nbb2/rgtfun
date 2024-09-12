function y = my_coulombchar(z1)
%MY_COULOMBCHAR    Outputs character array with fitting model.
%   Y=MY_COULOMBCHAR(Z1) generates a char array containing
%   the Coulomb potential equation with the user-specified Z1.
%
%   -- Z1 must be the integer atomic number of species 1.
%
%   See also RUN_FITPOTENTIAL
    eps_naught = 0.005526349406; %e^2 * eV^-1 * Angstrom^-1
    Ke = 1/(4*pi*eps_naught);
    y = sprintf("(%d)*%i*z2./x",Ke,z1);
end