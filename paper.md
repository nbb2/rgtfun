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
   ror: 00hx57361

date: 21 February 2025
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

# Introduction

RGTFun is a MATLAB app designed for the efficient calculation of scattering integrals and transport coefficients of elastic collisions. While the solution for classical scattering, as well as its application for determining gas transport coefficients, has been known for over approximately a century [@chapman_mathematical_1990], the numerical codes are usually kept as closed source codes or are printed in textbooks in older programming languages such as FORTRAN \cite{maitland_intermolecular_1987}.

This new code is open source and uses the well known dynamically compiled language MATLAB. Furthermore, the code features a well designed graphical user interface (GUI) to facilitate the step by step process of going from an intermolecular potential to macroscopic transport coefficients such as viscosity and diffusion coefficient. The ethos of the project is to decrease the learning curve of going from quantum chemistry calculations of intermolecular potential energy surfaces to usable transport coefficients in CFD or PIC codes.   

The paper briefly reviews the theory behind bimolecular scattering and how cross sections of elastic scattering events are used to calculate macroscopic transport properties. Then, four validation cases of the code are reviewed. Finally, an example calculation from start to finish is demonstrated. 


# Figures

Figures can be included like this:
![Caption for example figure.\label{fig:example}](figure.png)
and referenced from text using \autoref{fig:example}.

Figure sizes can be customized by adding an optional second parameter:
![Caption for example figure.](figure.png){ width=20% }


# References
