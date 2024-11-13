mfunction y = my_numdiffusioncs(scatterdatafile)
%MY_DIFFUSIONCS    Outputs float array with diffusion cross-section values.
%   Y=MY_DIFFUSIONCS(BETA) generates a float array containing diffusion 
%   cros-section value for each value of the scattering parameter beta
%   using a Lennard_Jones potential. 
%


%   -- BETA must be a float array containing values for the dimensionless
%   scattering parameter.
%
%   See also MY_DIFFUSIONCOEF RUN_TRANSPORTCS
scatterdata = readmatrix(scatterdatafile);
th = scatterdata(:,2);
bvals = scatterdata(:,1);
difcsintegrand = 2*pi*(1-cos(th)).*bvals;
y = trapz(bvals,difcsintegrand);
end
