function y = my_numvisccoef(Tvals,m1,m2,csdatafile)
%MY_NUMVISCCOEF   Outputs float array with viscosity coefficient values.
%   Y=MY_NUMVISCCOEF(TVALS,M1,M2,CSDATAFILE) generates a float array 
%   containing viscosity coefficient value for each value of Tvals by using
%   trapezoidal integration. 
%
%   -- TVALS must be an array of temperatures in Kelvin.
%   -- M1 must be mass in amu.
%   -- M2 must be mass in amu.
%   -- CSDATAFILE must be location of viscosity cross section data file.
%
%   See also MY_NUMDIFFUSIONCOEF RUN_TRANSPORTCS
%kb = 1.380649E-23; %J/K
kb = 8.617333262E-5; %eV/K
mred = m1*m2/(m1+m2);
csdata = readmatrix(csdatafile);
Evals = csdata(:,1); %eV
csvals = csdata(:,2); %A^2
y = (1E6)*0.001629989*(5/4)*((2*pi*mred)^(0.5))*((kb*Tvals).^(1/2)).*(1./(redviscquad(Tvals,Evals,csvals))); %microPa s
end

function y = redviscquad(Tvals,Evals,csvals)
kb = 8.617333262E-5; %eV/K
y = zeros(size(Tvals));
ct = 1;
for T = Tvals
    redviscintegrand = ((kb*T).^(-4)).*exp(-Evals/(kb*T)).*(Evals.^3).*csvals;
    y(ct) = trapz(Evals,redviscintegrand);
    %disp(y(ct))
    ct = ct + 1;
end
end