classdef TestTransportCoefs < matlab.unittest.TestCase


    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods
        function testmy_diffusioncoefexact(testCase)
            addpath('../test')
            Tvals = 100:1:1000;
            data = 'diffusioncstestdata.csv';
            actSolution = my_diffusioncoef(124,Tvals,1.013,39.948,39.948,3.418,'Exact',data); 
            expSolution = readmatrix('exactdiffusioncoefdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end
        function testmy_visccoefexact(testCase)
            addpath('../test')
            Tvals = 100:1:1000;
            data = 'viscositycstestdata.csv';
            actSolution = my_visccoef(124,Tvals,39.948,39.948,3.418,'Exact',data); 
            expSolution = readmatrix('exactviscositycoefdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end

        function testmy_diffusioncoeftrap(testCase)
            addpath('../test')
            Tvals = 100:1:1000;
            data = 'diffusioncstestdata.csv';
            actSolution = my_diffusioncoef(124,Tvals,1.013,39.948,39.948,3.418,'Trapezoidal',data); 
            expSolution = readmatrix('trapdiffusioncoefdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end
        function testmy_visccoeftrap(testCase)
            addpath('../test')
            Tvals = 100:1:1000;
            data = 'viscositycstestdata.csv';
            actSolution = my_visccoef(124,Tvals,39.948,39.948,3.418,'Trapezoidal',data); 
            expSolution = readmatrix('trapviscositycoefdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end
    end
end
