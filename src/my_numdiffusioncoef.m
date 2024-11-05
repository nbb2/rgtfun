function y = my_numdiffusioncoef(Tvals,m1,m2,P,csdatafile)
%MY_NUMDIFFUSIONCOEF   Outputs float array with diffusion coefficient values.
%   Y=MY_NUMDIFFUSIONCOEF(TVALS,M1,M2,P,CSDATAFILE) generates a float array containing self-diffusion 
%   coefficient value for each value of Tvals. 
%
%   -- TVALS must be an array of temperatures in Kelvin.
%   -- M1 must be mass in amu.
%   -- M2 must be mass in amu.
%   -- CSDATAFILE must be location of diffusion cross section data file.
%
%   See also MY_NUMDIFFUSIONCOEF RUN_TRANSPORTCS
%kb = 1.380649E-23; %J/K
kb = 8.617333262E-5; %eV/K
mred = m1*m2/(m1+m2);
press = P*100000;
%mred = mredamu/(6.022E26); %kg
%P = Pbarr*100000; %Pa
%n = P./(kb*Tvals); %m^-3
csdata = readmatrix(csdatafile);
Evals = csdata(:,1); %eV
csvals = csdata(:,2); %A^2
PD = 157081.8*(3/8)*((2*pi/mred)^(0.5))*((kb*Tvals).^(3/2)).*(1./(reddifquad(Tvals,Evals,csvals)));
y = 10000*PD/press; %outputs Diffusion coef in cm^2/s
plot(Tvals,PD)
end

function y = reddifquad(Tvals,Evals,csvals)
kb = 8.617333262E-5; %eV/K
y = zeros(size(Tvals));
ct = 1;
for T = Tvals
    reddifintegrand = ((kb*T).^(-3)).*exp(-Evals/(kb*T)).*(Evals.^2).*csvals;
    y(ct) = trapz(Evals,reddifintegrand);
    disp(y(ct))
    ct = ct + 1;
end
end