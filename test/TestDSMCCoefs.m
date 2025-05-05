classdef TestDSMCCoefs < matlab.unittest.TestCase


    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods
        function test_VHSomega(testCase)
            N = 20;
            tol = 1e-20;
            visccoefdata = readmatrix('../testFiles/DSMCCoefs/numlj_viscositycoefdata.csv');
            visccoef = visccoefdata(:,2);
            Tvals = visccoefdata(:,1);
            Tfine = min(Tvals):0.01:max(Tvals);
            vqvisc = interp1(Tvals,visccoef,Tfine);
            delta = (max(Tvals) - min(Tvals))/N;
            offset = min(Tvals);
            actSolution = zeros(1,N);
            for i = 1:N
                minT = offset;
                maxT = minT + delta;
                excludeT = ((Tfine < minT) | (Tfine > maxT));
                fitT = Tfine;
                fitT(excludeT) = [];
                T_sample = 0.5*(minT + maxT);
                mu_sample = interp1(Tfine, vqvisc, T_sample);
                vhscoefs = VHScoef(fitT,T_sample,mu_sample,excludeT,vqvisc,tol);
                omega = vhscoefs(2);
                actSolution(i) = omega;
                offset  = offset + delta;
            end
            expSolution = readmatrix('../testFiles/DSMCCoefs/ref_vhscoeftable.csv');
            testCase.verifyEqual(actSolution,expSolution(:,5)',AbsTol=sqrt(eps));
        end

        function test_VSSalpha(testCase)
            mr = 39;
            alphaguess = 1.2;
            tol = 1e-20;
            mrkg = mr/(6.022E26);
            molarkg = mr/(1E3);
            difcoefdata = readmatrix('../testFiles/DSMCCoefs/numlj_diffusioncoefdata.csv');
            vhscoefdata = readmatrix('../testFiles/DSMCCoefs/ref_vhscoeftable.csv');
            viscvals = vhscoefdata(:,3)*(1E-6);
            omegavals = vhscoefdata(:,5);
            alphavals = alphaguess*ones(length(omegavals),1);
            Tvals = vhscoefdata(:,4);
            difcoef = difcoefdata(:,2);
            difcoef_T = difcoefdata(:,1);
            dif_sample = interp1(difcoef_T, difcoef, Tvals);
            max_iter = 100;
            iter = 0;
            while VSSconvergence(alphavals,omegavals,molarkg,Tvals,dif_sample,viscvals,tol) && iter < max_iter
            diams = VSSdiameter(alphavals,omegavals,mrkg,Tvals,viscvals);
            newalpha = VSSalpha(omegavals,mrkg,molarkg,Tvals,dif_sample,diams);
            alphavals = newalpha;
            iter = iter + 1;
            end
            actSolution = alphavals;
            expSolution = readmatrix('../testFiles/DSMCCoefs/ref_VSScoeftable.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2),AbsTol=sqrt(eps));
        end

        function test_VSSdiam(testCase)
            mr = 39;
            alphaguess = 1.2;
            tol = 1e-20;
            mrkg = mr/(6.022E26);
            molarkg = mr/(1E3);
            difcoefdata = readmatrix('../testFiles/DSMCCoefs/numlj_diffusioncoefdata.csv');
            vhscoefdata = readmatrix('../testFiles/DSMCCoefs/ref_vhscoeftable.csv');
            viscvals = vhscoefdata(:,3)*(1E-6);
            omegavals = vhscoefdata(:,5);
            alphavals = alphaguess*ones(length(omegavals),1);
            Tvals = vhscoefdata(:,4);
            difcoef = difcoefdata(:,2);
            difcoef_T = difcoefdata(:,1);
            dif_sample = interp1(difcoef_T, difcoef, Tvals);
            max_iter = 100;
            iter = 0;
            while VSSconvergence(alphavals,omegavals,molarkg,Tvals,dif_sample,viscvals,tol) && iter < max_iter
            diams = VSSdiameter(alphavals,omegavals,mrkg,Tvals,viscvals);
            newalpha = VSSalpha(omegavals,mrkg,molarkg,Tvals,dif_sample,diams);
            alphavals = newalpha;
            iter = iter + 1;
            end
            diams = VSSdiameter(alphavals,omegavals,mrkg,Tvals,viscvals);
            diams_angstrom  = diams*(1E10);
            actSolution = diams_angstrom;
            expSolution = readmatrix('../testFiles/DSMCCoefs/ref_VSScoeftable.csv');
            testCase.verifyEqual(actSolution,expSolution(:,3),AbsTol=sqrt(eps));
        end
       
    end
end