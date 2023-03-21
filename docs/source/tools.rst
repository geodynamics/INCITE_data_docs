
Data conversion program
===========================================

.. toctree::
   :maxdepth: 1
   :caption: Contents:

Simulations under the INCITE project were performed with the pre-released version of Rayleigh V.0.99 on ALCF `Mira <https://www.alcf.anl.gov/alcf-resources/mira>'_ configured with IBM Blue Gene/Q processors.
Consequently, data conversion is required for post-processing and to continue simulations from the checkpoint file.

The data conversion tools consists of three programs. Conversion programs for:
* parameter file `main_input`
* output data except for checkpoints
* the checkpoint data in the folder `Checkpoints`

Requirement
-------------------------------------------
The checkpoint data conversion program is written in Fortran95 and C. The other programs are written in Python 3. Consequently, the following compilers and libraries are required:

* C
* Fortran
* Python 3
* numpy (https://numpy.org)
* matplotlib (https://matplotlib.org)

Installation of compiler and library
-------------------------------------------
The following are simple examples of the installation procedures for Linux (Ubuntu) and Mac OS.
There are a number of package managers available for both Linux and Mac OS that can install the required
compilers and libraries.

Ubuntu
```````````````````````````````````````````
GCC, the GNU Compiler Collection (\url{https://gcc.gnu.org}) is already installed in most
Linux distributions. However, packages for development are need to be installed.
For Ubuntu 20, for example, the required compilers and  libraries can be installed by
using \verb|apt| command as following::

	% sudo apt install build-essential gfortran python3
	% sudo apt install pip

Then, Python libraries numpy and matplotlib are installed by pip::

	% pip install numpy
	% pip install matplotlib


Mac OS
```````````````````````````````````````````
Xcode (Apple) does not have a fortran compiler.
The easiest way to install a fortran compiler is by installing GCC by using a package manager such as
macports (\url{https://www.macports.org}) or homebrew (\url{https://brew.sh/index}).

GCC in Homebrew includes the gfortran compiler. The compiler and packages can be installed as follows:

	% brew install gcc

Directories
-------------------------------------------
The top directory for the source files, src,  contains the following directories::

	% ls src
	.		C_src		Makefile.in	config.status	configure.ac
	..		Fortran_src	confdb		config.sub	work
	.DS_Store	INCITE_convert	config.guess	configure

* C_src           C source directory
* Fortran_src     Fortran source directory
* work            Work directory for build
* INCITE_convert  Python source directory

Build checkpoint converter program
-------------------------------------------
The configure script is used for configuration of the install. The simplest way to install programs is the following process. From the top directory.::

	%pwd
	[HOMEDIR]
	% ./configure
	...
	% make
	...

The program "INCITE_checkpoint_converter" can be found in [HOMEDIR]/bin directory as::

	% ls bin
	.				INCITE_checkpoint_converter


After the build, object modules in the work directory can be deleted by the following command::

	% make clean

To revert the initial repository structure, type the following command::

	% make distclean

Convert parameter file
-------------------------------------------
The checkpoint converter program is performed by executing the following::

	% INCITE_convert/convert_main_input.py [INCITE_MAIN_INPUT] [NEW_MAIN_INPUT] [START_STEP]  [END_STEP]

* [INCITE_MAIN_INPUT] is the file name of the original parameter file.
* [NEW_MAIN_INPUT] is the file name of the new parameter file.


Convert data file except for checkpoint
-------------------------------------------

CAUTION: This program overwrites the original data. Copy the data to a new directory before running the conversion program::

	% INCITE_convert/convert.py [FILES_TO_CONVERT]

* [FILES_TO_CONVERT] are the file names to be converted. Regular expressions for UNIX can be used for this file name list.

Convert checkpoint data file
-------------------------------------------

CAUTION: This program overwrites the original data. Copy the data to a new directory before running the conversion program.

The checkpoint converter program is performed by executing the following::

	% [HOMEDIR]/bin/convert_checkpoint [INCITE_CHECKPOINT_DIR] [NEW_CHECKPOINT_DIR] [START_STEP]  [END_STEP]

* [HOMEDIR]/bin is the directory where the program is stored.
* [INCITE_CHECKPOINT_DIR] is the directory of the copies of the original checkpoint data files.
* [NEW_CHECKPOINT_DIR] is the directory for the converted checkpoint data for Rayleigh 1.0.
* [START_STEP] is the integer value for the start step to convert.
* [END_STEP] is the integer value for the start step to convert.
