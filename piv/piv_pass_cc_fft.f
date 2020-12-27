      subroutine cross_correlate_fft_rect_slow
     _             (iw1, iw2, niw_xl , niw_yl ,ixcorr)
      use fft_vars_module
      implicit none
      integer, intent(in) :: niw_xl,niw_yl
      real(8), intent(in) :: iw1(niw_xl,niw_yl),iw2(niw_xl,niw_yl)
      real(8), intent(out) :: ixcorr(niw_xl,niw_yl)
! image variable
      integer:: nx1, ny1
      REAL(8) FIMAGE(niw_xl,niw_yl),SIMAGE(niw_xl,niw_yl)
      REAL(8) FIMAGE_mean,SIMAGE_mean
      REAL(8) EF,ES,E
! FFT variable
      integer:: nfx_1, nfy_1
      REAL(8) FR1X(niw_xl),FI1X(niw_xl)
      REAL(8) FR2X(niw_xl),FI2X(niw_xl)
      REAL(8) FR1Y(niw_yl),FI1Y(niw_yl)
      REAL(8) FR2Y(niw_yl),FI2Y(niw_yl)
      REAL(8) FR0Y(niw_yl,niw_xl),FI0Y(niw_yl,niw_xl)
      REAL(8) CFRFS(niw_yl,niw_xl),CFIFS(niw_yl,niw_xl)
      REAL(8) CFRSS(niw_yl,niw_xl),CFISS(niw_yl,niw_xl)
      REAL(8) FRY(niw_yl,niw_xl),FIY(niw_yl,niw_xl)
      REAL(8) RRF(niw_xl,niw_yl)
      INTEGER,allocatable:: IFX(:),IFY(:)
      real(8),allocatable:: TRFX(:),TRBX(:),TIFX(:),TIBX(:)
      real(8),allocatable:: TRFY(:),TRBY(:),TIFY(:),TIBY(:)
      INTEGER,allocatable:: LISTI1(:,:),LISTJ1(:,:),LISTK1(:,:)
      INTEGER,allocatable:: LISTI2(:,:),LISTJ2(:,:),LISTK2(:,:)
! temporary variable
      integer:: i,j,key,nxp,nyp
      real(8):: tmp_ffts
      real(8),parameter:: PAI=4.0*ATAN(1.0)

      nx1=niw_xl
      ny1=niw_yl
      NXP=nx1/2+1
      NYP=ny1/2+1
      RRF(1:niw_xl,1:niw_yl)=0.d0

      FIMAGE(1:niw_xl,1:niw_yl)=iw1(1:niw_xl,1:niw_yl)
      SIMAGE(1:niw_xl,1:niw_yl)=iw2(1:niw_xl,1:niw_yl)

      call check_nfft(nx1)
      call check_nfft(ny1)

! set fft radix
! for x
      call get_fft_radix_size(nx1,nfx_1)
      allocate(IFX(NFX_1))
      call get_fft_radix(nx1,nfx_1,ifx)
! for y
      call get_fft_radix_size(ny1,nfy_1)
      allocate(IFY(NFY_1))
      call get_fft_radix(ny1,nfy_1,ify)
! prepare arrays for FFT
      allocate(TRFX(nx1))
      allocate(TRBX(nx1))
      allocate(TIFX(nx1))
      allocate(TIBX(nx1))
      allocate(TRFY(ny1))
      allocate(TRBY(ny1))
      allocate(TIFY(ny1))
      allocate(TIBY(ny1))
      allocate(LISTI1(nx1/2,nfx_1))
      allocate(LISTJ1(nx1/2,nfx_1))
      allocate(LISTK1(nx1/2,nfx_1))
      allocate(LISTI2(ny1/2,nfy_1))
      allocate(LISTJ2(ny1/2,nfy_1))
      allocate(LISTK2(ny1/2,nfy_1))
      CALL LISTSUB(IFX ,NFX_1 ,nx1 ,LISTI1,LISTJ1,LISTK1,1 ,1)
      CALL LISTSUB(IFY ,NFY_1 ,ny1 ,LISTI2,LISTJ2,LISTK2,1 ,1)
      CALL SETFFT(TRFX ,TIFX ,TRBX ,TIBX ,nx1)
      CALL SETFFT(TRFY ,TIFY ,TRBY ,TIBY ,ny1)

! compute image statistics
      ef=0.d0
      es=0.d0
      fimage_mean=0.0d0
      simage_mean=0.0d0
      DO 112 j=1,ny1
        DO 112 i=1,nx1
          fimage_mean=fimage_mean+fimage(i,j)/dble(nx1*ny1)
          simage_mean=simage_mean+simage(i,j)/dble(nx1*ny1)
  112 CONTINUE
      do j=1,ny1
        do i=1,nx1
          ef=ef+(fimage(i,j)-fimage_mean)
     _         *(fimage(i,j)-fimage_mean)/dble(nx1*ny1)
          es=es+(simage(i,j)-simage_mean)
     _         *(simage(i,j)-simage_mean)/dble(nx1*ny1)
        enddo
      enddo
      ef=sqrt(ef)
      es=sqrt(es)
      e=1.0/ef/es

! forward FFT | note that following 2D FFT is SLOW but simple !< \todo implement real 2d fft
! 1st iw
! in x direction
      do j=1,ny1
        do i=1,nx1
          fr1x(i)=fimage(i,j)-fimage_mean
          fi1x(i)=0.d0
        enddo
        KEY=2
        CALL FREQUEN(fr1x,fi1x,fr2x,fi2x
     *                ,TRFX,TIFX,TRBX,TIBX
     *                ,IFX,NFX_1,nx1,1,1,KEY,LISTI1,LISTJ1,LISTK1)
        do i=1,nx1
          fr0y(j,i)=fr2x(i)
          fi0y(j,i)=fi2x(i)
        enddo
      enddo
! in y direction
      do i=1,nx1
        do j=1,ny1
          fr1y(j)=fr0y(j,i)
          fi1y(j)=fi0y(j,i)
        enddo
        KEY=2
        CALL FREQUEN(fr1y,fi1y,fr2y,fi2y
     *                ,TRFY,TIFY,TRBY,TIBY
     *                ,IFY,NFY_1,ny1,1,1,KEY,LISTI2,LISTJ2,LISTK2)
        do j=1,ny1
          fr0y(j,i)= fr2y(j)
          fi0y(j,i)= fi2y(j)
        enddo
      enddo
      DO I=1,nx1
        DO J=1,ny1
          cfrfs(J,I)=fr0y(J,I)
          cfifs(J,I)=fi0y(J,I)
        ENDDO
      ENDDO
! 2nd iw
! in x direction
      do j=1,ny1
        do i=1,nx1
          fr1x(i)=simage(i,j)-simage_mean
          fi1x(i)=0.d0
        enddo
        KEY=2
        CALL FREQUEN(fr1x,fi1x,fr2x,fi2x
     *                ,TRFX,TIFX,TRBX,TIBX
     *                ,IFX,NFX_1,nx1,1,1,KEY,LISTI1,LISTJ1,LISTK1)
        do i=1,nx1
          fr0y(j,i)=fr2x(i)
          fi0y(j,i)=fi2x(i)
        enddo
      enddo
! in y direction
      do i=1,nx1
        do j=1,ny1
          fr1y(j)=fr0y(j,i)
          fi1y(j)=fi0y(j,i)
        enddo
        KEY=2
        CALL FREQUEN(fr1y,fi1y,fr2y,fi2y
     *                ,TRFY,TIFY,TRBY,TIBY
     *                ,IFY,NFY_1,ny1,1,1,KEY,LISTI2,LISTJ2,LISTK2)
        do j=1,ny1
          fr0y(j,i)= fr2y(j)
          fi0y(j,i)= fi2y(j)
        enddo
      enddo
      DO I=1,nx1
        DO J=1,ny1
          cfrss(J,I)=fr0y(J,I)
          cfiss(J,I)=fi0y(J,I)
        ENDDO
      ENDDO

! for DEBUG writing transformed iws
!      if (pass_idx==1) then
!      open(10,file='iw1hr',access='stream')
!      write(10) cfrfs
!      close(10)
!      open(10,file='iw1hi',access='stream')
!      write(10) cfifs
!      close(10)
!      open(10,file='iw2hr',access='stream')
!      write(10) cfrss
!      close(10)
!      open(10,file='iw2hi',access='stream')
!      write(10) cfiss
!      close(10)
!      endif

! compute cross correlation fft2(iw1).*conj(fft2(iw2))
      do i=1,nx1
        do j=1,ny1
          fry(j,i)=  cfrfs(j,i)*cfrss(j,i)
     _              +cfifs(j,i)*cfiss(j,i)
          fiy(J,I) = cfifs(j,i)*cfrss(j,i)
     _              -cfrfs(j,i)*cfiss(j,i)
        enddo
      enddo

! inverse transform
! in y
        do i=1,nx1
          do j=1,ny1
            fr1y(J)=fry(J,I)
            fi1y(J)=fiy(J,I)
          enddo
          KEY=1
          CALL FREQUEN(fr1y,fi1y,fr2y,fi2y
     *                ,TRFY,TIFY,TRBY,TIBY
     *                ,IFY,NFY_1,ny1,1,1,KEY,LISTI2,LISTJ2,LISTK2)
          do j=1,ny1
            fr0y(j,i)= fr2y(j)
            fi0y(j,i)= fi2y(j)
          enddo
        enddo
! in x
        do j=1,ny1
          do i=1,nx1
            fr1x(i) = fr0y(j,i)
            fi1x(i) = fi0y(j,i)
          enddo
          KEY=1
          CALL FREQUEN(fr1x,fi1x,fr2x,fi2x
     *                ,TRFX,TIFX,TRBX,TIBX
     *                ,IFX,NFX_1,nx1,1,1,KEY,LISTI1,LISTJ1,LISTK1)
         do i=1,nx1
            fr0y(j,i)=fr2x(i)
            fi0y(j,i)=fi2x(i)
         enddo
        enddo

! normalize CC
      do j=1,ny1
        do i=1,nx1
          rrf(i,j)=fr0y(j,i)*e
        enddo
      enddo
      ixcorr(1:niw_xl,1:niw_yl)=rrf(1:niw_xl,1:niw_yl)

! fftshift: Q1 <--> Q3, Q2 <--> Q4
      do j=1,ny1/2
        do i=1,nx1/2
          tmp_ffts=ixcorr(i,j) ! store Q1
          ixcorr(i,j)=ixcorr(i+nx1/2,j+ny1/2) ! Q3 -> Q1
          ixcorr(i+nx1/2,j+ny1/2)=tmp_ffts ! Q1 -> Q3

          tmp_ffts=ixcorr(i+nx1/2,j) ! store Q2
          ixcorr(i+nx1/2,j)=ixcorr(i,j+ny1/2) ! Q4 -> Q2
          ixcorr(i,j+ny1/2)=tmp_ffts ! Q2 -> Q4
        enddo
      enddo

      deallocate(IFX)
      deallocate(TRFX)
      deallocate(TRBX)
      deallocate(TIFX)
      deallocate(TIBX)
      deallocate(LISTI1)
      deallocate(LISTJ1)
      deallocate(LISTK1)
      deallocate(IFY)
      deallocate(TRFY)
      deallocate(TRBY)
      deallocate(TIFY)
      deallocate(TIBY)
      deallocate(LISTI2)
      deallocate(LISTJ2)
      deallocate(LISTK2)

      END subroutine cross_correlate_fft_rect_slow

C****************************************************C
C     DPIV PROGRAM BY CROSS CORRELATION 1996.09.19   C
C     MODIFIED FOR EXPERIMENT DATA        1998.06.24 C
C                            _BINARY DATA 1998.07.10 C
C                                         2003.02.17 C
C                            _CHCH        2004.11.11 C
C****************************************************C
      subroutine cross_correlate_fft_mt(iw1,iw2,niw,ixcorr)
      use fft_vars_module
      use fft_shared
      IMPLICIT real(8) (A-H,O-Z)
      IMPLICIT INTEGER(I-N)
      integer, intent(in):: niw
      real(8), intent(in):: iw1(niw,niw)
      real(8), intent(in):: iw2(niw,niw)
      real(8), intent(out):: ixcorr(niw,niw)
!      include 'para_piv.h'

      integer:: n=0
      integer:: nfx=0

!      INTEGER IFX(NFX)
!      real(8) TRFX(N),TRBX(N)
!      real(8) TIFX(N),TIBX(N)
      INTEGER ISIGN(2)
C
!      INTEGER LISTI1(N/2*N,NFX),LISTJ1(N/2*N,NFX)
!     _       ,LISTK1(N/2*N,NFX)
C
      real(8) PX1R(Niw,Niw),PX1I(Niw,Niw)
     _       ,PX2R(Niw,Niw),PX2I(Niw,Niw)
     _       ,PXR(Niw,Niw),PXI(Niw,Niw)
      real(8) px1m,px2m,px1rms,px2rms
!      INTEGER X0,Y0,IM,JM

C------------------------------------------------C
c      COMMON /KX/KX,/DY/DY
c      COMMON /TRIGS1/TRFX,TRBX,TIFX,TIBX
c      COMMON /IFAX1/IFX
c      COMMON /LIST1/LISTI1,LISTJ1,LISTK1
C---------------------------C
      N=niw
      call check_nfft(N)
      call get_fft_radix_size(N,nfx)
      allocate(IFX(NFX))
      call get_fft_radix(N,nfx,IFX)

!      ! setting fft radix
!      if (n==96) then
!        nfx=3
!        allocate(IFX(NFX))
!        ifx(1)=4
!        ifx(2)=4
!        ifx(3)=6
!      elseif(n==64) then
!        nfx=3
!        allocate(IFX(NFX))
!        ifx(1)=4
!        ifx(2)=4
!        ifx(3)=4
!      elseif(n==48) then
!        nfx=3
!        allocate(IFX(NFX))
!        ifx(1)=3
!        ifx(2)=4
!        ifx(3)=4
!      else
!        print *, 'NO FFT RADIX COMBINATION IS DEFINED FOR NIW=',niw
!        STOP
!      endif

      allocate(TRFX(N))
      allocate(TRBX(N))
      allocate(TIFX(N))
      allocate(TIBX(N))
      allocate(LISTI1(N/2*N,nfx))
      allocate(LISTJ1(N/2*N,nfx))
      allocate(LISTK1(N/2*N,nfx))

      CALL LISTSUB(IFX,NFX,N,LISTI1,LISTJ1,LISTK1,N,1)
      CALL SETFFT(TRFX,TIFX,TRBX,TIBX,N)

C--------------------------------------------------------------------C
C     Fourier transformation to make cross correlation               C
C--------------------------------------------------------------------C
        px1m=0.0d0
        px2m=0.0d0
        px1rms=0.0d0
        px2rms=0.0d0
       DO I=1,N
         DO J=1,N
            PX1R(I,J)=iw1(i,j)
            PX2R(I,J)=iw2(i,j)
            PX1I(I,J)=0.0D0
            PX2I(I,J)=0.0D0
            px1m=px1m+px1r(i,j)
            px2m=px2m+px2r(i,j)
         ENDDO
       ENDDO
        px1m=px1m/n/n
        px2m=px2m/n/n
        do i=1,n
         do j=1,n
          px1r(i,j)=px1r(i,j)-px1m
          px2r(i,j)=px2r(i,j)-px2m
          px1rms=px1rms+px1r(i,j)*px1r(i,j)
          px2rms=px2rms+px2r(i,j)*px2r(i,j)
         enddo
        enddo
        px1rms=dsqrt(px1rms/n/n)
        px2rms=dsqrt(px2rms/n/n)
      ISIGN(1)=1
      CALL DFFTDF(PX1R,PX1I,PX2R,PX2I,ISIGN,niw)
       DO I=1,N
         DO J=1,N
            PXR(I,J)=PX1R(I,J)*PX2R(I,J)+PX1I(I,J)*PX2I(I,J)
            PXI(I,J)=-PX1R(I,J)*PX2I(I,J)+PX1I(I,J)*PX2R(I,J)
         ENDDO
       ENDDO
      ISIGN(1)=2
      CALL DFFTDF(PXR,PXI,PX1R,PX1I,ISIGN,niw)
C--------------------------------------------------------------------C
C     Transform X-Y position for cross correlation                   C
C--------------------------------------------------------------------C
       DO I=1,N
         DO J=1,N
            PX1R(I,J)=PXR(I,J)
         ENDDO
       ENDDO
       DO I=1,N
         DO J=1,N
            PXR(I,J)=0.0d0
         ENDDO
       ENDDO
       DO I=1,N/2
          DO J=1,N/2
            PXR(I,J)=PX1R(I+N/2,J+N/2)
         ENDDO
       ENDDO
       DO I=N/2+1,N
         DO J=N/2+1,N
            PXR(I,J)=PX1R(I-N/2,J-N/2)
         ENDDO
       ENDDO
       DO I=1,N/2
         DO J=N/2+1,N
            PXR(I,J)=PX1R(I+N/2,J-N/2)
         ENDDO
       ENDDO
       DO I=N/2+1,N
         DO J=1,N/2
            PXR(I,J)=PX1R(I-N/2,J+N/2)
         ENDDO
       ENDDO

      do i=1,N
      do j=1,N
      ixcorr(i,j)=pxr(i,j)/px1rms/px2rms
      enddo
      enddo

      deallocate(IFX)
      deallocate(TRFX)
      deallocate(TRBX)
      deallocate(TIFX)
      deallocate(TIBX)
      deallocate(LISTI1)
      deallocate(LISTJ1)
      deallocate(LISTK1)

      return
      end

C---------------------------------------------------------------------C
C     SUBROUTINE PROGRAM DFFTDF                                       C
C     2-COMPORNENT FFT                                                C
C                                    VER. 1.0 1990.12.06 BY TANAHASHI C
C                                    VER. 1.1 1991.07.29 BY TANAHASHI C
C---------------------------------------------------------------------C
      SUBROUTINE DFFTDF(PRA,PIA,PRB,PIB,ISIGN,niw)
      use fft_vars_module
      use fft_shared
!      include 'para_piv.h'
      integer:: n=96
      integer, parameter :: nfx=3
C
!      INTEGER IFX(NFX)
      INTEGER KEY
!      real(8) TRFX(N),TRBX(N)
!      real(8) TIFX(N),TIBX(N)
!      real(8) WIF3,WIB3
!      real(8) WRF5,WIF5,WRB5,WIB5
!     *      ,WR2F5,WI2F5,WR2B5,WI2B5
!      real(8) WIF6,WIB6
!      real(8) WRF8,WRB8
!      real(8) WRF9,WIF9,WRB9,WIB9
!     _      ,WR2F9,WI2F9,WR2B9,WI2B9
!     _      ,WR3F9,WI3F9,WR3B9,WI3B9
!     _      ,WR4F9,WI4F9,WR4B9,WI4B9
!      INTEGER LISTI1(N/2*N,NFX),LISTJ1(N/2*N,NFX)
!     *       ,LISTK1(N/2*N,NFX)
C
      INTEGER ISIGN(2),I,J,NI,NJ
      real(8) FRA(niw,niw),FIA(niw,niw)
      real(8) FRB(niw,niw),FIB(niw,niw)
      real(8) PRA(niw,niw),PIA(niw,niw)
      real(8) PRB(niw,niw),PIB(niw,niw)
C
!      COMMON /TRIGS1/TRFX,TRBX,TIFX,TIBX
!      COMMON /IFAX1/IFX
!      COMMON /W3/WIF3,WIB3
!      COMMON /W5/WRF5,WIF5,WRB5,WIB5
!     *          ,WR2F5,WI2F5,WR2B5,WI2B5
!      COMMON /W6/WIF6,WIB6
!      COMMON /W8/WRF8,WRB8
!      COMMON /W9/WRF9,WIF9,WRB9,WIB9
!     _          ,WR2F9,WI2F9,WR2B9,WI2B9
!     _          ,WR3F9,WI3F9,WR3B9,WI3B9
!     _          ,WR4F9,WI4F9,WR4B9,WI4B9
 !     COMMON /LIST1/LISTI1,LISTJ1,LISTK1
      n=niw
C------------------------------------------------C
      IF (ISIGN(1).EQ.1) THEN
C------------------------------------------------C
         KEY=2
         CALL FREQUEN(PRA,PRB,FRA,FIA
     *               ,TRFX,TIFX,TRBX,TIBX
     *               ,IFX,NFX,N,N,1,KEY,LISTI1,LISTJ1,LISTK1)
         DO 60 J=1,N
            DO 60 I=1,N
               PRA(J,I)=FRA(I,J)
               PRB(J,I)=FIA(I,J)
   60    CONTINUE
         DO 65 J=1,N
            PRA(J,N/2+1)=0.0D0
            PRB(J,N/2+1)=0.0D0
   65    CONTINUE
C------------------------------------------------C
         KEY=2
         CALL FREQUEN(PRA,PRB,PIA,PIB
     *               ,TRFX,TIFX,TRBX,TIBX
     *               ,IFX,NFX,N,N,1,KEY,LISTI1,LISTJ1,LISTK1)
         DO 80 I=1,N
            DO 80 J=1,N
               FRA(I,J)=PIA(J,I)
               FIA(I,J)=PIB(J,I)
   80    CONTINUE
         DO 85 I=1,N
            FRA(I,N/2+1)=0.0D0
            FIA(I,N/2+1)=0.0D0
   85    CONTINUE
C------------------------------------------------C
         DO 100 J=2,N/2+1
*VOPTION VEC
            DO 100 I=2,N/2+1
               NJ=N-J+2
               NI=N-I+2
               PRA(I,J)= 0.5D0*(FRA(I,J)+FRA(NI,NJ))
               PIA(I,J)= 0.5D0*(FIA(I,J)-FIA(NI,NJ))
               PRB(I,J)= 0.5D0*(FIA(I,J)+FIA(NI,NJ))
               PIB(I,J)=-0.5D0*(FRA(I,J)-FRA(NI,NJ))
               PRA(NI,J)= 0.5D0*(FRA(NI,J)+FRA(I,NJ))
               PIA(NI,J)= 0.5D0*(FIA(NI,J)-FIA(I,NJ))
               PRB(NI,J)= 0.5D0*(FIA(NI,J)+FIA(I,NJ))
               PIB(NI,J)=-0.5D0*(FRA(NI,J)-FRA(I,NJ))
               PRA(I,NJ)= 0.5D0*(FRA(I,NJ)+FRA(NI,J))
               PIA(I,NJ)= 0.5D0*(FIA(I,NJ)-FIA(NI,J))
               PRB(I,NJ)= 0.5D0*(FIA(I,NJ)+FIA(NI,J))
               PIB(I,NJ)=-0.5D0*(FRA(I,NJ)-FRA(NI,J))
               PRA(NI,NJ)= 0.5D0*(FRA(NI,NJ)+FRA(I,J))
               PIA(NI,NJ)= 0.5D0*(FIA(NI,NJ)-FIA(I,J))
               PRB(NI,NJ)= 0.5D0*(FIA(NI,NJ)+FIA(I,J))
               PIB(NI,NJ)=-0.5D0*(FRA(NI,NJ)-FRA(I,J))
  100    CONTINUE
*VOPTION VEC
         DO 110 I=2,N/2+1
            NI=N-I+2
            PRA(I,1)= 0.5D0*(FRA(I,1)+FRA(NI,1))
            PIA(I,1)= 0.5D0*(FIA(I,1)-FIA(NI,1))
            PRB(I,1)= 0.5D0*(FIA(I,1)+FIA(NI,1))
            PIB(I,1)=-0.5D0*(FRA(I,1)-FRA(NI,1))
            PRA(NI,1)= 0.5D0*(FRA(NI,1)+FRA(I,1))
            PIA(NI,1)= 0.5D0*(FIA(NI,1)-FIA(I,1))
            PRB(NI,1)= 0.5D0*(FIA(NI,1)+FIA(I,1))
            PIB(NI,1)=-0.5D0*(FRA(NI,1)-FRA(I,1))
  110    CONTINUE
*VOPTION VEC
         DO 115 J=2,N/2+1
            NJ=N-J+2
            PRA(1,J)= 0.5D0*(FRA(1,J)+FRA(1,NJ))
            PIA(1,J)= 0.5D0*(FIA(1,J)-FIA(1,NJ))
            PRB(1,J)= 0.5D0*(FIA(1,J)+FIA(1,NJ))
            PIB(1,J)=-0.5D0*(FRA(1,J)-FRA(1,NJ))
            PRA(1,NJ)= 0.5D0*(FRA(1,NJ)+FRA(1,J))
            PIA(1,NJ)= 0.5D0*(FIA(1,NJ)-FIA(1,J))
            PRB(1,NJ)= 0.5D0*(FIA(1,NJ)+FIA(1,J))
            PIB(1,NJ)=-0.5D0*(FRA(1,NJ)-FRA(1,J))
  115    CONTINUE
         PRA(1,1)= 0.5D0*(FRA(1,1)+FRA(1,1))
         PIA(1,1)= 0.5D0*(FIA(1,1)-FIA(1,1))
         PRB(1,1)= 0.5D0*(FIA(1,1)+FIA(1,1))
         PIB(1,1)=-0.5D0*(FRA(1,1)-FRA(1,1))
C------------------------------------------------C
      ELSE
C------------------------------------------------C
         DO 130 J=1,N
            DO 130 I=1,N
               FRA(I,J)=PRA(I,J)
               FIA(I,J)=PIA(I,J)
               FRB(I,J)=PRB(I,J)
               FIB(I,J)=PIB(I,J)
  130    CONTINUE
         DO 150 J=2,N/2
            NJ=N-J+2
            FRA(1,NJ)= FRA(1,J)
            FIA(1,NJ)=-FIA(1,J)
            FRB(1,NJ)= FRB(1,J)
            FIB(1,NJ)=-FIB(1,J)
  150    CONTINUE
         DO 160 J=2,N/2
            NJ=N-J+2
            DO 170 I=2,N/2
               NI=N-I+2
               FRA(I,NJ)= FRA(NI,J)
               FIA(I,NJ)=-FIA(NI,J)
               FRB(I,NJ)= FRB(NI,J)
               FIB(I,NJ)=-FIB(NI,J)
               FRA(NI,NJ)= FRA(I,J)
               FIA(NI,NJ)=-FIA(I,J)
               FRB(NI,NJ)= FRB(I,J)
               FIB(NI,NJ)=-FIB(I,J)
  170       CONTINUE
  160    CONTINUE
C------------------------------------------------C
         DO 190 I=1,N
            DO 190 J=1,N
               PRA(J,I)=FRA(I,J)-FIB(I,J)
               PRB(J,I)=FIA(I,J)+FRB(I,J)
  190    CONTINUE
         KEY=1
         CALL FREQUEN(PRA,PRB,PIA,PIB
     *               ,TRFX,TIFX,TRBX,TIBX
     *               ,IFX,NFX,N,N,1,KEY,LISTI1,LISTJ1,LISTK1)
C------------------------------------------------C
         DO 220 J=1,N
            DO 220 I=1,N
               FRA(I,J)=PIA(J,I)
               FRB(I,J)=PIB(J,I)
  220    CONTINUE
         KEY=1
         CALL FREQUEN(FRA,FRB,PRA,PRB
     *               ,TRFX,TIFX,TRBX,TIBX
     *               ,IFX,NFX,N,N,1,KEY,LISTI1,LISTJ1,LISTK1)
C------------------------------------------------C
      ENDIF
C------------------------------------------------C
      RETURN
      END


*/////////////////////////////////////////////////////////////////*
*     FFT PROGURAM FOR DIRECT NUMERICAL SIMULATION                *
*                      BASED ON                                   *
*                   C. TEMPERTON                                  *
*        (J. COMPUT. PHYSICS, 52, 1-23, (1983))                   *
*               VER.[1.0] 1991.05.26                              *
*               VER.[2.0] 1992.04.03 radix 8 & 9 are added        *
*                        BY                                       *
*                   M. TANAHASHI                                  *
*         MIYAUCHI LAB, DEP. MECH. ENG. SCI.,                     *
*                     T. I. T.                                    *
*/////////////////////////////////////////////////////////////////*
      subroutine frequen(ar,ai,cr,ci
     *           ,trigsrf,trigsif,trigsrb,trigsib
     *           ,ifax,nfax,n,n1,n2,key,listi,listj,listk)
      use fft_vars_module
      real(8) ar(n*n1*n2),cr(n*n1*n2),trigsrf(n),trigsrb(n)
      real(8) ai(n*n1*n2),ci(n*n1*n2),trigsif(n),trigsib(n)
      integer ifax(nfax),k,key
      integer listi(n/2*n1*n2,nfax),listj(n/2*n1*n2,nfax)
     *       ,listk(n/2*n1*n2,nfax)
!      real(8) wif3,wib3
!      real(8) wrf5,wif5,wrb5,wib5
!      real(8) wif6,wib6
!     *      ,wr2f5,wi2f5,wr2b5,wi2b5
!      real(8) wrf8,wrb8
!      real(8) wrf9,wif9,wrb9,wib9
!     *      ,wr2f9,wi2f9,wr2b9,wi2b9
!     *      ,wr3f9,wi3f9,wr3b9,wi3b9
!     *      ,wr4f9,wi4f9,wr4b9,wi4b9
!      common /w3/wif3,wib3
!      common /w5/wrf5,wif5,wrb5,wib5
!     *          ,wr2f5,wi2f5,wr2b5,wi2b5
!      common /w6/wif6,wib6
!      common /w8/wrf8,wrb8
!      common /w9/wrf9,wif9,wrb9,wib9
!     *          ,wr2f9,wi2f9,wr2b9,wi2b9
!     *          ,wr3f9,wi3f9,wr3b9,wi3b9
!     *          ,wr4f9,wi4f9,wr4b9,wi4b9
c
      k=1
      la=1
      if(key.eq.1) then
      do 10 i=1,nfax
        ifac=ifax(i)
       if(k.eq.1) then
        if(ifac.eq.2)
     *  call pass2(ar,ai,cr,ci,trigsrf,trigsif,ifac,nfax,la,n
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.3)
     *  call pass3(ar,ai,cr,ci,trigsrf,trigsif
     *            ,wif3,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.4)
     *  call pass4(ar,ai,cr,ci,trigsrf,trigsif
     *            ,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.5)
     *  call pass5(ar,ai,cr,ci,trigsrf,trigsif,wrf5,wif5
     *           ,wr2f5,wi2f5,ifac,nfax,la,n,key
     *           ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.6)
     *  call pass6(ar,ai,cr,ci,trigsrf,trigsif
     *            ,wif6,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.8)
     *  call pass8(ar,ai,cr,ci,trigsrf,trigsif
     *            ,wrf8,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.9)
     *  call pass9(ar,ai,cr,ci,trigsrf,trigsif
     *            ,wrf9,wif9,wr2f9,wi2f9,wr3f9,wi3f9,wr4f9,wi4f9
     *            ,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
       else
        if(ifac.eq.2)
     *  call pass2(cr,ci,ar,ai,trigsrf,trigsif,ifac,nfax,la,n
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.3)
     *  call pass3(cr,ci,ar,ai,trigsrf,trigsif
     *            ,wif3,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.4)
     *  call pass4(cr,ci,ar,ai,trigsrf,trigsif
     *            ,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.5)
     *  call pass5(cr,ci,ar,ai,trigsrf,trigsif,wrf5,wif5
     *            ,wr2f5,wi2f5,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.6)
     *  call pass6(cr,ci,ar,ai,trigsrf,trigsif
     *            ,wif6,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.8)
     *  call pass8(cr,ci,ar,ai,trigsrf,trigsif
     *            ,wrf8,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.9)
     *  call pass9(cr,ci,ar,ai,trigsrf,trigsif
     *            ,wrf9,wif9,wr2f9,wi2f9,wr3f9,wi3f9,wr4f9,wi4f9
     *            ,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
       endif
       la=la*ifac
       k=k*(-1)
   10 continue
      else
      do 15 i=1,nfax
        ifac=ifax(i)
       if(k.eq.1) then
        if(ifac.eq.2)
     *  call pass2(ar,ai,cr,ci,trigsrb,trigsib,ifac,nfax,la,n
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.3)
     *  call pass3(ar,ai,cr,ci,trigsrb,trigsib
     *            ,wib3,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.4)
     *  call pass4(ar,ai,cr,ci,trigsrb,trigsib
     *            ,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.5)
     *  call pass5(ar,ai,cr,ci,trigsrb,trigsib,wrb5,wib5
     *            ,wr2b5,wi2b5,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.6)
     *  call pass6(ar,ai,cr,ci,trigsrb,trigsib
     *            ,wib6,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.8)
     *  call pass8(ar,ai,cr,ci,trigsrb,trigsib
     *            ,wrb8,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.9)
     *  call pass9(ar,ai,cr,ci,trigsrb,trigsib
     *            ,wrb9,wib9,wr2b9,wi2b9,wr3b9,wi3b9,wr4b9,wi4b9
     *            ,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
       else
        if(ifac.eq.2)
     *  call pass2(cr,ci,ar,ai,trigsrb,trigsib,ifac,nfax,la,n
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.3)
     *  call pass3(cr,ci,ar,ai,trigsrb,trigsib
     *            ,wib3,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.4)
     *  call pass4(cr,ci,ar,ai,trigsrb,trigsib
     *            ,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.5)
     *  call pass5(cr,ci,ar,ai,trigsrb,trigsib,wrb5,wib5
     *            ,wr2b5,wi2b5,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.6)
     *  call pass6(cr,ci,ar,ai,trigsrb,trigsib
     *            ,wib6,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.8)
     *  call pass8(cr,ci,ar,ai,trigsrb,trigsib
     *            ,wrb8,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
        if(ifac.eq.9)
     *  call pass9(cr,ci,ar,ai,trigsrb,trigsib
     *            ,wrb9,wib9,wr2b9,wi2b9,wr3b9,wi3b9,wr4b9,wi4b9
     *            ,ifac,nfax,la,n,key
     *            ,listi,listj,listk,i,n1,n2)
       endif
       la=la*ifac
       k=k*(-1)
   15 continue
      endif
c
      if(k.eq.1) then
         if(key.eq.2) then
           do 50 i=1,n*n1*n2
             cr(i)=ar(i)/dble(n)
             ci(i)=ai(i)/dble(n)
   50      continue
         else
           do 60 i=1,n*n1*n2
             cr(i)=ar(i)
             ci(i)=ai(i)
   60      continue
         endif
      else
         if(key.eq.2) then
           do 55 i=1,n*n1*n2
             cr(i)=cr(i)/dble(n)
             ci(i)=ci(i)/dble(n)
   55      continue
         else
           do 65 i=1,n*n1*n2
             cr(i)=cr(i)
             ci(i)=ci(i)
   65      continue
         endif
      endif
c
      return
      end
*/////////////////////////////////////////////////////////////////*
      subroutine pass2(ar,ai,cr,ci,trigsr,trigsi
     *                ,ifac,nfax,la,n
     *                ,listi,listj,listk,p,n1,n2)
      use fft_vars_module
      real(8) ar(n*n1*n2),cr(n*n1*n2),trigsr(n)
      real(8) ai(n*n1*n2),ci(n*n1*n2),trigsi(n)
      real(8) s1,s2
      integer p
      integer listi(n/2*n1*n2,nfax),listj(n/2*n1*n2,nfax)
     *       ,listk(n/2*n1*n2,nfax)
      m=n/ifac
      ia=0
      ib=m
      ja=0
      jb=la
c
*VOPTION VEC
      do 10 i=1,n/ifac*n1*n2
      s1=ar(ia+listi(i,p))-ar(ib+listi(i,p))
      s2=ai(ia+listi(i,p))-ai(ib+listi(i,p))
      cr(ja+listj(i,p))=ar(ia+listi(i,p))+ar(ib+listi(i,p))
      ci(ja+listj(i,p))=ai(ia+listi(i,p))+ai(ib+listi(i,p))
      cr(jb+listj(i,p))=trigsr(listk(i,p)+1)*s1
     *                 -trigsi(listk(i,p)+1)*s2
      ci(jb+listj(i,p))=trigsi(listk(i,p)+1)*s1
     *                 +trigsr(listk(i,p)+1)*s2
   10 continue
      return
      end
*/////////////////////////////////////////////////////////////////*
      subroutine pass3(ar,ai,cr,ci,trigsr,trigsi
     *                ,wi,ifac,nfax,la,n,key
     *                ,listi,listj,listk,p,n1,n2)
      use fft_vars_module
      real(8) ar(n*n1*n2),cr(n*n1*n2),trigsr(n)
      real(8) ai(n*n1*n2),ci(n*n1*n2),trigsi(n),wi
      real(8) s1,s2,s3,s4,t1,t2,d1,d2,d3,d4
      integer key,p
      integer listi(n/2*n1*n2,nfax),listj(n/2*n1*n2,nfax)
     *       ,listk(n/2*n1*n2,nfax)
      m=n/ifac
      ia=0
      ib=m
      ic=m*2
      ja=0
      jb=la
      jc=la*2
c
*VOPTION VEC
      do 10 i=1,n/ifac*n1*n2
      s1=ar(ib+listi(i,p))+ar(ic+listi(i,p))
      s2=ai(ib+listi(i,p))-ai(ic+listi(i,p))
      s3=ai(ib+listi(i,p))+ai(ic+listi(i,p))
      s4=ar(ib+listi(i,p))-ar(ic+listi(i,p))
      t1=ar(ia+listi(i,p))-0.5d0*s1
      t2=ai(ia+listi(i,p))-0.5d0*s3
      d1=t1-wi*s2
      d2=t2+wi*s4
      d3=t1+wi*s2
      d4=t2-wi*s4
      cr(ja+listj(i,p))=ar(ia+listi(i,p))+s1
      ci(ja+listj(i,p))=ai(ia+listi(i,p))+s3
      cr(jb+listj(i,p))=trigsr(listk(i,p)+1)*d1
     *        -trigsi(listk(i,p)+1)*d2
      ci(jb+listj(i,p))=trigsi(listk(i,p)+1)*d1
     *        +trigsr(listk(i,p)+1)*d2
      cr(jc+listj(i,p))=trigsr(2*listk(i,p)+1)*d3
     *        -trigsi(2*listk(i,p)+1)*d4
      ci(jc+listj(i,p))=trigsi(2*listk(i,p)+1)*d3
     *        +trigsr(2*listk(i,p)+1)*d4
   10 continue
      return
      end
*/////////////////////////////////////////////////////////////////*
      subroutine pass4(ar,ai,cr,ci,trigsr,trigsi
     *                ,ifac,nfax,la,n,key
     *                ,listi,listj,listk,p,n1,n2)
      use fft_vars_module
      real(8) ar(n*n1*n2),cr(n*n1*n2),trigsr(n)
      real(8) ai(n*n1*n2),ci(n*n1*n2),trigsi(n)
      real(8) s1,s2,s3,s4,s5,s6,s7,s8
      real(8) t1,t2,t3,t4,t5,t6
      integer key,p
      integer listi(n/2*n1*n2,nfax),listj(n/2*n1*n2,nfax)
     *       ,listk(n/2*n1*n2,nfax)
      m=n/ifac
      ia=0
      ib=m
      ic=m*2
      id=m*3
      ja=0
      jb=la
      jc=la*2
      jd=la*3
c
      if(key.eq.1) then
*VOPTION VEC
      do 10 i=1,n/ifac*n1*n2
      s1=ar(ia+listi(i,p))+ar(ic+listi(i,p))
      s2=ai(ia+listi(i,p))+ai(ic+listi(i,p))
      s3=ar(ib+listi(i,p))+ar(id+listi(i,p))
      s4=ai(ib+listi(i,p))+ai(id+listi(i,p))
      s5=ar(ia+listi(i,p))-ar(ic+listi(i,p))
      s6=ai(ia+listi(i,p))-ai(ic+listi(i,p))
      s7=ar(ib+listi(i,p))-ar(id+listi(i,p))
      s8=ai(ib+listi(i,p))-ai(id+listi(i,p))
      t1=s5-s8
      t2=s6+s7
      t3=s1-s3
      t4=s2-s4
      t5=s5+s8
      t6=s6-s7
      cr(ja+listj(i,p))=s1+s3
      ci(ja+listj(i,p))=s2+s4
      cr(jb+listj(i,p))=trigsr(listk(i,p)+1)*t1
     *        -trigsi(listk(i,p)+1)*t2
      ci(jb+listj(i,p))=trigsi(listk(i,p)+1)*t1
     *        +trigsr(listk(i,p)+1)*t2
      cr(jc+listj(i,p))=trigsr(2*listk(i,p)+1)*t3
     *        -trigsi(2*listk(i,p)+1)*t4
      ci(jc+listj(i,p))=trigsi(2*listk(i,p)+1)*t3
     *        +trigsr(2*listk(i,p)+1)*t4
      cr(jd+listj(i,p))=trigsr(3*listk(i,p)+1)*t5
     *        -trigsi(3*listk(i,p)+1)*t6
      ci(jd+listj(i,p))=trigsi(3*listk(i,p)+1)*t5
     *        +trigsr(3*listk(i,p)+1)*t6
   10 continue
      else
*VOPTION VEC
      do 30 i=1,n/ifac*n1*n2
      s1=ar(ia+listi(i,p))+ar(ic+listi(i,p))
      s2=ai(ia+listi(i,p))+ai(ic+listi(i,p))
      s3=ar(ib+listi(i,p))+ar(id+listi(i,p))
      s4=ai(ib+listi(i,p))+ai(id+listi(i,p))
      s5=ar(ia+listi(i,p))-ar(ic+listi(i,p))
      s6=ai(ia+listi(i,p))-ai(ic+listi(i,p))
      s7=ar(ib+listi(i,p))-ar(id+listi(i,p))
      s8=ai(ib+listi(i,p))-ai(id+listi(i,p))
      t1=s5+s8
      t2=s6-s7
      t3=s1-s3
      t4=s2-s4
      t5=s5-s8
      t6=s6+s7
      cr(ja+listj(i,p))=s1+s3
      ci(ja+listj(i,p))=s2+s4
      cr(jb+listj(i,p))=trigsr(listk(i,p)+1)*t1
     *        -trigsi(listk(i,p)+1)*t2
      ci(jb+listj(i,p))=trigsi(listk(i,p)+1)*t1
     *        +trigsr(listk(i,p)+1)*t2
      cr(jc+listj(i,p))=trigsr(2*listk(i,p)+1)*t3
     *        -trigsi(2*listk(i,p)+1)*t4
      ci(jc+listj(i,p))=trigsi(2*listk(i,p)+1)*t3
     *        +trigsr(2*listk(i,p)+1)*t4
      cr(jd+listj(i,p))=trigsr(3*listk(i,p)+1)*t5
     *        -trigsi(3*listk(i,p)+1)*t6
      ci(jd+listj(i,p))=trigsi(3*listk(i,p)+1)*t5
     *        +trigsr(3*listk(i,p)+1)*t6
   30 continue
      endif
      return
      end
*/////////////////////////////////////////////////////////////////*
      subroutine pass5(ar,ai,cr,ci,trigsr,trigsi
     *                ,wr,wi,wr2,wi2,ifac,nfax,la,n,key
     *                ,listi,listj,listk,p,n1,n2)
      use fft_vars_module
      real(8) ar(n*n1*n2),cr(n*n1*n2),trigsr(n),wr,wr2
      real(8) ai(n*n1*n2),ci(n*n1*n2),trigsi(n),wi,wi2
      real(8) s1,s2,s3,s4,s5,s6,s7,s8
      real(8) t1,t2,t3,t4,t5,t6,t7,t8
     *      ,t9,t10,t11,t12,t13,t14,t15,t16
     *      ,d1,d2,d3,d4,d5,d6,d7,d8
     *      ,e1,e2,e3,e4,e5,e6,e7,e8
      integer key,p
      integer listi(n/2*n1*n2,nfax),listj(n/2*n1*n2,nfax)
     *       ,listk(n/2*n1*n2,nfax)
      m=n/ifac
c
      ia=0
      ib=m
      ic=m*2
      id=m*3
      ie=m*4
      ja=0
      jb=la
      jc=la*2
      jd=la*3
      je=la*4
c
*VOPTION VEC
      do 10 i=1,n/ifac*n1*n2
      s1=ar(ib+listi(i,p))+ar(ie+listi(i,p))
      s2=ar(ic+listi(i,p))+ar(id+listi(i,p))
      s3=ar(ib+listi(i,p))-ar(ie+listi(i,p))
      s4=ar(ic+listi(i,p))-ar(id+listi(i,p))
      s5=ai(ib+listi(i,p))+ai(ie+listi(i,p))
      s6=ai(ic+listi(i,p))+ai(id+listi(i,p))
      s7=ai(ib+listi(i,p))-ai(ie+listi(i,p))
      s8=ai(ic+listi(i,p))-ai(id+listi(i,p))
      t1=wr*s1
      t2=wr2*s1
      t3=wr*s2
      t4=wr2*s2
      t5=wi*s3
      t6=wi2*s3
      t7=wi*s4
      t8=wi2*s4
      t9=wr*s5
      t10=wr2*s5
      t11=wr*s6
      t12=wr2*s6
      t13=wi*s7
      t14=wi2*s7
      t15=wi*s8
      t16=wi2*s8
      d1=ar(ia+listi(i,p))+t1+t4
      d2=t13+t16
      d3=ai(ia+listi(i,p))+t9+t12
      d4=t5+t8
      d5=ar(ia+listi(i,p))+t2+t3
      d6=t14-t15
      d7=ai(ia+listi(i,p))+t10+t11
      d8=t6-t7
      e1=d1-d2
      e2=d3+d4
      e3=d1+d2
      e4=d3-d4
      e5=d5-d6
      e6=d7+d8
      e7=d5+d6
      e8=d7-d8
      cr(ja+listj(i,p))=ar(ia+listi(i,p))+s1+s2
      ci(ja+listj(i,p))=ai(ia+listi(i,p))+s5+s6
      cr(jb+listj(i,p))=trigsr(listk(i,p)+1)*e1
     *        -trigsi(listk(i,p)+1)*e2
      ci(jb+listj(i,p))=trigsi(listk(i,p)+1)*e1
     *        +trigsr(listk(i,p)+1)*e2
      cr(jc+listj(i,p))=trigsr(2*listk(i,p)+1)*e5
     *        -trigsi(2*listk(i,p)+1)*e6
      ci(jc+listj(i,p))=trigsi(2*listk(i,p)+1)*e5
     *        +trigsr(2*listk(i,p)+1)*e6
      cr(jd+listj(i,p))=trigsr(3*listk(i,p)+1)*e7
     *        -trigsi(3*listk(i,p)+1)*e8
      ci(jd+listj(i,p))=trigsi(3*listk(i,p)+1)*e7
     *        +trigsr(3*listk(i,p)+1)*e8
      cr(je+listj(i,p))=trigsr(4*listk(i,p)+1)*e3
     *        -trigsi(4*listk(i,p)+1)*e4
      ci(je+listj(i,p))=trigsi(4*listk(i,p)+1)*e3
     *        +trigsr(4*listk(i,p)+1)*e4
   10 continue
      return
      end
*/////////////////////////////////////////////////////////////////*
      subroutine pass6(ar,ai,cr,ci,trigsr,trigsi
     *                ,wi,ifac,nfax,la,n,key
     *                ,listi,listj,listk,p,n1,n2)
      use fft_vars_module
      real(8) ar(n*n1*n2),cr(n*n1*n2),trigsr(n)
      real(8) ai(n*n1*n2),ci(n*n1*n2),trigsi(n),wi
      real(8) s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12
     *      ,d1,d2,d3,d4,d5,d6,d7,d8,t1,t2,t3,t4,e1,e2,e3,e4
      real(8) f1,f2,f3,f4,f5,f6,f7,f8,f9,f10
      integer key,p
      integer listi(n/2*n1*n2,nfax),listj(n/2*n1*n2,nfax)
     *       ,listk(n/2*n1*n2,nfax)
      m=n/ifac
      ia=0
      ib=m
      ic=m*2
      id=m*3
      ie=m*4
      if=m*5
      ja=0
      jb=la
      jc=la*2
      jd=la*3
      je=la*4
      jf=la*5
c
*VOPTION VEC
      do 10 i=1,n/ifac*n1*n2
      s1=ar(ib+listi(i,p))+ar(if+listi(i,p))
      s2=ar(ib+listi(i,p))-ar(if+listi(i,p))
      s3=ar(ic+listi(i,p))+ar(ie+listi(i,p))
      s4=ar(ic+listi(i,p))-ar(ie+listi(i,p))
      s5=ar(ia+listi(i,p))+ar(id+listi(i,p))
      s6=ar(ia+listi(i,p))-ar(id+listi(i,p))
      s7=ai(ib+listi(i,p))+ai(if+listi(i,p))
      s8=ai(ib+listi(i,p))-ai(if+listi(i,p))
      s9=ai(ic+listi(i,p))+ai(ie+listi(i,p))
      s10=ai(ic+listi(i,p))-ai(ie+listi(i,p))
      s11=ai(ia+listi(i,p))+ai(id+listi(i,p))
      s12=ai(ia+listi(i,p))-ai(id+listi(i,p))
      t1=s1+s3
      t2=s1-s3
      t3=s7+s9
      t4=s7-s9
      d1=0.5d0*t1
      d2=0.5d0*t2
      d3=wi*(s2+s4)
      d4=wi*(s2-s4)
      d5=0.5d0*t3
      d6=0.5d0*t4
      d7=wi*(s8+s10)
      d8=wi*(s8-s10)
      e1=s6+d2
      e2=s5-d1
      e3=s11-d5
      e4=s12+d6
      f1=e1-d7
      f2=e4+d3
      f3=e2-d8
      f4=e3+d4
      f5=s6-t2
      f6=s12-t4
      f7=e2+d8
      f8=e3-d4
      f9=e1+d7
      f10=e4-d3
      cr(ja+listj(i,p))=t1+s5
      ci(ja+listj(i,p))=t3+s11
      cr(jb+listj(i,p))=trigsr(listk(i,p)+1)*f1
     *        -trigsi(listk(i,p)+1)*f2
      ci(jb+listj(i,p))=trigsi(listk(i,p)+1)*f1
     *        +trigsr(listk(i,p)+1)*f2
      cr(jc+listj(i,p))=trigsr(2*listk(i,p)+1)*f3
     *        -trigsi(2*listk(i,p)+1)*f4
      ci(jc+listj(i,p))=trigsi(2*listk(i,p)+1)*f3
     *        +trigsr(2*listk(i,p)+1)*f4
      cr(jd+listj(i,p))=trigsr(3*listk(i,p)+1)*f5
     *        -trigsi(3*listk(i,p)+1)*f6
      ci(jd+listj(i,p))=trigsi(3*listk(i,p)+1)*f5
     *        +trigsr(3*listk(i,p)+1)*f6
      cr(je+listj(i,p))=trigsr(4*listk(i,p)+1)*f7
     *        -trigsi(4*listk(i,p)+1)*f8
      ci(je+listj(i,p))=trigsi(4*listk(i,p)+1)*f7
     *        +trigsr(4*listk(i,p)+1)*f8
      cr(jf+listj(i,p))=trigsr(5*listk(i,p)+1)*f9
     *        -trigsi(5*listk(i,p)+1)*f10
      ci(jf+listj(i,p))=trigsi(5*listk(i,p)+1)*f9
     *        +trigsr(5*listk(i,p)+1)*f10
   10 continue
      return
      end
*/////////////////////////////////////////////////////////////////*
      subroutine pass8(ar,ai,cr,ci,trigsr,trigsi
     *                ,wr,ifac,nfax,la,n,key
     *                ,listi,listj,listk,p,n1,n2)
      use fft_vars_module
      real(8) ar(n*n1*n2),cr(n*n1*n2),trigsr(n),wr
      real(8) ai(n*n1*n2),ci(n*n1*n2),trigsi(n)
      real(8) s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16
     *      ,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16
     *      ,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10
     *      ,e1,e2,e3,e4,e5,e6,e7,e8
      integer key,p
      integer listi(n/2*n1*n2,nfax),listj(n/2*n1*n2,nfax)
     *       ,listk(n/2*n1*n2,nfax)
      m=n/ifac
      ia=0
      ib=m
      ic=m*2
      id=m*3
      ie=m*4
      if=m*5
      ig=m*6
      ih=m*7
      ja=0
      jb=la
      jc=la*2
      jd=la*3
      je=la*4
      jf=la*5
      jg=la*6
      jh=la*7
c
      if(key.eq.1) then
*VOPTION VEC
      do 10 i=1,n/ifac*n1*n2
      s1=ar(ia+listi(i,p))+ar(ie+listi(i,p))
      s2=ai(ia+listi(i,p))+ai(ie+listi(i,p))
      s3=ar(ia+listi(i,p))-ar(ie+listi(i,p))
      s4=ai(ia+listi(i,p))-ai(ie+listi(i,p))
      s5=ar(ic+listi(i,p))+ar(ig+listi(i,p))
      s6=ai(ic+listi(i,p))+ai(ig+listi(i,p))
      s7=ar(ic+listi(i,p))-ar(ig+listi(i,p))
      s8=ai(ic+listi(i,p))-ai(ig+listi(i,p))
      s9=ar(ib+listi(i,p))+ar(if+listi(i,p))
      s10=ai(ib+listi(i,p))+ai(if+listi(i,p))
      s11=ar(ib+listi(i,p))-ar(if+listi(i,p))
      s12=ai(ib+listi(i,p))-ai(if+listi(i,p))
      s13=ar(id+listi(i,p))+ar(ih+listi(i,p))
      s14=ai(id+listi(i,p))+ai(ih+listi(i,p))
      s15=ar(id+listi(i,p))-ar(ih+listi(i,p))
      s16=ai(id+listi(i,p))-ai(ih+listi(i,p))
      t1=s1+s5
      t2=s2+s6
      t3=s1-s5
      t4=s2-s6
      t5=s3+s8
      t6=s4+s7
      t7=s3-s8
      t8=s4-s7
      t9=s9+s13
      t10=s10+s14
      t11=s9-s13
      t12=s10-s14
      t13=wr*(s11+s12)
      t14=wr*(s15+s16)
      t15=wr*(s11-s12)
      t16=wr*(s15-s16)
      d1=t1-t9
      d2=t2-t10
      d3=t3-t12
      d4=t3+t12
      d5=t4+t11
      d6=t4-t11
      d7=t15-t14
      d8=t15+t14
      d9=t13+t16
      d10=t13-t16
      e1=t7+d7
      e2=t7-d7
      e3=t6+d9
      e4=t6-d9
      e5=t5-d10
      e6=t5+d10
      e7=t8+d8
      e8=t8-d8
      cr(ja+listj(i,p))=t1+t9
      ci(ja+listj(i,p))=t2+t10
      cr(jb+listj(i,p))=trigsr(listk(i,p)+1)*e1
     *                 -trigsi(listk(i,p)+1)*e3
      ci(jb+listj(i,p))=trigsi(listk(i,p)+1)*e1
     *                 +trigsr(listk(i,p)+1)*e3
      cr(jc+listj(i,p))=trigsr(2*listk(i,p)+1)*d3
     *                 -trigsi(2*listk(i,p)+1)*d5
      ci(jc+listj(i,p))=trigsi(2*listk(i,p)+1)*d3
     *                 +trigsr(2*listk(i,p)+1)*d5
      cr(jd+listj(i,p))=trigsr(3*listk(i,p)+1)*e5
     *                 -trigsi(3*listk(i,p)+1)*e7
      ci(jd+listj(i,p))=trigsi(3*listk(i,p)+1)*e5
     *                 +trigsr(3*listk(i,p)+1)*e7
      cr(je+listj(i,p))=trigsr(4*listk(i,p)+1)*d1
     *                 -trigsi(4*listk(i,p)+1)*d2
      ci(je+listj(i,p))=trigsi(4*listk(i,p)+1)*d1
     *                 +trigsr(4*listk(i,p)+1)*d2
      cr(jf+listj(i,p))=trigsr(5*listk(i,p)+1)*e2
     *                 -trigsi(5*listk(i,p)+1)*e4
      ci(jf+listj(i,p))=trigsi(5*listk(i,p)+1)*e2
     *                 +trigsr(5*listk(i,p)+1)*e4
      cr(jg+listj(i,p))=trigsr(6*listk(i,p)+1)*d4
     *                 -trigsi(6*listk(i,p)+1)*d6
      ci(jg+listj(i,p))=trigsi(6*listk(i,p)+1)*d4
     *                 +trigsr(6*listk(i,p)+1)*d6
      cr(jh+listj(i,p))=trigsr(7*listk(i,p)+1)*e6
     *                 -trigsi(7*listk(i,p)+1)*e8
      ci(jh+listj(i,p))=trigsi(7*listk(i,p)+1)*e6
     *                 +trigsr(7*listk(i,p)+1)*e8
   10 continue
      else
*VOPTION VEC
      do 20 i=1,n/ifac*n1*n2
      s1=ar(ia+listi(i,p))+ar(ie+listi(i,p))
      s2=ai(ia+listi(i,p))+ai(ie+listi(i,p))
      s3=ar(ia+listi(i,p))-ar(ie+listi(i,p))
      s4=ai(ia+listi(i,p))-ai(ie+listi(i,p))
      s5=ar(ic+listi(i,p))+ar(ig+listi(i,p))
      s6=ai(ic+listi(i,p))+ai(ig+listi(i,p))
      s7=ar(ic+listi(i,p))-ar(ig+listi(i,p))
      s8=ai(ic+listi(i,p))-ai(ig+listi(i,p))
      s9=ar(ib+listi(i,p))+ar(if+listi(i,p))
      s10=ai(ib+listi(i,p))+ai(if+listi(i,p))
      s11=ar(ib+listi(i,p))-ar(if+listi(i,p))
      s12=ai(ib+listi(i,p))-ai(if+listi(i,p))
      s13=ar(id+listi(i,p))+ar(ih+listi(i,p))
      s14=ai(id+listi(i,p))+ai(ih+listi(i,p))
      s15=ar(id+listi(i,p))-ar(ih+listi(i,p))
      s16=ai(id+listi(i,p))-ai(ih+listi(i,p))
      t1=s1+s5
      t2=s2+s6
      t3=s1-s5
      t4=s2-s6
      t5=s3+s8
      t6=s4+s7
      t7=s3-s8
      t8=s4-s7
      t9=s9+s13
      t10=s10+s14
      t11=s9-s13
      t12=s10-s14
      t13=wr*(s11+s12)
      t14=wr*(s15+s16)
      t15=wr*(s11-s12)
      t16=wr*(s15-s16)
      d1=t1-t9
      d2=t2-t10
      d3=t3-t12
      d4=t3+t12
      d5=t4+t11
      d6=t4-t11
      d7=t15-t14
      d8=t15+t14
      d9=t13+t16
      d10=t13-t16
      e1=t7+d7
      e2=t7-d7
      e3=t6+d9
      e4=t6-d9
      e5=t5-d10
      e6=t5+d10
      e7=t8+d8
      e8=t8-d8
      cr(ja+listj(i,p))=t1+t9
      ci(ja+listj(i,p))=t2+t10
      cr(jb+listj(i,p))=trigsr(listk(i,p)+1)*e6
     *                 -trigsi(listk(i,p)+1)*e8
      ci(jb+listj(i,p))=trigsi(listk(i,p)+1)*e6
     *                 +trigsr(listk(i,p)+1)*e8
      cr(jc+listj(i,p))=trigsr(2*listk(i,p)+1)*d4
     *                 -trigsi(2*listk(i,p)+1)*d6
      ci(jc+listj(i,p))=trigsi(2*listk(i,p)+1)*d4
     *                 +trigsr(2*listk(i,p)+1)*d6
      cr(jd+listj(i,p))=trigsr(3*listk(i,p)+1)*e2
     *                 -trigsi(3*listk(i,p)+1)*e4
      ci(jd+listj(i,p))=trigsi(3*listk(i,p)+1)*e2
     *                 +trigsr(3*listk(i,p)+1)*e4
      cr(je+listj(i,p))=trigsr(4*listk(i,p)+1)*d1
     *                 -trigsi(4*listk(i,p)+1)*d2
      ci(je+listj(i,p))=trigsi(4*listk(i,p)+1)*d1
     *                 +trigsr(4*listk(i,p)+1)*d2
      cr(jf+listj(i,p))=trigsr(5*listk(i,p)+1)*e5
     *                 -trigsi(5*listk(i,p)+1)*e7
      ci(jf+listj(i,p))=trigsi(5*listk(i,p)+1)*e5
     *                 +trigsr(5*listk(i,p)+1)*e7
      cr(jg+listj(i,p))=trigsr(6*listk(i,p)+1)*d3
     *                 -trigsi(6*listk(i,p)+1)*d5
      ci(jg+listj(i,p))=trigsi(6*listk(i,p)+1)*d3
     *                 +trigsr(6*listk(i,p)+1)*d5
      cr(jh+listj(i,p))=trigsr(7*listk(i,p)+1)*e1
     *                 -trigsi(7*listk(i,p)+1)*e3
      ci(jh+listj(i,p))=trigsi(7*listk(i,p)+1)*e1
     *                 +trigsr(7*listk(i,p)+1)*e3
   20 continue
      endif
      return
      end
*/////////////////////////////////////////////////////////////////*
      subroutine pass9(ar,ai,cr,ci,trigsr,trigsi
     *               ,w1r,w1i,w2r,w2i,w3r,w3i,w4r,w4i
     *               ,ifac,nfax,la,n,key
     *               ,listi,listj,listk,p,n1,n2)
      use fft_vars_module
      real(8) ar(n*n1*n2),cr(n*n1*n2),trigsr(n),w1r,w2r,w3r,w4r
      real(8) ai(n*n1*n2),ci(n*n1*n2),trigsi(n),w1i,w2i,w3i,w4i
      real(8) s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16
     *      ,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16
     *      ,d1,d2,d5,d6,d9,d10,d13,d14,d17,d18,d19,d20,d21,d22,d25,d26
     *      ,e1,e2,e3,e4,e5,e6
      integer key,p
      integer listi(n/2*n1*n2,nfax),listj(n/2*n1*n2,nfax)
     *       ,listk(n/2*n1*n2,nfax)
      m=n/ifac
      ia=0
      ib=m
      ic=m*2
      id=m*3
      ie=m*4
      if=m*5
      ig=m*6
      ih=m*7
      ii=m*8
      ja=0
      jb=la
      jc=la*2
      jd=la*3
      je=la*4
      jf=la*5
      jg=la*6
      jh=la*7
      ji=la*8
c
*VOPTION VEC
      do 10 i=1,n/ifac*n1*n2
      s1=ar(ib+listi(i,p))+ar(ii+listi(i,p))
      s2=ai(ib+listi(i,p))+ai(ii+listi(i,p))
      s3=ar(ib+listi(i,p))-ar(ii+listi(i,p))
      s4=ai(ib+listi(i,p))-ai(ii+listi(i,p))
      s5=ar(ic+listi(i,p))+ar(ih+listi(i,p))
      s6=ai(ic+listi(i,p))+ai(ih+listi(i,p))
      s7=ar(ic+listi(i,p))-ar(ih+listi(i,p))
      s8=ai(ic+listi(i,p))-ai(ih+listi(i,p))
      s9=ar(id+listi(i,p))+ar(ig+listi(i,p))
      s10=ai(id+listi(i,p))+ai(ig+listi(i,p))
      s11=ar(id+listi(i,p))-ar(ig+listi(i,p))
      s12=ai(id+listi(i,p))-ai(ig+listi(i,p))
      s13=ar(ie+listi(i,p))+ar(if+listi(i,p))
      s14=ai(ie+listi(i,p))+ai(if+listi(i,p))
      s15=ar(ie+listi(i,p))-ar(if+listi(i,p))
      s16=ai(ie+listi(i,p))-ai(if+listi(i,p))
      e1=ar(ia+listi(i,p))+w3r*s9
      e2=ai(ia+listi(i,p))+w3r*s10
      e3=w3i*s12
      e4=w3i*s11
      e5=ar(ia+listi(i,p))+s9
      e6=ai(ia+listi(i,p))+s10
      d1=w1r*s1+w2r*s5+e1+w4r*s13
      d2=w1i*s4+w2i*s8+e3+w4i*s16
      d5=w1i*s3+w2i*s7+e4+w4i*s15
      d6=w1r*s2+w2r*s6+e2+w4r*s14
      d9=w2r*s1+w4r*s5+e1+w1r*s13
      d10=w2i*s4+w4i*s8-e3-w1i*s16
      d13=w2i*s3+w4i*s7-e4-w1i*s15
      d14=w2r*s2+w4r*s6+e2+w1r*s14
      d17=e5+w3r*(s1+s5+s13)
      d18=w3i*(s4-s8+s16)
      d19=w3i*(s3-s7+s15)
      d20=e6+w3r*(s2+s6+s14)
      d21=w4r*s1+w1r*s5+e1+w2r*s13
      d22=w4i*s4-w1i*s8+e3-w2i*s16
      d25=w4i*s3-w1i*s7+e4-w2i*s15
      d26=w4r*s2+w1r*s6+e2+w2r*s14
      t1=d1-d2
      t2=d5+d6
      t3=d9-d10
      t4=d13+d14
      t5=d17-d18
      t6=d19+d20
      t7=d21-d22
      t8=d25+d26
      t9=d21+d22
      t10=-d25+d26
      t11=d17+d18
      t12=-d19+d20
      t13=d9+d10
      t14=-d13+d14
      t15=d1+d2
      t16=-d5+d6
      cr(ja+listj(i,p))=e5+s1+s5+s13
      ci(ja+listj(i,p))=e6+s2+s6+s14
      cr(jb+listj(i,p))=trigsr(listk(i,p)+1)*t1
     *                 -trigsi(listk(i,p)+1)*t2
      ci(jb+listj(i,p))=trigsi(listk(i,p)+1)*t1
     *                 +trigsr(listk(i,p)+1)*t2
      cr(jc+listj(i,p))=trigsr(2*listk(i,p)+1)*t3
     *                 -trigsi(2*listk(i,p)+1)*t4
      ci(jc+listj(i,p))=trigsi(2*listk(i,p)+1)*t3
     *                 +trigsr(2*listk(i,p)+1)*t4
      cr(jd+listj(i,p))=trigsr(3*listk(i,p)+1)*t5
     *                 -trigsi(3*listk(i,p)+1)*t6
      ci(jd+listj(i,p))=trigsi(3*listk(i,p)+1)*t5
     *                 +trigsr(3*listk(i,p)+1)*t6
      cr(je+listj(i,p))=trigsr(4*listk(i,p)+1)*t7
     *                 -trigsi(4*listk(i,p)+1)*t8
      ci(je+listj(i,p))=trigsi(4*listk(i,p)+1)*t7
     *                 +trigsr(4*listk(i,p)+1)*t8
      cr(jf+listj(i,p))=trigsr(5*listk(i,p)+1)*t9
     *                 -trigsi(5*listk(i,p)+1)*t10
      ci(jf+listj(i,p))=trigsi(5*listk(i,p)+1)*t9
     *                 +trigsr(5*listk(i,p)+1)*t10
      cr(jg+listj(i,p))=trigsr(6*listk(i,p)+1)*t11
     *                 -trigsi(6*listk(i,p)+1)*t12
      ci(jg+listj(i,p))=trigsi(6*listk(i,p)+1)*t11
     *                 +trigsr(6*listk(i,p)+1)*t12
      cr(jh+listj(i,p))=trigsr(7*listk(i,p)+1)*t13
     *                 -trigsi(7*listk(i,p)+1)*t14
      ci(jh+listj(i,p))=trigsi(7*listk(i,p)+1)*t13
     *                 +trigsr(7*listk(i,p)+1)*t14
      cr(ji+listj(i,p))=trigsr(8*listk(i,p)+1)*t15
     *                 -trigsi(8*listk(i,p)+1)*t16
      ci(ji+listj(i,p))=trigsi(8*listk(i,p)+1)*t15
     *                 +trigsr(8*listk(i,p)+1)*t16
   10 continue
      return
      end
*/////////////////////////////////////////////////////////////////*
      subroutine setfft(trigsrf,trigsif,trigsrb,trigsib,n)
      use fft_vars_module
      real(8) trigsrf(n),trigsrb(n)
      real(8) trigsif(n),trigsib(n)
!      real(8) wif3,wib3
!      real(8) wrf5,wif5,wrb5,wib5
!     *      ,wr2f5,wi2f5,wr2b5,wi2b5
!      real(8) wif6,wib6
!      real(8) wrf8,wrb8
!      real(8) wrf9,wif9,wrb9,wib9
!     *      ,wr2f9,wi2f9,wr2b9,wi2b9
!     *      ,wr3f9,wi3f9,wr3b9,wi3b9
!     *      ,wr4f9,wi4f9,wr4b9,wi4b9
      real(8) pai
!      common /w3/wif3,wib3
!      common /w5/wrf5,wif5,wrb5,wib5
!     *          ,wr2f5,wi2f5,wr2b5,wi2b5
!      common /w6/wif6,wib6
!      common /w8/wrf8,wrb8
!      common /w9/wrf9,wif9,wrb9,wib9
!     *          ,wr2f9,wi2f9,wr2b9,wi2b9
!     *          ,wr3f9,wi3f9,wr3b9,wi3b9
!     *          ,wr4f9,wi4f9,wr4b9,wi4b9
c
      pai=4.0d0*datan(1.0d0)
c
      wif3=dsin(2.0d0*pai/dble(3))
      wib3=-dsin(2.0d0*pai/dble(3))
      wrf5=dcos(2.0d0*pai/dble(5))
      wif5=dsin(2.0d0*pai/dble(5))
      wrb5=dcos(2.0d0*pai/dble(5))
      wib5=-dsin(2.0d0*pai/dble(5))
      wr2f5=wrf5**2-wif5**2
      wi2f5=2.0d0*wrf5*wif5
      wr2b5=wrb5**2-wib5**2
      wi2b5=2.0d0*wrb5*wib5
      wif6=dsin(2.0d0*pai/dble(6))
      wib6=-dsin(2.0d0*pai/dble(6))
      wrf8=dcos(2.0d0*pai/dble(8))
      wrb8=dcos(2.0d0*pai/dble(8))
      wrf9=dcos(2.0d0*pai/dble(9))
      wif9=dsin(2.0d0*pai/dble(9))
      wr2f9=wrf9**2-wif9**2
      wi2f9=2*wrf9*wif9
      wr3f9=wr2f9*wrf9-wi2f9*wif9
      wi3f9=wr2f9*wif9+wi2f9*wrf9
      wr4f9=wr2f9**2-wi2f9**2
      wi4f9=2*wr2f9*wi2f9
      wrb9=dcos(2.0d0*pai/dble(9))
      wib9=-dsin(2.0d0*pai/dble(9))
      wr2b9=wrb9**2-wib9**2
      wi2b9=2*wrb9*wib9
      wr3b9=wr2b9*wrb9-wi2b9*wib9
      wi3b9=wr2b9*wib9+wi2b9*wrb9
      wr4b9=wr2b9**2-wi2b9**2
      wi4b9=2*wr2b9*wi2b9
c
      do 20 i=1,n
        trigsrf(i)=dcos(2.d0*pai*dble(i-1)/dble(n))
        trigsrb(i)=dcos(2.d0*pai*dble(i-1)/dble(n))
        trigsif(i)=dsin(2.d0*pai*dble(i-1)/dble(n))
        trigsib(i)=-dsin(2.d0*pai*dble(i-1)/dble(n))
   20 continue
c
      return
      end
*/////////////////////////////////////////////////////////////////*
      subroutine listsub(ifax,nfax,n,listi,listj,listk,n1,n2)
      use fft_vars_module
      integer ifax(nfax),la,ii,kk,m
      integer listi(n/2*n1*n2,nfax),listj(n/2*n1*n2,nfax)
     *       ,listk(n/2*n1*n2,nfax)
c
c
      la=1
      do 5 i=1,nfax
        ifac=ifax(i)
      m=n/ifac
      ii=1
      do 30 ij=1,n1*n2
      kk=0
      jump=(ifac-1)*la
      do 10 jj=1,la
      do 20 k=0,m-la,la
          listj(ii,i)=kk*(jump+la)+jj+(ij-1)*n
          listi(ii,i)=kk*la+jj+(ij-1)*n
          listk(ii,i)=k
      kk=kk+1
      ii=ii+1
   20 continue
      kk=0
   10 continue
   30 continue
        la=la*ifac
    5 continue
      return
      end
