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

  integer, parameter :: nx=191
  integer, parameter :: nx_cut=191
  integer, parameter :: nx_start=1
  integer, parameter :: ny=121
  integer, parameter :: ny_cut=98
  integer, parameter :: ny_start=4
  integer, parameter :: nz=21838
  integer, parameter :: deal_start_frame=1
  integer, parameter :: deal_end_frame=21838
  integer, parameter :: by_frame_size=1
  integer, parameter :: dt=50d-6 ! [s]
  integer, parameter :: cond= 1

  character(*), parameter :: path_of_i = '/home/yatagi/mnt/velofield/20190821/piv/comblps/'
  character(*), parameter :: path_of_o = '/home/yatagi/analysis/piv_output/velofield/cold_dmd/20190821/data_files/'

  character(*) :: fni*200
  character(*) :: fno*200
  character(*) :: file_name_in*200
  character(*) :: file_name_out*200
  real(8) :: start_time,end_time,number_splited
  real(8):: craw(nx,ny,by_frame_size)
  real(8):: craw_cut(nx_cut,ny_cut,by_frame_size)
  integer :: i,j,k,l,m

  start_time=dt*deal_start_frame
  end_time=dt*deal_end_frame
  number_splited=(deal_end_frame-deal_start_frame+1)/by_frame_size

  print *,'start_time [s] =',start_time
  print *,'end_time [s] =',end_time
  print *,'The number of splitted data =',number_splited
!-------------------------------------------------------------------------------
  do m=1,cond
    print *,'Condition number =',m
  !-----------------input-------------------
    write(file_name_in,"('spiv_fbsc_',i2.2,'_vcl.dat')"),m
    fni=path_of_i//file_name_in
    open(10,file=fni,form='binary')

    do l=1,number_splited
      write(file_name_out,"('spiv_fbsc_',i2.2,'_vcl_',i5.5,'.dat')"),m,l
      fno=path_of_o//file_name_out
      read(10) craw

      do k=1,by_frame_size
        do j=1,ny_cut
          do i=1,nx_cut
            craw_cut(i,j,k)=craw(nx_start+i-1,ny_start+j-1,k)
          enddo
        enddo
      enddo

      write(*,*) fno
      open(65, file=fno, form='binary')
      write(65) craw_cut
      close(65)

    enddo
    close(10)

  enddo
  write(*,*) 'Operated Correctly!'
  stop
  end
