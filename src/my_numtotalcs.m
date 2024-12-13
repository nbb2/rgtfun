function y = my_numtotalcs(th_max,bvals,th)
%MY_NUMTOTALCS    Outputs total cross-section value.
%   Y=MY_NUMTOTALCS(SCATTERDATAFILE) generates a total cross-section value
%   for a specific energy by finding the intersection of TH_MAX and the 
%   scattering angle vs impact parameter curve. 
%
%   -- TH_MAX must be the angle in radians used to determine total CS.
%   -- SCATTERDATAFILE must be the filepath to the scattering angle vs 
%   impact para data.
%
%   See also RUN_TRANSPORTCS 

bfine = min(bvals):0.00001:max(bvals);
th_p = th - th_max;
%disp(th_max)
vqth = interp1(bvals,th_p,bfine);
bmax = max(data_zeros(bfine,vqth));
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
    x0 = x0(~isnan(x0));
end