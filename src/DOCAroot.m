function r0 = DOCAroot(Ec,b,V,rmin,rmax,chebfunpath)
%#function doca   % ensure doca.m is included in the compiled app
%DOCAROOT    Outputs float value for the root of the DOCA equation.
%   Y=DOCAROOT(EC,B,V,RMIN,RMAX) generates a float value for the root
%   of the distance of closest approach (DOCA) equation using two 
%   iterations of the CHEBFUN root finding package. 
%
%   -- EC must be the the energy in eV.
%   -- B must be the impact paramter in Angstrom.
%   -- V must be the potential function handle.
%   -- RMIN is the lower bound of possible root values in Angstrom.
%   -- RMAX is the upper bound of possble root values in Angstrom.
%
%   See also GMQUADSCATTERINGANGLE RUN_SCATTERINGINTEGRALS
    %addpath(chebfunpath)
    chebDOCA = chebfun(@(r) doca(r,Ec,b,V),[rmin,rmax]);
    ri = max(roots(chebDOCA));
    chebDOCA2 = chebfun(@(r) doca(r,Ec,b,V),[0.9*ri,1.1*ri]);
    r0 = max(roots(chebDOCA2));

end

function d = doca(r,Ec,b,V)
%MY_DOCA Ouputs the DOCA equation.
%   Y=MY_DOCA(R,EC,B,V) generates the DOCA equation.
%   -- R is a placeholder value for distance.
%   -- EC must be the energy in eV.
%   -- B must be the impact parameter in Angstrom.
%   -- V is the potential function handle.
%
%   See also DOCAROOT
    d = r^2 - ((r^2)*V(r)/Ec) - (b^2);
end