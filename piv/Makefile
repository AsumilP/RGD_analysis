### gfortran
#FC		= gfortran
#FFLAGS_DBG= -Ddebug -Dverbose #-Dddebug=true #-Ddddebug=true 
#FFLAGS		= -Wall -pedantic -std=f2003 -fall-intrinsics -fbounds-check -O -Wuninitialized -ffpe-trap=invalid,zero,overflow -fbacktrace -g  -xf95-cpp-input
#FFLAGS    = -Ofast -xf95-cpp-input
#LIBS    = -L$(HOME)/gfortran/lib -lnetcdff
#INCLUDE = -I$(HOME)/gfortran/include

### PGI fortran
#FC        = pgfortran
#FFLAGS_DBG = -Mpreprocess
#FFLAGS = -g -Minform=inform -Mbounds -Mstandard -Ktrap=fp -traceback # debug
#FFLAGS		= -fastsse 

### intel fortran
FC		= ifort
FFLAGS		= -g -check all -warn nodeclarations -gen_interfaces -fpe0 -ftrapuv -traceback
FFLAGS		= -O2
FFLAGS_DBG= -fpp #-Ddebug=true #-Dddebug=true #-Ddddebug=true 
LIBS    =
INCLUDE =

PROGRAM = piv

SRCS =    piv_const.f90 \
					piv_param.f90 \
					piv_vars.f90 \
					piv_pass_cc_fft_vars.f90 \
					piv_io.f90 \
					piv_pre.f90 \
					piv_pre_img.f90 \
					piv_pass_cc.f90 \
					piv_pass_cc_fft.f \
					piv_pass_cc_fft_radix.f90 \
					piv_pass_subpixel.f90 \
					piv_pass_iw.f90 \
					piv_pass.f90 \
					piv_post.f90 \
					piv_main.f90
					
OBJS	= $(SRCS:%.f90=%.o)

.SUFFIXES: .o .F

.SUFFIXES: .o .f90

all: $(PROGRAM)

%.o : %.mod

.F.o:
	$(FC) $(FFLAGS_DBG) $(FFLAGS) -c $< $(INCLUDE) $(LIBS) -o $@

.f90.o:
	$(FC) $(FFLAGS_DBG) $(FFLAGS) -c $< $(INCLUDE) $(LIBS) -o $@

piv: $(OBJS) 
	$(FC) $^ $(INCLUDE) $(LIBS) $(FFLAGS) $(FFLAGSDBG) -o $@

doc:	piv.doxyfile $(SRCS)
	doxygen piv.doxyfile

clean:
	rm -Rf $(PROGRAM) *.mod *.o *~ *__* *genmod* doc/*

tar:
	tar czf $(PROGRAM).tar $(SRCS) Makefile piv.doxyfile

www: 
	rsync -av doc/html/* /edu/www/usr7/naka-y-ae/public_html/piv_doc/
	rsync -av $(PROGRAM).tar /edu/www/usr7/naka-y-ae/public_html/piv_doc/
