function y = numstoppingcs(E,m1,m2,diffusioncs)
%NUMSTOPPINGCS    Outputs stopping cross-section value.
%   Y=NUMSTOPPINGCS(SCATTERDATAFILE) generates a stopping cross-section 
%   value using diffusion cs value, masses, and energy. 
%
%   -- E must be energy in eV.
%   -- M1 must be the mass of species 1 in amu.
%   -- M2 must be the mass of species 2 in amu.
%   -- DIFFUSIONCS must be diffusion CS value for energy E.
%
%   See also RUN_TRANSPORTCS 
yCM = 2*(m1*m2/(m1+m2)^2)*E*diffusioncs;
CMtoLab = (m1+m2)/m2;
y = yCM*CMtoLab; 
end


