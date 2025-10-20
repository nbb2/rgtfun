---
title: 'RGTFun: An Open-Source MATLAB App for Rarefied Gas
	Transport Coefficient Calculations'
tags:
  - MATLAB
authors:
  - name: Jackson Granat
    affiliation: 1 # (Multiple affiliations must be quoted)
  - name: Nathan Bartlett
    affiliation: 1
  - name: David N. Ruzic
    affiliation: 1
affiliations:
 - name: Department of Nuclear, Plasma, and Radiological Engineering, The University of Illinois at Urbana-Champaign, Urbana, Illinois
   index: 1
   ror: 047426m28

date: 3 March 2025
bibliography: paper.bib

---

# Key Definitions
$b$ - impact parameter (Å)  
$\theta_c$ - center of mass scattering angle (radians)  
$r_o$  - distance of closest approach during a binary elastic collision (Å)  
$r_m$  - location of the energy minimum of the intermolecular potential (Å)  
$\epsilon$ - the depth of the attractive portion of the intermolecular potential (eV)  
$D_{12}$ - the binary diffusion coefficient ($m^2\cdot s$)  
$\mu$ - viscosity coefficient ($Pa \cdot s$)  
$E_c$ - center of mass energy during a collision (eV)  
$E_l$ - lab frame energy (eV)  
$\sigma(\theta_c)$ - the differential scattering cross section  
$\sigma_T$ - total cross section ($m^2$)  
$\sigma_D$ - the diffusion cross section, also called the momentum cross section ($m^2$)  
$\sigma_\mu$ - the viscosity cross section ($m^2$)  
$r$ - distance between the centers of two molecules (Å)  
$U(r)$ - the intermolecular potential energy function of two molecules (eV)  
$S$ - the stopping cross section ($eV\cdot m^2 \cdot molecule^{-1}$)  
$\chi$ - $(\pi - \theta_c)/2$  
$Z_1$ - number of protons of the first colliding molecule  
$Z_2$ - number of protons of the second colliding molecule  
$q$ - elementary charge ($C$)  
$d_{ref}$ - the reference diameter of the collision model used in the variable hard sphere model incorporated into the direct simulation Monte-Carlo method (Å)  
$\omega$ - the DSMC viscosity temperature dependence parameter  
$N_a$ - Avogadro's number (atoms / mol)  
$P_{vap}$ - equilibrium vapor pressure (Pa)  
$k_B$ - Boltzmann's constant ($J \cdot K^{-1}$)  
$T$ - temperature (K)  
$M_{Sn}$ - mass of a tin atom (Kg)  
$d_{12}$ - collision diameter used in the VHS collision rule for DSMC simulations  
$VHS$ - variablele hard sphere - the collision rule used for the DSMC

# Statement of Need
RGTFun is a MATLAB app designed for the efficient calculation of scattering integrals and transport coefficients of elastic collisions. While the solution for classical scattering, as well as its application for determining gas transport coefficients, has been known for over approximately a century [@chapman_mathematical_1990], the numerical codes are usually kept as closed source codes or are printed in textbooks in older programming languages such as FORTRAN [@maitland_intermolecular_1987].

This new code is open source and uses the well known dynamically compiled language MATLAB. Furthermore, the code features a well designed graphical user interface (GUI) to facilitate the step by step process of going from an intermolecular potential to macroscopic transport coefficients such as viscosity and diffusion coefficient. The ethos of the project is to decrease the learning curve of going from quantum chemistry calculations of intermolecular potential energy surfaces to usable transport coefficients in CFD or PIC codes.   

The paper briefly reviews the theory behind bimolecular scattering and how cross sections of elastic scattering events are used to calculate macroscopic transport properties. Then, four validation cases of the code are reviewed.

# Theory
## The Intermolecular Potential

The intermolecular potential describes the potential energy between two atoms or molecules and is a function of their distance $r$. The actual shape of the potential energy surface of two molecules is unique to the pair and determined using quantum chemistry software [@valiev_nwchem_2010] or experiments [@amdur_experimental_1961;@amdur_repulsive_1949; @amdur_scattering_1954;@ruzic_total_1984]. RGTFun currently supports the following intermolecular potential models:
	
- Coulomb Potential  

$$U(r) = \frac{Z_1 Z_2 e^2}{ 4 \pi \epsilon_0 r}$$  

- 12-6 Lennard-Jones Potential [@lennard1931cohesion]  

$$U(r) = 4 \epsilon \left[\left(\frac{\sigma}{r}\right)^{12} - \left(\frac{\sigma}{r}\right)^6\right]$$
where $$\sigma  = 2^{-1/6} r_{m} $$  

- 12-4 Lennard-Jones Potential [@zhen1983calculation]  

$$U(r) = \frac{3^{3/2}}{2} \epsilon \left[\left(\frac{\sigma}{r}\right)^{12} - \left(\frac{\sigma}{r}\right)^4\right]$$
where $$\sigma  = 3^{-1/8} r_{m} $$  

- ZBL Potential [@Ziegler19831861]  

$$U(r) = \frac{1}{4 \pi \epsilon_0} \frac{Z_2 Z_2 e^2}{r} \phi(r/a)$$
where 
$$a = \frac{0.46850}{Z_1 ^{0.23} + Z_2 ^{0.23}}$$
and 
$$\phi(x) = 0.18175 e^{-3.19980 x} + 0.50986 e^{-0.94229 x} + 0.28022 e^{-0.40290 x} + 0.02817 e^{-0.20162 x}$$  

- Morse Potential [@morse1929diatomic]  

$$U(r) = \epsilon \left( e^{-2 a (r-r_m)} -2 e^{- a (r-r_m)}\right)$$ 
where $$a  = \sqrt{\frac{k}{2 \epsilon}}$$  

- Power Law Potential  

$$U(r) = a r^{-k}$$ 
	
## Bimolecular Scattering
Once an intermolecular potential is known, the scattering angle can be determined as a function of impact energy and impact parameter. First, the distance of closest approach $r_o$ must be solved by finding the root of equation (1), where $E_c$ is the center of mass energy. Next, the scattering angle $\theta_c$ is solved by integrating equation (2).

$$ 1 - \frac{V(r_o)}{E_c} - \frac{b^2}{r_o^2} = 0 \quad (1) $$

$$\theta_c = \pi - 2 \int_{r_o}^{\infty} \frac{bdr}{r^2 \sqrt{1 - \frac{V(r)}{E_c} - \frac{b^2}{r^2}}} \quad (2)$$

## Cross Sections
With a relationship between the impact parameter and scattering angle, cross section quantities can be defined. The differential cross section is defined by equation (3). The total cross section is defined by equation (4). It is important to note that the classical cross section is infinite. If a quantum mechanical approach is taken, then the total cross section becomes finite again. Instead of doing a quantum mechanical calculation, we can instead define a cutoff angle, $\theta_{cutoff}$, which has a corresponding cutoff impact parameter which makes a finite cross section according to equation (5). The cutoff angle can be chosen to either be the smallest measurable angle or when the classical scattering is no longer valid. The condition for the cutoff angle becoming invalid is given by equation (6) [@lane_calculations_1960]. Solving equation (6) requires a numerical root finding procedure. The momentum cross section is given by equation (7) and the viscosity cross section is given by equation (8). These last two cross sections are needed to calculate continuum transport coefficients using Chapman-Enskog theory. The final cross section of importance is the stopping cross section, given by equation (9), which tells us how much energy is lost per unit travel per unit density.
	
$$\sigma(\theta_c,E) = \left|\frac{b}{sin(\theta_c)} \frac{db}{d\theta}\right| \quad (3) $$

$$\sigma_T(E) = \int_{0}^{\pi} \sigma(\theta_c,E) 2\pi \sin(\theta_c) d \theta_c = 2\pi \int_{0}^{\infty}bdb  = \infty \quad (4)$$  
  
$$\sigma_T(E)_{classical} = \int _{\theta _{cutoff}}^{\pi} \sigma(\theta_c,E) 2\pi \sin(\theta_c) d \theta_c = \int _{0}^{b _{cutoff}}bdb =
2 \pi b _{cutoff}^2 \quad (5)$$

$$\theta_c(b_{cutoff}) - \frac{\hbar}{2\sqrt{2 E_c / m_r}\cdot  r_o(b_{cutoff},E_c)} = 0 \quad (6)$$

$$\sigma_D(E) = \int_{0}^{\pi} (1 - \cos(\theta_c))\cdot \sigma(\theta_c,E) 2\pi \sin(\theta_c) d \theta_c = 2\pi \int_{0}^{\infty}(1 - \cos(\theta_c))\cdot bdb \quad (7) $$

$$\sigma_{\mu}(E) = \int_{0}^{\pi} (1 - \cos^2(\theta_c))\cdot \sigma(\theta_c,E) 2\pi \sin(\theta_c) d \theta_c = 2\pi \int_{0}^{\infty}(1 - \cos^2(\theta_c))\cdot bdb \quad (8) $$


$$S_n = \frac{1}{n} \frac{dE}{dx}= \gamma E \sigma_D \quad (9) $$
where 
$$\gamma  = \frac{2 M_1 M_2}{(M_1 + M_2)^2}$$

## Continuum Transport Coefficients
The binary diffusion and single species viscosity coefficient can be determined by using the results of Chapman-Enskog theory [@chapman_mathematical_1990;@maitland_intermolecular_1987]. The binary diffusion coefficient is given by equation (10) and the single species viscosity is given by equation (11). The collision integrals are calculated using the results of the cross sections discussed in the previous section.
	
$$D_{12} = \frac{3}{16} \cdot \left(\frac{2 \pi k_B T (m_1 + m_2)}{m_1 m_2}\right)^{1/2} \frac{1}{n \overline{\Omega_{12}^{(1,1)}}} \quad (10) $$

$$\mu = \frac{5}{8} \cdot \left(\frac{2 \pi k_B T (m_1 m_2)}{(m_1 + m_2)}\right)^{1/2} \frac{1}{ \overline{\Omega^{(2,2)}}} \quad (11)$$

$$\overline{\Omega_{12}^{(1,1)}} = \frac{1}{2} (k_B T)^{-3} \int_{0}^{\infty} \sigma_D E^2 e^{-\frac{E}{k_BT}}dE \quad (12) $$

$$\overline{\Omega^{(2,2)}} =  \frac{1}{2} (k_B T)^{-4} \int_{0}^{\infty} \sigma_{\mu} E^3 e^{-\frac{E}{k_BT}}dE \quad (13) $$

## DSMC Coefficients
The most common DSMC collision rule is called the variable hard sphere (VHS) model. In this model, the relative velocity of two colliding particles determines an effective hard sphere potential and the particles collide according to the classic hard sphere scattering rule [@bird_dsmc_2013]. This rule is given by equation (14) where $d_{12}$ is the average of the two particles' diameters and is a function of the relative velocity according to equation (15). The value of $\omega$ in equation (15) is determined by fitting viscosity data over a limited range of temperatures which passes through a reference viscosity, $\mu_{ref}$, at a chosen reference temperature, $T_{ref}$, according to equation (16). Note that equation (14), the hard shell scattering rule, is undefined at impact parameters larger than $d_{12}$ which defines its total cross section [@fratus_scattering_2015].
	
$$b  = d_{12} \cdot \cos (\theta_c / 2) \quad (14)$$

$$d_{12} = \left(\frac{15\cdot \sqrt{mk_bT/\pi}}{2\cdot (5-2\omega)\cdot (7-2\omega )\mu}\right)^{1/2} \quad (15)$$

$$\mu = \mu_{ref} \cdot \left(\frac{T}{T_o}\right)^{\omega} \quad (16)$$

# Validation of RGTFun
Four main validation cases were used to verify the results obtained from RGTFun. These were: 

- Comparison of RGTFun scattering angle obtained from Coulomb potential vs exact scattering Coulomb scattering angle.
- Comparison of RGTFun scattering angle obtained from ZBL potential vs scattering angle from the Magic Formula [@biersack_monte_1980].
- Comparison of RGTFun Nuclear Stopping Cross Section obtained from ZBL potential [@ziegler_treatise_1985] to SRIM [@ziegler_srim_2010] nuclear stopping cross section for H into H.
- Comparison of RGTFun Viscosity Coefficient and Self-Diffusion Coefficient for Argon to NIST Argon data [@kestin_equilibrium_1984].

## Validation of Rutherford Scattering
As a first step in validation, we compared the scattering angle data obtained from RGTFun for a H-H Coulomb potential to the exact scattering angles for a Coulomb potential [@goldstein_classical_2008]. This validation case was chosen because the Coulomb potential is one of the few potentials for which there exists an exact solution for the scattering angle (the other being the series solution for the inverse power law potential). This comparison is shown in \autoref{fig:coulcomp}. In the figure, it is clear that the RGTFun scattering angle calcuation is in agreement with the analytical calcuation of Rutherford scattering.

![Comparison of scattering angle vs impact parameter curves for three different CM energies for a H-H Coulomb potential. The exact scattering angle curves are plotted as solid lines and the RGTFun scattering angle data are plotted as circles. \label{fig:coulcomp}](./figures/CoulComp.png){ width=60% }


## Validation Against Magic Formula Scattering
Next, we compared the scattering angle data obtained from RGTFun for a H-H ZBL potential to the scattering angle data obtained from the Magic Formula [@biersack_monte_1980]. This comparison is shown in \autoref{fig:magiccomp}. In the figure, it is clear that the RGTFun scattering angle calculations are in agreement with the Magic formula. However, RGTfun is slightly more accurate than the Magic Formula because it calculates the full scattering integral. RGTfun can also handle a wider range of intermolecular potentials as well as help calculate transport properties. 

![Comparison of scattering angle vs impact parameter curves for three different CM energies for a H-H ZBL potential. The Magic Formula scattering angle curves are plotted as solid lines and the RGTFun scattering angle data are plotted as circles. RGTfun has the advantage of being slightly more accurate than the Magic algorithm as well as being able to handle a wider range of intermolecular potential types. \label{fig:magiccomp}](./figures/MagicComp.png){ width=60% }

## Validation Against SRIM Nuclear Stopping Cross Section
Next, we compared the nuclear stopping cross section data obtained from RGTFun for a H-H ZBL potential to the nuclear stopping cross section data obtained from SRIM [@ziegler_srim_2010]. This comparison is shown in \autoref{fig:NSPcomp}. In the figure, it is clear that the RGTFun nuclear stopping cross sections  are in excellent agreement with the SRIM nuclear stopping cross sections. 

![Comparison of RTGFun nuclear stopping cross section data to SRIM nuclear stopping cross section data for H into H. The SRIM data are plotted as solid lines and the RGTFun data are plotted as circles. \label{fig:NSPcomp}](./figures/NSPComp.png){ width=60% }

## Validation Against NIST Transport Coefficient Data
Lastly, we compared the viscosity and self-diffusion coefficient data obtained from RGTFun for a 12-6 LJ potential of Ar to NIST transport coefficient data [@kestin_equilibrium_1984]. This comparison is shown in \autoref{fig:ViscosityComp} and \autoref{fig:DiffusionComp}. From the figures we see excellent agreement between the RGTFun and NIST data for low temperatures, with the curves slightly diverting in both cases for high temperatures. This diversion is not an error in the calculation, but instead due to the limitation of the Lennard-Jones potential. This is deduced as the code calculated the same numerical result as the work of [@khrapak_accurate_2014].

![Comparison of RTGFun viscosity coefficient data to NIST viscosity coefficient data for Argon. The NIST data are plotted as a solid line and the RGTFun data are plotted as a dashed line. \label{fig:ViscosityComp}](./figures/ViscosityComp.png){ width=60% }

![Comparison of RTGFun self-diffusion coefficient data to NIST self-diffusion coeficient data for Argon. The NIST data are plotted as a solid line and the RGTFun data are plotted as a dashed line. \label{fig:DiffusionComp}](./figures/DiffusionComp.png){ width=60% }

# Accessing RGTFun
 RGTFun can be downloaded from the public Github repository linked here:  
https://github.com/nbb2/rgtfun/releases/tag/v1.0.0
 Please follow installation instructions on the release page.

# References
