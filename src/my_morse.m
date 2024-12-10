function y = my_morse(rm,eps_well,k,r)
%MY_MORSE    Outputs MORSE potential data.
%   Y=MY_MORSE(RM,EPS_WELL,K,R) generates a float array containing
%   a potential energy value for each r value using the Morse potential. 
%   Units of potential energy are eV.
%
%   -- RM must be the float distance at which the potential is at a minimum.
%   -- EPS_WELL must be the float Morse well depth.
%   -- K must be the force constant at the well minimum in units of eV/Angstrom^2.
%   -- R must be the numerical array containing r values in units of 
%   Angstrom.
%
%   See also RUN_CALCPOTENTIAL
    a  = sqrt(k/(2*eps_well));
    y = eps_well*(exp(-2*a.*(r-rm))-2*exp(-a.*(r-rm)));
end