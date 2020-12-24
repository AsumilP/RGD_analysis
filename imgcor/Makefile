### gfortran
#FC		= gfortran
#FFLAGS_DBG= -Ddebug -Dverbose #-Dddebug=true #-Ddddebug=true 
#FFLAGS		= -Wall -pedantic -std=f2003 -fall-intrinsics -fbounds-check -O -Wuninitialized -ffpe-trap=invalid,zero,overflow -fbacktrace -g  -xf95-cpp-input
#FFLAGS    = -Ofast -xf95-cpp-input
#LIBS    = -L$(HOME)/gfortran/lib -lnetcdff
#INCLUDE = -I$(HOME)/gfortran/include

### PGI fortran
#FC		= pgfortran
#FFLAGSDBG	= -g -Minform=inform -Mdclchk -Mbounds -Mstandard -Ktrap=fp -traceback # debug
#FFLAGS		= -fastsse 

### intel fortran
FC		= ifort
#FFLAGS		= -g -check all -warn all -std -gen_interfaces -fpe0 -ftrapuv -traceback
FFLAGS		= -fast
#FFLAGS_DBG= -fpp #-Ddebug=true #-Dddebug=true #-Ddddebug=true 
#LIBS    = -L$(HOME)/intel/lib -L/usr/apps/free/fftw/3.2.2_i/lib -lfftw3 -lnetcdff
#INCLUDE = -I$(HOME)/intel/include -I/usr/apps/free/fftw/3.2.2_i/include

PACKAGE = imgcor
PROGRAM	= xc ls imgcor

SRC = cameraparam.f90 param.f90 
SRC_XC = xc.f90
SRC_LS = ls_4ord.f90 gauss.f lagrange_1d.f90 lagrange_2d.f90 get_imgcoord.f90
SRC_IC = imgcor.f90 lagrange_1d.f90 lagrange_2d.f90 get_imgcoord.f90
 
all: $(PROGRAM)

xc: $(SRC) $(SRC_XC)
	$(FC) $(SRC) $(SRC_XC) $(FFLAGS) $(FFLAGSDBG) -o $@

ls: $(SRC_LS) $(SRC)
	$(FC) $(SRC) $(SRC_LS) $(FFLAGS) $(FFLAGSDBG) -o $@

imgcor: $(SRC_IC) $(SRC)
	$(FC) $(SRC) $(SRC_IC) $(FFLAGS) $(FFLAGSDBG) -o $@
	
doc:	$(PACKAGE).doxyfile $(SRC) $(SRCS_XC) $(SRC_LS)
	doxygen $(PACKAGE).doxyfile

clean:
	rm -rf $(PROGRAM) *.mod *.o *~ *genmod* $(PACKAGE).tar doc 

tar:
	tar czf $(PACKAGE).tar $(SRC) $(SRC_XC) $(SRC_LS) $(SRC_IC) Makefile $(PACKAGE).doxyfile

www: 
	rsync -a doc/html/* /edu/www/usr7/naka-y-ae/public_html/imgcor_doc/
	rsync -a $(PACKAGE).tar /edu/www/usr7/naka-y-ae/public_html/imgcor_doc/
	
