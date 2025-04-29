function y = diffusioncoef(well_depth,T,m1,m2,d,inttype,data)
%DIFFUSIONCOEF    Outputs self-diffusion coefficient.
%   Y=DIFFUSIONCOEF(WELL_DEPTH,T,P,M1,M2,D,INTTYPE,DATA) generates a float 
%   array containing a self-diffusion coefficient value for each temperature
%   using a Lennard_Jones potential (from "Khrapak, S.A. Accurate transport
%   cross sections for the Lennard-Jones potential. Eur. Phys. J. D 68, 276
%   (2014)"). Units of self-diffusion coefficient are cm^2 /s.
%
%   -- WELL-DEPTH must be the LJ well-depth in Kelvin.
%   -- T must be a float array containing temperature values in units of K.
%   -- P must be the pressure in bar.
%   -- M1 must be the mass of species 1 in amu.
%   -- M2 must be the mass of species 2 in amu.
%   -- D must be the sigma LJ parameter in units of Angstrom.
%   -- INTTYPE must be a character string specifying if the integral will
%   be exact or numerical.
%   -- DATA must be a character string filepath that gives the location of 
%   the cross section data.
%
%   See also RUN_TRANSPORTCS
Tjoul = T.*(1.380649e-23);
%ppascal = p*100000;
mu = (m1*m2)/(m1+m2);
mukg = mu*(1.66054e-27);
dm = d*(1e-10);
Tstar = T/well_depth;
if strcmp(inttype,'Exact LJ')
    y = (3*sqrt(2*pi)/16)*((Tjoul).^(3/2))./(((mukg)^(1/2))* ...
    ((dm)^2)*reduceddifint(Tstar)); %PD in units of Pa * m^2 / s
elseif strcmp(inttype,'Trapezoidal LJ')
    y = (3*sqrt(2*pi)/16)*((Tjoul).^(3/2))./(((mukg)^(1/2))* ...
    ((dm)^2)*reduceddifquad(Tstar,data)); %PD in units of Pa * m^2 / s
else
    disp('Invalid Integration Type. Please check input file and try again.')
end
end

function y = reduceddifint(Tstar)
%REDUCEDDIFINT    Outputs the reduced diffusion integral.
%   Y=REDUCEDDIFINT(TSTAR) generates a float array containing a value
%   for the exact reduced diffusion integral in Khrapak, S.A. Accurate transport 
%   cross sections for the Lennard-Jones potential (2014).
%
%   -- TSTAR is  float array containing the reduced temperature values.
y = zeros(size(Tstar));
ct = 1;
for t = Tstar
reddifintegrand = @(x) 0.5*(x.^2).*exp(-x).*diffusioncs(1./(2*t*x));
y(ct) = integral(reddifintegrand,0,Inf);
ct = ct + 1;
end
end

function y = reduceddifquad(Tstar,data)
%REDUCEDDIFQUAD    Outputs the reduced diffusion integral using quadrature.
%   Y=REDUCEDDIFQUAD(TSTAR,DATA) generates a float array containing a value
%   for the reduced diffusion integral in Khrapak, S.A. Accurate transport 
%   cross sections for the Lennard-Jones potential (2014) using trapezoidal
%   integration.
%
%   -- TSTAR is  float array containing the reduced temperature values.
%   -- DATA is a char array containing the filepath of the cross-section
%   data.
y = zeros(size(Tstar));
ct = 1;
csdata = readmatrix(data);
for t = Tstar
X = 1./(2*t*csdata(:,1));
reddifintegrand = -0.25*(X.^2).*exp(-X).*csdata(:,2)./(t*csdata(:,1).^2);
y(ct) = trapz(csdata(:,1),reddifintegrand);
ct = ct + 1;
end
end