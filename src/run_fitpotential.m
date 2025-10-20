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
    %run(filepath);
    cfg = loadinputfile(filepath);
    if strcmp(cfg.Potential_Type,"Coulomb")
        ft = fittype(coulombchar(cfg.Z1),dependent="y",independent="x",...
        coefficients="z2");
        t = readmatrix(datapath);
        excludex = ((t(:,1) < cfg.minR) | (t(:,1) > cfg.maxR));
        xvals = t(:,1);
        yvals = t(:,2);
        xvals(excludex) = [];
        yvals(excludex) = [];
        y = fit(xvals,yvals,ft,'Exclude',(xvals<cfg.minR)&(xvals>cfg.maxR),...
            'TolFun',cfg.tol,'Lower',cfg.minZ2,'Upper',cfg.maxZ2);
    elseif strcmp(cfg.Potential_Type,"ZBL")
        ft = fittype(zblchar(cfg.Z1),dependent="y",independent="x",...
        coefficients="z2");
        t = readmatrix(datapath);
        excludex = ((t(:,1) < cfg.minR) | (t(:,1) > cfg.maxR));
        xvals = t(:,1);
        yvals = t(:,2);
        xvals(excludex) = [];
        yvals(excludex) = [];
        y = fit(xvals,yvals,ft,'Exclude',(xvals<cfg.minR)&(xvals>cfg.maxR),...
            'TolFun',cfg.tol,'Lower',cfg.minZ2,'Upper',cfg.maxZ2);
    elseif strcmp(cfg.Potential_Type,"12-6 Lennard-Jones")
        t = readmatrix(datapath);
        excludex = ((t(:,1) < cfg.minR) | (t(:,1) > cfg.maxR));
        xvals = t(:,1);
        yvals = t(:,2);
        xvals(excludex) = [];
        yvals(excludex) = [];
        ft = fittype("4*eps_well*(((sigma./x).^12)-((sigma./x).^6))",dependent="y",...
                    independent="x",coefficients=["eps_well" "sigma"]);
        y = fit(xvals,yvals,ft,...
                    'TolFun',cfg.tol,'Lower',[cfg.min_eps cfg.min_sigma],...
                    'Upper',[cfg.max_eps cfg.max_sigma],'StartPoint',[cfg.eps_start cfg.sigma_start]);
    elseif strcmp(cfg.Potential_Type,"12-4 Lennard-Jones")
        t = readmatrix(datapath);
        excludex = ((t(:,1) < cfg.minR) | (t(:,1) > cfg.maxR));
        xvals = t(:,1);
        yvals = t(:,2);
        xvals(excludex) = [];
        yvals(excludex) = [];
        ft = fittype("0.5*(3^1.5)*eps_well*(((sigma./x).^12)-((sigma./x).^4))",dependent="y",...
                    independent="x",coefficients=["eps_well" "sigma"]);
        y = fit(xvals,yvals,ft,...
                    'TolFun',cfg.tol,'Lower',[cfg.min_eps cfg.min_sigma],...
                    'Upper',[cfg.max_eps cfg.max_sigma],'StartPoint',[cfg.eps_start cfg.sigma_start]);
    elseif strcmp(cfg.Potential_Type,"Morse")
        t = readmatrix(datapath);
        excludex = ((t(:,1) < cfg.minR) | (t(:,1) > cfg.maxR));
        xvals = t(:,1);
        yvals = t(:,2);
        xvals(excludex) = [];
        yvals(excludex) = [];
        ft = fittype("eps_well*(exp(-2*sqrt(k/(2*eps_well)).*(x-rm))-2*exp(-sqrt(k/(2*eps_well)).*(x-rm)))", ...
            dependent="y",independent="x",coefficients=["rm" "eps_well" "k"]);
        y = fit(xvals,yvals,ft,...
                    'TolFun',cfg.tol,'Lower',[cfg.min_rm cfg.min_eps cfg.min_k],...
                    'Upper',[cfg.max_rm cfg.max_eps cfg.max_k],'StartPoint',[cfg.rm_start cfg.eps_start cfg.k_start]);
    elseif strcmp(cfg.Potential_Type,"Power Law")
        t = readmatrix(datapath);
        excludex = ((t(:,1) < cfg.minR) | (t(:,1) > cfg.maxR));
        xvals = t(:,1);
        yvals = t(:,2);
        xvals(excludex) = [];
        yvals(excludex) = [];
        ft = fittype("a*x.^(-k)",dependent="y",...
                    independent="x",coefficients=["a" "k"]);
        y = fit(xvals,yvals,ft,...
                    'TolFun',cfg.tol,'Lower',[cfg.min_a cfg.min_k],...
                    'Upper',[cfg.max_a cfg.max_k],'StartPoint',[cfg.a_start cfg.k_start]);
    end
end


