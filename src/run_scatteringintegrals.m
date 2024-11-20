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
%   See also MY_IMPACT MY_DIFSCATTER MY_DISTCLOSE MY_DOCAROOT MY_GMQUADSCATTERINGANGLE
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
    mkdir docadata

    if strcmp(inttype,'Exact Coulomb')
        theta = theta_min:theta_step:theta_max;
        mkdir impactparamdata
        mkdir difscatterdata


        % Loop through energies
        numSteps = numel(Evals);
        for i = 1:numSteps
            E = Evals(i);
            % Update progress bar if provided
            if nargin > 2 && isvalid(progressBar)
                progressBar.Value = i / numSteps;
                progressBar.Message = sprintf('Running %f eV...', E);
            end
            difscatter = my_difscatter(Z1, Z2, theta, E);
            impactparam = my_impact(Z2, Z2, theta, E);
            doca = my_distclose(Z1, Z2, impactparam, E);
            difscatterdatapath = [datafilepath sprintf('/difscatterdata/difscatterdata_%f.csv', E)];
            impactparamdatapath = [datafilepath sprintf('/impactparamdata/impactparamdata_%f.csv', E)];
            docadatapath = [datafilepath sprintf('/docadata/docadata_%f.csv', E)];
            A = [theta' difscatter'];
            B = [theta' impactparam'];
            C = [impactparam' doca'];
            writematrix(A, difscatterdatapath);
            writematrix(B, impactparamdatapath);
            writematrix(C, docadatapath);
        end

    elseif strcmp(inttype, 'Numerical')
        mkdir scatterangledata;
        run(fitfile);

        if strcmp(Potential_Type, 'Coulomb')
            potential = @(r) my_coulomb(Z1, z2_param, r);
        elseif strcmp(Potential_Type, 'Lennard-Jones')
            potential = @(r) my_lj(eps_param, sigma_param, r);
        elseif strcmp(Potential_Type, 'ZBL')
            potential = @(r) my_zbl(Z1, z2_param, r);
        elseif strcmp(Potential_Type, 'Power Law')
            potential = @(r) my_powerlaw(a_param, k_param, r);
        end
        if blogspace_on == 1
            minblog = log10(bmin);
            maxblog = log10(bmax);
            bvals = logspace(minblog,maxblog,blogstep);
        elseif blogspace_on == 0
            bvals = bmin:bstep:bmax;
        end

        % Loop through energies
        numSteps = numel(Evals);
        for i = 1:numSteps
            E = Evals(i);
            % Update progress bar if provided
            if nargin > 2 && isvalid(progressBar)
                progressBar.Value = i / numSteps;
                progressBar.Message = sprintf('Running %f eV...', E);
            end
            docas = zeros(1, length(bvals));
            th = zeros(1, length(bvals));
            for j = 1:length(bvals)
                docas(j) = my_DOCAroot(E, bvals(j), potential, minroot, maxroot);
                th(j) = my_GMquadScatteringAngle(potential, E, bvals(j), docas(j), 20);
            end
            scatterangdatapath = [datafilepath sprintf('/scatterangledata/scatterangledata_%f.csv', E)];
            docadatapath = [datafilepath sprintf('/docadata/docadata_%f.csv', E)];
            A = [bvals' th'];
            B = [bvals' docas'];
            writematrix(A, scatterangdatapath);
            writematrix(B, docadatapath);
        end
    end
end
    