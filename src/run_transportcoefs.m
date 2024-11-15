function y = run_transportcoefs(filepath,datafilepath)
%RUN_TRANSPORTCOEFS    Reads transport input file and calculates transport coefs.
%   RUN_TRANSPORTCOEFS(FILEPATH,DATAFILEPATH) reads the user-specified
%   transport parameters from the transport input file and calculates the 
%   self-diffusion or viscosity coefficient.
%
%   -- FILEPATH must specify the path to where input file is.
%   -- DATAFILEPATH must specify where to save the coef data.
%
%   See also MY_DIFFUSIONCOEF MY_VISCCOEF MY_NUMDIFFUSIONCOEF
%   MY_NUMVISCCOEF
    disp(filepath)
    run(filepath);
    Tvals = minT:Tstep:maxT;
    if strcmp(inttype,'Exact LJ') | strcmp(inttype,'Trapezoidal LJ')
        if strcmp(coeftype,'Self-Diffusion')
            diffusioncoef = my_diffusioncoef(welldepth,Tvals,p,m1,m2,d,inttype,datafile);
            diffusioncoefdatapath  = [datafilepath '/diffusioncoefdata.csv'];
            A = [Tvals' diffusioncoef'];
            writematrix(A, diffusioncoefdatapath);
            y = diffusioncoefdatapath;
        elseif strcmp(coeftype,'Viscosity')
            visccoef = my_visccoef(welldepth,Tvals,m1,m2,d,inttype,datafile);
            visccoefdatapath  = [datafilepath '/viscositycoefdata.csv'];
            A = [Tvals' visccoef'];
            writematrix(A, visccoefdatapath);
            y = visccoefdatapath;
        else
            disp('Something went wrong.')
        end
    elseif strcmp(inttype,'Numerical')
        if strcmp(coeftype,'Self-Diffusion')
            diffusioncoef = my_numdiffusioncoef(Tvals,m1,m2,p,datafile);
            diffusioncoefdatapath  = [datafilepath '/diffusioncoefdata.csv'];
            A = [Tvals' diffusioncoef'];
            writematrix(A, diffusioncoefdatapath);
            y = diffusioncoefdatapath;
        elseif strcmp(coeftype,'Viscosity')
            visccoef = my_numvisccoef(Tvals,m1,m2,datafile);
            visccoefdatapath  = [datafilepath '/viscositycoefdata.csv'];
            A = [Tvals' visccoef'];
            writematrix(A, visccoefdatapath);
            y = visccoefdatapath;
        else
            disp('Something went wrong.')
        end
    end
   
end

