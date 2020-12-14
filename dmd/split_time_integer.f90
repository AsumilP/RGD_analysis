!calculate mean,ud,rms of velocity components, after split_time
!c--------------------------------------------------c
!c          ( avedevi.f90 + rmvnoise.f90 )          c
!c            imgcor                                c
!c            piv                                   c
!c            get_uv_withcut.f90                    c
!c            rmverrvec_uvcut.f90                   c
!c            stereoscopic.f90                      c
!c            cutflipcombine.f90                    c
!c            rmverrvec_uvwcomb.f90                 c
!c                                                  c
!c              1. search_max.f90                   c
!c                                                  c
!c   --->       2. split_time.f90                   c
!c               2.1 calc_umean_rms.f90             c
!c               2.2 calc_scales_Q.f90              c
!c               2.3 dmd                            c
!c--------------------------------------------------c
  implicit none

  character(8), parameter :: date = "20190819"
  integer, parameter :: nx = 1024
  integer, parameter :: nx_cut = 1024
  integer, parameter :: nx_start = 1
  integer, parameter :: ny = 1024
  integer, parameter :: ny_cut = 1024
  integer, parameter :: ny_start = 1
  integer, parameter :: nz = 21839
  integer, parameter :: deal_start_frame = 15572 - 2500
  integer, parameter :: deal_end_frame = 15572 + 2500
  integer, parameter :: dt = 100d-6 ! [s]
  integer, parameter :: cond_start = 1
  integer, parameter :: cond_end = 1

  character(*), parameter :: path_of_i = '/home/yatagi/mnt/'//date//'/'
  character(*), parameter :: path_of_o = '/home/yatagi/analysis/chem_output/dmd/'//date//'/data_files/'

  character(*) :: fni*200
  character(*) :: fno*200
  character(*) :: file_name_in*200
  character(*) :: file_name_out*200
  real(8) :: start_time,end_time, number_splited
  integer(2) :: craw(nx,ny,1)
  real(8) :: craw_cut(nx_cut,ny_cut,1)
  integer :: i, j, k, l, m

  start_time = dt*deal_start_frame*10d3
  end_time = dt*deal_end_frame*10d3
  number_splited = (deal_end_frame-deal_start_frame+1)

  print *,'start_time [ms] =', start_time
  print *,'end_time [ms] =', end_time
  print *,'The number of splitted data =', number_splited
  print *,'nx, ny, nz', nx, ny, 1
!-------------------------------------------------------------------------------
  do m = cond_start, cond_end
    print *,'Condition number =', m
  !-----------------input-------------------
    write(file_name_in,"('chem_',i2.2,'_rmv.dat')"), m
    fni = path_of_i//file_name_in
    open(10, file=fni, form='binary')

    do l = 1, nz

      write(file_name_out,"('chem_',i2.2,'_rmv_',i5.5,'.dat')"), m, l
      fno = path_of_o//file_name_out
      read(10) craw

      if (l .ge. deal_start_frame .and. l .le. deal_end_frame) then
        do j = 1, ny_cut
          do i = 1, nx_cut
            craw_cut(i,j,1) = craw(nx_start+i-1, ny_start+j-1, 1)
          enddo
        enddo

        write(*,*) fno
        open(65, file=fno, form='binary')
        write(65) craw_cut
        close(65)
      end if

    enddo
    close(10)

  enddo
  write(*,*) 'Operated Correctly!'
  stop
  end
