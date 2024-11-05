function y = my_viscositycs(beta)
%MY_VISCOSITYCS    Outputs float array with viscosity cross-section values.
%   Y=MY_VISCOSITYCS(BETA) generates a float array containing viscosity 
%   cros-section value for each value of the scattering parameter beta
%   using a Lennard_Jones potential. 
%
%   -- BETA must be a float array containing values for the dimensionless
%   scattering parameter.
%
%   See also MY_VISCCOEF RUN_TRANSPORTCS
fLEeta = 1;
fHEeta = 1 - 2.229.*(beta) + 35.967.*(beta.^(2)) - 86.490.*(beta.^(3)) ...
    + 60.335.*(beta.^(4));

y = zeros(size(beta));
%%Case 1: beta < 0.491
idx1 = beta < 0.491;
y(idx1) = 3.599.*(beta(idx1).^(1/6)).*fHEeta(idx1);

%%Case 2: beta > 0.491
idx2 = beta > 0.491;
y(idx2) = 7.480.*(beta(idx2).^(1/3))*fLEeta;
end