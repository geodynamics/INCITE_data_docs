#Equatorial Slice Plotting Example.
#Displays a single variable from the equatorial_slice data structure
#
# Equatorial Slice Data stucture format:
#    """Rayleigh Equatorial Slice Structure
#    ----------------------------------
#    self.niter                                    : number of time steps
#    self.nq                                       : number of diagnostic quantities output
#    self.nr                                       : number of radial points
#    self.nphi                                     : number of phi points
#    self.qv[0:nq-1]                               : quantity codes for the diagnostics output
#    self.radius[0:nr-1]                           : radial grid
#    self.vals[0:phi-1,0:nr-1,0:nq-1,0:niter-1]    : The equatorial_slices
#    self.phi[0:nphi-1]                            : phi values (in radians)
#    self.iters[0:niter-1]                         : The time step numbers stored in this output file
#    self.time[0:niter-1]                          : The simulation time corresponding to each time step
#    self.version                                  : The version code for this particular output (internal use)
#    self.lut                                      : Lookup table for the different diagnostics output
#    """

from diagnostic_reading import Equatorial_Slice
import numpy as np
import matplotlib.pyplot as plt
from glob import glob

files = sorted(glob("./Equatorial_Slices/*"))
i = int(files[-1][-8:])
to_plot = files[-1][-9:]
print to_plot

timestep = to_plot#'07365000'
quantity_code = 64  # read in temperature
remove_mean = False  # remove the m=0 mean
tindex = 0          # Display the first timestep from the file

a = Equatorial_Slice(timestep)

#Set up the grid
nr = a.nr
nphi = a.nphi
r = a.radius/np.max(a.radius)
phi = np.zeros(nphi+1,dtype='float64')
phi[0:nphi] = a.phi
phi[nphi] = np.pi*2  # For display purposes, it is best to have a redunant data point at 0,2pi

radius_matrix, phi_matrix = np.meshgrid(r,phi)
X = radius_matrix * np.cos(phi_matrix)
Y = radius_matrix * np.sin(phi_matrix)


#plot field intensity
qindex = a.lut[401]
field1 = np.zeros((nphi+1,nr),dtype='float64')
field1[0:nphi,:] =a.vals[:,:,qindex,tindex]
field1[nphi,:] = field1[0,:]  #replicate phi=0 values at phi=2pi

qindex = a.lut[402]
field2 = np.zeros((nphi+1,nr),dtype='float64')
field2[0:nphi,:] =a.vals[:,:,qindex,tindex]
field2[nphi,:] = field2[0,:]  #replicate phi=0 values at phi=2pi

qindex = a.lut[403]
field3 = np.zeros((nphi+1,nr),dtype='float64')
field3[0:nphi,:] =a.vals[:,:,qindex,tindex]
field3[nphi,:] = field3[0,:]  #replicate phi=0 values at phi=2pi

field = -field2


#qindex = a.lut[1]
#field = np.zeros((nphi+1,nr),dtype='float64')
#field[0:nphi,:] =a.vals[:,:,qindex,tindex]
#field[nphi,:] = field[0,:]  #replicate phi=0 values at phi=2pi

#remove the mean if desired
if (remove_mean):
    for i in range(nr):
        the_mean = np.mean(field[:,i])
        field[:,i] = field[:,i]-the_mean

#Plot
cm = 'RdBu'
vmax =  2*np.std(field)
vmin =  -vmax
print vmax, vmin
cs = np.linspace(vmin, vmax, 30)


fig = plt.figure(figsize=(10,8))
ax = fig.add_axes([0.01, 0.01, 0.85, 0.98])
im = ax.contourf(X, Y, field, cs, cmap=plt.get_cmap(cm), extend='both')

pos = ax.get_position()
l, b, w, h = pos.bounds
cax = fig.add_axes([0.9, 0.46-0.7*h/2., 0.015, 0.7*h])
mir = fig.colorbar(im, cax=cax, format='%.e')
ax.axis('off')

# plt.show()
filename = 'Images/Bz_equator_%08d.png' % i
fig.savefig(filename, dpi=300)
print filename, 'saved.'
