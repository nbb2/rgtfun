function y = VSScoef2(minT, maxT, Tfine, vq, m, omega, P, tol)
    %MY_NUMVISCCOEF   Outputs float array with viscosity coefficient values.
    %   Y=MY_NUMVISCCOEF(TVALS,M1,M2,CSDATAFILE) generates a float array containing viscosity 
    %   coefficient value for each value of Tvals. 
    %
    % Constants
    kb = 1.380649E-23; % Boltzmann constant, J/K
    pi_val = pi;  % Use pi as a variable
    gamma_val = gamma(3.5 - omega);  % Gamma function value
    cref = 2 * (2.5 - omega) * kb * (0.5 * (minT + maxT)) / m;  % Calculate cref

    % Filter data within the specified temperature range
    excludeT = ((Tfine < minT) | (Tfine > maxT));
    fitcoef = vq(~excludeT);
    fitT = Tfine(~excludeT);

    % Pre-compute terms to simplify the fitting formula
    term1 = 3 * pi_val^(1/2) * (2 * pi_val * kb / m)^omega * kb;
    term2 = 16 * pi_val * P * gamma_val * cref^(2 * omega - 1);

    % Define the fitting function character string with the simplified terms
    fitchar = sprintf('%e * (a + 1) * T^(%f - 1) / (a * d^2 * %e)', ...
                      term1, omega, term2);

    % Display the fitchar string for debugging purposes

    % Create the fittype
    ft = fittype(fitchar, 'dependent', 'y', 'independent', 'T', 'coefficients', {'a', 'd'});

    % Perform the fit
    coeffit = fit(fitT', fitcoef', ft, 'TolFun', tol);

    % Extract and display coefficients
    coefs = coeffvalues(coeffit);
    alpha = coefs(1);
    d = coefs(2);
    
    % Output the fit results
    y = [alpha, d];
end