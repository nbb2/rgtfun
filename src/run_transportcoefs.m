function y = run_transportcoefs(filepath,datafilepath)
%RUN_TRANSPORTCOEFS    Reads transport input file and calculates transport coefs.
%   RUN_TRANSPORTCOEFS(FILEPATH,DATAFILEPATH) reads the user-specified
%   transport parameters from the transport input file and calculates the 
%   self-diffusion or viscosity coefficient.
%
%   -- FILEPATH must specify the path to where input file is.
%   -- DATAFILEPATH must specify where to save the potential data.
%
%   See also MY_DIFFUSIONCOEF MY_VISCCOEF
    disp(filepath)
    run(filepath);
    Tvals = minT:Tstep:maxT;
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
   
end

