module piv_param
  use piv_const
  implicit none

  integer, parameter :: inx = 1024 !< size in x [px]
  integer, parameter :: iny = 1024 !< size in y [px]
  integer, parameter :: nbytehead = 0 ! head size for *.mrw [byte]
  real(8), parameter :: fov_x = 81.92d0 !< field of view in x [mm] in imgcor
  real(8), parameter :: fov_y = 76.80d0 !< field of view in y [mm]
  real(8) :: dt = 50 !< [us] time separation between two images. it can also be specified from command line.

!---IW---
  integer, parameter :: m_piv_iw = 1
! 1: parametric (cut, spacing, number)
! 2: iw size of final pass is given by x and y vectors (should be the same length as the grid)

! m_piv_iw==1
  integer, parameter :: n_pass = 2!< number of passes
  integer, parameter :: niw_x(n_pass) = (/32,16/) !< interrogation window sizes
  integer, parameter :: niw_y(n_pass) = (/32,16/) !< interrogation window sizes
! m_piv_iw==2
  character(*),parameter :: fn_piviwx = ''
  character(*),parameter :: fn_piviwy = ''

!---GRID---
  integer, parameter :: m_piv_grid = 1 !< how to give PIV grid
! 1: conventional, parametric (cut, spacing, number)
! 2: orthogonal structured grid given by x and y vectors
! 3: (currently NA) arbitrary points specified by x and y vectors

! m_piv_grid==1
  integer :: nvec_x= 124 !100 !< number of vectors in x
  integer :: nvec_y= 124 !100 !< number of vectors in x
  integer, parameter :: imgcut_left_px = 1 !104 !< left cut
  integer, parameter :: imgcut_top_px = 1  !104 !<
  integer, parameter :: vec_spc_x_px = 8  !< spacing between vectors in x [px]
  integer, parameter :: vec_spc_y_px = 8 !< spacing between vectors in y [px]
! nvec_x=(in_x-imgcut_left_px-niw_x(1)/2-imgcut_right_px)/vec_spc_x_px

! m_piv_grid==2
  character(*),parameter :: fn_pivgridx = ''
  character(*),parameter :: fn_pivgridy = ''
!
!---OTHER OPTIONS---
!  logical :: is_odd = .true. !< true if you want to skip first image (also specifiable through command line)
  logical :: is_odd = .false.
  logical, parameter :: do_phys_conv = .true. !< true if you want to have physical velocity
  integer, parameter :: opt_sub_px = SUB_PX_GAUSSIAN_1D

!---IMG PRE-PROCESS
  logical, parameter :: do_bk_norm = .false. !< true if you are doing background normalization
  logical, parameter :: do_bk_div = .false. !< true if you are doing background division
  logical, parameter :: do_bk_sub = .false. !< true if you are doing background subtraction
  logical, parameter :: do_pre_smooth = .false.

!---
  logical, parameter :: is_disparity = .false. !< true if you are doing disparity analysis

contains
  subroutine print_param()
!    print "(A,i4)",          'number of stereo [-]       : ', num_stereo
    print "(A,i4,A,i4)",     'image size [px]            : ', inx, ', ', iny
    print "(A,f6.3,A,f6.3)", 'physical size of image [mm]: ', fov_x, ', ', fov_y
    print "(A,f12.4)",       'time separation dt [usec]  : ', dt
    print "(A,i4,A,i4)",     'number of vectors [-]      : ', nvec_x, ', ', nvec_y
    print "(A,i4,A,i4)",     'vector spacing  [px]       : ', vec_spc_x_px, ', ', vec_spc_y_px
    print "(A,i4)",          'number of piv pass [-]     : ', n_pass
    print "(A,4(i4))",       'IW size x       [px]       : ', niw_x
    print "(A,4(i4))",       'IW size y       [px]       : ', niw_y
!    print "(A,A)",     'image dir       : ', trim(dir_img_file)
!    print "(A,A)",     'piv result dir  : ', trim(dir_piv_out)
    if (opt_sub_px==SUB_PX_GAUSSIAN_1D) then
      print *, 'sub pixel interpolation: gaussian 1d'
    elseif (opt_sub_px==SUB_PX_GAUSSIAN_2D) then
      print *, 'sub pixel interpolation: gaussian 2d'
    elseif (opt_sub_px==SUB_PX_NONE) then
      print *, 'sub pixel interpolation: none'
    endif
  end subroutine print_param

end module piv_param
