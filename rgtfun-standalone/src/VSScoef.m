function y = VSScoef(minT,maxT,Tfine,vq,m,omega,P,tol)
%VSSCOEF  Outputs VSS params alpha and d.
%   Y=VSSCOEF(MINT,MAXT,TFINE,VQ,M,OMEGA,P,TOL) outputs VSS parameters 
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
kb = 8.617333262E-5; %eV/K
excludeT = ((Tfine < minT) | (Tfine > maxT));
fitcoef = vq;
fitT = Tfine;
fitT(excludeT) = [];
fitcoef(excludeT) = [];
T_sample = 0.5*(minT + maxT);
cref = 2*(2.5-omega)*kb*T_sample/m;
fitchar = sprintf("157377.3718*30000*(a+1)*(pi^0.5)*((%e)*T).*((pi*2*(%e)*T/(%e)).^(%e))/(16*a*gamma(3.5-%e)*(%e)*pi*(d^2)*(%e)^((%e) - 1/2))",...
    kb,kb,m,omega,omega,P,cref,omega);
ft = fittype(fitchar,dependent="y",...
        independent="T",coefficients=["a" "d"]);
coeffit = fit(fitT',fitcoef',ft,'TolFun',tol,'Lower',[0 0],...
                    'Upper',[10 10],'StartPoint',[1 1]);
coefs = coeffvalues(coeffit);
alpha = coefs(1);
d = coefs(2);
y = [alpha,d];
end