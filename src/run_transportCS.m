function run_transportCS(filepath,datafilepath)
%RUN_TRANSPORTCS    Reads cross-section input file and calculates transport cross-sections.
%   RUN_TRANSPORTCS(FILEPATH,DATAFILEPATH) reads the user-specified
%   cross-section parameters from the cross-section input file and 
%   calculates the diffusion cross-section and viscosity cross-section.
%



%   -- FILEPATH must specify the path to where input file is.
%   -- DATAFILEPATH must specify where to save the potential data.
%
%   See also MY_DIFFUSIONCS MY_VISCOSITYCS
    run(filepath);
    Evals = minE:Estep:maxE;
    if strcmp(inttype,'Exact LJ')
        beta = welldepth./(2*Evals);
        diffusioncs = my_diffusioncs(beta);
        viscositycs = my_viscositycs(beta);
        A = [beta' diffusioncs'];
        B = [beta' viscositycs'];

    elseif strcmp(inttype,'Numerical')
        diffusioncs = zeros(1,length(Evals));
        viscositycs = zeros(1,length(Evals));
        for j = 1:length(Evals)
            disp(Evals(j))

            file = fullfile(datafolder,sprintf('/scatterangledata_%f.csv',Evals(j)));
            disp(file)
            diffusioncs(j) = my_numdiffusioncs(file);
            viscositycs(j) = my_numvisccs(file);
        end
        A = [Evals' diffusioncs'];
        B = [Evals' viscositycs'];    
    end
    diffusioncsdatapath  = [datafilepath '/diffusioncsdata.csv'];
    viscositycsdatapath = [datafilepath '/viscositycsdata.csv'];
    writematrix(A, diffusioncsdatapath);
    writematrix(B,viscositycsdatapath);
end