
Geodynamo (ryadav)
-------------------------------------------
.. _tako2label:

Link to each case
=================================

.. toctree::
   :maxdepth: 1
   :caption: Contents of runs:

   ryadav/ensemble2/Pm0.05_Pr1_eta0.35_Ek1E-6_Ra2.5E10_no-slip_dyn/Case_doc
   ryadav/ensemble2/Pm0.1_Pr1_eta0.35_Ek1E-6_Ra1E10_no-slip_dyn/Case_doc
   ryadav/ensemble2/Pm0.2_Pr1_eta0.35_Ek1E-6_Ra5E9_no-slip_dyn/Case_doc
   ryadav/ensemble3/Pm0.05_Pr0.1_eta0.35_Ek1E-6_Ra2.5E9_no-slip_dyn/Case_doc
   ryadav/ensemble3/Pm0.5_Pr1_eta0.35_Ek1E-6_Ra3E9_no-slip_dyn/Case_doc
   ryadav/ensemble3/Pm1_Pr1_eta0.35_Ek1E-6_Ra3E9_no-slip_dyn/Case_doc
   ryadav/ensemble4/Pm0.03_Pr1_eta0.35_Ek1E-7_Ra3E11_no-slip_dyn/Case_doc
   ryadav/ensemble4/Pm0.05_Pr1_eta0.35_Ek1E-7_Ra1.5E11_no-slip_dyn/Case_doc
   ryadav/ensemble4/Pm0.2_Pr1_eta0.35_Ek1E-7_Ra3E10_no-slip_dyn/Case_doc


Overview
=================================

Simulations for geodynamo by Rakesh Yadav (Herverd University). Simulations are thermally driven magnetohydrodynamics (MHD) simulaiton in a rotating spherical shell modeled on the Earth's outer core. In the present simulations, the ratio of the inner to outer radii is set to 0.35, and spherical shell is filled by a electorically conductive fluid. The thermally driven convection is assumed with the Boussinesq approximation. The inner core is assumed to be co-rotating with mantle (outside pf the spherical shell).
 The non-slop boundary condition is applied to the inner and outer boundaries for the velocity, and temperature is fixed to be 1.0 and 0.0 at the inner and outer boundaries, respectively. The inner core and mantle is assumed to be electorically insulated. Consequently, the mangetic field is connected to potential magnetic fields at the inner and outer boundaries.

Spatial resolution, dimenstionless number, and hyperdiffusivity settings for each case are listed in the following table as a parameter setting in 'main_input'. The definision of the paremter is described in `the Rayleigh document <https://rayleigh-documentation.readthedocs.io/en/latest/index.html>`_.

List of parameters
=================================

.. csv-table:: 
   :file: rakesh_parameters.csv
   :encoding: UTF-8
   :header-rows: 1

Here is the link to tako1label_
    :ref:`tako1label`
