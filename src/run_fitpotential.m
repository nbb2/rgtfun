function y = run_fitpotential(directory)
%RUN_FITPOTENTIAL    Reads fitting input file and generates cfit object.
%   RUN_FITPOTENTIAL(DIRECTORY) reads the user-specified fitting parameters
%   from the fitting input file, creates a fittype based off of those
%   parameters using the MY_COULOMBCHAR function, and then creates a fit
%   object using the FIT function.
%
%   -- DIRECTORY must specify the path to where potential data file is.
%
%   See also MY_COULOMBCHAR FIT FITTYPE
    run([directory '/fitinputfile.m']);
    ft = fittype(my_coulombchar(Z1),dependent="y",independent="x",...
        coefficients="z2");
    datalocation = [directory '/coulomb_data.csv'];
    t = readmatrix(datalocation);
    xvals = nonzeros(t(:,1).*((minR <= t(:,1)) & (t(:,1) <= maxR)));
    yvals = nonzeros(t(:,2).*((minR <= t(:,1)) & (t(:,1) <= maxR)));
    y = fit(xvals,yvals,ft,'Exclude',(xvals<minR)&(xvals>maxR),'TolFun',...
        tol,'Lower',minZ2,'Upper',maxZ2);
end