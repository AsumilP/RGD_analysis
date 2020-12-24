!> @mainpage imgcor
!! @section xc
!! @li cross correlation
!! @section ls
!! [todo] output suggestion for the threashould
! Compute correlation numerical cross with calibration grid image
program xc
use param
implicit none

integer(1) :: img_head(head_size)
integer(2) :: raw_int(nx, ny),raw_dark(nx, ny)
!real(8) :: raw_int(nx, ny),raw_dark(nx, ny)
real(8) :: raw_real(nx, ny)
real(8) :: raw_tmp(nx, ny)
real(8) :: ccc(nx, ny)
real(8) :: cross(nxc, nyc)
real(8) :: circ(2*radius,2*radius)
character(90):: frawi
character(90):: fccco

integer :: i, j
real(8) :: r

ccc(1:nx,1:ny) = 0.0d0

! display parameters
write(*,*) 'nx:', nx
write(*,*) 'ny:', ny
write(*,*) 'nxc:', nxc
write(*,*) 'nyc:', nyc
write(*,*) 'width_x:', width_x
write(*,*) 'width_y:', width_y

! input raw data
frawi = path_of_grid_raw//file_name_raw
fccco = path_of_grid_ccc//file_name_ccc

write(*,*) frawi
open(10, file=frawi, form='binary')
if (head_size==0) then
  if (flag_skip==0) then
    read(10) raw_int
  elseif (flag_skip==1) then
    read(10) raw_dark,raw_int
    write(*,*) 'skip 1 dark frame'
  elseif (flag_skip==2) then
    read(10) raw_dark,raw_dark,raw_int
    write(*,*) 'skip 2 dark frame'
  endif
else
  if (flag_skip==0) then
    read(10) img_head,raw_int
  elseif (flag_skip==1) then
    read(10) img_head,raw_dark,raw_int
    write(*,*) 'skip 1 dark frame'
  else
    read(10) img_head,raw_dark,raw_dark,raw_int
    write(*,*) 'skip 2 dark frame'
  endif
endif
close(10)
!raw_real(1:nx,1:ny)=dble(raw_int(1:nx,1:ny))
raw_real(1:nx,1:ny) = raw_int(1:nx,1:ny)

if(xflip) then
  raw_tmp(1:nx,1:ny) = raw_real(nx:1:-1,1:ny)
  raw_real(1:nx,1:ny)=raw_tmp(1:nx,1:ny)
endif

if(yflip) then
  raw_tmp(1:nx,1:ny) = raw_real(1:nx,ny:1:-1)
  raw_real(1:nx,1:ny)=raw_tmp(1:nx,1:ny)
endif

if(iflip) then
  raw_real(1:nx,1:ny) = 2**nbit_c - raw_real(1:nx,1:ny)
endif

! define numerical cross
cross(1:nxc,1:nyc) = 0.0d0
do j=nyc/2-width_y/2, nyc/2+width_y/2
  do i=1, nxc
    cross(i,j) = 1.0d0
  enddo
enddo
do j=1, nyc
  do i=nxc/2-width_x/2, nxc/2+width_x/2
    cross(i,j) = 1.0d0
  enddo
enddo

call doccc(raw_real,cross,ccc,nx,ny,nxc,nyc)

write(*,*) fccco
open(20, file=fccco, form='binary')
write(20) ccc
close(20)

print *, 'max of ccc: ', maxval(ccc)

! define numerical circle
circ(1:2*radius,1:2*radius) = 0.d0
do j=1, 2*radius
  do i=1, 2*radius
    r = int(sqrt(dble(i-radius)**2 + dble(j-radius)**2))
    if(r<radius) then
      circ(i,j) = 1.d0
    endif
  enddo
enddo
do j=radius-width_y/2, radius+width_y/2
  do i=1, 2*radius
    circ(i,j) = 0.0d0
  enddo
enddo
do j=1, 2*radius
  do i=radius-width_x/2, radius+width_x/2
    circ(i,j) = 0.0d0
  enddo
enddo


!print *, radius
!print *, circ
!open(10,file='circ.dat',form='binary')
!write(10) circ
!close(10)

ccc(1:nx,1:ny)=0.d0
call doccc(raw_real,circ,ccc,nx,ny,2*radius,2*radius)

fccco = path_of_grid_ccc//file_name_ccco
write(*,*) fccco
open(20, file=fccco, form='binary')
write(20) ccc
close(20)
print *, 'max of ccco: ', maxval(ccc)

end program xc

subroutine doccc(raw_real,cross_t,ccc,nx,ny,nxc,nyc)
  implicit none
  integer,intent(in):: nx,ny
  integer,intent(in):: nxc,nyc
  real(8),intent(in):: raw_real(nx,ny)
  real(8),intent(in):: cross_t(nxc,nyc)
  real(8),intent(out):: ccc(nx,ny)
  real(8) :: raw_c(nxc, nyc)
  real(8) :: cross(nxc, nyc)
  real(8) :: raw_mean, raw_rms
  real(8) :: cross_mean, cross_rms
  integer :: i,j,k,l
  
  cross(1:nxc,1:nyc)=cross_t(1:nxc,1:nyc)
  cross_mean = 0.0d0
  cross_rms  = 0.0d0

  do j=1, nyc
    do i=1, nxc
      cross_mean = cross_mean + cross(i,j)
    enddo
  enddo
  cross_mean = cross_mean/dble(nxc*nyc)
  do j=1, nyc
    do i=1, nxc
      cross_rms = cross_rms + (cross(i,j) - cross_mean)**2
    enddo
  enddo

  do j=1, nyc
    do i=1, nxc
      cross(i,j) = cross(i,j) - cross_mean
    enddo
  enddo

  do j=nyc/2, ny-nyc/2
    do i=nxc/2, nx-nxc/2

      do l=1, nyc
        do k=1, nxc
          raw_c(k,l) = raw_real(i-nxc/2+k,j-nyc/2+l)
        enddo
      enddo

      raw_mean = 0.0d0
      raw_rms  = 0.0d0
      do l=1, nyc
        do k=1, nxc
          raw_mean = raw_mean + raw_c(k,l)
        enddo
      enddo
      raw_mean = raw_mean/dble(nxc*nyc)
      do l=1, nyc
        do k=1, nxc
          raw_rms = raw_rms + (raw_c(k,l) - raw_mean)**2.d0
       enddo
      enddo
      do l=1, nyc
        do k=1, nxc
          raw_c(k,l) = raw_c(k,l) - raw_mean
        enddo
      enddo

      do l=1, nyc
        do k=1, nxc
          ccc(i,j) = ccc(i,j) + raw_c(k,l)*cross(k,l)
        enddo
      enddo
      ccc(i,j) = ccc(i,j)/dsqrt(raw_rms*cross_rms)
    enddo
  enddo
end subroutine doccc
