function y = my_VHSviscosity(T,omega,T_ref,mu_ref)
%MY_NUMVISCCOEF   Outputs float array with viscosity coefficient values.
%   Y=MY_NUMVISCCOEF(TVALS,M1,M2,CSDATAFILE) generates a float array containing viscosity 
%   coefficient value for each value of Tvals. 
%

%   -- DATAFILE must be location of viscosity cross section data file.
%
%   See also MY_NUMDIFFUSIONCOEF RUN_TRANSPORTCS
y = mu_ref*(T/T_ref).^omega;
end