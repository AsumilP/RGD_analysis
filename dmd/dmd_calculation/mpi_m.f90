!----------------------------------------------------------------------!
!                         module mpi_m                                 !
!                                                    2017/10/11        !
!----------------------------------------------------------------------!
  module mpi_m

  implicit none

  integer :: ipnum, nprocs, ierr, wid

  contains
!----------------------------------------------------------------------!
!     subroutine mpi_init                                              !
!----------------------------------------------------------------------!
  recursive subroutine mpi_initialize(flag)
  use grid_m, only: nt

  implicit none
  include 'mpif.h'

  integer :: flag

  if (flag.eq.1)then

    call mpi_init(ierr)
    call mpi_comm_rank(mpi_comm_world,ipnum,ierr)
    call mpi_comm_size(mpi_comm_world,nprocs,ierr)

    wid = nt/nprocs

    if(mod(nt, nprocs).ne.0)then
      write(*,*)"** Modify nprocs, so that mod(nt,nprocs) = 0 **"
        call mpi_init(-1)
      stop
    endif

  elseif(flag.eq.-1)then

    call mpi_finalize(ierr)
  
  endif

  return
  end subroutine mpi_initialize

  end module mpi_m



