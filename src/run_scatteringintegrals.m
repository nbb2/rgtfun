function y = run_scatteringintegrals(directory)
%RUN_FITPOTENTIAL    Reads fitting input file and generates cfit object.
%   RUN_FITPOTENTIAL(DIRECTORY) reads the user-specified fitting parameters
%   from the fitting input file, creates a fittype based off of those
%   parameters using the MY_COULOMBCHAR function, and then creates a fit
%   object using the FIT function.
%



%   -- DIRECTORY must specify the path to where potential data file is.
%
%   See also MY_COULOMBCHAR FIT FITTYPE
    run([directory '/scatterintinputfile.m']);
    theta = theta_min:0.001:theta_max;
    difscatter = my_difscatter(Z1,Z2,theta,E);
    impactparam = my_impact(Z2,Z2,theta,E);
    doca = my_distclose(Z1,Z2,impactparam,E);
    difscatterdatapath  = [directory '/difscatterdata.csv'];
    impactparamdatapath = [directory '/impactparamdata.csv'];
    docadatapath = [directory '/docadata.csv'];
    A = [theta' difscatter'];
    B = [theta' impactparam'];
    C = [impactparam' doca'];
    writematrix(A,difscatterdatapath);
    writematrix(B,impactparamdatapath);
    writematrix(C,docadatapath);
    