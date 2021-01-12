!remove error vectors, using fft --> low-pass filter --> ifft, use after cutflipcombine
!c--------------------------------------------------c
!c          ( avedevi.f90 + rmvnoise.f90 )          c
!c            imgcor                                c
!c            piv                                   c
!c            get_uv_withcut.f90                    c
!c            rmverrvec_uvcut.f90                   c
!c            stereoscopic.f90                      c
!c            cutflipcombine.f90                    c
!c   --->     rmverrvec_uvwcomb.f90                 c
!c                                                  c
!c              1. search_max.f90                   c
!c                                                  c
!c              2. split_time.f90                   c
!c               2.1 calc_umean_rms.f90             c
!c               2.2 calc_scales_Q.f90              c
!c--------------------------------------------------c
 implicit none

 integer, parameter :: nvec_x_fit_dbl= 211
 integer, parameter :: nvec_y= 123
 integer, parameter :: nz= 21838
 integer, parameter :: NFX=512, IPX=9
 integer, parameter :: NFY=256, IPY=8
 integer, parameter :: NFZ=65536, IPZ=16
 real(8), parameter :: NCUT_LPF=0.48D0
 real(8), parameter :: NCUT_LPF_T=0.3D0
 integer, parameter :: cond = 11

 character(*), parameter :: path_of_velo_i = '/home/yatagi/analysis/piv_output/velofield/20190301/piv/combined/'
! character(*), parameter :: path_of_velo_i = '/home/yatagi/analysis/piv_output/velofield/20181218/rmvpiv/combined/'
 character(*), parameter :: path_of_velo_o = '/home/yatagi/analysis/piv_output/velofield/20190301/piv/comblps/'
! character(*), parameter :: path_of_velo_o = '/home/yatagi/analysis/piv_output/velofield/20181218/rmvpiv/comblps/'

!-------------------------------------------------------------------------------
 integer :: i,j,k,l
 real(8) :: UI(nvec_x_fit_dbl,nvec_y),VI(nvec_x_fit_dbl,nvec_y),WI(nvec_x_fit_dbl,nvec_y)
 real(8) :: UR(nvec_x_fit_dbl,nvec_y,nz),VR(nvec_x_fit_dbl,nvec_y,nz),WR(nvec_x_fit_dbl,nvec_y,nz)
 real(8) :: U(nvec_x_fit_dbl,nvec_y,nz),V(nvec_x_fit_dbl,nvec_y,nz),W(nvec_x_fit_dbl,nvec_y,nz)
 real(8) :: UPREX(nvec_x_fit_dbl),UPREY(nvec_y),UPREZ(nz),VPREX(nvec_x_fit_dbl),VPREY(nvec_y),VPREZ(nz),WPREX(nvec_x_fit_dbl),WPREY(nvec_y),WPREZ(nz)
 real(8) :: UFFTX(NFX),UFFTY(NFY),UFFTZ(NFZ),VFFTX(NFX),VFFTY(NFY),VFFTZ(NFZ),WFFTX(NFX),WFFTY(NFY),WFFTZ(NFZ)
 character(*) :: file_name_uraw*200
 character(*) :: file_name_vraw*200
 character(*) :: file_name_wraw*200
 character(*) :: file_name_ulpf*200
 character(*) :: file_name_vlpf*200
 character(*) :: file_name_wlpf*200
 character(*) :: fur*200
 character(*) :: fvr*200
 character(*) :: fwr*200
 character(*) :: ful*200
 character(*) :: fvl*200
 character(*) :: fwl*200

!-------------------------------------------------------------------------------
 do l=1,cond

  print *,'Condition number =',l
  !-----------------input-------------------
  write(file_name_uraw,"('spiv_fbsc_',i2.2,'_u.dat')"),l
!  write(file_name_uraw,"('spiv_fbsc_',i2.2,'_rmv_u.dat')"),l
  write(file_name_vraw,"('spiv_fbsc_',i2.2,'_v.dat')"),l
!  write(file_name_vraw,"('spiv_fbsc_',i2.2,'_rmv_v.dat')"),l
  write(file_name_wraw,"('spiv_fbsc_',i2.2,'_w.dat')"),l
!  write(file_name_wraw,"('spiv_fbsc_',i2.2,'_rmv_w.dat')"),l

  !-----------------output-------------------
  write(file_name_ulpf,"('spiv_fbsc_',i2.2,'_ucl.dat')"),l
!  write(file_name_ulpf,"('spiv_fbsc_',i2.2,'_rmv_ucl.dat')"),l
  write(file_name_vlpf,"('spiv_fbsc_',i2.2,'_vcl.dat')"),l
!  write(file_name_vlpf,"('spiv_fbsc_',i2.2,'_rmv_vcl.dat')"),l
  write(file_name_wlpf,"('spiv_fbsc_',i2.2,'_wcl.dat')"),l
!  write(file_name_wlpf,"('spiv_fbsc_',i2.2,'_rmv_wcl.dat')"),l

  fur=path_of_velo_i//file_name_uraw
  fvr=path_of_velo_i//file_name_vraw
  fwr=path_of_velo_i//file_name_wraw

  ful=path_of_velo_o//file_name_ulpf
  fvl=path_of_velo_o//file_name_vlpf
  fwl=path_of_velo_o//file_name_wlpf

!----------------------------------------------
write(*,*) 'Reading files...'
 open(10,file=fur,form='binary')
  do k=1,nz
    read(10) UI
      do j=1,nvec_y
        do i=1,nvec_x_fit_dbl
           UR(i,j,k)=UI(i,j)
        enddo
      enddo
  enddo
 close(10)

 open(11,file=fvr,form='binary')
  do k=1,nz
    read(11) VI
      do j=1,nvec_y
        do i=1,nvec_x_fit_dbl
           VR(i,j,k)=VI(i,j)
        enddo
      enddo
  enddo
 close(11)

 open(12,file=fwr,form='binary')
   do k=1,nz
     read(12) WI
       do j=1,nvec_y
         do i=1,nvec_x_fit_dbl
            WR(i,j,k)=WI(i,j)
         enddo
       enddo
   enddo
 close(12)

 !--------- max filter ----------

   call max_filter(U,UR)
   call max_filter(V,VR)
   call max_filter(W,WR)

!----------------------U_X----------------------
  write(*,*) 'Calcurating U_X...'
   do k=1,nz
     do j=1,nvec_y
       do i=1,nvec_x_fit_dbl
            UPREX(i)=U(i,j,k)
       enddo

          CALL PRE_FFT(UPREX,nvec_x_fit_dbl,NFX,UFFTX)
          CALL LOWPASS(UFFTX,nvec_x_fit_dbl,NFX,IPX,NCUT_LPF)

          do i=1,nvec_x_fit_dbl
            U(i,j,k)=UFFTX(i+nvec_x_fit_dbl)
          enddo
        enddo
      enddo

!----------------------U_Y----------------------
  write(*,*) 'Calcurating U_Y...'
    do k=1,nz
      do i=1,nvec_x_fit_dbl
        do j=1,nvec_y
            UPREY(j)=U(i,j,k)
        enddo

          CALL PRE_FFT(UPREY,nvec_y,NFY,UFFTY)
          CALL LOWPASS(UFFTY,nvec_y,NFY,IPY,NCUT_LPF)

          do j=1,nvec_y
            U(i,j,k)=UFFTY(j+nvec_y)
          enddo
        enddo
      enddo

!----------------------U_T----------------------
  write(*,*) 'Calcurating U_T...'
      do i=1,nvec_x_fit_dbl
        do j=1,nvec_y
          do k=1,nz
              UPREZ(k)=U(i,j,k)
          enddo

            CALL PRE_FFT(UPREZ,nz,NFZ,UFFTZ)
            CALL LOWPASS(UFFTZ,nz,NFZ,IPZ,NCUT_LPF_T)

            do k=1,nz
              U(i,j,k)=UFFTZ(k+nz)
            enddo
          enddo
        enddo

!---------------------V_X-------------------------
  write(*,*) 'Calcurating V_X...'
      do k=1,nz
        do j=1,nvec_y
          do i=1,nvec_x_fit_dbl
            VPREX(i)=V(i,j,k)
          enddo

          CALL PRE_FFT(VPREX,nvec_x_fit_dbl,NFX,VFFTX)
          CALL LOWPASS(VFFTX,nvec_x_fit_dbl,NFX,IPX,NCUT_LPF)

          do i=1,nvec_x_fit_dbl
            V(i,j,k)=VFFTX(i+nvec_x_fit_dbl)
          enddo
        enddo
      enddo

!----------------------V_Y--------------------------
  write(*,*) 'Calcurating V_Y...'
      do k=1,nz
        do i=1,nvec_x_fit_dbl
          do j=1,nvec_y
            VPREY(j)=V(i,j,k)
          enddo

          CALL PRE_FFT(VPREY,nvec_y,NFY,VFFTY)
          CALL LOWPASS(VFFTY,nvec_y,NFY,IPY,NCUT_LPF)

          do j=1,nvec_y
            V(i,j,k)=VFFTY(j+nvec_y)
          enddo
        enddo
      enddo

!----------------------V_T----------------------
  write(*,*) 'Calcurating V_T...'
      do i=1,nvec_x_fit_dbl
        do j=1,nvec_y
          do k=1,nz
              VPREZ(k)=V(i,j,k)
          enddo

          CALL PRE_FFT(VPREZ,nz,NFZ,VFFTZ)
          CALL LOWPASS(VFFTZ,nz,NFZ,IPZ,NCUT_LPF_T)

          do k=1,nz
            V(i,j,k)=VFFTZ(k+nz)
          enddo
        enddo
      enddo

!---------------------W_X-------------------------
   write(*,*) 'Calcurating W_X...'
       do k=1,nz
         do j=1,nvec_y
           do i=1,nvec_x_fit_dbl
             WPREX(i)=W(i,j,k)
           enddo

           CALL PRE_FFT(WPREX,nvec_x_fit_dbl,NFX,WFFTX)
           CALL LOWPASS(WFFTX,nvec_x_fit_dbl,NFX,IPX,NCUT_LPF)

           do i=1,nvec_x_fit_dbl
             W(i,j,k)=WFFTX(i+nvec_x_fit_dbl)
           enddo
         enddo
       enddo

!----------------------W_Y--------------------------
   write(*,*) 'Calcurating W_Y...'
       do k=1,nz
         do i=1,nvec_x_fit_dbl
           do j=1,nvec_y
             WPREY(j)=W(i,j,k)
           enddo

           CALL PRE_FFT(WPREY,nvec_y,NFY,WFFTY)
           CALL LOWPASS(WFFTY,nvec_y,NFY,IPY,NCUT_LPF)

           do j=1,nvec_y
             W(i,j,k)=WFFTY(j+nvec_y)
           enddo
         enddo
       enddo

!----------------------W_T----------------------
   write(*,*) 'Calcurating W_T...'
       do i=1,nvec_x_fit_dbl
         do j=1,nvec_y
           do k=1,nz
             WPREZ(k)=W(i,j,k)
           enddo

           CALL PRE_FFT(WPREZ,nz,NFZ,WFFTZ)
           CALL LOWPASS(WFFTZ,nz,NFZ,IPZ,NCUT_LPF_T)

           do k=1,nz
              W(i,j,k)=WFFTZ(k+nz)
           enddo
         enddo
       enddo

!----------------------------------------------------
  write(*,*) 'Saving files...'

  write(*,*) ful
  open(15, file=ful,form='binary')
  write(15) U
  close(15)

  write(*,*) fvl
  open(16, file=fvl,form='binary')
  write(16) V
  close(16)

  write(*,*) fwl
  open(17, file=fwl,form='binary')
  write(17) W
  close(17)

 enddo

 write(*,*) 'Operated Correctly!'
 stop
 end

!-------------------------SUBROUTINES-------------------------------
!c----------------------c
!c      max filter      c
!c----------------------c
  subroutine max_filter(UOUT,binin)

  integer, parameter :: nx = 211
  integer, parameter :: ny = 123
  integer, parameter :: nz = 21838

  integer, parameter :: thrl = 8  ![m/s]
  integer, parameter :: nb = 3   !binning area;odd number

  integer(8) :: i,j,k,ii,jj
  real(8) :: binin(nx,ny,nz)
  real(8) :: UOUT(nx,ny,nz)
  real(8) :: temp(nx,ny,nz)

  temp=0.0d0

!c------------------------------------c
  do k=1,nz

    do j=(nb+1)/2,ny-(nb-1)/2
      do i=(nb+1)/2,nx-(nb-1)/2
        do jj=1,nb
          do ii=1,nb
            temp(i,j,k)=temp(i,j,k)+binin(i+ii-(nb+1)/2,j+jj-(nb+1)/2,k)/(nb**2)
          enddo
        enddo
      enddo
    enddo

    do j=(nb+1)/2,ny-(nb-1)/2
      do i=(nb+1)/2,nx-(nb-1)/2
        if ( binin(i,j,k) .gt. thrl ) then
          UOUT(i,j,k) = (temp(i,j,k)*(nb**2)-binin(i,j,k))/((nb**2)-1)
        else
          UOUT(i,j,k) = binin(i,j,k)
        end if
      enddo
    enddo


    do j=1,(nb-1)/2
      do i=(nb+1)/2,nx-(nb-1)/2
        do jj=1,j+(nb-1)/2
          do ii=1,nb
            temp(i,j,k)=temp(i,j,k)+binin(i+ii-(nb+1)/2,jj,k)/(nb*(j+(nb-1)/2))
          enddo
        enddo
      enddo
    enddo

    do j=1,(nb-1)/2
      do i=(nb+1)/2,nx-(nb-1)/2
        if ( binin(i,j,k) .gt. thrl ) then
          UOUT(i,j,k) = (temp(i,j,k)*(nb*(j+(nb-1)/2))-binin(i,j,k))/(nb*(j+(nb-1)/2)-1)
        else
          UOUT(i,j,k) = binin(i,j,k)
        end if
      enddo
    enddo


    do j=ny-(nb-3)/2,ny
      do i=(nb+1)/2,nx-(nb-1)/2
        do jj=1,ny-j+(nb+1)/2
          do ii=1,nb
            temp(i,j,k)=temp(i,j,k)+binin(i+ii-(nb+1)/2,j+jj-(nb+1)/2,k)/(nb*(ny-j+(nb+1)/2))
          enddo
        enddo
      enddo
    enddo

    do j=ny-(nb-3)/2,ny
      do i=(nb+1)/2,nx-(nb-1)/2
        if ( binin(i,j,k) .gt. thrl ) then
          UOUT(i,j,k) = (temp(i,j,k)*(nb*(ny-j+(nb+1)/2))-binin(i,j,k))/(nb*(ny-j+(nb+1)/2)-1)
        else
          UOUT(i,j,k) = binin(i,j,k)
        end if
      enddo
    enddo


    do j=(nb+1)/2,ny-(nb-1)/2
      do i=1,(nb-1)/2
        do jj=1,nb
          do ii=1,i+(nb-1)/2
            temp(i,j,k)=temp(i,j,k)+binin(ii,j+jj-(nb+1)/2,k)/(nb*(i+(nb-1)/2))
          enddo
        enddo
      enddo
    enddo

    do j=(nb+1)/2,ny-(nb-1)/2
      do i=1,(nb-1)/2
        if ( binin(i,j,k) .gt. thrl ) then
          UOUT(i,j,k) = (temp(i,j,k)*(nb*(i+(nb-1)/2))-binin(i,j,k))/(nb*(i+(nb-1)/2)-1)
        else
          UOUT(i,j,k) = binin(i,j,k)
        end if
      enddo
    enddo


    do j=(nb+1)/2,ny-(nb-1)/2
      do i=nx-(nb-3)/2,nx
        do jj=1,nb
          do ii=1,nx-i+(nb+1)/2
            temp(i,j,k)=temp(i,j,k)+binin(i+ii-(nb+1)/2,j+jj-(nb+1)/2,k)/(nb*(nx-i+(nb+1)/2))
          enddo
        enddo
      enddo
    enddo

    do j=(nb+1)/2,ny-(nb-1)/2
      do i=nx-(nb-3)/2,nx
        if ( binin(i,j,k) .gt. thrl ) then
          UOUT(i,j,k) = (temp(i,j,k)*(nb*(nx-i+(nb+1)/2))-binin(i,j,k))/(nb*(nx-i+(nb+1)/2)-1)
        else
          UOUT(i,j,k) = binin(i,j,k)
        end if
      enddo
    enddo


    do j=1,(nb-1)/2
      do i=1,(nb-1)/2
        do jj=1,j+(nb-1)/2
          do ii=1,i+(nb-1)/2
            temp(i,j,k)=temp(i,j,k)+binin(ii,jj,k)/((i+(nb-1)/2)*(j+(nb-1)/2))
          enddo
        enddo
      enddo
    enddo

    do j=1,(nb-1)/2
      do i=1,(nb-1)/2
        if ( binin(i,j,k) .gt. thrl ) then
          UOUT(i,j,k) = (temp(i,j,k)*((i+(nb-1)/2)*(j+(nb-1)/2))-binin(i,j,k))/((i+(nb-1)/2)*(j+(nb-1)/2)-1)
        else
          UOUT(i,j,k) = binin(i,j,k)
        end if
      enddo
    enddo


    do j=ny-(nb-3)/2,ny
      do i=1,(nb-1)/2
        do jj=1,ny-j+(nb+1)/2
          do ii=1,i+(nb-1)/2
            temp(i,j,k)=temp(i,j,k)+binin(ii,j+jj-(nb+1)/2,k)/((i+(nb-1)/2)*(ny-j+(nb+1)/2))
          enddo
        enddo
      enddo
    enddo

    do j=ny-(nb-3)/2,ny
      do i=1,(nb-1)/2
        if ( binin(i,j,k) .gt. thrl ) then
          UOUT(i,j,k) = (temp(i,j,k)*((i+(nb-1)/2)*(ny-j+(nb+1)/2))-binin(i,j,k))/((i+(nb-1)/2)*(ny-j+(nb+1)/2)-1)
        else
          UOUT(i,j,k) = binin(i,j,k)
        end if
      enddo
    enddo


    do j=1,(nb-1)/2
      do i=nx-(nb-3)/2,nx
        do jj=1,j+(nb-1)/2
          do ii=1,nx-i+(nb+1)/2
            temp(i,j,k)=temp(i,j,k)+binin(i+ii-(nb+1)/2,jj,k)/((nx-i+(nb+1)/2)*(j+(nb-1)/2))
          enddo
        enddo
      enddo
    enddo

    do j=1,(nb-1)/2
      do i=nx-(nb-3)/2,nx
        if ( binin(i,j,k) .gt. thrl ) then
          UOUT(i,j,k) = (temp(i,j,k)*((nx-i+(nb+1)/2)*(j+(nb-1)/2))-binin(i,j,k))/((nx-i+(nb+1)/2)*(j+(nb-1)/2)-1)
        else
          UOUT(i,j,k) = binin(i,j,k)
        end if
      enddo
    enddo


    do j=ny-(nb-3)/2,ny
      do i=nx-(nb-3)/2,nx
        do jj=1,ny-j+(nb+1)/2
          do ii=1,nx-i+(nb+1)/2
            temp(i,j,k)=temp(i,j,k)+binin(i+ii-(nb+1)/2,j+jj-(nb+1)/2,k)/((nx-i+(nb+1)/2)*(ny-j+(nb+1)/2))
          enddo
        enddo
      enddo
    enddo

    do j=ny-(nb-3)/2,ny
      do i=nx-(nb-3)/2,nx
        if ( binin(i,j,k) .gt. thrl ) then
          UOUT(i,j,k) = (temp(i,j,k)*((nx-i+(nb+1)/2)*(ny-j+(nb+1)/2))-binin(i,j,k))/((nx-i+(nb+1)/2)*(ny-j+(nb+1)/2)-1)
        else
          UOUT(i,j,k) = binin(i,j,k)
        end if
      enddo
    enddo

  enddo

  return
  end

!-------------------------------------------------------------------------------
      SUBROUTINE PRE_FFT(U,NX,NFX,UFFT)
      IMPLICIT REAL*8(A-H,O-Z)

      REAL*8 U(NX),UF(NX),UCOM(2*NX),UFFT(NFX)

      UF=0.D0
      UCOM=0.D0
      UFFT=0.D0

      DO I=1,NX
        UF(I)=U(NX-I+1)
      END DO

      DO I=1,2*NX
        IF(I.le.NX)THEN
          UCOM(I)=UF(I)
          ELSE
          UCOM(I)=U(I-NX)
        END IF
      END DO
      DO I=1,NFX
        IF(I.le.2*NX)THEN
          UFFT(I)=UCOM(I)
        ELSE
          UFFT(I)=0.D0
        END IF
      END DO

      RETURN
      END

!-------------------------------------------------------------------
      SUBROUTINE LOWPASS(UR,N,NF,IP,NCUT)

      integer LIST(NF/2*IP),KEY
      REAL*8 UR(NF),DR(NF),DI(NF),NCUT
      COMPLEX*16 T(NF/2*IP,2),B(NF),C(NF),CC(NF)

      LIST=0
      DR=0.D0
      DI=0.D0
      T=0.D0
      B=0.D0
      C=0.D0
      CC=0.D0

      CALL SETLST(LIST,NF/2,IP)
      CALL SETTBL(NF/2,T,B,IP)

      DO I=1,NF
        DR(I)=UR(I)
        DI(I)=0.D0
      END DO

      DO I=1,NF
        C(I)=DCMPLX(DR(I),DI(I))
      END DO

      KEY=1
      CALL F2FFT(C,CC,LIST,T,NF/2,IP,KEY)
      DO I=1,NF
        IF(I.le.INT(N*NCUT) .or. I.ge.NF-INT(N*NCUT)+1)THEN
          DR(I)=DREAL(CC(I))
          DI(I)=DIMAG(CC(I))
        ELSE
          DR(I)=0.D0
          DI(I)=0.D0
        END IF
      END DO

      DO I=1,NF
        C(I)=DCMPLX(DR(I),DI(I))
      END DO
      KEY=2
      CALL F2FFT(C,CC,LIST,T,NF/2,IP,KEY)
      DO I=1,NF
         UR(I)=DREAL(CC(I))
         DI(I)=DIMAG(CC(I))
      END DO

      RETURN
      END

!-------------------------------------------------------------------
      SUBROUTINE F2FFT(A,B,LIST,T,N2,LP,KEY)
       IMPLICIT COMPLEX*16(A-C,E-H,O-Z)
       REAL*8   DIV
       DIMENSION A(N2*2),B(N2*2),T(N2*LP,2),LIST(N2*LP)

       K=1
       L=N2
       DO 10 I=1,LP
           M=(I-1)*N2+1
           IF(K.EQ.1) THEN
              CALL FFTSUB(A,B,T(M,KEY),LIST(M),L,N2)
           ELSE
              CALL FFTSUB(B,A,T(M,KEY),LIST(M),L,N2)
           END IF
           K=K*(-1)
           L=L/2
   10 CONTINUE

       IF(KEY.EQ.1) THEN
          DIV=1.0D0/(N2*2)
          IF(K.EQ.1) THEN
             DO 20 I=1,N2*2
                B(I)=A(I)*DIV
   20       CONTINUE
          ELSE
             DO 30 I=1,N2*2
                B(I)=B(I)*DIV
   30       CONTINUE
          END IF
       ELSE IF(K.EQ.1) THEN
          DO 40 I=1,N2*2
             B(I)=A(I)
   40    CONTINUE
       END IF
       RETURN
       END

!------------------------------------------------------------------
      SUBROUTINE FFTSUB(A,B,T,LIST,L,N2)
      IMPLICIT COMPLEX*16(A-H,O-Z)
      DIMENSION A(N2*2),B(N2,2),T(N2),LIST(N2)

      DO 10 I=1,N2
         B(I,1)=A(LIST(I))+A(LIST(I)+L)*T(I)
         B(I,2)=A(LIST(I))-A(LIST(I)+L)*T(I)
   10 CONTINUE
      RETURN
      END

!------------------------------------------------------------------
      SUBROUTINE SETLST(LIST,N2,LP)
      DIMENSION LIST(N2,LP)
      N1=N2
      NN=1
      DO 30 K=1,LP
         M=0
         DO 20 J=1,NN
            DO 10 I=1,N1
               M=M+1
               LIST(M,K)=I+(J-1)*2*N1
   10       CONTINUE
   20    CONTINUE
         N1=N1/2
         NN=NN*2
   30 CONTINUE
      RETURN
      END

!-------------------------------------------------------------------
      SUBROUTINE SETTBL(N2,T,B,LP)
      COMPLEX*16 T,B
      REAL*8 TR,TI,PAI
      DIMENSION T(N2,LP,2),B(N2,2)
      PAI=4.0D0*DATAN(1.0D0)
      DO 10 I=1,N2
         TR=DCOS(2.0D0*PAI*(I-1)/DFLOAT(N2*2))
         TI=DSIN(2.0D0*PAI*(I-1)/DFLOAT(N2*2))
         B(I,1)=DCMPLX(TR,-TI)
         B(I,2)=DCMPLX(TR,TI)
   10 CONTINUE
      K=1
      NN=N2
      DO 40 L=1,LP
         DO 30 J=0,K-1
            DO 20 I=1,NN
               T(I+J*NN,L,1)=B(1+NN*J,1)
               T(I+J*NN,L,2)=B(1+NN*J,2)
   20       CONTINUE
   30    CONTINUE
         K=K*2
         NN=NN/2
   40 CONTINUE
      RETURN
      END
