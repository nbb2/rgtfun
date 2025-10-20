function y = visc_coef(well_depth,T,m1,m2,d,inttype,data)
%VISC_COEF    Outputs viscosity coefficient.
%   Y=VISC_COEF(WELL_DEPTH,T,M1,M2,D,INTTYPE,DATA) generates a float 
%   array containing a viscosity coefficient value for each temperature
%   using a Lennard_Jones potential (from "Khrapak, S.A. Accurate transport
%   cross sections for the Lennard-Jones potential. Eur. Phys. J. D 68, 276
%   (2014)"). Units of viscosity coefficient are micro-Pascal*s.
%
%   -- WELL-DEPTH must be the LJ well-depth in Kelvin.
%   -- T must be a float array containing temperature values in units of K.
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
mu = (m1*m2)/(m1+m2);
mukg = mu*(1.66054e-27);
dm = d*(1e-10);
Tstar = T/well_depth;
if strcmp(inttype,'Exact LJ')
y = (1e6)*(5*sqrt(2*pi)/8)*(((mukg)^(1/2))*(Tjoul).^(1/2))./(((dm)^2) ...
    *reducedviscint(Tstar));
elseif strcmp(inttype,'Trapezoidal LJ')
y = (1e6)*(5*sqrt(2*pi)/8)*(((mukg)^(1/2))*(Tjoul).^(1/2))./(((dm)^2) ...
    *reducedviscquad(Tstar,data));
else
    disp('Invalid Integration Type. Please check input file and try again.')
end
end

function y = reducedviscint(Tstar)
%REDUCEDVISCINT    Outputs the reduced viscosity integral.
%   Y=MY_REDUCEDVISCINT(TSTAR) generates a float array containing a value
%   for the exact reduced viscosity integral in Khrapak, S.A. Accurate 
%   transport cross sections for the Lennard-Jones potential (2014).
%
%   -- TSTAR is  float array containing the reduced temperature values.
y = zeros(size(Tstar));
ct = 1;
for t = Tstar
redviscintegrand = @(x) 0.5*(x.^3).*exp(-x).*viscositycs(1./(2*t*x));
y(ct) = integral(redviscintegrand,0,Inf);
ct = ct + 1;
end
end

function y = reducedviscquad(Tstar,data)
%REDUCEDVISCQUAD    Outputs the reduced viscosity integral using quadrature.
%   Y=MY_REDUCEDVISCQUAD(TSTAR,DATA) generates a float array containing a value
%   for the reduced viscosity integral in Khrapak, S.A. Accurate transport 
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
redviscintegrand = -0.25*(X.^3).*exp(-X).*csdata(:,2)./(t*csdata(:,1).^2);
y(ct) = trapz(csdata(:,1),redviscintegrand);
ct = ct + 1;
end
end
