function y = my_VSSalpha(omegavals,m,molar,Tvals,difvals,diams)
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
rhoD = molar*difvals./(Na*kb*Tvals);
% disp(molar)
% disp('rhoD')
% disp(rhoD)
% disp('diams')
% disp(diams)
% test_y = 4*(5-2*omegavals).*rhoD.*(diams.^2)./(3*sqrt(m*kb*Tvals/pi));
% %disp(test_y)
% disp('omegas')
% disp(omegavals)
y = ((4*(5-2*omegavals).*rhoD.*(diams.^2))./(3*sqrt(m*kb*Tvals/pi))) - 1;
end
