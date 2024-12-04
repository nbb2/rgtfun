function th = my_magicscatter(Ec,b,V,rm,z1,z2)
%MY_DOCAROOT    Outputs float value for the root of the DOCA equation.
%   Y=MY_DOCAROOT(EC,B,V,RMIN,RMAX) generates a float value for the root
%   of the distance of closest approach (DOCA) equation using two 
%   iterations of the CHEBFUN root finding package. 
%

%   -- EC must be the the energy in eV.
%   -- B must be the impact parameter in Angstrom.
%   -- V must be the potential function handle.
%   -- RMIN is the lower bound of possible root values in Angstrom.
%   -- RMAX is the upper bound of possble root values in Angstrom.
%
%   See also MY_GMQUADSCATTERINGANGLE RUN_SCATTERINGINTEGRALS
    m1 = 9.012; %this needs to be updated!!
    m2 = 1.008; %this needs to be updated!!
    epschar = (32.53*m2*Ec)/(z1*z2*(m1+m2)*(z1^(0.23) + z2^(0.23)));
    a = (0.46850)/(z1^(0.23) + z2^(0.23));
    Vprmin = my_zblderivative(z1,z2,rm);
    %fprintf('Here is %f',Vprmin)
    thArg = (Bvar(b,a) + Rcvar(rhovar(Ec,V(rm),Vprmin),a) +  ... 
        Deltavar(epschar,Bvar(b,a),R0var(rm,a)))/(R0var(rm,a) + Rcvar(rhovar(Ec,V(rm),Vprmin),a));
    th = 2*acos(thArg);
    disp(th)
end

function y = Bvar(b,a)
    y = b/a;
end

function y = Rcvar(rhovar,a)
    y = rhovar/a;
end

function y = rhovar(E,Vrmin,Vprmin)
    y = -2*(E-Vrmin)/Vprmin;
end

function y = R0var(rmin,a)
    y = rmin/a;
end

function y = Deltavar(epschar,Bvar,R)
    C1 = 0.9923;
    C2 = 0.01162;
    C3 = 0.007122;
    C4 = 9.307;
    C5 = 14.81;
    alpha = 1 + C1/sqrt(epschar);
    beta = (C2 + sqrt(epschar))/(C3 + sqrt(epschar));
    A =2*alpha*epschar*(Bvar^beta);
    gammavar = (C4 + epschar)/(C5 + epschar);
    G = gammavar/(sqrt(1+A^2)-A);
    y = A*(R-Bvar)/(1+G);
end

