!----------------------------------------------------------------------!
!                         module arrays_m                              !
!                                                    2017/10/11        !
!----------------------------------------------------------------------!
  module arrays_m

  implicit none

  integer,allocatable :: ipiv(:)
  real(8),allocatable :: vect1(:), vect2(:), kk(:,:), kx(:), temp(:)
  real(8),allocatable :: sendbuf1(:), recvbuf1(:)
  real(8),allocatable :: sendbuf2(:), recvbuf2(:)
  real(8),allocatable :: wr(:), wi(:), vr(:,:), vl(:,:), work(:), freq(:), grow(:)
  complex(kind(0d0)),allocatable :: vand(:,:), workc(:), vm(:)

  contains
!----------------------------------------------------------------------!
!         subroutine allocation                                        !
!----------------------------------------------------------------------!
  subroutine allocation(flag)
  use grid_m, only: num, nt, lwork
  use mpi_m, only: wid

  implicit none

  integer :: flag

  if(flag.eq.1)then
 
    allocate(ipiv(nt)); ipiv = 0
    allocate(vect1(num)); vect1 = 0.0d0
    allocate(vect2(num)); vect2 = 0.0d0
    allocate(kk(nt,nt)); kk = 0.0d0
    allocate(kx(nt)); kx = 0.0d0
    allocate(temp(nt)); temp = 0.0d0
    allocate(sendbuf1(wid)); sendbuf1 = 0.0d0
    allocate(recvbuf1(nt)); recvbuf1 = 0.0d0
    allocate(sendbuf2(nt*wid)); sendbuf2 = 0.0d0
    allocate(recvbuf2(nt*nt)); recvbuf2 = 0.0d0
    allocate(wr(nt)); wr = 0.0d0
    allocate(wi(nt)); wi = 0.0d0 
    allocate(vr(nt, nt)); vr = 0.0d0
    allocate(vl(1,1)); vl = 0.0d0
    allocate(work(lwork)); work = 0.0d0
    allocate(vand(nt, nt)); vand = (0.0d0, 0.0d0)
    allocate(workc(lwork)); workc = (0.0d0, 0.0d0)
    allocate(vm(num)); vm = (0.0d0, 0.0d0)
    allocate(freq(nt)); freq = 0.0d0
    allocate(grow(nt)); grow = 0.0d0

  elseif(flag.eq.-1)then

    deallocate(ipiv)
    deallocate(vect1)
    deallocate(vect2)
    deallocate(temp)
    deallocate(kk)
    deallocate(kx)
    deallocate(sendbuf1)
    deallocate(recvbuf1)
    deallocate(sendbuf2)
    deallocate(recvbuf2)
    deallocate(wr)
    deallocate(wi)
    deallocate(vr)
    deallocate(vl)
    deallocate(work)
    deallocate(vand)
    deallocate(workc)
    deallocate(vm)
    deallocate(freq)
    deallocate(grow)

  endif

  return
  end subroutine allocation

  end module arrays_m

 
