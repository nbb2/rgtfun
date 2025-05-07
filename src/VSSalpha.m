function y = VSSalpha(omegavals,m,molar,Tvals,difvals,diams)
%VSSALPHA  Outputs VSS param alpha.
%   Y=VSSALPHA(OMEGAVALS,M,MOLAR,TVALS,DIFVALS,DIAMS) outputs VSS parameter 
%   alpha using reference diffusion coefficient and collision diameter data. 
%
%   -- OMEGAVALS must be an array of reference omega values.
%   -- M must be the mass of a particle in kg.
%   -- MOLAR must be the molar mass in kg.
%   -- TVALS must be an array of the reference temperature values in K.
%   -- DIFVALS must be an array of the reference diffusion coefficient data.
%   -- DIAMS must be an array of the reference collision diameteres in angstrom.
%
%   See also RUN_VSSCOEF
kb = 1.380649E-23; %J/K
Na = 6.022E23;
rhoD = molar*difvals./(Na*kb*Tvals);
y = ((2*4*(5-2*omegavals).*rhoD.*(diams.^2))./(3*sqrt(2*m*kb*Tvals/pi))) - 1;
end
