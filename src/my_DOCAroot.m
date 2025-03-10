function r0 = my_DOCAroot(Ec,b,V,rmin,rmax)
%MY_DOCAROOT    Outputs float value for the root of the DOCA equation.
%   Y=MY_DOCAROOT(EC,B,V,RMIN,RMAX) generates a float value for the root
%   of the distance of closest approach (DOCA) equation using two 
%   iterations of the CHEBFUN root finding package. 
%
%   -- EC must be the the energy in eV.
%   -- B must be the impact paramter in Angstrom.
%   -- V must be the potential function handle.
%   -- RMIN is the lower bound of possible root values in Angstrom.
%   -- RMAX is the upper bound of possble root values in Angstrom.
%
%   See also MY_GMQUADSCATTERINGANGLE RUN_SCATTERINGINTEGRALS
    %addpath('../src/chebfun');
    chebDOCA = chebfun(@(r) my_doca(r,Ec,b,V),[rmin,rmax]);
    ri = max(roots(chebDOCA));
    chebDOCA2 = chebfun(@(r) my_doca(r,Ec,b,V),[0.9*ri,1.1*ri]);
    r0 = max(roots(chebDOCA2));
    %disp(ri)
    %fplot(@(r) my_doca(r, Ec, b, V), [0.001, 2000])

end

function doca = my_doca(r,Ec,b,V)
%MY_DOCA Ouputs the DOCA equation.
%   Y=MY_DOCA(R,EC,B,V) generates the DOCA equation.
%   -- R is a placeholder value for distance.
%   -- EC must be the energy in eV.
%   -- B must be the impact parameter in Angstrom.
%   -- V is the potential function handle.
%
%   See also MY_DOCAROOT
    doca = r^2 - ((r^2)*V(r)/Ec) - (b^2);
end