function y = my_VSSdiffusion(T,omega,a,d,m,P,T_sample)
%MY_VSSDIFFUSION  Outputs float array with diffusion coefficient values.
%   Y=MY_VSSDIFFUSION(T,OMEGA,A,D,M,P,T_SAMPLE) generates a float array 
%   containing diffusion coefficient value for each value of T using the 
%   VSS model. 
%
%   -- T must be a float array of temperature values in K.
%   -- OMEGA must be the VHS parameter.
%   -- A must be the alpha VSS parameter.
%   -- D must be the d VSS parameter.
%   -- M must be the reduced mass in amu.
%   -- P must be the pressure in bar.
%   -- T_SAMPLE must be the reference temp in K.
%
%   See also RUN_DSMCCOEF
%kb = 1.380649E-23; %J/K
kb = 8.617333262E-5; %eV/K
cref = 2*(2.5-omega)*kb*T_sample/m;
fprintf('cref is %f\n',cref)
y = 157377.3718*30000*(a+1)*(pi^0.5)*(kb*T).*((pi*2*kb*T/m).^omega)/(16*a*gamma(3.5-omega)*...
    P*pi*(d^2)*(cref)^(omega - 0.5));
end

