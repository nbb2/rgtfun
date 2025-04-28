function y = my_VSSconvergence(alphavals,omegavals,m,Tvals,difvals,muref,tol)
%MY_VSSCOEF  Outputs VSS params alpha and d.
%   Y=MY_VSSCOEF(MINT,MAXT,TFINE,VQ,M,OMEGA,P,TOL) outputs VSS parameters 
%   alpha and d by fitting the VSS model to user-specified diffusin 
%   coefficient data. 
%


%   -- MINT must be the lower bound of the temp range in K.
%   -- MAXT mut be the upper bound of the temp range in K.
%   -- TFINE must be the interpolated temperature values in K.
%   -- VQ must be the interpolated diffusion coefficient values with the
%   same dimension as TFINE.
%   -- M must be the reduced mass of the system in amu.
%   -- OMEGA must be the VHS param.
%   -- TOL must be the fitting tolerance.
%
%   See also RUN_DSMCCOEF
kb = 1.380649E-23; %J/K
%kb = 8.617333262E-5; %eV/K
Na = 6.022E23;
rhoD = m*difvals./(Na*kb*Tvals);
muvals = ((10./alphavals)+5).*rhoD./(21-6*omegavals);
Sc = rhoD./muref;
%disp('Tvals Sc muvals muref')
%disp([Tvals Sc muvals*(1E6) muref*(1E6)])
% disp(sum((muvals - muref).^2))
LSerror = sum((muvals - muref).^2);
%disp(LSerror)
%fprintf('least squares error is %e \n',LSerror)
y = (LSerror > tol);
end
