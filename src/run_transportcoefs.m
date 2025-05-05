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
    run(filepath);
    Tvals = minT:Tstep:maxT;
    if strcmp(inttype,'Exact LJ') | strcmp(inttype,'Trapezoidal LJ')
            difcoef = diffusion_coef(welldepth,Tvals,m1,m2,d,inttype,diffusiondatafile);
            diffusioncoefdatapath  = fullfile(datafilepath,'/diffusioncoefdata.csv');
            A = [Tvals' difcoef'];
            writematrix(A, diffusioncoefdatapath);
            viscositycoef = visc_coef(welldepth,Tvals,m1,m2,d,inttype,viscositydatafile);
            visccoefdatapath  = fullfile(datafilepath,'/viscositycoefdata.csv');
            B = [Tvals' viscositycoef'];
            writematrix(B, visccoefdatapath);
            y = datafilepath;
    elseif strcmp(inttype,'Numerical')
            diffusioncoef = numdiffusioncoef(Tvals,m1,m2,diffusiondatafile);
            diffusioncoefdatapath  = fullfile(datafilepath,'/diffusioncoefdata.csv');
            A = [Tvals' diffusioncoef'];
            writematrix(A, diffusioncoefdatapath);
            visccoef = numvisccoef(Tvals,m1,m2,viscositydatafile);
            visccoefdatapath  = fullfile(datafilepath,'/viscositycoefdata.csv');
            B = [Tvals' visccoef'];
            writematrix(B, visccoefdatapath);
            coefdatapath = datafilepath;
            y = coefdatapath;
    end
end

