function run_calcpotential(directory)
run([directory '/inputfile.m']);
r = minR:0.1:maxR;
data = my_coulomb(Z1,Z2,r);
datapath  = [directory '/coulumb_data.csv'];
A = [r' data'];
writematrix(A,datapath);
end