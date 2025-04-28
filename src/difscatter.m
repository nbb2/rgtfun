function y = my_difscatter(z1,z2,theta,E)
%MY_DIFSCATTER    Outputs differential scattering cross section.
%   Y=MY_DIFSCATTER(Z1,Z2,THETA,E) generates a float array containing
%   a differential scattering cross section value for each scattering 
%   angle using the Rutherford scattering model. Units of differential 
%   scattering cross section are Angstrom^2 / sr.
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
    y = (z1*z2./(4*Ke*E.*sin(theta/2).^2)).^2;
end