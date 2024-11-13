function y = my_VHScoef(fitT,T_sample,excludeT,vq,tol)
%MY_NUMVISCCOEF   Outputs float array with viscosity coefficient values.
%   Y=MY_NUMVISCCOEF(TVALS,M1,M2,CSDATAFILE) generates a float array containing viscosity 
%   coefficient value for each value of Tvals. 
%

%   -- DATAFILE must be location of viscosity cross section data file.
%
%   See also MY_NUMDIFFUSIONCOEF RUN_TRANSPORTCS
fitcoef = vq;
fitcoef(excludeT) = [];
mu_sample = mean(fitcoef);
fitchar = sprintf("(%f)*(T/(%f)).^(a)",mu_sample,T_sample);
ft = fittype(fitchar,dependent="y",...
        independent="T",coefficients="a");
coeffit = fit(fitT',fitcoef',ft,'TolFun',tol);
omega = coeffvalues(coeffit);
y = [mu_sample,omega];
end



