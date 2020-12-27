subroutine define_piv_coordinate_vec(xxp_piv,yyp_piv,pivgridfile_head)
  use piv_param
  use piv_vars
  implicit none
  real(8),intent(out):: xxp_piv(nvec_x)
  real(8),intent(out):: yyp_piv(nvec_y)
  character(*),intent(in) :: pivgridfile_head
  integer:: i,j

  character(*),parameter:: ext_x = '_x.txt'
  character(*),parameter:: ext_y = '_y.txt'
  character(*),parameter:: ext_xniw = '_xniw.txt'
  character(*),parameter:: ext_yniw = '_yniw.txt'

  character(1024)::filename
  integer:: ptmp

  filename=trim(pivgridfile_head)//ext_x
  open(11,file=filename,status='old')
  do i=1,nvec_x
    read(11,'(i12)') ptmp
    xxp_piv(i)=dble(ptmp)
  end do
  close(11)

  filename=trim(pivgridfile_head)//ext_y
  open(11,file=filename,status='old')
  do i=1,nvec_y
    read(11,'(i12)') ptmp
    yyp_piv(i)=dble(ptmp)
  end do
  close(11)

  filename=trim(pivgridfile_head)//ext_xniw
  open(11,file=filename,status='old')
  do i=1,nvec_x
    read(11,'(i12)') ptmp
    niw_x_final(i)=dble(ptmp)
  end do
  close(11)

  filename=trim(pivgridfile_head)//ext_yniw
  open(11,file=filename,status='old')
  do i=1,nvec_y
    read(11,'(i12)') ptmp
    niw_y_final(i)=dble(ptmp)
  end do
  close(11)

end subroutine define_piv_coordinate_vec

!> define physical 2D coordinate for piv analysis
!! @param[out] xxp_piv physical position of x coordinate
!! @param[out] yyp_piv physical position of y coordinate
!! \todo coodinate shoud be given from nc-file or parameter, should not be hardcorded
subroutine define_piv_coordinate_param(xxp_piv,yyp_piv)
  use piv_param
  implicit none
  real(8),intent(out):: xxp_piv(nvec_x)
  real(8),intent(out):: yyp_piv(nvec_y)
  integer:: i,j

  integer:: niw_largest

  niw_largest=niw_x(1)

  do i=1,nvec_x
    xxp_piv(i)=dble(niw_largest/2 + imgcut_left_px + vec_spc_x_px*(i-1))
  enddo

  do j=1,nvec_y
    yyp_piv(j)=dble(niw_largest/2 + imgcut_top_px + vec_spc_y_px*(j-1))
  enddo

  if (xxp_piv(1)-niw_largest/2 < 1) then
    print *, "left edge of iw exceeds img border!"
    STOP
  endif
  if (xxp_piv(nvec_x)+niw_largest/2 > inx) then
    print *, "right edge of iw exceeds img border!"
    print *, "pos: ",xxp_piv(nvec_x)
    STOP
  endif
  if (yyp_piv(1)-niw_largest/2 < 1) then
    print *, "top edge of iw exceeds img border!"
    STOP
  endif
  if (yyp_piv(nvec_y)+niw_largest/2 > iny) then
    print *, "bottom edge of iw exceeds img border!"
    STOP
  endif

  print "(A,i4,A,i4)", 'top left iw center (x,y) [px]    : ',nint(xxp_piv(1)),',',nint(yyp_piv(1))
  print "(A,i4,A,i4)", 'bottom right iw center (x,y) [px]: ',nint(xxp_piv(nvec_x)),',',nint(yyp_piv(nvec_y))


end subroutine define_piv_coordinate_param

