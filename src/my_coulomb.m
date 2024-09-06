function y = my_coulomb(z1,z2,r)
    eps_naught = 0.005526349406; %e^2 * eV^-1 * Angstrom^-1
    Ke = 4*pi*eps_naught;
    y = z1*z2./(Ke.*r);
end

