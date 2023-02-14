
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
The cases are used for the following paper:

.. include:: mheimpel/publications.rst

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
    - :math:`Pr = \frac{\nu}{\kappa}`: Prandtl number
    - :math:`Ram = \frac{\alpha g_{o} T}{\nu \Omega}`: Modified Rayleigh number

#. Boundary conditions

    - :math:`\frac{dT}{dr}|_{r=r_i}`: Temperature gradient at inner boundary
    - :math:`- \frac{dT}{dr}|_{r=r_o}`: Temperature gradient at the outer boundary

#. Reference states 

    - Reference type: Integer value that determines the fluid approximation and background state by integer:

      - 1:  Boussinesq + nondimensional
      - 2:  Anelastic + polytropic background state (dimensional)
      - 3:  Anelastic + polytropic background state (non-dimensional)
      - 4:  Custom reference-state (read from file)
 
    - Heating type: Integer value that determines the form of the internal heating function :math:`Q(r)`:

      - 0: no internal heating :math:`Q(r) = 0`.
      - 1: :math:`Q(r)\propto\overline{\rho}(r)\overline{T}(r)`.
      - 4: :math:`Q(r)` is a constant function of radius.

    - :math:`n_{p}`: The polytropic index used to describe the background state for reference types 2 and 3
    - :math:`n_{\rho}`: Number of density scaleheights spanning the interval :math:`r_\mathrm{min}\le r\le r_\mathrm{max}` for reference types 2 and 3.
    - :math:`n_{g}`: Specifies the value of *n* (real number) used to determine the radial variation of gravitational acceleration *g* in reference type 1, where :math:`g\propto\left(\frac{r}{r_\mathrm{max}}\right)^n`.


#. Hyperdiffusivity parameters 
    - Hyper-diffusion: Flag for hyperdiffusivity
  Set this to variable to .true. to enable hyperdiffusion.  The default value is .false.  When active, diffusivities :math:`\nu`, :math:`\kappa`, and :math:`\eta`,  are multiplied by an additional factor as:
     :math:`\{\nu,\kappa,\eta\}\rightarrow\{\nu,\kappa,\eta\}\left(1+\alpha\left(\frac{\ell-1}{\ell_\mathrm{max}-1}\right)^\beta\right)`
    - :math:`\alpha`: The value of :math:`\alpha` when hyper diffusion is active.
    - :math:`\beta`:  The value of :math:`\beta` when hyper diffusion is active.
