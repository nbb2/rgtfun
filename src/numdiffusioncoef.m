function y = numdiffusioncoef(Tvals,m1,m2,csdatafile)
%NUMDIFFUSIONCOEF   Outputs float array with diffusion coefficient values.
%   Y=NUMDIFFUSIONCOEF(TVALS,M1,M2,P,CSDATAFILE) generates a float array 
%   containing self-diffusion coefficient value for each value of Tvals by]
%   using trapezoidal integration. 
%
%   -- TVALS must be an array of temperatures in Kelvin.
%   -- M1 must be mass in amu.
%   -- M2 must be mass in amu.
%   -- CSDATAFILE must be location of diffusion cross section data file.
%
%   See also NUMDIFFUSIONCS RUN_TRANSPORTCS
kb = 8.617333262E-5; %eV/K
mred = m1*m2/(m1+m2);
csdata = readmatrix(csdatafile);
Evals = csdata(:,1); %eV
csvals = csdata(:,2); %A^2
amu_to_kg = 1/(6.022e26);
ev_to_j = 1.60218e-19;
a_to_m = 1e-10;
atomic_to_si = (amu_to_kg^(-1/2))*(ev_to_j^(3/2))*(a_to_m^(-2));

y = atomic_to_si*(3/8)*((2*pi/mred)^(0.5))*((kb*Tvals).^(3/2)).*(1./(reddifquad(Tvals,Evals,csvals))); %PD in units of Pa * m^2 / s
end

function y = reddifquad(Tvals,Evals,csvals)
kb = 8.617333262E-5; %eV/K
y = zeros(size(Tvals));
ct = 1;
for T = Tvals
    reddifintegrand = ((kb*T).^(-3)).*exp(-Evals/(kb*T)).*(Evals.^2).*csvals;
    y(ct) = trapz(Evals,reddifintegrand);
    fprintf('T = %f, omega = %f',T,y(ct)*0.5)
    ct = ct + 1;
end
end


