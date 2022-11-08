
Data conversion program
===========================================

.. toctree::
   :maxdepth: 1
   :caption: Contents:

Simulations under the INCITE project are performed by pre-released version on Rayleigh V.0.99 on ALCF Mira which has IBM Blue Gene/q processor. Consequently, data conversion is required to post-processing and continue the simulation from the checkpoint file.

The tools consists of threee programs:
* Conversion program for parameter file 'main_input'
* Conversion program for output data except for checkpoints
* Conversion program for the checkpoint data in the folder 'Checkpints'

Requirement
-------------------------------------------
The checkpint data conversion program is written in Fortran95 and C, and the other programs are written by Python 3. Consequently, the following compiler and libraries are required:

* C compiler
* Fortran compiler 
* Python 3 compiler
* numpy (https://numpy.org)
* matplotlib (https://matplotlib.org)

Installation of compiler and library
-------------------------------------------
Here is a simple installation procedure for Linux (Ubuntu) and Mac OS. There are a number of package managers for the both Linux and Mac OS, please install requiremnet compilers and libraries as you like.

Ubuntu
```````````````````````````````````````````
GCC, the GNU Compiler Collection (\url{https://gcc.gnu.org}) is already installed in the most of Linux distributions. However, packages for development are need to be installed. For Ubuntu 20, for example, the required compilers and  libraries can be installed by using \verb|apt| command as following::

	% sudo apt install build-essential gfortran python3
	% sudo apt install pip

Then, Python libraries numpy and matplotlib are installed by pip::

	% pip install numpy
	% pip install matplotlib


Mac OS
```````````````````````````````````````````
For MacOS, any fortran compiler needs to be installed because Xcode does not have fortran compiler. The easiest way is installing GCC by using a package manager such as macports (\url{https://www.macports.org}) or homebrew (\url{https://brew.sh/index}).
The required compiler and packages can be installed as followings: GCC in Homebrew includes gfortran compiler.::

	% brew install gcc

Directories
-------------------------------------------
The top directory of source file src contains the following directories::

	% ls src
	.		C_src		Makefile.in	config.status	configure.ac
	..		Fortran_src	confdb		config.sub	work
	.DS_Store	INCITE_convert	config.guess	configure

* C_src           C source directory
* Fortran_src     Fortran source directory
* work            Work directory for build
* INCITE_convert  Python source directory

Build Checkpoint converter program
-------------------------------------------
The configure script is used for configuration to install. The simplest way to install programs is the following process in the top directory.::

	%pwd
	[HOMEDIR]
	% ./configure
	...
	% make
	...

The program "INCITE_checkpoint_converter" can be found in [HOMEDIR]/bin directory as::

	% ls bin
	.				INCITE_checkpoint_converter


After the build, object modules in work directory can be deleted by the following command::

	% make clean

To revert the initial repository strucure, type the following command::

	% make distclean

Convert parameter file
-------------------------------------------
The checkpoint converter program is performed by the folowing::

	% INCITE_convert/convert_main_input.py [INCITE_MAIN_INPUT] [NEW_MAIN_INPUT] [START_STEP]  [END_STEP]

* [INCITE_MAIN_INPUT] is the file name of the origianl parameter file for the INCITE project.
* [NEW_MAIN_INPUT] is the file name of the new parameter file made by the INCITE project.


Convert data file except for Checkpint
-------------------------------------------

CAUTION: This program overwrits the original data. I strongly recommend to run this program to copied data.::

	% INCITE_convert/convert.py [FILES_TO_CONVERT]

* [FILES_TO_CONVERT] is the file names to be converted. Regular expressions for UNIX can be used for this file name list.

Convert Checkpint data file
-------------------------------------------

The checkpoint converter program is performed by the folowing::

	% [HOMEDIR]/bin/convert_checkpoint [INCITE_CHECKPOINT_DIR] [NEW_CHECKPOINT_DIR] [START_STEP]  [END_STEP]

* [HOMEDIR]/bin is the directrory where the program is stored. The program can run after copying to the directory where the data copied.
* [INCITE_CHECKPOINT_DIR] is the directrory of the origianl checkpoint data files made by the INCITE project.
* [NEW_CHECKPOINT_DIR] is the directory for the converted Checkpoint data for Rayleigh 1.0.
* [START_STEP] is the integer value for the start step to convert
* [END_STEP] is the integer value for the start step to convert

