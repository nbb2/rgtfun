function y = powerlaw(a,k,r)
%POWERLAW    Outputs power law potential data.
%   Y=POWERLAW(A,K,R) generates a float array containing a potential 
%   energy value for each r value using the basic power law potential.
%   Units of potential energy are eV.
%
%   -- A is the first power law coefficient.
%   -- K is the exponent power law coefficient.
%   -- R must be the numerical array containing r values in units of 
%   Angstrom.
%
%   See also RUN_CALCPOTENTIAL
    y = a*r.^(-k);
end