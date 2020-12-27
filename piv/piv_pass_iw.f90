subroutine compute_shift_i(disp_xx,disp_yy,xi_shift,yi_shift)
  implicit none
  real(8), intent(in):: disp_xx !> displacement in px in x direction
  real(8), intent(in):: disp_yy !> displacement in px in y direction
  integer, intent(out):: xi_shift !> window shift in px in x direction
  integer, intent(out):: yi_shift !> window shift in px in y direction

  ! determine how much window should be shifted in IMAGE coordinate
    xi_shift=-idnint(disp_xx/2.d0) !> for both windows shift
    yi_shift=-idnint(disp_yy/2.d0)

end subroutine compute_shift_i


!> \brief prepare interrogation window with no interpolation
subroutine prepare_iw &
(raw,inx,iny,iw,niw_xl,niw_yl,xi_piv_l,yi_piv_l,xi_shift,yi_shift)
  implicit none
  integer, intent(in):: inx,iny
  integer, intent(in):: niw_xl,niw_yl
  real(8), intent(in):: raw(inx,iny)
  real(8), intent(out):: iw(niw_xl,niw_yl)
  real(8), intent(in):: xi_piv_l
  real(8), intent(in):: yi_piv_l
  integer, intent(in):: xi_shift
  integer, intent(in):: yi_shift

  integer:: i,j,xidx,yidx
  real(8):: x,y
  logical:: is_ref_out

  is_ref_out=.false.
  ! make IWs with no interpolation
  do j=1,niw_yl
    do i=1,niw_xl
      x=xi_shift+xi_piv_l+(i-niw_xl/2)
      y=yi_shift+yi_piv_l+(j-niw_yl/2)
      xidx=idnint(x)
      yidx=idnint(y)

      if (xidx > 1 .and. xidx < inx .and. yidx > 1 .and. yidx < iny) then
        IW(i,j)=raw(xidx,yidx)
      else
        x=xi_piv_l+(i-niw_xl/2)
        y=yi_piv_l+(j-niw_yl/2)
        xidx=idnint(x)
        yidx=idnint(y)
        IW(i,j)=raw(xidx,yidx)
        is_ref_out=.true.
!#ifdef debug
!        print *, "xi_shift:", xi_shift
!        print *, "yi_shift:", yi_shift
!#endif
      endif

    enddo
  enddo
  if (is_ref_out) then
        print *, "referencing outside of image. xi_shift/yi_shift may be too large!"
  endif
end subroutine prepare_iw
