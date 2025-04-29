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
    run(filepath);
    if logspace_on == 1
        minElog = log10(minE);
        maxElog = log10(maxE);
        Evals = logspace(minElog,maxElog,logstep);
    elseif logspace_on == 0
        Evals = minE:Estep:maxE;
    end
    cd(sprintf('%s',y))
    %mkdir docadata

    if strcmp(inttype,'Exact Coulomb')
        theta = theta_min:theta_step:theta_max;
        %mkdir impactparamdata
        %mkdir difscatterdata
        % Loop through energies
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
            % Update progress bar if provided
            if nargin > 2 && isvalid(progressBar)
                progressBar.Value = i / numESteps;
                progressBar.Message = sprintf('Running %f eV...', E);
            end
            difscatter = difscatter(Z1, Z2, theta, E);
            impactparam = impact(Z2, Z2, theta, E);
            doca = distclose(Z1, Z2, impactparam, E);
            colNames(i+1) = sprintf('E=%f',E);
            colNamesC(1,2*i-1) = sprintf('bval E=%f',E);
            colNamesC(1,2*i) = sprintf('doca E=%f',E);
            A(:,i+1) = difscatter';
            B(:,i+1) = impactparam';
            C(:,2*i-1) = impactparam';
            C(:,2*i) = doca';
        end
        %disp(colNamesC)
        ATable = array2table(A,'VariableNames',colNames);
        BTable = array2table(B,'VariableNames',colNames);
        CTable = array2table(C,'VariableNames',colNamesC);
        difscatterdatapath = fullfile(datafilepath,'/difscatterdata.csv');
        impactparamdatapath = fullfile(datafilepath,'/impactparamdata.csv');
        docadatapath = fullfile(datafilepath,'/docadata.csv');
        writetable(ATable, difscatterdatapath);
        writetable(BTable, impactparamdatapath);
        writetable(CTable, docadatapath);

    elseif strcmp(inttype, 'Numerical')
        %mkdir scatterangledata;
        mkdir magicscatterdata
        run(fitfile);
        if strcmp(Potential_Type, 'Coulomb')
            potential = @(r) coulomb(Z1, z2_param, r);
        elseif strcmp(Potential_Type, '12-6 Lennard-Jones')
            potential = @(r) lj_126(eps_param, sigma_param, r);
        elseif strcmp(Potential_Type, '12-4 Lennard-Jones')
            potential = @(r) lj_124(eps_param, sigma_param, r);
        elseif strcmp(Potential_Type, 'ZBL')
            potential = @(r) zbl(Z1, z2_param, r);
        elseif strcmp(Potential_Type, 'Morse')
            potential = @(r) morse(rm_param,eps_param,k_param,r);
        elseif strcmp(Potential_Type, 'Power Law')
            potential = @(r) powerlaw(a_param, k_param, r);
        end
        if blogspace_on == 1
            minblog = log10(bmin);
            maxblog = log10(bmax);
            bvals = logspace(minblog,maxblog,blogstep);
        elseif blogspace_on == 0
            bvals = bmin:bstep:bmax;
        end

        % Loop through energies
        numESteps = numel(Evals);
        numBSteps = numel(bvals);
        A = zeros(numBSteps,numESteps);
        B = zeros(numBSteps,numESteps);
        colNames = strings(1,1+numESteps);
        %disp(colNames)
        A(:,1) = bvals';
        B(:,1) = bvals';
        colNames(1,1) = 'bvals';
       
        for i = 1:numESteps
            E = Evals(i);
            % Update progress bar if provided
            if nargin > 2 && isvalid(progressBar)
                progressBar.Value = i / numESteps;
                progressBar.Message = sprintf('Running %f eV...', E);
            end
            docas = zeros(1, length(bvals));
            th = zeros(1, length(bvals));
            thmagic = zeros(1,length(bvals));
            for j = 1:length(bvals)
                docas(j) = DOCAroot(E, bvals(j), potential, minroot, maxroot);
                th(j) = GMquadScatteringAngle(potential, E, bvals(j), docas(j), 20);
                if strcmp(Potential_Type, 'ZBL')
                    thmagic(j) = magicscatter(E,bvals(j),potential,docas(j),Z1,z2_param);
                    %disp(thmagic(j))
                end
            end
            %disp(thmagic)
            colNames(i+1) = sprintf('E=%f',E);
            A(:,i+1) = th';
            B(:,i+1) = docas';
            C = [bvals' thmagic'];
            %magicscatterpath = fullfile(datafilepath,sprintf('/magicscatterdata/scatterangledata_%f.csv',E));
            %writematrix(C, magicscatterpath)
        end
        %disp(colNames)
        ATable = array2table(A,'VariableNames',colNames);
        BTable = array2table(B,'VariableNames',colNames);
        scatterangdatapath = fullfile(datafilepath,'/scatterangledata.csv');
        docadatapath = fullfile(datafilepath,'/docadata.csv');
        writetable(ATable, scatterangdatapath);
        writetable(BTable, docadatapath);
        %writematrix(C, magicscatterpath)
    end
end
    