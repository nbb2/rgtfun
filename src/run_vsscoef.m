function y = run_vsscoef(inputfile,datapath)
%RUN_VHSCOEF    Reads VHS coef input file and calculates VHS params.
%   RUN_DSMCCOEF(INPUTFILE,DATAPATH) reads the user-specified parameters 
%   from the input file and calculates DSMC params for the VHS 
%   model.
%
%   -- INPUTFILE must specify the path to where input file is.
%   -- DATAFILEPATH must specify where to save the param table.
%
%   See also MY_VHSCOEF MY_VHSVISCOSITY
y = datapath;
run(inputfile);
%mr = m1*m2/(m1+m2);
mr = m1;
mrkg = mr/(6.022E26);
molarkg = mr/(1E3);
difcoefdata = readmatrix(diffusiondatafile);
vhscoefdata = readmatrix(vhstablefile);
viscvals = vhscoefdata(:,3)*(1E-6);
omegavals = vhscoefdata(:,5);
alphavals = alphaguess*ones(length(omegavals),1);
Tvals = vhscoefdata(:,4);
difcoef = difcoefdata(:,2);
difcoef_T = difcoefdata(:,1);
dif_sample = interp1(difcoef_T, difcoef, Tvals);
max_iter = 100;
iter = 0;
while my_VSSconvergence(alphavals,omegavals,molarkg,Tvals,dif_sample,viscvals,tol) && iter < max_iter
diams = my_VSSdiameter(alphavals,omegavals,mrkg,Tvals,viscvals);
% disp('loop diams are ')
% disp(diams*(1E10))
% disp('end loop diams')
newalpha = my_VSSalpha(omegavals,mrkg,molarkg,Tvals,dif_sample,diams);
alphavals = newalpha;
% disp('alpha vals')
% disp(alphavals)
% disp('end alpha vals')
iter = iter + 1;
end
if iter == max_iter
    warning('Reached maximum number of iterations without convergence.');
end
diams = my_VSSdiameter(alphavals,omegavals,mrkg,Tvals,viscvals);
%disp(diams)
diams_angstrom  = diams*(1E10);
%disp(diams_angstrom)
%disp(alphavals)
A = [Tvals alphavals diams_angstrom];
vssdatapath = fullfile(datapath,'/VSScoeftable.csv');
A = array2table(A,'VariableNames',{'Reference Temp (K)', 'alpha','collision_diam'});
disp(A)
writetable(A,vssdatapath);
end
