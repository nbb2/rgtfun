function y = run_fitpotential(filepath,datapath)
%RUN_FITPOTENTIAL    Reads fitting input file and generates cfit object.
%   RUN_FITPOTENTIAL(FILEPATH,DATAFILEPATH) reads the user-specified 
%   fitting parameters from the fitting input file, creates a fittype based
%   off those parameters using the appropriate character function or 
%   string, and then creates a fit object using the FIT function.
%
%   -- FILEPATH must specify the path to where input file is.
%   -- DATAFILEPATH must specify where the potential data is saved.
%
%   See also COULOMBCHAR ZBLCHAR
    run(filepath);
    if strcmp(Potential_Type,"Coulomb")
        ft = fittype(coulombchar(Z1),dependent="y",independent="x",...
        coefficients="z2");
        t = readmatrix(datapath);
        excludex = ((t(:,1) < minR) | (t(:,1) > maxR));
        xvals = t(:,1);
        yvals = t(:,2);
        xvals(excludex) = [];
        yvals(excludex) = [];
        y = fit(xvals,yvals,ft,'Exclude',(xvals<minR)&(xvals>maxR),...
            'TolFun',tol,'Lower',minZ2,'Upper',maxZ2);
    elseif strcmp(Potential_Type,"ZBL")
        ft = fittype(zblchar(Z1),dependent="y",independent="x",...
        coefficients="z2");
        t = readmatrix(datapath);
        excludex = ((t(:,1) < minR) | (t(:,1) > maxR));
        xvals = t(:,1);
        yvals = t(:,2);
        xvals(excludex) = [];
        yvals(excludex) = [];
        y = fit(xvals,yvals,ft,'Exclude',(xvals<minR)&(xvals>maxR),...
            'TolFun',tol,'Lower',minZ2,'Upper',maxZ2);
    elseif strcmp(Potential_Type,"12-6 Lennard-Jones")
        t = readmatrix(datapath);
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
    elseif strcmp(Potential_Type,"12-4 Lennard-Jones")
        t = readmatrix(datapath);
        excludex = ((t(:,1) < minR) | (t(:,1) > maxR));
        xvals = t(:,1);
        yvals = t(:,2);
        xvals(excludex) = [];
        yvals(excludex) = [];
        ft = fittype("0.5*(3^1.5)*eps_well*(((sigma./x).^12)-((sigma./x).^4))",dependent="y",...
                    independent="x",coefficients=["eps_well" "sigma"]);
        y = fit(xvals,yvals,ft,...
                    'TolFun',tol,'Lower',[min_eps min_sigma],...
                    'Upper',[max_eps max_sigma],'StartPoint',[eps_start sigma_start]);
        %Exclude',(xvals<minR)|(xvals>maxR),
    elseif strcmp(Potential_Type,"Morse")
        t = readmatrix(datapath);
        excludex = ((t(:,1) < minR) | (t(:,1) > maxR));
        xvals = t(:,1);
        yvals = t(:,2);
        xvals(excludex) = [];
        yvals(excludex) = [];
        ft = fittype("eps_well*(exp(-2*sqrt(k/(2*eps_well)).*(x-rm))-2*exp(-sqrt(k/(2*eps_well)).*(x-rm)))", ...
            dependent="y",independent="x",coefficients=["rm" "eps_well" "k"]);
        y = fit(xvals,yvals,ft,...
                    'TolFun',tol,'Lower',[min_rm min_eps min_k],...
                    'Upper',[max_rm max_eps max_k],'StartPoint',[rm_start eps_start k_start]);
    elseif strcmp(Potential_Type,"Power Law")
        t = readmatrix(datapath);
        excludex = ((t(:,1) < minR) | (t(:,1) > maxR));
        xvals = t(:,1);
        yvals = t(:,2);
        xvals(excludex) = [];
        yvals(excludex) = [];
        ft = fittype("a*x.^(-k)",dependent="y",...
                    independent="x",coefficients=["a" "k"]);
        y = fit(xvals,yvals,ft,...
                    'TolFun',tol,'Lower',[min_a min_k],...
                    'Upper',[max_a max_k],'StartPoint',[a_start k_start]);
    end
end


