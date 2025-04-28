function y = my_VSSdiameter(alphavals,omegavals,m,Tvals,muvals)
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
%disp(omegavals)
kb = 1.380649E-23; %J/K
%kb = 8.617333262E-5; %eV/K
y2 = ((5*(alphavals+1).*(alphavals+2).*sqrt(m*kb*Tvals/pi))./...
    (4*alphavals.*(5-2*omegavals).*(7-2*omegavals).*muvals)); % meters
%disp(y2)
y = sqrt(y2);
end
