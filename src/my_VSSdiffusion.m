function y = my_VSSdiffusion(T,omega,a,d,m,P,T_sample)
%MY_NUMVISCCOEF   Outputs float array with viscosity coefficient values.
%   Y=MY_NUMVISCCOEF(TVALS,M1,M2,CSDATAFILE) generates a float array containing viscosity 
%   coefficient value for each value of Tvals. 
%

%   -- DATAFILE must be location of viscosity cross section data file.
%
%   See also MY_NUMDIFFUSIONCOEF RUN_TRANSPORTCS
%kb = 1.380649E-23; %J/K
kb = 8.617333262E-5; %eV/K
cref = 2*(2.5-omega)*kb*T_sample/m;
fprintf('cref is %f\n',cref)
y = 157081.8*30000*(a+1)*(pi^0.5)*(kb*T).*((pi*2*kb*T/m).^omega)/(16*a*gamma(3.5-omega)*...
    P*pi*(d^2)*(cref)^(omega - 0.5));
end

