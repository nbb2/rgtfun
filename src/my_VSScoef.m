function y = my_VSScoef(minT,maxT,Tfine,vq,m,omega,P,tol)
%MY_NUMVISCCOEF   Outputs float array with viscosity coefficient values.
%   Y=MY_NUMVISCCOEF(TVALS,M1,M2,CSDATAFILE) generates a float array containing viscosity 
%   coefficient value for each value of Tvals. 
%

%   -- DATAFILE must be location of viscosity cross section data file.
%
%   See also MY_NUMDIFFUSIONCOEF RUN_TRANSPORTCS
%kb = 1.380649E-23; %J/K
kb = 8.617333262E-5; %eV/K
excludeT = ((Tfine < minT) | (Tfine > maxT));
fitcoef = vq;
fitT = Tfine;
fitT(excludeT) = [];
fitcoef(excludeT) = [];
T_sample = 0.5*(minT + maxT);
cref = 2*(2.5-omega)*kb*T_sample/m;
fitchar = sprintf("157081.8*30000*(a+1)*(pi^0.5)*((%e)*T).*((pi*2*(%e)*T/(%e)).^(%e))/(16*a*gamma(3.5-%e)*(%e)*pi*(d^2)*(%e)^((%e) - 1/2))",...
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