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
            %addpath('../test')
            run_calcpotential('../testFiles/AnalyticPotentials/potentialinputfile.m','../testFiles/AnalyticPotentials');
            actSolution = readmatrix("../testFiles/AnalyticPotentials/coulombdata.csv");
            expSolution = readmatrix("../testFiles/AnalyticPotentials/coulomb_testdata.csv");
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
        function test_Coulomb(testCase)
            %addpath('../test')
            actSolution = coulomb(1,1,1:0.1:20); 
            expSolution = readmatrix('../testFiles/AnalyticPotentials/coulomb_testdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end
       
        function test_lj126(testCase)
            %addpath('../test')
            actSolution = lj_126(2,4,2:0.1:20); 
            expSolution = readmatrix('../testFiles/AnalyticPotentials/126lj_testdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end

        function test_lj124(testCase)
            %addpath('../test')
            actSolution = lj_124(2,4,2:0.1:20); 
            expSolution = readmatrix('../testFiles/AnalyticPotentials/124lj_testdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end

        function test_zbl(testCase)
            %addpath('../test')
            actSolution = zbl(1,1,1:0.1:20); 
            expSolution = readmatrix('../testFiles/AnalyticPotentials/zbl_testdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end

        function test_powerlaw(testCase)
            %addpath('../test')
            actSolution = powerlaw(10,4,1:0.1:20); 
            expSolution = readmatrix('../testFiles/AnalyticPotentials/powerlaw_testdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end
        
        function test_morse(testCase)
            %addpath('../test')
            actSolution = morse(3,0.5,6,2:0.1:20); 
            expSolution = readmatrix('../testFiles/AnalyticPotentials/morse_testdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end
       
    end

end
