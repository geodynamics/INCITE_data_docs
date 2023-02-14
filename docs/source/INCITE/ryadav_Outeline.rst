
Geodynamo (ryadav)
-------------------------------------------
.. _tako2label:

.. toctree::
   :glob:
   :hidden:

   ./ryadav/*/*/Case_doc

Overview
=================================

Simulations for the geodynamo by Rakesh Yadav (Harvard University).
Simulations are thermally driven magnetohydrodynamics (MHD) simulations in a rotating spherical shell modeled on the Earth's outer core.
In the present simulations, the ratio of the inner to outer radii is set to 0.35, and the spherical shell is filled by a electrically conductive fluid.
The thermally driven convection is assumed with the Boussinesq approximation. The inner core is assumed to be co-rotating with the mantle (outside of the spherical shell).
 The non-slip boundary condition is applied to the inner and outer boundaries for the velocity, and temperature is fixed to be 1.0 and 0.0 at the inner and outer boundaries, respectively.
 The inner core and mantle is assumed to be electrically insulated. Consequently, the magnetic field is connected to the potential magnetic fields at the inner and outer boundaries.

Spatial resolution, dimensionless number, and hyperdiffusivity settings for each case are listed in the following table as a parameter setting in 'main_input'.
The definition of each parameter is described in `the Rayleigh document <https://rayleigh-documentation.readthedocs.io/en/latest/index.html>`_.


Publications
=================================
The data is used for the following paper:

.. include:: ryadav/publications.rst

List of parameters
=================================

.. csv-table::
   :file: rakesh_parameters.csv
   :encoding: UTF-8
   :header-rows: 1

Definition of parameters
=================================

#. Geometry and spatial resolution

    - :math:`N_{r}`: Number of radial grid points
    - :math:`N_{\theta}`: Number of meridional grid points

#. Dimensionless numbers

    - :math:`E = \frac{\nu}{\Omega L^2}`: Ekman number
    - :math:`Pr = \frac{\nu}{\kappa}`: Prandtl number
    - :math:`Pm = \frac{\nu}{\eta}`: Magnetic Prandtl number
    - :math:`Ra = \frac{\alpha g_{o} T L^3}{\kappa \nu}`: Rayleigh number

#. Hyperdiffusivity parameters 
    - Hyper-diffusion: Flag for hyperdiffusivity
  Set this to variable to .true. to enable hyperdiffusion.  The default value is .false.  When active, diffusivities :math:`\nu`, :math:`\kappa`, and :math:`\eta`,  are multiplied by an additional factor as:
     :math:`\{\nu,\kappa,\eta\}\rightarrow\{\nu,\kappa,\eta\}\left(1+\alpha\left(\frac{\ell-1}{\ell_\mathrm{max}-1}\right)^\beta\right)`
    - :math:`\alpha`: The value of :math:`\alpha` when hyper diffusion is active.
    - :math:`\beta`:  The value of :math:`\beta` when hyper diffusion is active.
