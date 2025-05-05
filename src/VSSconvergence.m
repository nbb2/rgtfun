function y = VSSconvergence(alphavals,omegavals,m,Tvals,difvals,muref,tol)
%VSSCONVERGENCE  Checks least squares convergence of VSS parameters.
%   Y=VSSCONVERGENCE(ALPHAVALS,OMEGAVALS,M,TVALS,DIFVALS,MUREF,TOL) outputs
%   TRUE or FALSE depending on if the user-specified least-squares
%   tolerance is satisfied.
%
%   -- ALPHAVALS must be an array of the alpha values at each reference temperature.
%   -- OMEGAVALS must be an array of the omega values at each reference
%   temperature.
%   -- M must be the mass of a particle in kg.
%   -- TVALS must be an array of the reference temperature values in K.
%   -- DIFVALS must be an array of the reference diffusion coefficient data.
%   -- MUREF must be an array of the reference viscosity coefficient data.
%   -- TOL must be the user-specified least squares tolerance.
%   See also RUN_VSSCOEF
kb = 1.380649E-23; %J/K
Na = 6.022E23;
rhoD = m*difvals./(Na*kb*Tvals);
muvals = ((10./alphavals)+5).*rhoD./(21-6*omegavals);
Sc = rhoD./muref; %Schmidt number
LSerror = sum((muvals - muref).^2);
y = (LSerror > tol);
end
