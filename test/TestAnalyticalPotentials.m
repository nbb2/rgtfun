classdef TestAnalyticalPotentials < matlab.unittest.TestCase


    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function testRealSolution(testCase)
            addpath('../src')
            actSolution = my_root(4);
            expSolution = 2;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
        function testmy_Coulomb(testCase)
            addpath('../test')
            actSolution = my_coulomb(15,2,0.1:0.1:10); 
            expSolution = load('Coulombpotentialtestdata.mat').testdata;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
        function testmy_difscatter(testCase)
            addpath('../test')
            actSolution = my_difscatter(15,2,0:0.1:pi,100); 
            expSolution = load('Difscattertestdata.mat').ans;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
        function testmy_impact(testCase)
            addpath('../test')
            actSolution = my_impact(15,2,0:0.1:pi,100); 
            expSolution = load('Impactparamtestdata.mat').ans;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
        function testrun_calcpotential(testCase)
            addpath('../test')
            run_calcpotential('../test');
            actSolution = readmatrix("coulomb_data.csv");
            expSolution = readmatrix("coulomb_testdata.csv");
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
        function testrun_fitpotential(testCase)
            addpath('../test')
            model = run_fitpotential('../test');
            run('fitinputfile.m');
            if strcmp(Potential_Type,"Coulomb")
                actSolution = model.z2;
                expSolution = load('fittingtestdata.mat').y.z2;
            end
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
        function testmy_coulombchar(testCase)
            addpath('../test')
            actSolution = my_coulombchar(2); 
            expSolution = load('testcoulombchar.mat').testchar;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
        function testmy_lj(testCase)
            addpath('../test')
            actSolution = my_lj(2,4,3:0.01:20); 
            expSolution = load('ljtestdata.mat').dat;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
        function testmy_doca(testCase)
            addpath('../test')
            actSolution = my_distclose(2,15,my_impact(15,2,0:0.1:pi,100),100); 
            expSolution = load('docatestdata.mat').doca;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
    end

end