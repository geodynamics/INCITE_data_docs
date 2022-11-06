#
#  Copyright (C) 2018 by the authors of the RAYLEIGH code.
#
#  This file is part of RAYLEIGH.
#
#  RAYLEIGH is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3, or (at your option)
#  any later version.
#
#  RAYLEIGH is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with RAYLEIGH; see the file LICENSE.  If not see
#  <http://www.gnu.org/licenses/>.
#

# VIII.  Spherical Harmonic Spectra
# ===================
# 
# **Summary:**    Spherical Harmonic Spectra sampled at discrete radii. 
# 
# **Subdirectory:**  Shell_Spectra
# 
# **main_input prefix:** shellspectra
# 
# **Python Classes:** 
# 
# * Shell_Spectra :  Complete data structure associated with Shell_Spectra outputs.
# * PowerSpectrum :  Reduced data structure -- contains power spectrum of velocity and/or magnetic fields only.
# 
# **Additional Namelist Variables:**  
# 
# * shellspectra_levels (indicial) : indices along radial grid at which to output spectra.
# 
# * shellspectra_levels_nrm (normalized) : normalized radial grid coordinates at which to output spectra.
# 
# 
# The shell-spectra output type allows us to examine the spherical harmonic decomposition of output variables at discrete radii.
# 
# Examining the *main_input* file, we see that the following output values have been denoted for the Shell Spectra (see *rayleigh_output_variables.pdf* for mathematical formulae):
# 
# 
# | Menu Code  | Description |
# |------------|-------------|
# | 1          | Radial Velocity |
# | 2          | Theta Velocity |
# | 3          | Phi Velocity  |
# 
# 
# 
# Spherical harmonic spectra can be read into Python using either the **Shell_Spectra** or **PowerSpectrum** classes.  
# 
# The **Shell_Spectra** class provides the full complex spectra, as a function of degree ell and azimuthal order m, for each specified output variable.   It possesses an attribute named *lpower* that contains the associated power for each variable, along with its m=0 contributions separated and removed.
# 
# The **Power_Spectrum** class can be used to read a Shell_Spectra file and quickly generate a velocity or magnetic-field power spectrum.   For this class to work correctly, your file must contain all three components of either the velocity or magnetic field.   Other variables are ignored (use Shell_Spectrum's lpower for those).
# 
# We illustrate how to use these two classes below.  As usual, we call the help() function to display the docstrings that describe the different data structures embodied by each class.

# In[23]:

import matplotlib.pyplot as plt
from matplotlib import ticker
import numpy
from rayleigh_diagnostics import Shell_Spectra, Power_Spectrum
import os


def s_plot_Shell_Spectra_rakesh(path):
# Get file list in G_Aves
  filelist = []
  filelist = os.listdir(path)
#  print(filelist)
  nfile=len(filelist)
  if(nfile < 1):
    print('No file')
    return
#  print(nfile)
  
  istring = filelist[0]
  max_step = int(filelist[0])
  for fname in filelist:
    istep = int(fname)
    if(istep > max_step):
      max_step = istep
      istring = fname
  print('File to plot: ', istring)
  
#  istring = '00159000'
  
  vpower = Power_Spectrum(istring, magnetic = True)
  plot_each_Shell_Spectra_rakesh(vpower, 0, 0)
  plot_each_Shell_Spectra_rakesh(vpower, 1, (vpower.nr-1))
  plot_each_Shell_Spectra_rakesh(vpower, 2, (vpower.nr-2))
  plot_each_Shell_Spectra_rakesh(vpower, 3, (vpower.nr-3))
  return

def plot_each_Shell_Spectra_rakesh(vpower, icou, rindex):
  kpower = vpower.power
  bpower = vpower.mpower
  lmax = vpower.lmax
  tind = 0
#  rindex = 0
  depth = vpower.radius[0] - vpower.radius[rindex]
#  print(vpower.radius)
  title_u = 'Velocity Power at r = r_o-{:.3f}'.format(depth)
  title_B = 'Magnetic Field Power at r = r_o-{:.3f}'.format(depth)
#  print(title_u)
  
  fig, ax = plt.subplots(nrows=1, figsize=(6,4))
  ax.plot(kpower[:,rindex,tind,0], label='Total')
  ax.set_xlabel(r'Degree $\ell$')
  ax.set_title(title_u)
  ax.set_xlim(1, lmax+10)
  ax.set_xscale('log')
  ax.set_yscale('log')
  
  ax.plot(kpower[:,rindex,tind,1], label='Axisymmetric')
  ax.plot(kpower[:,rindex,tind,2], label='Non-axisymmetric')
  ax.legend(loc='lower left', shadow=True)
  ax.set_xlabel(r'Degree $\ell$')
  
  plt.tight_layout()
  savefile = 'images/KPower_' + str(icou) + '.pdf'
  print('Saving figure to: ', savefile)
  plt.savefig(savefile)

  fig, ax = plt.subplots(nrows=1, figsize=(6,4))
  ax.plot(bpower[:,rindex,tind,0], label='Total')
  ax.set_xlabel(r'Degree $\ell$')
  ax.set_title(title_B)
  ax.set_xlim(1, lmax+10)
  ax.set_xscale('log')
  ax.set_yscale('log')
  
  ax.plot(bpower[:,rindex,tind,1], label='Axisymmetric')
  ax.plot(bpower[:,rindex,tind,2], label='Non-axisymmetric')
  ax.legend(loc='lower left', shadow=True)
  ax.set_xlabel(r'Degree $\ell$')
  
  plt.tight_layout()
  savefile = 'images/MPower_' + str(icou) + '.pdf'
  print('Saving figure to: ', savefile)
  plt.savefig(savefile)
  return


if __name__ == '__main__':
  path = "Shell_Spectra"
  s_plot_Shell_Spectra_rakesh(path)
