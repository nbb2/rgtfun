function y = my_numvisccs(scatterdatafile)
%MY_NUMVISCCS    Outputs viscosity cross-section value.
%   Y=MY_NUMVISCCS(SCATTERDATAFILE) generates a viscosity cross-section 
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
difcsintegrand = 2*pi*(1-cos(th).^2).*bvals;
y = trapz(bvals,difcsintegrand);
end