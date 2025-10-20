function y = run_scatteringintegrals(filepath,datafilepath,progressBar)
%RUN_SCATTERINGINTEGRALS    Reads scattering input file and calculates scattering integrals.
%   RUN_SCATTERINGINTEGRALS(FILEPATH,DATAFILEPATH) reads the user-specified
%   scattering parameters from the scattering input file and calculates the
%   differential scattering cross section, impact parameter, and distance 
%   of closest approach (for the Coulomb case), or calculates the 
%   scattering angle and distance of closest approach (general) case.
%
%   -- FILEPATH must specify the path to where input file is.
%   -- DATAFILEPATH must specify where to save the scattering integral data.
%
%   See also IMPACT DIFSCATTER DISTCLOSE DOCAROOT GMQUADSCATTERINGANGLE
    y = datafilepath;
    %run(filepath);
    cfg = loadinputfile(filepath);
    if cfg.logspace_on == 1
        minElog = log10(cfg.minE);
        maxElog = log10(cfg.maxE);
        Evals = logspace(minElog,maxElog,cfg.logstep);
    elseif cfg.logspace_on == 0
        Evals = cfg.minE:cfg.Estep:cfg.maxE;
    end
    cd(sprintf('%s',y))

    if strcmp(cfg.inttype,'Exact Coulomb')
        theta = cfg.theta_min:cfg.theta_step:cfg.theta_max;
        numESteps = numel(Evals);
        numthSteps = numel(theta);
        A = zeros(numthSteps,numESteps);
        B = zeros(numthSteps,numESteps);
        C = zeros(numthSteps,2*numESteps);
        colNames = strings(1,1+numESteps);
        A(:,1) = theta';
        B(:,1) = theta';
        colNames(1,1) = 'theta';
        colNamesC = strings(1,2*numESteps);
        for i = 1:numESteps
            E = Evals(i);
            if nargin > 2 && isvalid(progressBar)
                progressBar.Value = i / numESteps;
                progressBar.Message = sprintf('Running %f eV...', E);
            end
            mydifscatter = difscatter(cfg.Z1, cfg.Z2, theta, E);
            impactparam = impact(cfg.Z2, cfg.Z2, theta, E);
            doca = distclose(cfg.Z1, cfg.Z2, impactparam, E);
            colNames(i+1) = sprintf('E=%f',E);
            colNamesC(1,2*i-1) = sprintf('bval E=%f',E);
            colNamesC(1,2*i) = sprintf('doca E=%f',E);
            A(:,i+1) = mydifscatter';
            B(:,i+1) = impactparam';
            C(:,2*i-1) = impactparam';
            C(:,2*i) = doca';
        end
        ATable = array2table(A,'VariableNames',colNames);
        BTable = array2table(B,'VariableNames',colNames);
        CTable = array2table(C,'VariableNames',colNamesC);
        difscatterdatapath = fullfile(datafilepath,'/difscatterdata.csv');
        impactparamdatapath = fullfile(datafilepath,'/impactparamdata.csv');
        docadatapath = fullfile(datafilepath,'/docadata.csv');
        writetable(ATable, difscatterdatapath);
        writetable(BTable, impactparamdatapath);
        writetable(CTable, docadatapath);

    elseif strcmp(cfg.inttype, 'Numerical')
        fitf = loadinputfile(cfg.fitfile);
        %run(fitfile);
        if strcmp(fitf.Potential_Type, 'Coulomb')
            potential = @(r) coulomb(fitf.Z1, fitf.z2_param, r);
        elseif strcmp(fitf.Potential_Type, '12-6 Lennard-Jones')
            potential = @(r) lj_126(fitf.eps_param, fitf.sigma_param, r);
        elseif strcmp(fitf.Potential_Type, '12-4 Lennard-Jones')
            potential = @(r) lj_124(fitf.eps_param, fitf.sigma_param, r);
        elseif strcmp(fitf.Potential_Type, 'ZBL')
            potential = @(r) zbl(fitf.Z1, fitf.z2_param, r);
        elseif strcmp(fitf.Potential_Type, 'Morse')
            potential = @(r) morse(fitf.rm_param,fitf.eps_param,fitf.k_param,r);
        elseif strcmp(fitf.Potential_Type, 'Power Law')
            potential = @(r) powerlaw(fitf.a_param, fitf.k_param, r);
        end
        if cfg.blogspace_on == 1
            minblog = log10(cfg.bmin);
            maxblog = log10(cfg.bmax);
            bvals = logspace(minblog,maxblog,cfg.blogstep);
        elseif cfg.blogspace_on == 0
            bvals = cfg.bmin:cfg.bstep:cfg.bmax;
        end

        numESteps = numel(Evals);
        numBSteps = numel(bvals);
        A = zeros(numBSteps,numESteps);
        B = zeros(numBSteps,numESteps);
        colNames = strings(1,1+numESteps);
        A(:,1) = bvals';
        B(:,1) = bvals';
        colNames(1,1) = 'bvals';
       
        for i = 1:numESteps
            E = Evals(i);
            if nargin > 2 && isvalid(progressBar)
                progressBar.Value = i / numESteps;
                progressBar.Message = sprintf('Running %f eV...', E);
            end
            docas = zeros(1, length(bvals));
            th = zeros(1, length(bvals));
            thmagic = zeros(1,length(bvals));
            for j = 1:length(bvals)
                docas(j) = DOCAroot(E, bvals(j), potential, cfg.minroot, cfg.maxroot,cfg.chebfunpath);
                th(j) = GMquadScatteringAngle(potential, E, bvals(j), docas(j), 20);
                if strcmp(fitf.Potential_Type, 'ZBL')
                    thmagic(j) = magicscatter(E,bvals(j),potential,docas(j),fitf.Z1,fitf.z2_param);
                end
            end
            colNames(i+1) = sprintf('E=%f',E);
            A(:,i+1) = th';
            B(:,i+1) = docas';
            C = [bvals' thmagic'];
            %magicscatterpath = fullfile(datafilepath,sprintf('/magicscatterdata/scatterangledata_%f.csv',E));
            %writematrix(C, magicscatterpath)
        end
        ATable = array2table(A,'VariableNames',colNames);
        BTable = array2table(B,'VariableNames',colNames);
        scatterangdatapath = fullfile(datafilepath,'/scatterangledata.csv');
        docadatapath = fullfile(datafilepath,'/docadata.csv');
        writetable(ATable, scatterangdatapath);
        writetable(BTable, docadatapath);
        %writematrix(C, magicscatterpath)
    end
end
    