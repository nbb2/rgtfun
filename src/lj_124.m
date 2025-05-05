function y = lj_124(eps_well,sig,r)
%LJ_124    Outputs Lennard Jones potential data.
%   Y=LJ_124(EPS_WELL,SIG,R) generates a float array containing
%   a potential energy value for each r value using the 12-4 Lennard Jones
%   potential. Units of potential energy are eV.
%
%   -- EPS_WELL must be the float LJ well depth.
%   -- SIGMA must be the float distance at which the potential is zero.
%   -- R must be the numerical array containing r values in units of 
%   Angstrom.
%
%   See also RUN_CALCPOTENTIAL
    y = (0.5)*(3^1.5)*eps_well*(((sig./r).^12)-((sig./r).^4));
end