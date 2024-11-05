function y = run_scatteringintegrals(filepath,datafilepath)
%RUN_SCATTERINGINTEGRALS    Reads scattering input file and calculates scattering integrals.
%   RUN_SCATTERINGINTEGRALS(FILEPATH,DATAFILEPATH) reads the user-specified
%   Coulomb/scattering parameters from the scattering input file and 
%   calculates the differential scattering cross section, impact parameter,
%   and distance of closest approach (for the Coulomb case), or calculates
%   the scattering angle and distance of closest approach (general) case.
%
%   -- FILEPATH must specify the path to where input file is.
%   -- DATAFILEPATH must specify where to save the potential data.
%
%   See also MY_IMPACT MY_DIFSCATTER MY_DISTCLOSE MY_DOCAROOT MY_GMQUADSCATTERINGANGLE
    y = datafilepath;
    run(filepath);
    Evals = minE:Estep:maxE;
    cd(sprintf('%s',y))
    mkdir docadata
    if strcmp(inttype,'Exact Coulomb')
        theta = theta_min:theta_step:theta_max;
        mkdir impactparamdata
        mkdir difscatterdata
        for E = Evals
            difscatter = my_difscatter(Z1,Z2,theta,E);
            impactparam = my_impact(Z2,Z2,theta,E);
            doca = my_distclose(Z1,Z2,impactparam,E);
            difscatterdatapath  = [datafilepath sprintf('/difscatterdata/difscatterdata_%f.csv',E)];
            impactparamdatapath = [datafilepath sprintf('/impactparamdata/impactparamdata_%f.csv',E)];
            docadatapath = [datafilepath sprintf('/docadata/docadata_%f.csv',E)];
            A = [theta' difscatter'];
            B = [theta' impactparam'];
            C = [impactparam' doca'];
            writematrix(A,difscatterdatapath);
            writematrix(B,impactparamdatapath);
            writematrix(C,docadatapath);
        end
    elseif strcmp(inttype,'Numerical')
        mkdir scatterangledata
        run(fitfile);
        if strcmp(Potential_Type,'Coulomb')
            potential  = @(r) my_coulomb(Z1,z2_param,r);
        elseif strcmp(Potential_Type,'Lennard-Jones')
            potential = @(r) my_lj(eps_param,sigma_param,r);
        elseif strcmp(Potential_Type,'ZBL')
            potential  = @(r) my_zbl(Z1,z2_param,r);
        elseif strcmp(Potential_Type,'Power Law')
            potential = @(r) my_powerlaw(a_param,k_param,r);
        end
        bvals = bmin:bstep:bmax;
        for E = Evals
            disp(E)
            docas = zeros(1,length(bvals));
            th = zeros(1,length(bvals));
            for j = 1:length(bvals)
                %disp(bvals(j))
                docas(j) = my_DOCAroot(E,bvals(j),potential,minroot,maxroot);
                th(j) = my_GMquadScatteringAngle(potential,E,bvals(j),docas(j),10);
                %make it so user can choose n?
            end
            scatterangdatapath  = [datafilepath sprintf('/scatterangledata/scatterangledata_%f.csv',E)];
            docadatapath = [datafilepath sprintf('/docadata/docadata_%f.csv',E)];
            A = [bvals' th'];
            B = [bvals' docas'];
            writematrix(A,scatterangdatapath);
            writematrix(B,docadatapath);
        end
    end
    