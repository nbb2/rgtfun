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
    end

end