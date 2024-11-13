function y = my_numstoppingcs(E,m1,m2,diffusioncs)
%MY_DIFFUSIONCS    Outputs float array with diffusion cross-section values.
%   Y=MY_DIFFUSIONCS(BETA) generates a float array containing diffusion 
%   cros-section value for each value of the scattering parameter beta
%   using a Lennard_Jones potential. 
%

%   -- BETA must be a float array containing values for the dimensionless
%   scattering parameter.
%
%   See also MY_DIFFUSIONCOEF RUN_TRANSPORTCS

y = 2*(m1*m2/(m1+m2)^2)*E*diffusioncs;




end


