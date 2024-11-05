classdef TestPotentialFit < matlab.unittest.TestCase


    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods
        function testrun_fitpotentialcoul(testCase)
            addpath('../test')
            model = run_fitpotential('coulomb_fitinputfile.m','coulomb_testdata.csv');
            run('coulomb_fitinputfile.m');
            run('coulomb_fitoutputfile.m');
            actSolution = model.z2;
            expSolution = z2_param;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=0.00001);
        end
        function testrun_fitpotentialzbl(testCase)
            addpath('../test')
            model = run_fitpotential('zbl_fitinputfile.m','zbl_testdata.csv');
            run('zbl_fitinputfile.m');
            run('zbl_fitoutputfile.m');
            actSolution = model.z2;
            expSolution = z2_param;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=0.00001);
        end
        function testrun_fitpotentiallj(testCase)
            addpath('../test')
            model = run_fitpotential('lj_fitinputfile.m','lj_testdata.csv');
            run('lj_fitinputfile.m');
            run('lj_fitoutputfile.m');
            coefs = coeffvalues(model);
            actSolution1 = coefs(1);
            actSolution2 = coefs(2);
            expSolution1 = eps_param;
            expSolution2 = sigma_param;
            testCase.verifyEqual(actSolution1,expSolution1,AbsTol=0.00001);
            testCase.verifyEqual(actSolution2,expSolution2,AbsTol=0.00001);
        end
        function testrun_fitpotentialpowerlaw(testCase)
            addpath('../test')
            model = run_fitpotential('powerlaw_fitinputfile.m','powerlaw_testdata.csv');
            run('powerlaw_fitinputfile.m');
            run('powerlaw_fitoutputfile.m');
            coefs = coeffvalues(model);
            actSolution1 = coefs(1);
            actSolution2 = coefs(2);
            expSolution1 = a_param;
            expSolution2 = k_param;
            testCase.verifyEqual(actSolution1,expSolution1,AbsTol=0.00001);
            testCase.verifyEqual(actSolution2,expSolution2,AbsTol=0.00001);
        end
        function testmy_coulombchar(testCase)
            addpath('../test')
            actSolution = my_coulombchar(2); 
            expSolution = load('testcoulombchar.mat').testchar;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
        function testmy_zblchar(testCase)
            addpath('../test')
            actSolution = my_zblchar(2); 
            expSolution = load('testzblchar.mat').zbl;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
        
       
    end

end
