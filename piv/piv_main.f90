program piv
  use piv_param
  use piv_vars
  use piv_const
  implicit none

  !> Arrays for piv image pair
  real(8):: img1(inx,iny)
  real(8):: img2(inx,iny)

  !> Arrays for piv output data
  real(8),allocatable:: xi_piv(:) ! image coordinate of piv vector
  real(8),allocatable:: yi_piv(:)
  real(8),allocatable:: disp_x(:,:) ! displacement in x
  real(8),allocatable:: disp_y(:,:) ! displacement in x
  real(8),allocatable:: ccc(:,:) ! peak CC
  integer(8),allocatable:: flag(:,:)  ! flag (int8 for consistency with NETCDF data type)

  character(512)::img_filepath,arg,arg2,outfilepath,pivgridfile_head
  !> initializing indices...
  integer :: piv_idx = 1
  integer :: piv_idx_start = 1
  integer :: num_piv_analysis = 1
  integer :: piv_idx_end = 1

  !> local temporary variables
  real(8):: tic, toc !> elapsed time measurement
  integer:: i,j
  integer:: loopidx

  call parse_option()

#ifndef quiet
  call print_param()
#endif

  print *,     'input img file         : ', trim(img_filepath)
  print *,     'piv result output file : ', trim(outfilepath)
  call init_shared_vars()

  pivgridfile_head='pivgrid'
  if (m_piv_grid == 2) then
    call define_nvec(nvec_x,nvec_y,pivgridfile_head)
  endif

  call init_array()

  if (m_piv_grid == 1) then
    call define_piv_coordinate_param(xi_piv,yi_piv)
  elseif (m_piv_grid == 2) then
    call define_piv_coordinate_vec(xi_piv,yi_piv,pivgridfile_head)
  endif

  print *, 'xi_piv:'
  print "(10(f8.1))", xi_piv
  print *, 'yi_piv:'
  print "(10(f8.1))", yi_piv

  !  call print_loop(idx_stereo,idx_lr)
  print *, "piv_idx_start: ", piv_idx_start
  print *, "piv_idx_end: ", piv_idx_end

  loopidx=0
  do piv_idx=piv_idx_start,piv_idx_end
    loopidx=loopidx+1

    ! initialize displacement and flag before starting new piv passes
    disp_x(1:nvec_x,1:nvec_y)=0.d0
    disp_y(1:nvec_x,1:nvec_y)=0.d0
    ccc(1:nvec_x,1:nvec_y)=0.d0
    flag(1:nvec_x,1:nvec_y)=0

    call read_fbinimgpair(img1,img2,inx,iny,img_filepath,piv_idx)

!    open(100,file='img1.bin',access='stream',form='unformatted')
!    write(100) img1
!    close(100)
!    open(100,file='img2.bin',access='stream',form='unformatted')
!    write(100) img2
!    close(100)

      
    if (do_bk_div) then
      call img_background_div(img1,img2,img1bk,img2bk,inx,iny)
      deallocate(img1bk)
      deallocate(img2bk)
    elseif (do_bk_sub) then
      call img_background_sub(img1,img2,img1bk,img2bk,inx,iny)
      deallocate(img1bk)
      deallocate(img2bk)
    elseif (do_bk_norm) then
      call img_background_norm(img1,img2,img1bkmin,img2bkmin,img1bkmean,img2bkmean,inx,iny)
    endif

    if (do_pre_smooth) then
      call img_gaussian_smooth(img1,img2,inx,iny)
    endif

    do i=1,n_pass
      print *, '------------------------------------------------------------'
      print *, 'pass #', i
      print "(A,i3,A,i3)", ' iw size (x,y) [px]      : ', niw_x(i),', ', niw_y(i)
      call cpu_time( tic )
      call piv_pass(img1,img2,niw_x(i),niw_y(i),xi_piv,yi_piv,disp_x,disp_y,ccc,flag,i)
      call cpu_time( toc )
      print *, "done in ", toc-tic, "sec"
    enddo

    ! pixel <-> velocity conversion
    if (do_phys_conv) then
      disp_x=px2vel_x*disp_x
      disp_y=px2vel_y*disp_y
    endif

#ifdef debug
    print *, "size:", size(disp_x)
#endif

    if (loopidx==1) then
      call write_pivdata_fbin(disp_x,disp_y,ccc,flag,outfilepath,FBIN_WRITE_OVERWRITE) ! note the last argument is switch to append file or not.
    else
      call write_pivdata_fbin(disp_x,disp_y,ccc,flag,outfilepath,FBIN_WRITE_APPEND)
    endif

  enddo

  call finalize()


  print *, "Done!"

contains
  subroutine parse_option()
    implicit none

    do i = 1, command_argument_count()
      call get_command_argument(i, arg)

      select case (arg)
        case ('-i','--img-file')
          call get_command_argument(i+1, arg2)
          img_filepath=trim(arg2)
        case ('-o','--output')
          call get_command_argument(i+1, arg2)
          outfilepath=trim(arg2)
        case ('-v', '--version')
          print *, 'piv program v0.0.1'
          print *, 'use -h option to see the usage.'
          stop
        case ('--dt')
          call get_command_argument(i+1, arg2)
          read(arg2,*) dt
        case ('-h', '--help')
          call print_help()
          stop
        case ('-s', '--start')
          call get_command_argument(i+1, arg2)
          read(arg2,*) piv_idx_start
        case ('-n', '--number')
          call get_command_argument(i+1, arg2)
          read(arg2,*) num_piv_analysis
        case ('--odd')
          is_odd = .true.
        case default
      !          print '(a,a,/)', 'Unrecognized command-line option: ', arg
      !          call print_help()
      end select
      piv_idx_end = piv_idx_start+num_piv_analysis-1
    enddo

  end subroutine parse_option

  subroutine print_help()
    print *, "-i"
    print *, "image file path"
    print *, ""
    print *, "-o"
    print *, "piv result output file path"
    print *, ""
    print *, "-s"
    print *, "start piv_idx"
    print *, ""
    print *, "-n"
    print *, "number of piv fields to process"
    print *, ""
    print *, "--dt"
    print *, "time separation of two successive images [us]"
    print *, ""
    print *, "-h"
    print *, "print help"
  end subroutine print_help

  subroutine print_loop(kk,ll)
    implicit none
    integer:: kk
    integer::ll
    print  "(A)", "------"
    print  "(A,i1)", "stereo:   #", kk
    if (ll==1) then
      print "(A)", "camera:   left"
    else
      print "(A)", "camera:   right"
    endif
  end subroutine print_loop

  !> \brief initialize arrays
  subroutine init_array()
    implicit none
    if (do_bk_div) then
      allocate(img1bk(inx,iny))
      allocate(img2bk(inx,iny))
    elseif (do_bk_sub) then
      allocate(img1bk(inx,iny))
      allocate(img2bk(inx,iny))
    elseif (do_bk_norm) then
      allocate(img1bkmin(inx,iny))
      allocate(img2bkmin(inx,iny))
      allocate(img1bkmean(inx,iny))
      allocate(img2bkmean(inx,iny))
      call read_fbinimg(img1bkmin,inx,iny, &
      '/work1/t2gmt-turb/ynaka/surfactant/20130709b/particle/cam1_q90_dt250_01_A_min.dis')
      call read_fbinimg(img2bkmin,inx,iny, &
      '/work1/t2gmt-turb/ynaka/surfactant/20130709b/particle/cam1_q90_dt250_01_B_min.dis')
      call read_fbinimg(img1bkmean,inx,iny, &
      '/work1/t2gmt-turb/ynaka/surfactant/20130709b/particle/cam1_q90_dt250_01_A_mean.dis')
      call read_fbinimg(img2bkmean,inx,iny, &
      '/work1/t2gmt-turb/ynaka/surfactant/20130709b/particle/cam1_q90_dt250_01_B_mean.dis')
    endif

    allocate(niw_x_final(nvec_x))
    allocate(niw_y_final(nvec_y))

    allocate(xi_piv(nvec_x))
    allocate(yi_piv(nvec_y))
    allocate(disp_x(nvec_x,nvec_y))
    allocate(disp_y(nvec_x,nvec_y))
    allocate(ccc(nvec_x,nvec_y))
    allocate(flag(nvec_x,nvec_y))
    disp_x(1:nvec_x,1:nvec_y)=0.d0
    disp_y(1:nvec_x,1:nvec_y)=0.d0
    ccc(1:nvec_x,1:nvec_y)=0.d0
    flag(1:nvec_x,1:nvec_y)=0
  end subroutine init_array

  !> \brief deallocate arrays and close netcdf files
  subroutine finalize()
    implicit none
    print *, "Closing files..."
    if (do_bk_div) then
      deallocate(img1bk)
      deallocate(img2bk)
    elseif (do_bk_sub) then
      deallocate(img1bk)
      deallocate(img2bk)
    elseif (do_bk_norm) then
      deallocate(img1bkmin)
      deallocate(img2bkmin)
      deallocate(img1bkmean)
      deallocate(img2bkmean)
    endif

    deallocate(xi_piv)
    deallocate(yi_piv)
    deallocate(disp_x)
    deallocate(disp_y)
    deallocate(ccc)
    deallocate(flag)
  end subroutine finalize

end program piv




