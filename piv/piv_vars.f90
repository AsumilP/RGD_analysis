module piv_vars
  use piv_param
  implicit none

  real(8):: res_x !< mm/pixel
  real(8):: res_y !< mm/pixel

  real(8):: px2vel_x
  real(8):: px2vel_y

  real(8),allocatable :: niw_x_final(:)
  real(8),allocatable :: niw_y_final(:)

  !> Arrays for background image
  real(8),allocatable:: img1bkmean(:,:)
  real(8),allocatable:: img2bkmean(:,:)
  real(8),allocatable:: img1bkmin(:,:)
  real(8),allocatable:: img2bkmin(:,:)
  real(8),allocatable:: img1bk(:,:)
  real(8),allocatable:: img2bk(:,:)

contains

  subroutine init_shared_vars
    implicit none
    res_x=fov_x/inx !< mm/pixel
    res_y=fov_y/iny !< mm/pixel
    px2vel_x = -res_x/dt*1000.d0 !< (m/s)/px
    px2vel_y = -res_y/dt*1000.d0 !< (m/s)/px
    print "(A,f6.3,A,f6.3)", 'px resolution [um/px]      : ', res_x*1000, ', ', res_y*1000
    print "(A,i3)", 'n_pass [-]                 : ', n_pass
  end subroutine init_shared_vars

  subroutine define_nvec(nvec_x,nvec_y,pivgridfile_head)
    implicit none
    integer,intent(out)::nvec_x,nvec_y
    character(*),intent(in)::pivgridfile_head
    character(*),parameter:: ext_x = '_x.txt'
    character(*),parameter:: ext_y = '_y.txt'

    character(1024)::filename
    integer counter
    integer p

    filename=trim(pivgridfile_head)//ext_x
    open(11,file=filename,status='old')
    counter = 0
    do
      read(11,'(i12)',end=100) p
!      print *, p
      counter = counter + 1
    end do
100 close(11)
!    print *,'Number of lines is',counter
    nvec_x=counter

    filename=trim(pivgridfile_head)//ext_y
    open(11,file=filename,status='old')
    counter = 0
    do
      read(11,'(i12)',end=101) p
!      print *, p
      counter = counter + 1
    end do
101 close(11)
!    print *,'Number of lines is',counter
    nvec_y=counter

  end subroutine define_nvec

end module piv_vars

