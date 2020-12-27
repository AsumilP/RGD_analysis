!< \brief subpixel interpolation by 3 point gaussian
subroutine subpixel_gaussian(ixcorr,niw_xl,niw_yl,imax,jmax,X,Y)
  implicit none

  integer, intent(in):: niw_xl,niw_yl
  real(8), intent(in):: ixcorr(niw_xl,niw_yl)
  integer, intent(in):: imax
  integer, intent(in):: jmax
  real(8), intent(inout):: X
  real(8), intent(inout):: Y
  X=X+ &
  (DLOG(ixcorr(imax-1,jmax))-DLOG(ixcorr(imax+1,jmax)))/2.0D0/ &
  (DLOG(ixcorr(imax-1,jmax))+DLOG(ixcorr(imax+1,jmax))-2.0D0*DLOG(ixcorr(imax,jmax)))
  Y=Y+ &
  (DLOG(ixcorr(imax,jmax-1))-DLOG(ixcorr(imax,jmax+1)))/2.0D0/ &
  (DLOG(ixcorr(imax,jmax-1))+DLOG(ixcorr(imax,jmax+1))-2.0D0*DLOG(ixcorr(imax,jmax)))
end subroutine subpixel_gaussian

!< \brief subpixel interpolation by 2D 3x3 point gaussian fit
!! taken from the paper of Nobach&Honkanen, Exp. Fluids 2005 38: 511-515
subroutine subpixel_gaussian_2d(ixcorr,niw_xl,niw_yl,imax,jmax,X,Y)
  implicit none
  integer, intent(in):: niw_xl,niw_yl
  real(8), intent(in):: ixcorr(niw_xl,niw_yl)
  integer, intent(in):: imax
  integer, intent(in):: jmax
  real(8), intent(inout):: X
  real(8), intent(inout):: Y
  real(8):: c10,c01,c11,c20,c02,c00
  integer:: i,j,cnt
  real(8):: xi(3),yj(3),Z(3,3)
  c10=0.d0
  c01=0.d0
  c11=0.d0
  c20=0.d0
  c02=0.d0
  c00=0.d0

  xi(1)=-1.d0
  xi(2)=0.d0
  xi(3)=1.d0
  yj(1)=-1.d0
  yj(2)=0.d0
  yj(3)=1.d0


  do i=1,3
    do j=1,3
      Z(i,j)=ixcorr(imax+i-2,jmax+j-2)
    enddo
  enddo

  cnt=0
  do i=1,3
    do j=1,3
      if (Z(i,j)>=0.d0) then !< to prevent floating point exception (negative input for log)
        c10=c10+xi(i)*dlog(Z(i,j))/6.d0
        c01=c01+yj(j)*dlog(Z(i,j))/6.d0
        c11=c11+xi(i)*yj(j)*dlog(Z(i,j))/4.d0
        c20=c20+(3.d0*xi(i)**2.d0-2.d0)*dlog(Z(i,j))/6.d0
        c02=c02+(3.d0*yj(j)**2.d0-2.d0)*dlog(Z(i,j))/6.d0
        c00=c00+(5.d0-3.d0*xi(i)**2.d0-3.d0*yj(j)**2.d0)*dlog(Z(i,j))/9.d0
      else
        cnt=cnt+1;
      endif
    enddo
  enddo
  if (cnt>3) then !< how many negatives are acceptable?
    print *, cnt,"negative values are found in corr"
  endif
  if ((4.d0*c20*c02-c11**2.d0)/=0) then  !< to prevent floating point exception (zero division)
    X=X+((c11*c01-2.d0*c10*c02)/(4.d0*c20*c02-c11**2.d0))
    Y=Y+((c11*c10-2.d0*c01*c20)/(4.d0*c20*c02-c11**2.d0))
  else
    print *, "denominator is zero. subpixel interpolation is not performed."
  endif
end subroutine subpixel_gaussian_2d

