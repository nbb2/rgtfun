function run_transportCS(filepath,datafilepath)
%RUN_TRANSPORTCS    Reads cross-section input file and calculates transport cross-sections.
%   RUN_TRANSPORTCS(FILEPATH,DATAFILEPATH) reads the user-specified
%   cross-section (CS) parameters from the cross-section input file and 
%   calculates the diffusion CS and viscosity CS (for the exact LJ case in 
%   "Khrapak, S.A. Accurate transport cross sections for the Lennard-Jones 
%   potential. Eur. Phys. J. D 68, 276 (2014)") or the diffusion CS, 
%   viscosity CS, stopping CS, and total CS (for the general case).
%
%   -- FILEPATH must specify the path to where input file is.
%   -- DATAFILEPATH must specify where to save the CS data.
%
%   See also MY_DIFFUSIONCS MY_VISCOSITYCS MY_NUMDIFFUSIONCS MY_NUMVISCCS
%   MY_NUMTOTALCS MY_NUMSTOPPINGCS
    run(filepath);
    if logspace_on == 1
        minElog = log10(minE);
        maxElog = log10(maxE);
        Evals = logspace(minElog,maxElog,logstep);
    elseif logspace_on == 0
        Evals = minE:Estep:maxE;
    end
    if strcmp(inttype,'Exact LJ')
        beta = welldepth./(2*Evals);
        diffusioncs = my_diffusioncs(beta);
        viscositycs = my_viscositycs(beta);
        A = [Evals' diffusioncs'];
        B = [Evals' viscositycs'];

    elseif strcmp(inttype,'Numerical')
        diffusioncs = zeros(1,length(Evals));
        viscositycs = zeros(1,length(Evals));
        stoppingcs = zeros(1,length(Evals));
        totalcs = zeros(1,length(Evals));
        for j = 1:length(Evals)
            disp(Evals(j))
            file = fullfile(datafolder,sprintf('/scatterangledata_%f.csv',Evals(j)));
            %disp(file)
            diffusioncs(j) = my_numdiffusioncs(file);
            viscositycs(j) = my_numvisccs(file);
            stoppingcs(j) = my_numstoppingcs(Evals(j),m1,m2,diffusioncs(j));
            totalcs(j) = my_numtotalcs(th_max,file);
        end
        CMtoLab = (m1+m2)/m2;
        A = [Evals' diffusioncs'];
        B = [Evals' viscositycs'];    
        C = [(CMtoLab*Evals)' stoppingcs'];
        D = [Evals' totalcs'];
        stoppingcsdatapath = [datafilepath '/stoppingcsdata.csv'];
        totalcsdatapath = [datafilepath '/totalcsdata.csv'];
        writematrix(C,stoppingcsdatapath);
        writematrix(D,totalcsdatapath);
    end
    diffusioncsdatapath  = [datafilepath '/diffusioncsdata.csv'];
    viscositycsdatapath = [datafilepath '/viscositycsdata.csv'];
    writematrix(A, diffusioncsdatapath);
    writematrix(B,viscositycsdatapath);
    
end