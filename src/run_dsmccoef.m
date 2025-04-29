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
run(inputfile);
mr = m1*m2/(m1+m2);
mrkg = mr/(6.022E26);
%Ppa = P*100000;
kb = 1.380649E-23; %J/K
cd(sprintf('%s',y))
mkdir dsmcfitdata
visccoefdata = readmatrix(viscdatafile);
%difcoefdata = readmatrix(difdatafile);
visccoef = visccoefdata(:,2);
%difcoef = difcoefdata(:,2);
Tvals = visccoefdata(:,1);
%Tvals2 = difcoefdata(:,1);
Tfine = min(Tvals):0.01:max(Tvals);
%Tfine2 = min(Tvals2):0.01:max(Tvals2);
vqvisc = interp1(Tvals,visccoef,Tfine);
%vqdif = interp1(Tvals2,difcoef,Tfine);
delta = (max(Tvals) - min(Tvals))/N;
offset = min(Tvals);
dsmcdatapath = fullfile(datapath,'/dsmccoeftable.csv');
A = [];
C = [Tfine' vqvisc'];
%D = [Tfine2' vqdif'];
interpviscdata = fullfile(datapath,'/dsmcfitdata/dsmcfitviscdata.csv');
%interpdifdata = [datapath '/dsmcfitdata/dsmcfitdifdata.csv'];
writematrix(C,interpviscdata);
%writematrix(D,interpdifdata);
for i = 1:N
    minT = offset;
    maxT = minT + delta;
    excludeT = ((Tfine < minT) | (Tfine > maxT));
    fitT = Tfine;
    fitT(excludeT) = [];
    T_sample = 0.5*(minT + maxT);
    vhscoefs = my_VHScoef(fitT,T_sample,excludeT,vqvisc,tol);
    mu_sample = vhscoefs(1);
    omega = vhscoefs(2);
    %vsscoefs = my_VSScoef(minT,maxT,Tfine2,vqdif,mr,omega,P,tol);
    %alpha = vsscoefs(1);
    %d = vsscoefs(2);
    dcollision = (1E10)*sqrt(15*sqrt(mrkg*kb*T_sample/pi)/...
        (2*(5-2*omega)*(7-2*omega)*(mu_sample/(1E6)))); %Angstrom
    viscfit = my_VHSviscosity(fitT,omega,T_sample,mu_sample);
    %diffit = my_VSSdiffusion(fitT,omega,alpha,d,mr,P,T_sample);
    viscfitdatapath = fullfile(datapath,sprintf('/dsmcfitdata/viscfitdata_n=%i.csv',i));
    %diffitdatapath = [datapath sprintf('/dsmcfitdata/diffitdata_n=%i.csv',i)];
    B1 = [fitT' viscfit'];
    %B2 = [fitT' diffit'];
    writematrix(B1,viscfitdatapath);
    %writematrix(B2,diffitdatapath);
    A = [A; minT maxT mu_sample T_sample omega dcollision];
    offset  = offset + delta;
end
A = array2table(A,'VariableNames',{'Tmin','Tmax','mu_ref','T_ref','omega','collision_diam'});
disp(A)
writetable(A,dsmcdatapath);
end