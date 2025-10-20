function y = VSSdiameter(alphavals,omegavals,m,Tvals,muvals)
%VSSDIAMETER  Outputs VSS collision diameter.
%   Y=VSSDIAMETER(ALPHAVALS,OMEGAVALS,M,TVALS,MUVALS) outputs VSS collision  
%   diamater using reference viscosity coefficient and VHS parameter data. 
%
%   -- ALPHAVALS must be an array of the alpha values at each reference temperature.
%   -- OMEGAVALS must be an array of reference omega values.
%   -- M must be the mass of a particle in kg.
%   -- TVALS must be an array of the reference temperature values in K.
%   -- MUVALS must be an array of the reference viscosity coefficient data.
%
%   See also RUN_VSSCOEF
kb = 1.380649E-23; %J/K
y2 = ((5*(alphavals+1).*(alphavals+2).*sqrt(2*m*kb*Tvals/pi))./...
    (4*alphavals.*(5-2*omegavals).*(7-2*omegavals).*muvals)); % meters
y = sqrt(y2);
end
