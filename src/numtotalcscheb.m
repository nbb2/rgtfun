function y = numtotalcscheb(th_max,bvals,th)
%NUMTOTALCSCHEB    Outputs total cross-section value.
%   Y=NUMTOTALCSCHEB(SCATTERDATAFILE) generates a total cross-section value
%   for a specific energy by finding the intersection of TH_MAX and the 
%   scattering angle vs impact parameter curve using Chebfun rootfinding. 
%
%   -- TH_MAX must be the angle in radians used to determine total CS.
%   -- SCATTERDATAFILE must be the filepath to the scattering angle vs 
%   impact para data.
%
%   See also RUN_TRANSPORTCS 
%addpath('../src/chebfun');
%bfine = min(bvals):0.00001:max(bvals);
th_p = th - th_max;
%disp(th_max)
p = spline(bvals,th_p);
poly = @(r) ppval(p,r);
chebtotalcs = chebfun(poly,[min(bvals),max(bvals)]);
bmax = max(roots(chebtotalcs));
y = pi*bmax^2;
end