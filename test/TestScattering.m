classdef TestScattering < matlab.unittest.TestCase
    methods (TestClassSetup)
        % Shared setup for the entire test class
    end
    methods (TestMethodSetup)
        % Setup for each test
    end
    methods (Test)
        % Test methods
        function test_difscatter(testCase)
            run('../testFiles/ScatteringQuantities/coulombscatterintinputfile.m')
            file = '../testFiles/ScatteringQuantities/coulomb_difscatterdata.csv';
            expSolution = readmatrix(file);
            Evals = minE:Estep:maxE;
            numESteps = numel(Evals);
            for i = 1:numESteps
                E = Evals(i);
                ref_data = expSolution(:,i+1);
                actSolution = difscatter(1,1,0.001:0.001:3.14,E); 
                testCase.verifyEqual(actSolution,ref_data',AbsTol=sqrt(eps));
            end
        end
        function test_impact(testCase)
            run('../testFiles/ScatteringQuantities/coulombscatterintinputfile.m')
            file = '../testFiles/ScatteringQuantities/coulomb_impactparamdata.csv';
            expSolution = readmatrix(file);
            Evals = minE:Estep:maxE;
            numESteps = numel(Evals);
            for i = 1:numESteps
                E = Evals(i);
                ref_data = expSolution(:,i+1);
                actSolution = impact(1,1,0.001:0.001:3.14,E); 
                testCase.verifyEqual(actSolution,ref_data',AbsTol=sqrt(eps));
            end
        end
        function test_doca(testCase)
            run('../testFiles/ScatteringQuantities/coulombscatterintinputfile.m')
            file = '../testFiles/ScatteringQuantities/coulomb_docadata.csv';
            expSolution = readmatrix(file);
            Evals = minE:Estep:maxE;
            numESteps = numel(Evals);
            for i = 1:numESteps
                E = Evals(i);
                ref_data = expSolution(:,2*i);
                actSolution = distclose(1,1,my_impact(1,1,0.001:0.001:3.14,E),E); 
                testCase.verifyEqual(actSolution,ref_data',AbsTol=sqrt(eps));
            end
        end
        function test_DOCArootcoul(testCase)
            run('../testFiles/ScatteringQuantities/numcoulscatterintinputfile.m');
            run('../testFiles/ScatteringQuantities/coulomb_fitoutputfile.m');
            file = '../testFiles/ScatteringQuantities/numcoul_docadata.csv';
            expSolution = readmatrix(file);
            potential  = @(r) my_coulomb(Z1,z2_param,r);
            bvals = bmin:bstep:bmax;
            Evals = minE:Estep:maxE;
            numESteps = numel(Evals);
            for i = 1:numESteps
                E = Evals(i);
                docas = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = DOCAroot(E,bvals(j),potential,minroot,maxroot);
                end
                ref_data = expSolution(:,i+1);
                actSolution = docas; 
                testCase.verifyEqual(actSolution,ref_data',AbsTol=sqrt(eps));
            end
        end
        function test_DOCArootlj(testCase)
            run('../testFiles/ScatteringQuantities/numljscatterintinputfile.m');
            run('../testFiles/ScatteringQuantities/lj_fitoutputfile.m');
            file = '../testFiles/ScatteringQuantities/numlj_docadata.csv';
            expSolution = readmatrix(file);
            potential = @(r) my_lj(eps_param,sigma_param,r);
            bvals = bmin:bstep:bmax;
            Evals = minE:Estep:maxE;
            numESteps = numel(Evals);
            for i = 1:numESteps
                E = Evals(i);
                docas = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = DOCAroot(E,bvals(j),potential,minroot,maxroot);
                end
                ref_data = expSolution(:,i+1);
                actSolution = docas; 
                testCase.verifyEqual(actSolution,ref_data',AbsTol=sqrt(eps));
            end
        end
        function test_DOCArootzbl(testCase)
            run('../testFiles/ScatteringQuantities/numzblscatterintinputfile.m');
            run('../testFiles/ScatteringQuantities/zbl_fitoutputfile.m');
            file = '../testFiles/ScatteringQuantities/numzbl_docadata.csv';
            expSolution = readmatrix(file);
            potential  = @(r) my_zbl(Z1,z2_param,r);
            bvals = bmin:bstep:bmax;
            Evals = minE:Estep:maxE;
            numESteps = numel(Evals);
            for i = 1:numESteps
                E = Evals(i);
                docas = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = DOCAroot(E,bvals(j),potential,minroot,maxroot);
                end
                ref_data = expSolution(:,i+1);
                actSolution = docas; 
                testCase.verifyEqual(actSolution,ref_data',AbsTol=sqrt(eps));
            end
        end
        function test_DOCArootpowerlaw(testCase)
            run('../testFiles/ScatteringQuantities/numpowerlawscatterintinputfile.m');
            run('../testFiles/ScatteringQuantities/powerlaw_fitoutputfile.m');
            file = '../testFiles/ScatteringQuantities/numpowerlaw_docadata.csv';
            expSolution = readmatrix(file);
            potential  = @(r) powerlaw(a_param,k_param,r);
            bvals = bmin:bstep:bmax;
            Evals = minE:Estep:maxE;
            numESteps = numel(Evals);
            for i = 1:numESteps
                E = Evals(i);
                docas = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = DOCAroot(E,bvals(j),potential,minroot,maxroot);
                end
                ref_data = expSolution(:,i+1);
                actSolution = docas; 
                testCase.verifyEqual(actSolution,ref_data',AbsTol=sqrt(eps));
            end
        end
        function test_gmscattercoul(testCase)
            run('../testFiles/ScatteringQuantities/numcoulscatterintinputfile.m');
            run('../testFiles/ScatteringQuantities/coulomb_fitoutputfile.m');
            file = '../testFiles/ScatteringQuantities/numcoul_docadata.csv';
            expSolution = readmatrix(file);
            potential  = @(r) coulomb(Z1,z2_param,r);
            bvals = bmin:bstep:bmax;
            Evals = minE:Estep:maxE;
            numESteps = numel(Evals);
            for i = 1:numESteps
                E = Evals(i);
                docas = zeros(1,length(bvals));
                th = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = DOCAroot(E,bvals(j),potential,minroot,maxroot);
                    th(j) = GMquadScatteringAngle(potential,E,bvals(j),docas(j),10);
                end
                ref_data = expSolution(:,i+1);
                actSolution = th; 
                testCase.verifyEqual(actSolution,ref_data',AbsTol=sqrt(eps));
            end
        end
        function test_gmscatterlj(testCase)
            run('../testFiles/ScatteringQuantities/numljscatterintinputfile.m');
            run('../testFiles/ScatteringQuantities/lj_fitoutputfile.m');
            file = '../testFiles/ScatteringQuantities/numlj_docadata.csv';
            expSolution = readmatrix(file);
            potential = @(r) lj_126(eps_param,sigma_param,r);
            bvals = bmin:bstep:bmax;
            Evals = minE:Estep:maxE;
            numESteps = numel(Evals);
            for i = 1:numESteps
                E = Evals(i);
                docas = zeros(1,length(bvals));
                th = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = DOCAroot(E,bvals(j),potential,minroot,maxroot);
                    th(j) = GMquadScatteringAngle(potential,E,bvals(j),docas(j),10);
                end
                ref_data = expSolution(:,i+1);
                actSolution = th; 
                testCase.verifyEqual(actSolution,ref_data',AbsTol=sqrt(eps));
            end
        end
        function test_gmscatterzbl(testCase)
            run('../testFiles/ScatteringQuantities/numzblscatterintinputfile.m');
            run('../testFiles/ScatteringQuantities/zbl_fitoutputfile.m');
            file = '../testFiles/ScatteringQuantities/numzbl_docadata.csv';
            expSolution = readmatrix(file);
            potential  = @(r) zbl(Z1,z2_param,r);
            bvals = bmin:bstep:bmax;
            Evals = minE:Estep:maxE;
            numESteps = numel(Evals);
            for i = 1:numESteps
                E = Evals(i);
                docas = zeros(1,length(bvals));
                th = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = DOCAroot(E,bvals(j),potential,minroot,maxroot);
                    th(j) = GMquadScatteringAngle(potential,E,bvals(j),docas(j),10);
                end
                ref_data = expSolution(:,i+1);
                actSolution = th; 
                testCase.verifyEqual(actSolution,ref_data',AbsTol=sqrt(eps));
            end
        end
        function test_gmscatterpowerlaw(testCase)
            run('../testFiles/ScatteringQuantities/numpowerlawscatterintinputfile.m');
            run('../testFiles/ScatteringQuantities/powerlaw_fitoutputfile.m');
            file = '../testFiles/ScatteringQuantities/numpowerlaw_docadata.csv';
            expSolution = readmatrix(file);
            potential  = @(r) powerlaw(a_param,k_param,r);
            bvals = bmin:bstep:bmax;
            Evals = minE:Estep:maxE;
            numESteps = numel(Evals);
            for i = 1:numESteps
                E = Evals(i);
                docas = zeros(1,length(bvals));
                th = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = DOCAroot(E,bvals(j),potential,minroot,maxroot);
                    th(j) = GMquadScatteringAngle(potential,E,bvals(j),docas(j),10);
                end
                ref_data = expSolution(:,i+1);
                actSolution = th; 
                testCase.verifyEqual(actSolution,ref_data',AbsTol=sqrt(eps));
            end
        end
    end
end
