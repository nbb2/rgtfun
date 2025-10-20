function y = run_dsmccoef(inputfile,datapath)
%RUN_DSMCCOEF    Reads dsmc coef input file and calculates dsmc params.
%   RUN_DSMCCOEF(INPUTFILE,DATAPATH) reads the user-specified parameters 
%   from the input file and calculates DSMC params for the VSS and VHS 
%   models.
%
%   -- INPUTFILE must specify the path to where input file is.
%   -- DATAFILEPATH must specify where to save the param table.
%
%   See also VHSCOEF VHSVISCOSITY VSSCOEF VSSDIFFUSION
y = datapath;
%run(inputfile);
cfg = loadinputfile(inputfile);
mr = cfg.m1*cfg.m2/(cfg.m1+cfg.m2);
mrkg = mr/(6.022E26);
kb = 1.380649E-23; %J/K
cd(sprintf('%s',y))
mkdir dsmcfitdata
visccoefdata = readmatrix(cfg.viscdatafile);
visccoef = visccoefdata(:,2);
Tvals = visccoefdata(:,1);
Tfine = min(Tvals):0.01:max(Tvals);
vqvisc = interp1(Tvals,visccoef,Tfine);
delta = (max(Tvals) - min(Tvals))/cfg.N;
offset = min(Tvals);
dsmcdatapath = fullfile(datapath,'/dsmccoeftable.csv');
A = [];
C = [Tfine' vqvisc'];
interpviscdata = fullfile(datapath,'/dsmcfitdata/dsmcfitviscdata.csv');
writematrix(C,interpviscdata);
for i = 1:cfg.N
    minT = offset;
    maxT = minT + delta;
    excludeT = ((Tfine < minT) | (Tfine > maxT));
    fitT = Tfine;
    fitT(excludeT) = [];
    T_sample = 0.5*(minT + maxT);
    vhscoefs = my_VHScoef(fitT,T_sample,excludeT,vqvisc,cfg.tol);
    mu_sample = vhscoefs(1);
    omega = vhscoefs(2);
    dcollision = (1E10)*sqrt(15*sqrt(mrkg*kb*T_sample/pi)/...
        (2*(5-2*omega)*(7-2*omega)*(mu_sample/(1E6)))); %Angstrom
    viscfit = my_VHSviscosity(fitT,omega,T_sample,mu_sample);
    viscfitdatapath = fullfile(datapath,sprintf('/dsmcfitdata/viscfitdata_n=%i.csv',i));
    B1 = [fitT' viscfit'];
    writematrix(B1,viscfitdatapath);
    A = [A; minT maxT mu_sample T_sample omega dcollision];
    offset  = offset + delta;
end
A = array2table(A,'VariableNames',{'Tmin','Tmax','mu_ref','T_ref','omega','collision_diam'});
disp(A)
writetable(A,dsmcdatapath);
end