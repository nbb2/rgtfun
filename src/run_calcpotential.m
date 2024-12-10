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
        datapath  = fullfile(datafilepath,'/coulombdata.csv');
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    elseif strcmp(Potential_Type,"12-6 Lennard-Jones")
        data = my_126lj(eps_well,sig,r);
        datapath  = fullfile(datafilepath,'/126ljdata.csv');
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    elseif strcmp(Potential_Type,"12-4 Lennard-Jones")
        data = my_124lj(eps_well,sig,r);
        datapath  = fullfile(datafilepath,'/124ljdata.csv');
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    elseif strcmp(Potential_Type,"ZBL")
        data = my_zbl(Z1,Z2,r);
        datapath  = fullfile(datafilepath,'/zbldata.csv');
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    elseif strcmp(Potential_Type,"Morse")
        data = my_morse(rm,eps_well,k,r);
        datapath  = fullfile(datafilepath,'/morsedata.csv');
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    elseif strcmp(Potential_Type,"Power Law")
        data = my_powerlaw(a,k,r);
        datapath = fullfile(datafilepath,'/powerlawdata.csv');
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    end
end