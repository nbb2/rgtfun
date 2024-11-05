classdef TestCrossSections < matlab.unittest.TestCase


    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods
        function testmy_diffusioncs(testCase)
            addpath('../test')
            Evals = 0.01:0.01:100;
            well_depth = 0.010685;
            beta = well_depth./(2*Evals); 
            actSolution = my_diffusioncs(beta); 
            expSolution = readmatrix('diffusioncstestdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end
        function testmy_viscositycs(testCase)
            addpath('../test')
            Evals = 0.01:0.01:100;
            well_depth = 0.010685;
            beta = well_depth./(2*Evals); 
            actSolution = my_viscositycs(beta); 
            expSolution = readmatrix('viscositycstestdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end
    end
end
