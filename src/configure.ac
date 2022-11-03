
#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

# AC_PREREQ([2.71])
AC_INIT([FULL-PACKAGE-NAME],[VERSION],[BUG-REPORT-ADDRESS])

# AM_INIT_AUTOMAKE

dnl Include GNU make check
builtin(include,confdb/check_gnu_make.m4)

AC_CONFIG_SRCDIR([Fortran_src/INCITE_checkpoint_converter.f90])
# AC_CONFIG_HEADERS([config.h])

# Checks for programs.
AC_PROG_CC
AC_PROG_FC

if test -z ${FC}
then
	FC=${F77}
else
	F77=${FC}
fi

AC_PROG_MAKE_SET
AC_PROG_RANLIB

# GNU make check
CHECK_GNU_MAKE()
GMAKE=$_cv_gnu_make_command
AC_SUBST(GMAKE)

# libtool check
PKG_PROG_PKG_CONFIG

# Checks using Fortran Compiler
AC_LANG_SAVE
AC_LANG(Fortran)

# Checks using C compiler
AC_LANG_SAVE
AC_LANG(C)

# Checks for header files.
m4_warn([obsolete],
[The preprocessor macro `STDC_HEADERS' is obsolete.
  Except in unusual embedded environments, you can safely include all
  ISO C90 headers unconditionally.])dnl
# Autoupdate added the next two lines to ensure that your configure
# script's behavior did not change.  They are probably safe to remove.
AC_CHECK_INCLUDES_DEFAULT
AC_PROG_EGREP

AC_CHECK_HEADERS([stdlib.h string.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_HEADER_STDBOOL
AC_C_CONST

# Checks for library functions.
AC_FUNC_MALLOC
AC_CHECK_FUNCS([floor memset sqrt strrchr strtol])

AC_MSG_RESULT()
AC_MSG_RESULT(-----   Configuration summary   -------------------------------)
AC_MSG_RESULT()
AC_MSG_RESULT(  host:        "${host}")
AC_MSG_RESULT()
AC_MSG_RESULT(---------------------------------------------------------------)
AC_MSG_RESULT()


AC_CONFIG_FILES([Makefile])
AC_OUTPUT
