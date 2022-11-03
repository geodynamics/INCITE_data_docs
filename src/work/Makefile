#
#
#
#
SHELL=
#

HOMEDIR=
BINDIR=

F90=
CC=

F90OPTFLAGS=
OPTFLAGS=
#
# ------------------Do not edit the following------------------------
#


F_SRCDIR= $(HOMEDIR)/Fortran_src
C_SRCDIR= $(HOMEDIR)/C_src

TARGET_CHECKPOINT =   $(BINDIR)/INCITE_checkpoint_converter

C_OBJS= cmkdir.o

F_OBJS= \
m_precision.o \
m_constants.o \
m_machine_parameter.o\
byte_swap_f.o \
t_rayleigh_restart_IO.o \
rayleigh99_rst_param_IO.o \
INCITE_checkpoint_converter.o


# all: $(TARGET_CHECKPOINT) $(TARGET_MAIN_INPUT) $(TARGET_DIAGONOSTICS)
all: $(TARGET_CHECKPOINT)



$(TARGET_CHECKPOINT):  $(C_OBJS)  $(F_OBJS)
	$(F90) $(F90OPTFLAGS) -o $(TARGET_CHECKPOINT) $(C_OBJS)  $(F_OBJS)

cmkdir.o: $(C_SRCDIR)/cmkdir.c
	$(CC) -c $(OPTFLAGS) $(C_INCLUDE) $<

m_precision.o: $(F_SRCDIR)/m_precision.f90
	$(F90) -c $(F90OPTFLAGS) $<
m_constants.o: $(F_SRCDIR)/m_constants.f90 m_precision.o
	$(F90) -c $(F90OPTFLAGS) $<
m_machine_parameter.o: $(F_SRCDIR)/m_machine_parameter.f90 m_precision.o
	$(F90) -c $(F90OPTFLAGS) $<
byte_swap_f.o: $(F_SRCDIR)/byte_swap_f.f90 m_precision.o
	$(F90) -c $(F90OPTFLAGS) $<
t_rayleigh_restart_IO.o: $(F_SRCDIR)/t_rayleigh_restart_IO.f90 m_precision.o m_constants.o m_machine_parameter.o m_precision.o byte_swap_f.o
	$(F90) -c $(F90OPTFLAGS) $<
rayleigh99_rst_param_IO.o: $(F_SRCDIR)/rayleigh99_rst_param_IO.f90 m_precision.o m_precision.o t_rayleigh_restart_IO.o byte_swap_f.o
	$(F90) -c $(F90OPTFLAGS) $<
INCITE_checkpoint_converter.o: $(F_SRCDIR)/INCITE_checkpoint_converter.f90 m_precision.o t_rayleigh_restart_IO.o rayleigh99_rst_param_IO.o
	$(F90) -c $(F90OPTFLAGS) $<

clean:
	rm -f *.o ;
	rm -f *.mod ;
	rm -f *~ ;
