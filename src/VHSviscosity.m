function y = VHSviscosity(T,omega,T_ref,mu_ref)
%VHSVISCOSITY  Outputs float array with viscosity coefficient values.
%   Y=VHSVISCOSITY(T,OMEGA,T_REF,MU_REF) generates a float array 
%   containing viscosity coefficient value for each value of T using the 
%   VHS model. 
%
%   -- T must be a float array of temperature values in K.
%   -- OMEGA must be the VHS parameter.
%   -- T_REF must be the reference temp in K.
%   -- MU_REF must be the reference viscosity value.
%
%   See also RUN_DSMCCOEF
y = mu_ref*(T/T_ref).^omega;
end