function y = my_126lj(eps_well,sig,r)
%MY_LJ    Outputs Lennard Jones potential data.
%   Y=MY_LJ(EPS_WELL,SIG,R) generates a float array containing
%   a potential energy value for each r value using the 12-6 Lennard Jones
%   potential. Units of potential energy are eV.
%
%   -- EPS_WELL must be the float LJ well depth.
%   -- SIGMA must be the float distance at which the potential is zero.
%   -- R must be the numerical array containing r values in units of 
%   Angstrom.
%
%   See also RUN_CALCPOTENTIAL
    y = 4*eps_well*(((sig./r).^12)-((sig./r).^6));
end