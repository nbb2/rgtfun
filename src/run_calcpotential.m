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
r = minR:0.1:maxR;
data = my_coulomb(Z1,Z2,r);
datapath  = [directory '/coulumb_data.csv'];
A = [r' data'];
writematrix(A,datapath);
end