function y = my_impact(z1,z2,theta,E)
%MY_IMPACT    Outputs impact parameter.
%   Y=MY_IMPACT(Z1,Z2,THETA,E) generates a float array containing an 
%   impact parameter value for each scattering angle using the 
%   Rutherford scattering model. Units of impact parameter are Angstrom.
%
%   -- Z1 must be the integer atomic number of species 1.
%   -- Z2 must be the integer atomic number of species 2.
%   -- THETA must be the float array containing scattering angle values in
%   units of radians.
%   -- E must be the incident energy as numeric char in units of eV.
%
%   See also RUN_SCATTERINGINTEGRALS
    eps_naught = 0.005526349406; %e^2 * eV^-1 * Angstrom^-1
    Ke = 4*pi*eps_naught;
    y = z1*z2.*cot(theta/2)./(2*Ke*E);
end