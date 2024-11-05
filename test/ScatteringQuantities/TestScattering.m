classdef TestScattering < matlab.unittest.TestCase
    methods (TestClassSetup)
        % Shared setup for the entire test class
    end
    methods (TestMethodSetup)
        % Setup for each test
    end
    methods (Test)
        % Test methods
        function testmy_difscatter(testCase)
            addpath('../test')
            run('coulombscatterintinputfile.m')
            for E = minE:Estep:maxE
                file = sprintf('./difscatter_testdata/difscatterdata_%f.csv',E);
                expSolution = readmatrix(file);
                actSolution = my_difscatter(1,1,0:0.1:3.14,E); 
                testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
            end
        end
        function testmy_impact(testCase)
            addpath('../test')
            run('coulombscatterintinputfile.m')
            for E = minE:Estep:maxE
                file = sprintf('./impactparam_testdata/impactparamdata_%f.csv',E);
                expSolution = readmatrix(file);
                actSolution = my_impact(1,1,0:0.1:3.14,E); 
                testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
            end
        end
        function testmy_doca(testCase)
            addpath('../test')
            run('coulombscatterintinputfile.m')
            for E = minE:Estep:maxE
                file = sprintf('./doca_testdata/docadata_%f.csv',E);
                expSolution = readmatrix(file);
                actSolution = my_distclose(1,1,my_impact(1,1,0:0.1:3.14,E),E); 
                testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
            end
        end
        function testmy_DOCArootcoul(testCase)
            addpath('../test')
            run('numcoulscatterintinputfile.m');
            run('coulomb_fitoutputfile.m');
            potential  = @(r) my_coulomb(Z1,z2_param,r);
            bvals = bmin:bstep:bmax;
            for E = minE:Estep:maxE
                docas = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = my_DOCAroot(E,bvals(j),potential,minroot,maxroot);
                end
                file = sprintf('./numcouldoca_testdata/docadata_%f.csv',E);
                expSolution = readmatrix(file);
                actSolution = docas; 
                testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
            end
        end
        function testmy_DOCArootlj(testCase)
            addpath('../test')
            run('numljscatterintinputfile.m');
            run('lj_fitoutputfile.m');
            potential = @(r) my_lj(eps_param,sigma_param,r);
            bvals = bmin:bstep:bmax;
            for E = minE:Estep:maxE
                docas = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = my_DOCAroot(E,bvals(j),potential,minroot,maxroot);
                end
                file = sprintf('./numljdoca_testdata/docadata_%f.csv',E);
                expSolution = readmatrix(file);
                actSolution = docas; 
                testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
            end
        end
        function testmy_DOCArootzbl(testCase)
            addpath('../test')
            run('numzblscatterintinputfile.m');
            run('zbl_fitoutputfile.m');
            potential  = @(r) my_zbl(Z1,z2_param,r);
            bvals = bmin:bstep:bmax;
            for E = minE:Estep:maxE
                docas = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = my_DOCAroot(E,bvals(j),potential,minroot,maxroot);
                end
                file = sprintf('./numzbldoca_testdata/docadata_%f.csv',E);
                expSolution = readmatrix(file);
                actSolution = docas; 
                testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
            end
        end
        function testmy_DOCArootpowerlaw(testCase)
            addpath('../test')
            run('numpowerlawscatterintinputfile.m');
            run('powerlaw_fitoutputfile.m');
            potential  = @(r) my_powerlaw(a_param,k_param,r);
            bvals = bmin:bstep:bmax;
            for E = minE:Estep:maxE
                docas = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = my_DOCAroot(E,bvals(j),potential,minroot,maxroot);
                end
                file = sprintf('./numpowerlawdoca_testdata/docadata_%f.csv',E);
                expSolution = readmatrix(file);
                actSolution = docas; 
                testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
            end
        end
        function testmy_gmscattercoul(testCase)
            addpath('../test')
            run('numcoulscatterintinputfile.m');
            run('coulomb_fitoutputfile.m');
            potential  = @(r) my_coulomb(Z1,z2_param,r);
            bvals = bmin:bstep:bmax;
            for E = minE:Estep:maxE
                docas = zeros(1,length(bvals));
                th = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = my_DOCAroot(E,bvals(j),potential,minroot,maxroot);
                    th(j) = my_GMquadScatteringAngle(potential,E,bvals(j),docas(j),10);
                end
                file = sprintf('./numcoulscatterangle_testdata/scatterangledata_%f.csv',E);
                expSolution = readmatrix(file);
                actSolution = th; 
                testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
            end
        end
        function testmy_gmscatterlj(testCase)
            addpath('../test')
            run('numljscatterintinputfile.m');
            run('lj_fitoutputfile.m');
            potential = @(r) my_lj(eps_param,sigma_param,r);
            bvals = bmin:bstep:bmax;
            for E = minE:Estep:maxE
                docas = zeros(1,length(bvals));
                th = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = my_DOCAroot(E,bvals(j),potential,minroot,maxroot);
                    th(j) = my_GMquadScatteringAngle(potential,E,bvals(j),docas(j),10);
                end
                file = sprintf('./numljscatterangle_testdata/scatterangledata_%f.csv',E);
                expSolution = readmatrix(file);
                actSolution = th; 
                testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
            end
        end
        function testmy_gmscatterzbl(testCase)
            addpath('../test')
            run('numzblscatterintinputfile.m');
            run('zbl_fitoutputfile.m');
            potential  = @(r) my_zbl(Z1,z2_param,r);
            bvals = bmin:bstep:bmax;
            for E = minE:Estep:maxE
                docas = zeros(1,length(bvals));
                th = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = my_DOCAroot(E,bvals(j),potential,minroot,maxroot);
                    th(j) = my_GMquadScatteringAngle(potential,E,bvals(j),docas(j),10);
                end
                file = sprintf('./numzblscatterangle_testdata/scatterangledata_%f.csv',E);
                expSolution = readmatrix(file);
                actSolution = th; 
                testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
            end
        end
        function testmy_gmscatterpowerlaw(testCase)
            addpath('../test')
            run('numpowerlawscatterintinputfile.m');
            run('powerlaw_fitoutputfile.m');
            potential  = @(r) my_powerlaw(a_param,k_param,r);
            bvals = bmin:bstep:bmax;
            for E = minE:Estep:maxE
                docas = zeros(1,length(bvals));
                th = zeros(1,length(bvals));
                for j = 1:length(bvals)
                    disp(bvals(j))
                    docas(j) = my_DOCAroot(E,bvals(j),potential,minroot,maxroot);
                    th(j) = my_GMquadScatteringAngle(potential,E,bvals(j),docas(j),10);
                end
                file = sprintf('./numpowerlawscatterangle_testdata/scatterangledata_%f.csv',E);
                expSolution = readmatrix(file);
                actSolution = th; 
                testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
            end
        end
    end
end
