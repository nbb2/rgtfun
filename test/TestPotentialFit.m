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
            addpath('../src')
            model = run_fitpotential('../testFiles/PotentialFit/coulomb_fitinputfile.m','../testFiles/PotentialFit/coulomb_testdata.csv');
            run('../testFiles/PotentialFit/coulomb_fitinputfile.m');
            run('../testFiles/PotentialFit/coulomb_fitoutputfile.m');
            actSolution = model.z2;
            expSolution = z2_param;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=0.00001);
        end
        function testrun_fitpotentialzbl(testCase)
            model = run_fitpotential('../testFiles/PotentialFit/zbl_fitinputfile.m','../testFiles/PotentialFit/zbl_testdata.csv');
            run('../testFiles/PotentialFit/zbl_fitinputfile.m');
            run('../testFiles/PotentialFit/zbl_fitoutputfile.m');
            actSolution = model.z2;
            expSolution = z2_param;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=0.00001);
        end

        function testrun_fitpotentiallj126(testCase)
            model = run_fitpotential('../testFiles/PotentialFit/lj126_fitinputfile.m','../testFiles/PotentialFit/lj126_testdata.csv');
            run('../testFiles/PotentialFit/lj126_fitinputfile.m');
            run('../testFiles/PotentialFit/lj126_fitoutputfile.m');
            coefs = coeffvalues(model);
            actSolution1 = coefs(1);
            actSolution2 = coefs(2);
            expSolution1 = eps_param;
            expSolution2 = sigma_param;
            testCase.verifyEqual(actSolution1,expSolution1,AbsTol=0.00001);
            testCase.verifyEqual(actSolution2,expSolution2,AbsTol=0.00001);
        end

        function testrun_fitpotentiallj124(testCase)
            model = run_fitpotential('../testFiles/PotentialFit/lj124_fitinputfile.m','../testFiles/PotentialFit/lj124_testdata.csv');
            run('../testFiles/PotentialFit/lj124_fitinputfile.m');
            run('../testFiles/PotentialFit/lj124_fitoutputfile.m');
            coefs = coeffvalues(model);
            actSolution1 = coefs(1);
            actSolution2 = coefs(2);
            expSolution1 = eps_param;
            expSolution2 = sigma_param;
            testCase.verifyEqual(actSolution1,expSolution1,AbsTol=0.00001);
            testCase.verifyEqual(actSolution2,expSolution2,AbsTol=0.00001);
        end

        function testrun_fitpotentialmorse(testCase)
            model = run_fitpotential('../testFiles/PotentialFit/morse_fitinputfile.m','../testFiles/PotentialFit/morse_testdata.csv');
            run('../testFiles/PotentialFit/morse_fitinputfile.m');
            run('../testFiles/PotentialFit/morse_fitoutputfile.m');
            coefs = coeffvalues(model);
            actSolution1 = coefs(1);
            actSolution2 = coefs(2);
            actSolution3 = coefs(3);
            expSolution1 = rm_param;
            expSolution2 = eps_param;
            expSolution3 = k_param;
            testCase.verifyEqual(actSolution1,expSolution1,AbsTol=0.00001);
            testCase.verifyEqual(actSolution2,expSolution2,AbsTol=0.00001);
            testCase.verifyEqual(actSolution3,expSolution3,AbsTol=0.00001);
        end

        function testrun_fitpotentialpowerlaw(testCase)
            model = run_fitpotential('../testFiles/PotentialFit/powerlaw_fitinputfile.m','../testFiles/PotentialFit/powerlaw_testdata.csv');
            run('../testFiles/PotentialFit/powerlaw_fitinputfile.m');
            run('../testFiles/PotentialFit/powerlaw_fitoutputfile.m');
            coefs = coeffvalues(model);
            actSolution1 = coefs(1);
            actSolution2 = coefs(2);
            expSolution1 = a_param;
            expSolution2 = k_param;
            testCase.verifyEqual(actSolution1,expSolution1,AbsTol=0.00001);
            testCase.verifyEqual(actSolution2,expSolution2,AbsTol=0.00001);
        end
        function test_coulombchar(testCase)
            actSolution = coulombchar(2); 
            expSolution = load('../testFiles/PotentialFit/testcoulombchar.mat').testchar;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
        function test_zblchar(testCase)
            actSolution = zblchar(2); 
            expSolution = load('../testFiles/PotentialFit/testzblchar.mat').zbl;
            testCase.verifyEqual(actSolution,expSolution,AbsTol=sqrt(eps));
        end
        
       
    end

end
