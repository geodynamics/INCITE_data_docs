
Jovian Atomosphere (mheimpel)
-------------------------------------------

Overview
=================================

Simulations for Jovian or Uranucian atomosphere have been performed by Moriz Heimpel (Univ. of Alberta). Simulations are thermally driven convection simulaiton in a rotating spherical shell modeled on the Jupiter's atomosphere. It is noted that magnetic field is not take account into these simulations. In the present simulation, anelastic approximation is applied, and system is solved in the non-dimensionally. The ratio of the inner bounday to the outer boundary is set to be :math:`r_i / r_o = 0.95` or 0.90 for the Jovian atomosphere model, and to be :math:`r_i / r_o = 0.75` forr the Uranus model.
 The free-slip boundary condition is applied to the velocity. Fixed heat flux (i.e. dT/dr) is applied for the inner and out boundaries.
 
 Spatial resolution, dimenstionless number, amplidtude of dT/dr, and hyperdiffusivity settings for each case are listed in the following table as a parameter setting in 'main_input'. The definision of the paremter is described in `the Rayleigh document <https://rayleigh-documentation.readthedocs.io/en/latest/index.html>`_.


List of parameters
=================================

.. csv-table:: 
   :file: moritz_parameters.csv
   :encoding: UTF-8
   :header-rows: 1

Link to each case
=================================

.. toctree::
    :maxdepth: 1
    :caption: Contents of runs:

    mheimpel/JupNatGeo/E1n3/run1/Case_doc
    mheimpel/JupNatGeo/E1n3/run2/Case_doc
    mheimpel/JupNatGeo/E1n4/run1/Case_doc
    mheimpel/JupNatGeo/E1n4/run2/Case_doc
    mheimpel/JupNatGeo/E1n4/run3/Case_doc
    mheimpel/JupNatGeo/E1n5/run1/Case_doc
    mheimpel/JupNatGeo/E3n5/run1/Case_doc
    mheimpel/JupNatGeo/E3n6/run1/Case_doc
    mheimpel/JupNatGeo/E3n6/run2/Case_doc
    mheimpel/JupNatGeo/E3n6/run3/Case_doc
    mheimpel/JupNatGeo/E3n6/run4/Case_doc
    mheimpel/JupNatGeo/E3n6/run4a/Case_doc
    mheimpel/JupNatGeo/E3n6/run4b/Case_doc
    mheimpel/JupNatGeo/E3n6/run5/Case_doc
    mheimpel/JupNatGeo/E3n6/run6/Case_doc
    mheimpel/Jup90/fsb/E3n6/run1/Case_doc
    mheimpel/Jup90/fsb/E3n6/run2/Case_doc
    mheimpel/Jup90/fsb/E3n6/run3/Case_doc
    mheimpel/Jup90/fsb/E3n6/runM1/Case_doc
    mheimpel/Jup90/fsb/E3n6/runM2/Case_doc
    mheimpel/Jup90/fsb/E3n6/runM3/Case_doc
    mheimpel/Jup90/fsb/E3n6/runM4/Case_doc
    mheimpel/Jup90/fsb/E3n6/runM5/Case_doc
    mheimpel/Jup90/fsb/E3n6/runM6/Case_doc
    mheimpel/Jup90/nsb/E1n4/run1/Case_doc
    mheimpel/Jup90/nsb/E1n4/run2/Case_doc
    mheimpel/Jup90/nsb/E1n4/run3/Case_doc
    mheimpel/Jup90/nsb/E1n5/run1/Case_doc
    mheimpel/Jup90/nsb/E1n5/run2/Case_doc
    mheimpel/Jup90/nsb/E3n5/run1/Case_doc
    mheimpel/Jup90/nsb/E3n5/run2/Case_doc
    mheimpel/Jup90/nsb/E3n5/run3/Case_doc
    mheimpel/Jup90/nsb/E3n6/run1/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E1n4/run1/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E1n4/run2/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E1n5/run1a/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E1n5/run1b/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E1n5/run1c/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E1n5/run2/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E1n5/run3/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E1n5/run4/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E1n5/run5/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E1n5/run6/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E1n5/run7/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E3n5/run1a/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E3n5/run1b/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E3n5/run1c/Case_doc
    mheimpel/Jup95/fsb/poly_n1/E3n6/run1a/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n5/run1/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n5/run2/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n5/run3/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n5/run4/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/run1a/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/run1b/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/run1c/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/run1d/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/run2/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/run3/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/run4/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/runM1/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/runM2/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/runM3/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/runM4/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/runM5/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/runM6/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/runM7/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E2n6/run1/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n5/run1/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n5/run2/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n5/run3/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n5/run4/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n5/run5/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n5/run6/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n5/run7/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n5/run8/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/run1/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/run2/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/run3/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/run4/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/run5/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/run6/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/run7/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/run8/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/runM1/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n7/run1a/Case_doc
    mheimpel/Jup95/nsb/poly_n2/E1n5/run1/Case_doc
    mheimpel/Jup95/nsb/poly_n2/E1n5/run2/Case_doc
    mheimpel/Jup95/nsb/poly_n2/E3n5/run1/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n4/run1/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n4/run2/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n4/run3/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n5/run01/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n5/run02/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n5/run03/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n5/run04/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n5/run1/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n6/run01/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n6/run02/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n6/runR1/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n6/runR2/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n6/runR3/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n6/runR4/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n4/run1/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n4/run2/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n4/run3/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n5/run1/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n5/run2/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n5/run3/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n5/run4/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n5/run5/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n5/run6/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n5/run7/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run01/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run02/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run03/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run04/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run05/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run1/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run2/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run3/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run4/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run5/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run6/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/runM7/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/runM8/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type4/E1n4/run1/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type4/E1n4/run2/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type4/E1n5/run1a/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type4/E1n5/run1b/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type4/E1n5/run2/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type4/E3n4/run1/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type4/E3n4/run1a/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type4/E3n5/run1a/Case_doc
    mheimpel/Jup95/fsb/poly_n2/heating_type4/E3n5/run1b/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n5/10xRa/run1/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n5/10xRa/run2/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n5/10xRa/runM1/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/4xRa/run1/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/4xRa/run2/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/4xRa/runM1/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/4xRa/runM2/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E1n6/4xRa/runM3/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/run1/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM1/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM10/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM2/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM3/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM4/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM5/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM6/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM7/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM8/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM9/Case_doc
    mheimpel/Jup95/nsb/poly_n1/E3n6/Prp3/run1/Case_doc
    mheimpel/Uranus75/E1n3/run1/Case_doc
    mheimpel/Uranus75/E1n4/run1/Case_doc
    mheimpel/Uranus75/E3n4/run1/Case_doc
    mheimpel/Uranus75/E3n4/run2/Case_doc
    mheimpel/Uranus75/E3n4/run3/Case_doc
    mheimpel/Uranus75/E3n4/run4/Case_doc
    mheimpel/Uranus75/N5/E1n3/run1/Case_doc
    mheimpel/Uranus75/N5/E1n3/run2/Case_doc
    mheimpel/Uranus75/N5/E1n4/run1/Case_doc
    mheimpel/Uranus75/N5/E3n4/run1/Case_doc
