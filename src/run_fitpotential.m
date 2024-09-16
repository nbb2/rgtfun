function y = run_fitpotential(directory)
%RUN_FITPOTENTIAL    Reads fitting input file and generates cfit object.
%   RUN_FITPOTENTIAL(DIRECTORY) reads the user-specified fitting parameters
%   from the fitting input file, creates a fittype based off of those
%   parameters using the MY_COULOMBCHAR function or LJ string, and then creates a fit
%   object using the FIT function.
%
%   -- DIRECTORY must specify the path to where potential data file is.
%
%   See also MY_COULOMBCHAR FIT FITTYPE
    run([directory '/fitinputfile.m']);
    if strcmp(Potential_Type,"Coulomb")
        ft = fittype(my_coulombchar(Z1),dependent="y",independent="x",...
        coefficients="z2");
        datalocation = [directory '/data.csv'];
        t = readmatrix(datalocation);
        excludex = ((t(:,1) < minR) | (t(:,1) > maxR));
        xvals = t(:,1);
        yvals = t(:,2);
        xvals(excludex) = [];
        yvals(excludex) = [];
        y = fit(xvals,yvals,ft,'Exclude',(xvals<minR)&(xvals>maxR),...
            'TolFun',tol,'Lower',minZ2,'Upper',maxZ2);
    
    elseif strcmp(Potential_Type,"Lennard-Jones")
        datalocation = [directory '/data.csv'];
        t = readmatrix(datalocation);
        excludex = ((t(:,1) < minR) | (t(:,1) > maxR));
        xvals = t(:,1);
        yvals = t(:,2);
        xvals(excludex) = [];
        yvals(excludex) = [];
        ft = fittype("4*eps_well*(((sigma./x).^12)-((sigma./x).^6))",dependent="y",...
                    independent="x",coefficients=["eps_well" "sigma"]);
        y = fit(xvals,yvals,ft,...
                    'TolFun',tol,'Lower',[min_eps min_sigma],...
                    'Upper',[max_eps max_sigma],'StartPoint',[eps_start sigma_start]);
        %Exclude',(xvals<minR)|(xvals>maxR),
    end
end