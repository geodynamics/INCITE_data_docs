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

# VII.3  Shell Slices
# --------------------------
# 
# **Summary:**    2-D, spherical profiles of selected output variables sampled in at discrete radii. 
# 
# **Subdirectory:**  Shell_Slices
# 
# **main_input prefix:** shellslice
# 
# **Python Class:** Shell_Slices
# 
# **Additional Namelist Variables:**  
# 
# * shellslice_levels (indicial) : indices along radial grid at which to output spherical surfaces.
# 
# * shellslice_levels_nrm (normalized) : normalized radial grid coordinates at which to output spherical surfaces.
# 
# 
# The shell-slice output type allows us to examine how the fluid properties vary on spherical surfaces.
# 
# Examining the *main_input* file, we see that the following output values have been denoted for the Shell Slices (see *rayleigh_output_variables.pdf* for mathematical formulae):
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
# 
# In the examples that follow, we demonstrate how to create a 2-D plot of radial velocity:
# * on a Cartesian, lat-lon grid
# * projected onto a spherical surface using Basemap   (MUST set use Basemap=True below)
# 
# 
# 
# Plotting on a lat-lon grid is straightforward and illustrated below.   The shell-slice data structure is also displayed via the help() function in the example below and contains information needed to define the spherical grid for plotting purposes.
# 
# It is worth noting the *slice_spec* keyword (described in the docstring) that can be passed to the init method.  When reading large shell slices, a user can save time and memory during the read process by specifying the slice they want to read.

# In[21]:

#####################################
#  Shell Slice
from find_first_last_Rayleigh_data import find_last2_Rayleigh_data
from rayleigh_diagnostics import Shell_Slices
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import ticker, font_manager
import os
import math

Shell_Slices_path =         "Shell_Slices/"
Shell_Slices_caption_prefix = 'Shell_Slices_caption_'
Shell_Slices_image_prefix =    'images/Shell_Slices_'
temp_postfix = 'temp_'
Ur_postfix =   'Ur_'
Bz_postfix =   'Bz_'

def plot_each_r_Shell_Slices_rakesh(ss, icou, rindex, init_time):
  niter = ss.niter
  tindex = niter - 1 # All example quantities were output with same cadence.  Grab second time-index from all.
  
  time = ss.time[tindex] - init_time
  tpow = math.floor(np.log10(time))
  tnum = time * 10.0**(-tpow)
  ttext = "{:.3f} \\times 10^{{{:d}}}".format(tnum, tpow)
  
  ntheta = ss.ntheta
  nphi = ss.nphi
  costheta = ss.costheta
  theta = np.arccos(costheta) - np.pi/2.0
  phi = np.arange(nphi)*2.0*np.pi/nphi - np.pi
  
  depth = ss.radius[0] - ss.radius[rindex]
  vr =   ss.vals[:,:,rindex,ss.lut[1],tindex]
  temp = ss.vals[:,:,rindex,ss.lut[501],tindex]
  br =   ss.vals[:,:,rindex,ss.lut[801],tindex]
  
  ttitle = 'Temperature $T$'
  utitle = 'Radial Velocity $u_r$'
  btitle = 'Radial Magnetic Field $B_r$'
  
  bbox_props = dict(boxstyle="round", fc="w", ec="0.5", alpha=1.0)
  rtext = "{:.3f}".format(depth)
  textbox = "$r = r_o - $ " + rtext + " \n $t = " + ttext + "$"
  r_and_t_text = "at :math:`r = r_o - " + rtext + "` and :math:`t = " + ttext + "`"
  
#     Spacing is default spacing set up by subplot
  figdpi=300
  sizetuple=(12,5)
  tsize = 20     # title font size
  cbfsize = 10   # colorbar font size
  
  
  fig = plt.figure(figsize=sizetuple,dpi=figdpi)
  ax1 = fig.add_subplot(111, projection='mollweide')
  
  v_max = np.max(temp)
  v_min = np.min(temp)
  plot1 = ax1.pcolormesh(phi, theta, temp.transpose(), shading='auto', 
                         cmap='hot',vmin=v_min,vmax=v_max, rasterized=True)
  
  ax1.set_xticklabels([])
  ax1.set_yticklabels([])
  
  ax1.set_title(ttitle)
  ax1.text(5.4, -1.2, textbox, ha="center", va="center", size=12, bbox=bbox_props)
  
  plt.colorbar(plot1, label=r'$T$')
  plt.tight_layout()
  savefile = Shell_Slices_image_prefix + temp_postfix + str(icou) + '.pdf'
  print('Saving figure to: ', savefile)
  plt.savefig(savefile)
  
  
  fig = plt.figure(figsize=sizetuple,dpi=figdpi)
  ax2 = fig.add_subplot(111, projection='mollweide')
  
  v_max = np.max(vr)
  v_min = -v_max
  plot1 = ax2.pcolormesh(phi, theta, vr.transpose(), shading='auto', 
                         cmap='seismic',vmin=v_min,vmax=v_max,
                         rasterized=True)
  
  ax2.set_xticklabels([])
  ax2.set_yticklabels([])
  ax2.set_title(utitle)
  ax2.text(5.4, -1.2, textbox, ha="center", va="center", size=12, bbox=bbox_props)
  
  plt.colorbar(plot1, label=r'$U_r$')
  plt.tight_layout()
  savefile = Shell_Slices_image_prefix + Ur_postfix + str(icou) + '.pdf'
  print('Saving figure to: ', savefile)
  plt.savefig(savefile)
  
  
  fig = plt.figure(figsize=sizetuple,dpi=figdpi)
  ax3 = fig.add_subplot(111, projection='mollweide')
  
  v_max = np.max(br)
  v_min = -v_max
  plot1 = ax3.pcolormesh(phi, theta, br.transpose(), shading='auto', 
                         cmap='seismic',vmin=v_min,vmax=v_max,
                         rasterized=True)
  
  ax3.set_xticklabels([])
  ax3.set_yticklabels([])
  ax3.set_title(btitle)
  ax3.text(5.4, -1.2, textbox, ha="center", va="center", size=12, bbox=bbox_props)
  
  plt.colorbar(plot1, label=r'$B_r$')
  plt.tight_layout()
  savefile = Shell_Slices_image_prefix + Bz_postfix + str(icou) + '.pdf'
  print('Saving figure to: ', savefile)
  plt.savefig(savefile)
  
  return r_and_t_text

def write_Shell_Slices_rakesh_captions(caption_prefix, r_and_t_text, icou):
  caption_file_name = caption_prefix + temp_postfix + str(icou) + '.rst'
  print('Write ', caption_file_name)
  fp = open(caption_file_name, 'w')
  fp.write('\n')
  
  ftext = '.. figure:: ./' + Shell_Slices_image_prefix \
          + temp_postfix + str(icou) + '.pdf' + ' \n'
  fp.write(ftext)
  fp.write('   :width: 600px \n')
  fp.write('   :align: center \n')
  fp.write('\n')
  
  fp.write('Temperature :math:`T` ')
  fp.write(r_and_t_text)
  fp.write('\n')
  fp.write('\n')
  fp.close()
  
  caption_file_name = caption_prefix + Ur_postfix + str(icou) + '.rst'
  print('Write ', caption_file_name)
  fp = open(caption_file_name, 'w')
  fp.write('\n')
  
  ftext = '.. figure:: ./' + Shell_Slices_image_prefix \
          + Ur_postfix + str(icou) + '.pdf' + ' \n'
  fp.write(ftext)
  fp.write('   :width: 600px \n')
  fp.write('   :align: center \n')
  fp.write('\n')
  
  fp.write('Radial component of the velocity field :math:`u_r` ')
  fp.write(r_and_t_text)
  fp.write('\n')
  fp.write('\n')
  fp.close()
  
  caption_file_name = caption_prefix + Bz_postfix + str(icou) + '.rst'
  print('Write ', caption_file_name)
  fp = open(caption_file_name, 'w')
  fp.write('\n')
  
  ftext = '.. figure:: ./' + Shell_Slices_image_prefix \
          + Bz_postfix + str(icou) + '.pdf' + ' \n'
  fp.write(ftext)
  fp.write('   :width: 600px \n')
  fp.write('   :align: center \n')
  fp.write('\n')
  
  fp.write('Radial magnetic field :math:`B_r` ')
  fp.write(r_and_t_text)
  fp.write('\n')
  fp.write('\n')
  fp.close()
  
  return


def s_plot_Shell_Slices_rakesh(Gpath, caption_prefix, init_time):
#  print("path: ", Gpath)
  last2_file_name = find_last2_Rayleigh_data(Gpath)
  if(last2_file_name[0] == 'NO_FILE'):
    return
  
  print('Step to plot: ', last2_file_name[1])
  
  ss = Shell_Slices(last2_file_name[1])
  r_and_t_textlist = []
  if(ss.nr > 0):
    text_tmp = plot_each_r_Shell_Slices_rakesh(ss, 0, 0, init_time)
    write_Shell_Slices_rakesh_captions(caption_prefix, text_tmp, 0)
    r_and_t_textlist.append(text_tmp)
  if(ss.nr > 1):
    text_tmp = plot_each_r_Shell_Slices_rakesh(ss, 1, (ss.nr-1), init_time)
    write_Shell_Slices_rakesh_captions(caption_prefix, text_tmp, 1)
    r_and_t_textlist.append(text_tmp)
  if(ss.nr > 2):
    text_tmp = plot_each_r_Shell_Slices_rakesh(ss, 2, (ss.nr-2), init_time)
    write_Shell_Slices_rakesh_captions(caption_prefix, text_tmp, 2)
    r_and_t_textlist.append(text_tmp)
  if(ss.nr > 3):
    text_tmp = plot_each_r_Shell_Slices_rakesh(ss, 3, (ss.nr-3), init_time)
    write_Shell_Slices_rakesh_captions(caption_prefix, text_tmp, 3)
    r_and_t_textlist.append(text_tmp)
  return



if __name__ == '__main__':
  init_time = 0.0
  s_plot_Shell_Slices_rakesh(Shell_Slices_path, \
                             Shell_Slices_caption_prefix, init_time)


