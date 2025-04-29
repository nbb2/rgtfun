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
%   See also DIFFUSIONCS VISCOSITYCS NUMDIFFUSIONCS NUMVISCCS
%   NUMTOTALCS NUMSTOPPINGCS
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
        difcs = diffusioncs(beta);
        visccs = viscositycs(beta);
        A = [Evals' difcs'];
        B = [Evals' visccs'];

    elseif strcmp(inttype,'Numerical')
        difcs = zeros(1,length(Evals));
        visccs = zeros(1,length(Evals));
        stoppingcs = zeros(1,length(Evals));
        totalcs = zeros(1,length(Evals));
        for j = 1:length(Evals)
            disp(Evals(j))
            file = datafile;
            scatterdata = readmatrix(file);
            th = scatterdata(:,j+1);
            bvals = scatterdata(:,1);
            if strcmp(thetacutoff,'Quantum')
                docadata = readmatrix(docafile);
                doca = docadata(:,j+1)*(1e-10); %m
                hbar = 1.054571817E-34; %J*s
                m_redamu  = m1*m2/(m1+m2);
                m_red = m_redamu/(6.022E26); %kg
                E = Evals(j)*(1.60218E-19); %J
                v_cm = sqrt(2*E/m_red);
                lam_bar = hbar/(m_red*v_cm);
                th_c = lam_bar./doca;
            elseif strcmp(thetacutoff,'Manual')
                th_c = th_max;
            end
            %disp(file)
            difcs(j) = numdiffusioncs(bvals,th);
            visccs(j) = numvisccs(bvals,th);
            stoppingcs(j) = numstoppingcs(Evals(j),m1,m2,diffusioncs(j));
            totalcs(j) = numtotalcs(th_c,bvals,th);
        end
        CMtoLab = (m1+m2)/m2;
        A = [Evals' difcs'];
        B = [Evals' visccs'];    
        C = [(CMtoLab*Evals)' stoppingcs'];
        D = [Evals' totalcs'];
        stoppingcsdatapath = fullfile(datafilepath,'/stoppingcsdata.csv');
        totalcsdatapath = fullfile(datafilepath,'/totalcsdata.csv');
        writematrix(C,stoppingcsdatapath);
        writematrix(D,totalcsdatapath);
    end
    diffusioncsdatapath  = fullfile(datafilepath,'/diffusioncsdata.csv');
    viscositycsdatapath = fullfile(datafilepath,'/viscositycsdata.csv');
    writematrix(A, diffusioncsdatapath);
    writematrix(B,viscositycsdatapath);
    
end