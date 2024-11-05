function y = run_calcpotential(filepath,datafilepath)
%RUN_CALCPOTENTIAL    Reads input file and generates potential data.
%   RUN_CALCPOTENTIAL(FILEPATH,DATAFILEPATH) reads the user-specified input
%   file, generates potential data using the appropriate potential 
%   function, and saves the data to a user-specified folder.
%
%   -- FILEPATH must specify the path to where input file is.
%   -- DATAFILEPATH must specify where to save the potential data.
%
%   See also MY_COULOMB MY_LJ MY_ZBL MY_POWERLAW
    run(filepath);
    r = minR:Rstep:maxR;
    if strcmp(Potential_Type,"Coulomb")
        data = my_coulomb(Z1,Z2,r);
        datapath  = [datafilepath '/coulombdata.csv'];
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    elseif strcmp(Potential_Type,"Lennard-Jones")
        data = my_lj(eps_well,sigma,r);
        datapath  = [datafilepath '/ljdata.csv'];
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    elseif strcmp(Potential_Type,"ZBL")
        data = my_zbl(Z1,Z2,r);
        datapath  = [datafilepath '/zbldata.csv'];
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    elseif strcmp(Potential_Type,"Power Law")
        data = my_powerlaw(a,k,r);
        datapath = [datafilepath '/powerlawdata.csv'];
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    end
end