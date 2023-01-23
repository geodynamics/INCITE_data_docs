
Jovian Atmosphere (mheimpel)
-------------------------------------------

Overview
=================================

Simulations for the Jovian or Uranucian atmosphere have been performed by Moritz Heimpel (Univ. of Alberta).
Simulations are thermally driven convection simulations in a rotating spherical shell modeled on Jupiter's atmosphere.
It is noted that magnetic field is not taken into account in these simulations. In the present simulations, the anelastic approximation is applied, and system is solved non-dimensionally.
The ratio of the inner bounday to the outer boundary is set to be :math:`r_i / r_o = 0.95` or 0.90 for the Jovian atmosphere model, and :math:`r_i / r_o = 0.75` for the Uranus model.
 The free-slip boundary condition is applied to the velocity. Fixed heat flux (i.e. dT/dr) is applied to the inner and outer boundaries.

 Spatial resolution, dimensionless number, amplitude of dT/dr, and hyperdiffusivity settings for each case are listed in the following table as a parameter setting in 'main_input'.
 The definition of each parameter is described in `the Rayleigh document <https://rayleigh-documentation.readthedocs.io/en/latest/index.html>`_.


Publications
=================================
The data is used for the following paper:

#. Heimpel, M.H., and Rakesh, K.Y., and Featherstone, N.A., and Aurnou J.M., Polar and mid-latitude vortices and zonal flows on Jupiter and Saturn, *Icarus*, **379**, 114942, Doi:https://doi.org/10.1016/j.icarus.2022.114942, 2022.

    - :ref:`J95-pn1-ht1-E3n6-10Ra-M6`
    - :ref:`J95-pn2-ht1-E3n6-M8`
    - :ref:`J95-pn1-ht1-E1n5-5`
    - :ref:`J90-ht4-E3n6-6`

List of parameters
=================================

.. csv-table::
   :file: moritz_parameters.csv
   :encoding: UTF-8
   :header-rows: 1

Definition of parameters
=================================

#. Geometry and spatial resolution

    - :math:`N_{r}`: Number of radial grid points
    - :math:`N_{\theta}`: Number of meridional grid points
    - :math:`r_i / r_o`: Ratio of inner boundary to outer boundary radii

#. Dimensionless numbers

    - :math:`E = \frac{\nu}{\Omega L^2}`: Ekman number
    - :math:`Pr = \frac{\kappa}{\nu}`: Prandtl number
    - :math:`Ram = \frac{\alpha g_{o} T}{\nu \Omega}`: Modified Rayleigh number
    - :math:`\frac{dT}{dr}|_{r=r_i}`: Temperature gradient at inner boundary
    - :math:`- \frac{dT}{dr}|_{r=r_o}`: Temperature gradient at the outer boundary

#. Reference states 

    - Reference type: Integer flag for reference state 
    - Heating type: Integer flag for heating type
    - :math:`n_{p}`: 
    - :math:`n_{\rho}`: 
    - :math:`n_{g}`: Radial gravity profile

#. Hyperdiffusivity parameters 

    - Hyper-diffusion: Integer flag for hyperdiffusivity
    - :math:`\alpha`: 
    - :math:`\beta`: 