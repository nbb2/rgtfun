function y = my_zblchar(z1)
%MY_ZBLCHAR    Outputs character array with fitting model.
%   Y=MY_ZBLCHAR(Z1) generates a char array containing the ZBL potential 
%   equation with the user-specified Z1.
%
%   -- Z1 must be the integer atomic number of species 1.
%
%   See also RUN_FITPOTENTIAL
    eps_naught = 0.005526349406; %e^2 * eV^-1 * Angstrom^-1
    Ke = 1/(4*pi*eps_naught);
    a = sprintf('(0.46850)/((%i)^(0.23) + z2^(0.23))',z1);
    phi1 = sprintf('0.18175*exp(-3.19980*x/(%s)) + 0.50986*exp(-0.94229*x/(%s))',a,a); 
    phi2 = sprintf('0.28022*exp(-0.40290*x/(%s)) + 0.02817*exp(-0.20162*x/(%s))',a,a);
    phi = [phi1 '+' phi2];
    y = sprintf("(%d)*(%s)*%i*z2./x",Ke,phi,z1);
end

