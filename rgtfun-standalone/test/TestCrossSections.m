classdef TestCrossSections < matlab.unittest.TestCase


    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods
        function test_diffusioncs(testCase)
            Evals = 0.01:0.01:100;
            well_depth = 0.010685;
            beta = well_depth./(2*Evals); 
            actSolution = diffusioncs(beta); 
            expSolution = readmatrix('../testFiles/CrossSections/diffusioncstestdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end

        function test_viscositycs(testCase)
            Evals = 0.01:0.01:100;
            well_depth = 0.010685;
            beta = well_depth./(2*Evals); 
            actSolution = viscositycs(beta); 
            expSolution = readmatrix('../testFiles/CrossSections/viscositycstestdata.csv');
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end

        function test_numdiffusioncs(testCase)
            scatterdata = readmatrix('../testFiles/CrossSections/numlj_scatterangledata.csv');
            run('../testFiles/CrossSections/numljtransportinputfile.m')
            Evals = logspace(minE,maxE,logstep);
            actSolution = zeros(1,length(Evals));
            expSolution = readmatrix('../testFiles/CrossSections/numlj_diffusioncsdata.csv');
            for j = 1:length(Evals)
                th = scatterdata(:,j+1);
                bvals = scatterdata(:,1);
                actSolution(j) = numdiffusioncs(bvals,th);
            end
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end

        function test_numviscositycs(testCase)
            scatterdata = readmatrix('../testFiles/CrossSections/numlj_scatterangledata.csv');
            run('../testFiles/CrossSections/numljtransportinputfile.m')
            Evals = logspace(minE,maxE,logstep);
            actSolution = zeros(1,length(Evals));
            expSolution = readmatrix('../testFiles/CrossSections/numlj_viscositycsdata.csv');
            for j = 1:length(Evals)
                th = scatterdata(:,j+1);
                bvals = scatterdata(:,1);
                actSolution(j) = numvisccs(bvals,th);
            end
            testCase.verifyEqual(actSolution,expSolution(:,2)',AbsTol=sqrt(eps));
        end
    end
end
