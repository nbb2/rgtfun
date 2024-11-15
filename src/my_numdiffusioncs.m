function y = my_numdiffusioncs(scatterdatafile)
%MY_NUMDIFFUSIONCS    Outputs diffusion cross-section value.
%   Y=MY_NUMDIFFUSIONCS(SCATTERDATAFILE) generates diffusion cross-section
%   value by integrating scattering angle vs impact param data for a 
%   specific energy using TRAPZ. 
%
%   -- SCATTERDATAFILE must be the filepath to the scattering angle vs 
%   impact para data.
%
%   See also RUN_TRANSPORTCS 
scatterdata = readmatrix(scatterdatafile);
th = scatterdata(:,2);
bvals = scatterdata(:,1);
difcsintegrand = 2*pi*(1-cos(th)).*bvals;
y = trapz(bvals,difcsintegrand);
end
