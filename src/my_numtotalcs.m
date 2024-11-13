function y = my_numtotalcs(th_max,scatterdatafile)
%MY_DIFFUSIONCS    Outputs float array with diffusion cross-section values.
%   Y=MY_DIFFUSIONCS(BETA) generates a float array containing diffusion 
%   cros-section value for each value of the scattering parameter beta
%   using a Lennard_Jones potential. 
%


%   -- BETA must be a float array containing values for the dimensionless
%   scattering parameter.
%
%   See also MY_DIFFUSIONCOEF RUN_TRANSPORTCS
scatterdata = readmatrix(scatterdatafile);
th = scatterdata(:,2);
bvals = scatterdata(:,1);
bfine = min(bvals):0.00001:max(bvals);
th_p = th - th_max;
vqth = interp1(bvals,th_p,bfine);
bmax = max(data_zeros(bfine,vqth));
disp(bmax)

y = pi*bmax^2;
end

function x0 = data_zeros(x, y)
    % Identify indices where there is a sign change between consecutive elements
    zero_crossings = find((y(1:end-1) .* y(2:end)) <= 0);

    % Preallocate for the zero-crossing points
    x0 = NaN(length(zero_crossings), 1);

    % Loop through each detected zero-crossing for interpolation
    for k = 1:length(zero_crossings)
        % Indices for interpolation points
        idx1 = zero_crossings(k);
        idx2 = idx1 + 1;

        % Linear interpolation between the points around zero-crossing
        b = [1, x(idx1); 1, x(idx2)] \ [y(idx1); y(idx2)];
        x0(k) = -b(1) / b(2); % Solving for x at y = 0
    end
end