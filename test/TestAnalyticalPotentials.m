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
        function testCoulomb(testCase)
            addpath('../test')
            actSolution = my_coulomb(15,2,0.1:0.1:10); 
            expSolution = load('Coulombpotentialtestdata.mat').testdata;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
    end

end