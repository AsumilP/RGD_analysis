!----------------------------------------------------------------------!
!              Program for conducting DMD for matrix data              !
!                                                                      !
!                      input : DNS field data                          !
!                     output : DMD mode, norm, frequency, growth rate  !
!                                                                      !
!                                                    2017/10/11        !
!----------------------------------------------------------------------!
  program dmd
  use grid_m
  use arrays_m
  use mpi_m

  implicit none
  include 'mpif.h'

  integer :: i, j, k, k2, inum=90, onum=80, info, ip
  real(8) :: pi
  character :: lno5*5, lno4*4, filename*150

  call mpi_initialize(1)
  call allocation(1)

  pi = 4.0d0*datan(1.0d0)
!========================================================================!
!----------------------- start dmd --------------------------------------!
!========================================================================!

!========================================================================!
!  Reading data & constructing data matrix                               !
!========================================================================!
  do k = wid*ipnum+1, wid*ipnum+wid

    write(lno5,'(i5.5)')tsst+(k-1)*tsint
    filename = trim(dir_in)//trim(case_name)//'_'//lno5//'.dat'
    if(ipnum.eq.0 .and. mod((tsst+(k-1)*tsint),100).eq.0) write(*,*)'** reading (roop1): '//trim(filename)
    open(inum,file=trim(filename),form='unformatted',access = 'stream',status='old')
    read(inum)vect1
    close(inum)

    do k2 = k, nt

      write(lno5,'(i5.5)')tsst+(k2-1)*tsint
      filename = trim(dir_in)//trim(case_name)//'_'//lno5//'.dat'
      !if(ipnum.eq.0 .and. k2.eq.nt) write(*,*)'** reading (roop2): '//trim(filename)
      open(inum,file=trim(filename),form='unformatted',access = 'stream',status='old')
      read(inum)vect2
      close(inum)

      kk(k,k2) = dot_product(vect1,vect2)

    enddo

    write(lno5,'(i5.5)')tsed
    filename = trim(dir_in)//trim(case_name)//'_'//lno5//'.dat'
    !if(ipnum.eq.0 .and. mod((tsed),1000).eq.0) write(*,*)'** reading(roop1): '//trim(filename)
    open(inum,file=trim(filename),form='unformatted',access = 'stream',status='old')
    read(inum)vect2
    close(inum)

    kx(k) = dot_product(vect1,vect2)

  enddo
!========================================================================!
! End reading data                                                       !
!========================================================================!

  call MPI_BARRIER(MPI_COMM_WORLD, ierr)

!========================================================================!
! Constructing data matrix                                               !
!========================================================================!
  do i = 1, nt
    ip = (i-1)/wid
    call mpi_bcast(kx(i),1,mpi_double_precision,ip,mpi_comm_world,ierr)
  enddo

  do i = 1, nt
    do j = i, nt
      ip = (i-1)/wid
      call mpi_bcast(kk(i,j),1,mpi_double_precision,ip,mpi_comm_world,ierr)
    enddo
  enddo

  do i = 1, nt
    do j = 1, nt
      if(j.gt.i) kk(j,i) = kk(i,j)
    enddo
  enddo

!========================================================================!
!   solve (KK)c=Kxm                                                      !
!========================================================================!
  call dgetrf(nt, nt, kk, nt, ipiv,info)
  call dgetri(nt, kk, nt, ipiv, work, lwork, info)
  if(ipnum.eq.0)then
    write(*,*)'info of DGETRI:',info,work(1)
  endif
  temp = matmul(kk, kx)

  if(ipnum.eq.0)then
  do i = 1, nt
    write(*,*)'c(',i,')=',temp(i)
  enddo
  endif
!========================================================================!
!   Construction of companion matrix                                     !
!========================================================================!
   kk = 0.0d0

   do i = 2, nt
     do j = 1, nt-1
       if (i.eq.j+1) kk(i, j) = 1.0d0
     enddo
   enddo

   do i = 1, nt
     kk(i, nt) = temp(i)
   enddo
!========================================================================!
!   Solve eigen value problem C = B Lam A                                !
!========================================================================!
  call dgeev('N', 'V', nt, kk, nt, wr, wi, vl, 1, vr, nt, work, lwork, info)

  if(ipnum.eq.0)then
     write(*,*)'info of DGEEV:', info, work(1)
  endif

!========================================================================!
!   Construction of Vandermonde matrix                                   !
!========================================================================!
  do i = 1, nt
    do j = 1, nt
      vand(i, j) = dcmplx(wr(i), wi(i))**(j-1)
    enddo
  enddo

!========================================================================!
!  Calculation of inverse of vand                                        !
!========================================================================!
  call zgetrf(nt, nt, vand, nt, ipiv, info)

  if(ipnum.eq.0)then
    write(*,*)'info of zgetrf:', info
  endif

  call zgetri(nt, vand, nt, ipiv, workc, lwork, info)

  if(ipnum.eq.0)then
    write(*,*)'info of zgetri:', info,workc(1)
  endif

!========================================================================!
!   Construction of DMD modes                                            !
!========================================================================!
  do k2 = wid*ipnum+1, wid*ipnum+wid

    vm = (0.0d0, 0.0d0)     

    do k = 1, nt

      write(lno5,'(i5.5)')tsst+(k-1)*tsint
	  filename = trim(dir_in)//trim(case_name)//'_'//lno5//'.dat'
      !if(ipnum.eq.0 .and. mod((tsst+(k-1)*tsint),1000).eq.0) write(*,*)'** reading: '//trim(filename)
      open(inum,file=trim(filename),form='unformatted',access = 'stream',status='old')
      read(inum)vect2
      close(inum)

      do j = 1, num
        vm(j) = vm(j) + vand(k, k2) * vect2(j)
      enddo
  
    enddo

    !-- norm of DMD modes
    temp(k2) = 0.0d0
    do j = 1, num
      temp(k2) = temp(k2) + cdabs(vm(j)) * cdabs(vm(j))
    enddo
    temp(k2) = dsqrt(temp(k2))

    write(lno4,'(i4.4)')k2

    filename = trim(dir_out)//'mode/real_mode_'//lno4//'.dat'
    if(ipnum.eq.0 .and. mod((k2),500).eq.0)write(*,*)'** writing: '//trim(filename)
    open(onum,file=trim(filename),form='unformatted',access = 'stream')
    write(onum) (dble(vm(:)))
    close(onum)

    filename = trim(dir_out)//'mode/imag_mode_'//lno4//'.dat'
    if(ipnum.eq.0 .and. mod((k2),500).eq.0)write(*,*)'** writing: '//trim(filename)
    open(onum,file=trim(filename),form='unformatted',access = 'stream')
    write(onum) (dimag(vm(:)))
    close(onum)

  enddo

  call MPI_BARRIER(MPI_COMM_WORLD, ierr)
!========================================================================!
!   Construction of DMD mode norms                                       !
!========================================================================!
  do i = 1, wid
    sendbuf1(i) = temp(wid*ipnum+i)
  enddo

  call MPI_ALLGATHER(sendbuf1,wid,MPI_DOUBLE_PRECISION, &
                     recvbuf1,wid,MPI_DOUBLE_PRECISION, &
                     MPI_COMM_WORLD, ierr)

  do i = 1, nt
    temp(i) = recvbuf1(i)
  enddo

  if(ipnum.eq.0)then

    filename=trim(dir_out)//'mode/norm.txt'
    write(*,*)'** writing: '//trim(filename)
    open(onum,file=trim(filename),form='formatted',access = 'stream')
    do i = 1, nt
      write(onum,*) temp(i)
    enddo
    close(onum)

    dt =delta_t * dble(tsint)

    do i = 1, nt
      freq(i) = datan2(wi(i), wr(i))/(2.0d0*pi*dt)
      grow(i) = dlog(dsqrt(wr(i)**2+wi(i)**2))/dt
    enddo

    filename=trim(dir_out)//'mode/f_and_g.txt'
    write(*,*)'** writing: '//trim(filename)
    open(onum,file=trim(filename),form='formatted',access = 'stream')
    do i = 1, nt
      write(onum,*) freq(i), grow(i)
    enddo
    close(onum)

  endif

!========================================================================!
!   Finalization of program                                              !
!========================================================================!
  call allocation(-1)
  call mpi_initialize(-1)

  stop
  end program dmd

