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

# VII.1  Equatorial Slices
# --------------------------
# 
# **Summary:**    2-D profiles of selected output variables in the equatorial plane. 
# 
# **Subdirectory:**  Equatorial_Slices
# 
# **main_input prefix:** equatorial
# 
# **Python Class:** Equatorial_Slices
# 
# **Additional Namelist Variables:**  
# None
# 
# The equatorial-slice output type allows us to examine how the fluid properties vary in longitude and radius.
# 
# Examining the *main_input* file, we see that the following output values have been denoted for the Equatorial Slices (see *rayleigh_output_variables.png* for mathematical formulae):
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
# In the example that follows, we demonstrate how to create a 2-D plot of radial velocity in the equatorial plane (at a single time step).
# 
# We begin with the usual preamble.  Examining the data structure, we see that the *vals* array is dimensioned to account for longitudinal variation, and that we have the new coordinate attribute *phi*.

# In[31]:

from find_first_last_Rayleigh_data import find_last2_Rayleigh_data
from rayleigh_diagnostics import Equatorial_Slices
import sys
import os
import math
import numpy
import matplotlib.pyplot as plt
from matplotlib import ticker, font_manager


Equatorial_Slices_path =         "Equatorial_Slices/"
Equatorial_Slices_caption_file = 'Equatorial_Slices_caption.rst'
Equatorial_Slices_image_file =   'images/Equatorial_Slice.png'

def plot_each_Equatorial_Slices_rakesh(istring, init_time):
  es = Equatorial_Slices(istring)
  tindex =0 # Grab first time index from this file
  
################################
# Equatorial Slice 
#Set up the grid
  
  niter = es.niter
  iters = es.iters[tindex]
  time = es.time[tindex] - init_time
  
  tpow = math.floor(numpy.log10(time))
  tnum = time * 10.0**(-tpow)
  ttext = "{:.3f} \\times 10^{{{:d}}}".format(tnum, tpow)
  
#  print('niter: ', niter)
#  print('iters: ', iters)
#  print('time: ', time)
#  print('time: ', time, tnum, tpow)
  
  remove_mean = False # Remove the m=0 mean
  nr = es.nr
  nphi = es.nphi
  r = es.radius/numpy.max(es.radius)
  phi = numpy.zeros(nphi+1,dtype='float64')
  phi[0:nphi] = es.phi
  phi[nphi] = numpy.pi*2  # For display purposes, it is best to have a redunant data point at 0,2pi

#We need to generate a cartesian grid of x-y coordinates (both X & Y are 2-D)
  radius_matrix, phi_matrix = numpy.meshgrid(r,phi)
  X = radius_matrix * numpy.cos(phi_matrix)
  Y = radius_matrix * numpy.sin(phi_matrix)
  
  qindex = es.lut[1] # radial velocity
  field_u = numpy.zeros((nphi+1,nr),dtype='float64')
  field_u[0:nphi,:] =es.vals[:,:,qindex,tindex]
  field_u[nphi,:] = field_u[0,:]  #replicate phi=0 values at phi=2pi
  
  qindex = es.lut[802] # B_theta
  field_B = numpy.zeros((nphi+1,nr),dtype='float64')
  field_B[0:nphi,:] = -es.vals[:,:,qindex,tindex]  # B_z = -B_theta
  field_B[nphi,:] = field_B[0,:]  #replicate phi=0 values at phi=2pi
  
  qindex = es.lut[501] # temperature
  field_T = numpy.zeros((nphi+1,nr),dtype='float64')
  field_T[0:nphi,:] = es.vals[:,:,qindex,tindex]
  field_T[nphi,:] = field_T[0,:]  #replicate phi=0 values at phi=2pi

#remove the mean if desired (usually a good idea, but not always)
  if (remove_mean):
    for i in range(nr):
      the_mean = numpy.mean(field_u[:,i])
      field_u[:,i] = field_u[:,i]-the_mean
  
  if (remove_mean):
    for i in range(nr):
      the_mean = numpy.mean(field_B[:,i])
      field_B[:,i] = field_B[:,i]-the_mean
  
  if (remove_mean):
    for i in range(nr):
      the_mean = numpy.mean(field_T[:,i])
      field_T[:,i] = field_T[:,i]-the_mean

#Plot
  figdpi=300
  sizetuple=(6*3,6.2)
 
  bbox_props = dict(boxstyle="round", fc="w", ec="0.5", alpha=1.0)
  textbox = "$z = 0.0$ \n $t = " + ttext + "$"
#Plot Ur
  fig, ax = plt.subplots(ncols=3,figsize=sizetuple,dpi=figdpi)
  tsize = 20     # title font size
  cbfsize = 10   # colorbar font size
  v_max = numpy.std(field_u)
  v_min = -v_max
  img = ax[0].pcolormesh(X,Y,field_u,cmap='seismic',vmin=v_min,vmax=v_max)
  ax[0].axis('equal')  # Ensure that x & y axis ranges have a 1:1 aspect ratio
  ax[0].axis('off')    # Do not plot x & y axes
  
# Plot bounding circles
  ax[0].plot(r[nr-1]*numpy.cos(phi), r[nr-1]*numpy.sin(phi), color='black')  # Inner circle
  ax[0].plot(r[0]*numpy.cos(phi), r[0]*numpy.sin(phi), color='black')  # Outer circle
  
  ax[0].set_title(r'$u_r$', fontsize=20)
  ax[0].text(0.6, -1.2, textbox, ha="center", va="center", size=12, bbox=bbox_props)
#colorbar ...
  cbar = plt.colorbar(img,orientation='horizontal', shrink=0.5, aspect = 15, ax=ax[0])
  cbar.set_label(r'$u_r$')
  
  tick_locator = ticker.MaxNLocator(nbins=5)
  cbar.locator = tick_locator
  cbar.update_ticks()
  cbar.ax.tick_params(labelsize=cbfsize)   #font size for the ticks
  
  t = cbar.ax.xaxis.label
  t.set_fontsize(cbfsize)  # font size for the axis title
  
#Plot Bz
  v_max = numpy.max(field_B)
  v_min = -v_max
  img = ax[1].pcolormesh(X,Y,field_B,cmap='seismic',vmin=v_min,vmax=v_max)
  ax[1].axis('equal')  # Ensure that x & y axis ranges have a 1:1 aspect ratio
  ax[1].axis('off')    # Do not plot x & y axes
  
# Plot bounding circles
  ax[1].plot(r[nr-1]*numpy.cos(phi), r[nr-1]*numpy.sin(phi), color='black')  # Inner circle
  ax[1].plot(r[0]*numpy.cos(phi), r[0]*numpy.sin(phi), color='black')  # Outer circle
  
  ax[1].set_title(r'$B_z$', fontsize=20)
  ax[1].text(0.6, -1.2, textbox, ha="center", va="center", size=12, bbox=bbox_props)
#colorbar ...
  cbar = plt.colorbar(img,orientation='horizontal', shrink=0.5, aspect = 15, ax=ax[1])
  cbar.set_label(r'$B_z$')
  
  tick_locator = ticker.MaxNLocator(nbins=5)
  cbar.locator = tick_locator
  cbar.update_ticks()
  cbar.ax.tick_params(labelsize=cbfsize)   #font size for the ticks
  
  t = cbar.ax.xaxis.label
  t.set_fontsize(cbfsize)  # font size for the axis title
  
#Plot T
  v_max = numpy.max(field_T)
  v_min = numpy.min(field_T)
  img = ax[2].pcolormesh(X,Y,field_T,cmap='hot',vmin=v_min,vmax=v_max)
  ax[2].axis('equal')  # Ensure that x & y axis ranges have a 1:1 aspect ratio
  ax[2].axis('off')    # Do not plot x & y axes
  
# Plot bounding circles
  ax[2].plot(r[nr-1]*numpy.cos(phi), r[nr-1]*numpy.sin(phi), color='black')  # Inner circle
  ax[2].plot(r[0]*numpy.cos(phi), r[0]*numpy.sin(phi), color='black')  # Outer circle
  
  ax[2].set_title(r'Temperature $T$', fontsize=20)
  ax[2].text(0.6, -1.2, textbox, ha="center", va="center", size=12, bbox=bbox_props)
#colorbar ...
  cbar = plt.colorbar(img,orientation='horizontal', shrink=0.5, aspect = 15, ax=ax[2])
  cbar.set_label(r'$T$')
  
  tick_locator = ticker.MaxNLocator(nbins=5)
  cbar.locator = tick_locator
  cbar.update_ticks()
  cbar.ax.tick_params(labelsize=cbfsize)   #font size for the ticks
  
  t = cbar.ax.xaxis.label
  t.set_fontsize(cbfsize)  # font size for the axis title
  
  
  plt.tight_layout()
  print('Saving figure to: ', Equatorial_Slices_image_file)
  plt.savefig(Equatorial_Slices_image_file)
  
  return time


def s_plot_Equatorial_Slices_rakesh(dir_name, init_time):
  last2_file_names = find_last2_Rayleigh_data(dir_name)
  time = plot_each_Equatorial_Slices_rakesh(last2_file_names[1], init_time)
  return time

def write_Equatorial_Slices_rakesh_captions(caption_file_name, time):
  print('Write ', caption_file_name)
  fp = open(caption_file_name, 'w')
  fp.write('\n')
  
  ftext = '.. figure:: ./' + Equatorial_Slices_image_file + ' \n'
  fp.write(ftext)
  fp.write('   :width: 800px \n')
  fp.write('   :align: center \n')
  fp.write('\n')
  
  tpow = math.floor(numpy.log10(time))
  tnum = time * 10.0**(-tpow)
  ttext = " at :math:`t = {:.3f} \\times 10^{{{:d}}} \\tau_{{\\nu}}`. \n".format(tnum, tpow)
  fp.write('Radial component of the velocity field :math:`u_r` (left), ')
  fp.write(' :math:`z`-component of the magnetic field :math:`B_z` (middle), ')
  fp.write(' and temperature :math:`T` (right)')
  fp.write(' at the equatorial plane :math:`z = 0.0` and ')
  fp.write(ttext)
  fp.write('\n')
  fp.write('\n')
  
  fp.close()
  return

if __name__ == '__main__':
  init_time = 0.0
  time_EQ = s_plot_Equatorial_Slices_rakesh(Equatorial_Slices_path, init_time)
  print(time_EQ)
  write_Equatorial_Slices_rakesh_captions(Equatorial_Slices_caption_file, time_EQ)

