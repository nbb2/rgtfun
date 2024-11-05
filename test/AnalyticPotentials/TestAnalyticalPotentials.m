classdef TestAnalyticalPotentials < matlab.unittest.TestCase


    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods
        function testrun_calcpotential(testCase)
            addpath('../test')
            run_calcpotential('potentialinputfile.m','../AnalyticPotentials');
            actSolution = readmatrix("coulombdata.csv");
            expSolution = readmatrix("coulomb_testdata.csv");
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
        function testmy_Coulomb(testCase)
            addpath('../test')
            actSolution = my_coulomb(1,1,1:0.1:20); 
            expSolution = readmatrix('coulomb_testdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end
       
        function testmy_lj(testCase)
            addpath('../test')
            actSolution = my_lj(2,4,2:0.1:20); 
            expSolution = readmatrix('lj_testdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end
        function testmy_zbl(testCase)
            addpath('../test')
            actSolution = my_zbl(1,1,1:0.1:20); 
            expSolution = readmatrix('zbl_testdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end
        function testmy_powerlaw(testCase)
            addpath('../test')
            actSolution = my_powerlaw(10,4,1:0.1:20); 
            expSolution = readmatrix('powerlaw_testdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end
        
       
    end

end
