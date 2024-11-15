function y = my_diffusioncs(beta)
%MY_DIFFUSIONCS    Outputs float array with diffusion cross-section values.
%   Y=MY_DIFFUSIONCS(BETA) generates a float array containing diffusion 
%   cros-section value for each value of the scattering parameter beta
%   using a Lennard_Jones potential. 
%
%   -- BETA must be a float array containing values for the dimensionless
%   scattering parameter.
%
%   See also MY_VISCOSITYCS RUN_TRANSPORTCS
fLEd = 1 - 0.019.*(beta.^(-1)) + 0.038.*(beta.^(-2)) - 0.049.*(beta.^(-3)) ...
    + 0.015.*(beta.^(-4));
fHEd = 1 - 0.692.*(beta) + 9.594.*(beta.^(2)) - 8.284.*(beta.^(3)) ...
    - 2.355.*(beta.^(4));

y = zeros(size(beta));
%%Case 1: beta < 0.506
idx1 = beta < 0.506;
y(idx1) = 4.507.*(beta(idx1).^(1/6)).*fHEd(idx1);

%%Case 2: beta > 0.506
idx2 = beta > 0.506;
y(idx2) = 9.866.*(beta(idx2).^(1/3)).*fLEd(idx2);
end



