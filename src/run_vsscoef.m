function y = run_vsscoef(inputfile,datapath)
%RUN_VSSCOEF    Reads VSS coef input file and calculates VSS params.
%   RUN_DSMCCOEF(INPUTFILE,DATAPATH) reads the user-specified parameters 
%   from the input file and calculates DSMC params for the VSS 
%   model.
%
%   -- INPUTFILE must specify the path to where input file is.
%   -- DATAFILEPATH must specify where to save the param table.
%
%   See also VSSALPHA VSSDIAMETER VSSCONVERGENCE
y = datapath;
%run(inputfile);
cfg = loadinputfile(inputfile);
mr = cfg.m1*cfg.m2/(cfg.m1+cfg.m2);
%mr = m1;
mrkg = mr/(6.022E26);
molarkg = mr/(1E3);
difcoefdata = readmatrix(cfg.diffusiondatafile);
vhscoefdata = readmatrix(cfg.vhstablefile);
viscvals = vhscoefdata(:,3)*(1E-6);
omegavals = vhscoefdata(:,5);
alphavals = cfg.alphaguess*ones(length(omegavals),1);
Tvals = vhscoefdata(:,4);
difcoef = difcoefdata(:,2);
difcoef_T = difcoefdata(:,1);
dif_sample = interp1(difcoef_T, difcoef, Tvals);
max_iter = 100;
iter = 0;
while VSSconvergence(alphavals,omegavals,molarkg,Tvals,dif_sample,viscvals,cfg.tol) && iter < max_iter
diams = VSSdiameter(alphavals,omegavals,mrkg,Tvals,viscvals);
newalpha = VSSalpha(omegavals,mrkg,molarkg,Tvals,dif_sample,diams);
alphavals = newalpha;
iter = iter + 1;
end
if iter == max_iter
    warning('Reached maximum number of iterations without convergence.');
end
diams = VSSdiameter(alphavals,omegavals,mrkg,Tvals,viscvals);
diams_angstrom  = diams*(1E10);
A = [Tvals alphavals diams_angstrom];
vssdatapath = fullfile(datapath,'/VSScoeftable.csv');
A = array2table(A,'VariableNames',{'Reference Temp (K)', 'alpha','collision_diam'});
disp(A)
writetable(A,vssdatapath);
end
