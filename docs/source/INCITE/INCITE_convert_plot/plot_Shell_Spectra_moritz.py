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

from find_first_last_Rayleigh_data import find_last2_Rayleigh_data
from rayleigh_diagnostics import Shell_Spectra, Power_Spectrum
import matplotlib.pyplot as plt
from matplotlib import ticker
import numpy
import os
import math

Shell_Spectra_path =         "Shell_Spectra/"
Shell_Spectra_caption_prefix = 'Spectr_caption_'
Shell_Spectra_image_prefix =   'images/SSpectr_'
KE_postfix =   'KE_'


def plot_each_Shell_Spectra_moritz(vpower, icou, rindex, time_SSpecctra):
  niter = vpower.niter
  tindex = niter - 1 # All example quantities were output with same cadence.  Grab second time-index from all.
  
  time = time_SSpecctra
  print('Spectr', tindex, vpower.iters[tindex], vpower.time[tindex], time)
  
  tpow = math.floor(numpy.log10(time))
  tnum = time * 10.0**(-tpow)
  ttext = "{:.3f} \\times 10^{{{:d}}}".format(tnum, tpow)
  
  kpower = vpower.power
  lmax = vpower.lmax
  
  bbox_props = dict(boxstyle="round", fc="w", ec="0.5", alpha=1.0)
  
  depth = vpower.radius[0] - vpower.radius[rindex]
  if(depth == 0.0):
    textbox = " at $r = r_o$ and $t = " + ttext + "$"
    r_and_t_text = "at :math:`r = r_o` and :math:`t = " + ttext + "`"
  else:
    rtext = "{:.3f}".format(depth)
    textbox = " at $r = r_o - $ " + rtext + " and $t = " + ttext + "$"
    r_and_t_text = "at :math:`r = r_o - " + rtext + "` and :math:`t = " + ttext + "`"
  title_u = 'Velocity Power \n ' + textbox
  
  fig, ax = plt.subplots(nrows=1, figsize=(6,4))
  ax.plot(kpower[:,rindex,tindex,0], label='Total')
  ax.set_xlabel(r'Degree $\ell$')
  ax.set_title(title_u)
  ax.set_xscale('log')
  ax.set_yscale('log')
  
  ax.plot(kpower[:,rindex,tindex,1], label='Axisymmetric')
  ax.plot(kpower[:,rindex,tindex,2], label='Non-axisymmetric')
  ax.set_xlim(1, lmax+10)
  ax.legend(loc='lower left', shadow=True)
  ax.set_xlabel(r'Degree $\ell$')
  
  plt.tight_layout()
  savefile = Shell_Spectra_image_prefix + KE_postfix + str(icou) + '.pdf'
  print('Saving figure to: ', savefile)
  plt.savefig(savefile)
  return r_and_t_text

def write_Shell_Spectr_moritz_captions(caption_prefix, r_and_t_text, icou):
  caption_file_name = caption_prefix + KE_postfix + str(icou) + '.rst'
  print('Write ', caption_file_name)
  fp = open(caption_file_name, 'w')
  fp.write('\n')
  
  ftext = '.. figure:: ./' + Shell_Spectra_image_prefix \
          + KE_postfix + str(icou) + '.pdf' + ' \n'
  fp.write(ftext)
  fp.write('   :width: 600px \n')
  fp.write('   :align: center \n')
  fp.write('\n')
  
  fp.write('Kinetic energy density spectra as a function')
  fp.write(' of spherical harmonic degree :math:`l` ')
  fp.write(r_and_t_text)
  fp.write('\n')
  fp.write('\n')
  fp.close()
  
  return


def s_plot_Shell_Spectra_moritz(Gpath, caption_prefix, time_SSpecctra):
  last2_file_name = find_last2_Rayleigh_data(Gpath)
  if(last2_file_name[0] == 'NO_FILE'):
    return
  
  print('file to plot: ', last2_file_name[1])
  
  vpower = Power_Spectrum(last2_file_name[1])
  
  r_and_t_textlist = []
  icou = 0
  for rindex in vpower.rad_inds:
    text_tmp = plot_each_Shell_Spectra_moritz(vpower, icou, icou, time_SSpecctra)
    write_Shell_Spectr_moritz_captions(caption_prefix, text_tmp, icou)
    r_and_t_textlist.append(text_tmp)
    icou = icou + 1
  
  return


if __name__ == '__main__':
  s_plot_Shell_Spectra_moritz(Shell_Spectra_path, \
                              Shell_Spectra_caption_prefix, 0, 0, 0.0)
