function y = run_transportcoefs(filepath,datafilepath)
%RUN_TRANSPORTCOEFS    Reads transport input file and calculates transport coefs.
%   RUN_TRANSPORTCOEFS(FILEPATH,DATAFILEPATH) reads the user-specified
%   transport parameters from the transport input file and calculates the 
%   self-diffusion or viscosity coefficient.
%
%   -- FILEPATH must specify the path to where input file is.
%   -- DATAFILEPATH must specify where to save the coef data.
%
%   See also DIFFUSIONCOEF VISCCOEF NUMDIFFUSIONCOEF NUMVISCCOEF
    %disp(filepath)
    %run(filepath);
    cfg = loadinputfile(filepath);
    Tvals = cfg.minT:cfg.Tstep:cfg.maxT;
    if strcmp(cfg.inttype,'Exact LJ') | strcmp(cfg.inttype,'Trapezoidal LJ')
            difcoef = diffusion_coef(cfg.welldepth,Tvals,cfg.m1,cfg.m2,cfg.d,cfg.inttype,cfg.diffusiondatafile);
            diffusioncoefdatapath  = fullfile(datafilepath,'/diffusioncoefdata.csv');
            A = [Tvals' difcoef'];
            writematrix(A, diffusioncoefdatapath);
            viscositycoef = visc_coef(cfg.welldepth,Tvals,cfg.m1,cfg.m2,cfg.d,cfg.inttype,cfg.viscositydatafile);
            visccoefdatapath  = fullfile(datafilepath,'/viscositycoefdata.csv');
            B = [Tvals' viscositycoef'];
            writematrix(B, visccoefdatapath);
            y = datafilepath;
    elseif strcmp(cfg.inttype,'Numerical')
            diffusioncoef = numdiffusioncoef(Tvals,cfg.m1,cfg.m2,cfg.diffusiondatafile);
            diffusioncoefdatapath  = fullfile(datafilepath,'/diffusioncoefdata.csv');
            A = [Tvals' diffusioncoef'];
            writematrix(A, diffusioncoefdatapath);
            visccoef = numvisccoef(Tvals,cfg.m1,cfg.m2,cfg.viscositydatafile);
            visccoefdatapath  = fullfile(datafilepath,'/viscositycoefdata.csv');
            B = [Tvals' visccoef'];
            writematrix(B, visccoefdatapath);
            coefdatapath = datafilepath;
            y = coefdatapath;
    end
end

