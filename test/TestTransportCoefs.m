classdef TestTransportCoefs < matlab.unittest.TestCase


    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods
        function test_diffusioncoefexact(testCase)
            Tvals = 100:1:1000;
            data = '../testFiles/TransportCoefs/diffusioncstestdata.csv';
            actSolution = diffusion_coef(124,Tvals,39.948,39.948,3.418,'Exact LJ',data); 
            expSolution = readmatrix('../testFiles/TransportCoefs/exactdiffusioncoefdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end

        function test_visccoefexact(testCase)
            Tvals = 100:1:1000;
            data = '../testFiles/TransportCoefs/viscositycstestdata.csv';
            actSolution = visc_coef(124,Tvals,39.948,39.948,3.418,'Exact LJ',data); 
            expSolution = readmatrix('../testFiles/TransportCoefs/exactviscositycoefdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end

        function test_diffusioncoefnum(testCase)
            Tvals = 100:1:1000;
            actSolution = numdiffusioncoef(Tvals,39,39,'../testFiles/TransportCoefs/numlj_diffusioncsdata.csv'); 
            expSolution = readmatrix('../testFiles/TransportCoefs/numlj_diffusioncoefdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end

        function test_visccoefnum(testCase)
            Tvals = 100:1:1000;
            actSolution = numvisccoef(Tvals,39,39,'../testFiles/TransportCoefs/numlj_viscositycsdata.csv'); 
            expSolution = readmatrix('../testFiles/TransportCoefs/numlj_viscositycoefdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end
    end
end
