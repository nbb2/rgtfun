function y = my_distclose(z1,z2,b,E)
%MY_DISTCLOSE    Outputs distance of closest approach.
%   Y=MY_DISTCLOSE(Z1,Z2,B,E) generates a float array containing an 
%   impact parameter value for each scattering angle using the 
%   Rutherford scattering model. Units of distance of closest approach 
%   are Angstroms.
%
%   -- Z1 must be the integer atomic number of species 1.
%   -- Z2 must be the integer atomic number of species 2.
%   -- B must be the float array containing impact parameter values in
%   units of Angstroms.
%   -- E must be the incident energy as numeric char in units of eV.
%
%   See also RUN_SCATTERINGINTEGRALS
    eps_naught = 0.005526349406; %e^2 * eV^-1 * Angstrom^-1
    Ke = 1/(4*pi*eps_naught);
    gamma = (Ke*z1*z2*(2*z1 + 2*z2))/(2*z2*E);
    y = 0.5*(gamma+sqrt(gamma^2 + 4*(b.^2)));
end