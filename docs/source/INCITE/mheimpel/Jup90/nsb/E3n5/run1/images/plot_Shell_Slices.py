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
from rayleigh_diagnostics import Shell_Slices
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import ticker, font_manager
import os
# Read the data

path = "Shell_Slices"

filelist = []
filelist = os.listdir(path)
# print(filelist)
nfile=len(filelist)
# print(nfile)

max_step = int(filelist[0])
istring = filelist[0]
for fname in filelist:
  istep = int(fname)
  if(istep > max_step):
    max_step = istep
    istring = fname

print('Step to plot: ', istring)

# istring = '00040000'
ss = Shell_Slices(istring)

ntheta = ss.ntheta
nphi = ss.nphi
costheta = ss.costheta
theta = np.arccos(costheta) - np.pi/2.0
phi = np.arange(nphi)*2.0*np.pi/nphi - np.pi


tindex = 0 # All example quantities were output with same cadence.  Grab second time-index from all.
rindex = 1 # only output one radius
sizetuple=(12,5)

vr =   ss.vals[:,:,rindex,ss.lut[1],tindex]
temp = ss.vals[:,:,rindex,ss.lut[501],tindex]

fig = plt.figure(figsize=sizetuple)
ax1 = fig.add_subplot(111, projection='mollweide')

plot1 = ax1.pcolormesh(phi, theta, temp.transpose(), shading='auto', cmap='hot', rasterized=True)

ax1.set_xticklabels([])
ax1.set_yticklabels([])

#ax1.set_xlabel( 'Longitude')
#ax1.set_ylabel( 'Latitude')
ax1.set_title(  'temperature')

plt.colorbar(plot1, label='U_r')
plt.tight_layout()
savefile = 'images/Shell_Slices_temp_mid.pdf'
print('Saving figure to: ', savefile)
plt.savefig(savefile)



fig = plt.figure(figsize=sizetuple)
ax2 = fig.add_subplot(111, projection='mollweide')

plot1 = ax2.pcolormesh(phi, theta, vr.transpose(), shading='auto', cmap='seismic', rasterized=True)

ax2.set_xticklabels([])
ax2.set_yticklabels([])

#ax2.set_xlabel( 'Longitude')
#ax2.set_ylabel( 'Latitude')
ax2.set_title(  'Radial Velocity')

plt.colorbar(plot1, label='U_r')
plt.tight_layout()
savefile = 'images/Shell_Slices_Ur_mid.pdf'
print('Saving figure to: ', savefile)
plt.savefig(savefile)


