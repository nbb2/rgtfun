function y = run_calcpotential(filepath,datafilepath)
%RUN_CALCPOTENTIAL    Reads input file and generates potential data.
%   RUN_CALCPOTENTIAL(FILEPATH,DATAFILEPATH) reads the user-specified input
%   file, generates potential data using the appropriate potential 
%   function, and saves the data to a user-specified folder.
%
%   -- FILEPATH must specify the path to where input file is.
%   -- DATAFILEPATH must specify where to save the potential data.
%
%   See also COULOMB LJ_126 LJ_124 ZBL POWERLAW MORSE
    cfg = loadinputfile(filepath);
    %run(filepath);
    r = cfg.minR:cfg.Rstep:cfg.maxR;
    if strcmp(cfg.Potential_Type,"Coulomb")
        data = coulomb(cfg.Z1,cfg.Z2,r);
        datapath  = fullfile(datafilepath,'/coulombdata.csv');
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    elseif strcmp(cfg.Potential_Type,"12-6 Lennard-Jones")
        data = lj_126(cfg.eps_well,cfg.sig,r);
        datapath  = fullfile(datafilepath,'/126ljdata.csv');
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    elseif strcmp(cfg.Potential_Type,"12-4 Lennard-Jones")
        data = lj_124(cfg.eps_well,cfg.sig,r);
        datapath  = fullfile(datafilepath,'/124ljdata.csv');
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    elseif strcmp(cfg.Potential_Type,"ZBL")
        data = zbl(cfg.Z1,cfg.Z2,r);
        datapath  = fullfile(datafilepath,'/zbldata.csv');
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    elseif strcmp(cfg.Potential_Type,"Morse")
        data = morse(cfg.rm,cfg.eps_well,cfg.k,r);
        datapath  = fullfile(datafilepath,'/morsedata.csv');
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    elseif strcmp(cfg.Potential_Type,"Power Law")
        data = powerlaw(cfg.a,cfg.k,r);
        datapath = fullfile(datafilepath,'/powerlawdata.csv');
        A = [r' data'];
        writematrix(A,datapath);
        y = datapath;
    end
end