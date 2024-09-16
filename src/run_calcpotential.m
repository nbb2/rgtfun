function run_calcpotential(directory)
%RUN_CALCPOTENTIAL    Reads input file and generates Coulomb potential data.
%   RUN_CALCPOTENTIAL(DIRECTORY) reads the user-specified input file,
%   generates Coulomb potential data using the MY_COULOMB function, and
%   saves the data to a user-specified folder.
%
%   -- DIRECTORY must specify the path to where input file is.
%
%   See also MY_COULOMB
    run([directory '/inputfile.m']);
    r = minR:0.01:maxR;
    if strcmp(Potential_Type,"Coulomb")
        data = my_coulomb(Z1,Z2,r);
        datapath  = [directory '/data.csv'];
        A = [r' data'];
        writematrix(A,datapath);
    elseif strcmp(Potential_Type,"Lennard-Jones")
        data = my_lj(eps_well,sigma,r);
        datapath  = [directory '/data.csv'];
        A = [r' data'];
        writematrix(A,datapath);
    end
end