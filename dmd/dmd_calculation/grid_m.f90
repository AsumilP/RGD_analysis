!----------------------------------------------------------------------!
!                         module grid_m                                !
!                                                    2017/10/11        !
!----------------------------------------------------------------------!
  module grid_m

  implicit none

  integer :: nx_g, ny_g, num, tsst, tsed, tsint, nt, lwork
  real(8) :: delta_t, dt
  character :: dir_in*100, dir_out*100, case_name*100

  parameter (nx_g = 191)
  parameter (ny_g = 98)
  ! parameter (nx_g = 1024)
  ! parameter (ny_g = 1024)
  parameter (tsst = 13) !CHECK,start number
  parameter (tsed = 21838) !last number
  ! parameter (tsst = 16187 - 2500 + 0) !CHECK,start number
  ! parameter (tsed = 16187 + 0) !last number
  parameter (tsint = 25) !increment
  ! parameter (tsint = 6) !increment
  ! parameter (tsint = 3) !increment
  parameter (delta_t = 5.0D-5) !measurement speed (attention!!! check code, dmd.f90)
  ! parameter (delta_t = 10D-5) !measurement speed (attention!!! check code, dmd.f90)
  parameter (nt = (tsed-tsst)/tsint) !number of images
  parameter (num  = nx_g * ny_g)
  parameter (lwork = 4*nt+250*nt)
  parameter (dir_in = '/home/yatagi/analysis/piv_output/velofield/dmd/20201214/data_files/')
  parameter (dir_out = '/home/yatagi/analysis/piv_output/velofield/dmd/20201214/11/averaging/u/13_13/') ! CHECK,directory
  ! parameter (dir_out = '/home/yatagi/analysis/piv_output/velofield/dmd/20201214/16/averaging/v/01_13/') ! CHECK,directory
  ! parameter (dir_out = '/home/yatagi/analysis/piv_output/velofield/dmd/20190823/10/averaging/trans4/u1_3/') ! CHECK,directory
  ! parameter (dir_out = '/home/yatagi/analysis/piv_output/velofield/dmd/20190823/01/averaging/trans1/v1_3/') ! CHECK,directory
  ! parameter (dir_in = '/home/yatagi/analysis/chem_output/dmd/20190823/data_files/')
  ! parameter (dir_out = '/home/yatagi/analysis/chem_output/dmd/20190823/10/averaging/trans1/1_3/') ! CHECK,directory
  parameter (case_name = 'spiv_fbsc_11_u') ! CHECK,number
  ! parameter (case_name = 'spiv_fbsc_01_v') ! CHECK,number
  ! parameter (case_name = 'spiv_fbsc_10_ucl') ! CHECK,number
  ! parameter (case_name = 'spiv_fbsc_01_vcl') ! CHECK,number
  ! parameter (case_name = 'chem_10_rmv') ! CHECK,number

  end module grid_m
