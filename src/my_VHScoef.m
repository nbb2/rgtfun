function y = my_VHScoef(fitT,T_sample,excludeT,vq,tol)
%MY_VHSCOEF  Outputs sample visc value and VHS param.
%   Y=MY_VHSCOEF(FITT,T_SAMPLE,EXCLUDET,VQ,TOL) outputs a reference
%   viscosity value and VHS parameter omega by fitting the VHS model to 
%   user-specified visocity coefficient data. 
%
%   -- FITT must be the interpolated temperature values in K.
%   -- T_SAMPLE must be the reference temperature value.
%   -- EXCLUDET must be a logical array of what temp values to use.
%   -- VQ must be the interpolated viscosity coefficient values with the
%   same dimension as FITT.
%   -- TOL must be the fitting tolerance.
%
%   See also RUN_DSMCCOEF
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



