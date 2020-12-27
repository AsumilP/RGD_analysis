subroutine img_background_norm(img1,img2,img1bkmin,img2bkmin,img1bkmean,img2bkmean,nx,ny)
  implicit none
  integer, intent(in)::nx,ny
  real(8), intent(inout):: img1(nx,ny),img2(nx,ny)
  real(8), intent(in):: img1bkmin(nx,ny),img2bkmin(nx,ny)
  real(8), intent(in):: img1bkmean(nx,ny),img2bkmean(nx,ny)
  real(8):: denom1(nx,ny), denom2(nx,ny)
  integer:: i,j
  real(8):: eps=1.d-6

  denom1(1:nx,1:ny)=(img1bkmean(1:nx,1:ny)-img1bkmin(1:nx,1:ny))
  denom2(1:nx,1:ny)=(img2bkmean(1:nx,1:ny)-img2bkmin(1:nx,1:ny))

  do i=1,nx
  do j=1,ny
    if (abs(denom1(i,j))<1.d-6) then
      denom1(i,j)=denom1(i,j)+0.1d0
    endif
  enddo
  enddo

  do i=1,nx
  do j=1,ny
    if (abs(denom2(i,j))<1.d-6) then
      denom2(i,j)=denom2(i,j)+0.1d0
    endif
  enddo
  enddo

  img1(1:nx,1:ny)=(img1(1:nx,1:ny)-img1bkmin(1:nx,1:ny))/denom1(1:nx,1:ny)
  img2(1:nx,1:ny)=(img2(1:nx,1:ny)-img2bkmin(1:nx,1:ny))/denom2(1:nx,1:ny)

end subroutine img_background_norm

subroutine img_background_div(img1,img2,img1bk,img2bk,nx,ny)
  implicit none
  integer, intent(in)::nx,ny
  real(8), intent(inout):: img1(nx,ny),img2(nx,ny)
  real(8), intent(in):: img1bk(nx,ny),img2bk(nx,ny)

  img1(1:nx,1:ny)=img1(1:nx,1:ny)/img1bk(1:nx,1:ny)
  img2(1:nx,1:ny)=img2(1:nx,1:ny)/img2bk(1:nx,1:ny)

end subroutine img_background_div

subroutine img_background_sub(img1,img2,img1bk,img2bk,nx,ny)
  implicit none
  integer, intent(in)::nx,ny
  real(8), intent(inout):: img1(nx,ny),img2(nx,ny)
  real(8), intent(in):: img1bk(nx,ny),img2bk(nx,ny)

  img1(1:nx,1:ny)=img1(1:nx,1:ny)-img1bk(1:nx,1:ny)
  img2(1:nx,1:ny)=img2(1:nx,1:ny)-img2bk(1:nx,1:ny)

end subroutine img_background_sub

subroutine img_gaussian_smooth(img1, img2, nx, ny)
  implicit none
  integer, intent(in):: nx
  integer, intent(in):: ny
  real(8), intent(inout):: img1(nx,ny)
  real(8), intent(inout):: img2(nx,ny)
  real(8):: imgf(nx,ny)
  integer,parameter :: L=7
  real(8):: C(L)
  real(8):: px
  integer:: i,j,k

  do i=1,7
    C(i)=exp(-(dble(i)-4.d0)**2.d0/2.d0)
  enddo
  C(1:7)=C(1:7)/sum(C)
  do i=4,nx-3
    do j=4,ny-3
      px=0.d0
      do k=1,L
        px=px+C(k)*img1(i+k-4,j)
      enddo
      imgf(i,j)=px
    enddo
  enddo
  img1(4:nx-3,4:ny-3)=imgf(4:nx-3,4:ny-3)
  do i=4,nx-3
    do j=4,ny-3
      px=0.d0
      do k=1,L
        px=px+C(k)*img1(i,j+k-4)
      enddo
      imgf(i,j)=px
    enddo
  enddo
  img1(4:nx-3,4:ny-3)=imgf(4:nx-3,4:ny-3)

  do i=4,nx-3
    do j=4,ny-3
      px=0.d0
      do k=1,L
        px=px+C(k)*img2(i+k-4,j)
      enddo
      imgf(i,j)=px
    enddo
  enddo
  img2(4:nx-3,4:ny-3)=imgf(4:nx-3,4:ny-3)
  do i=4,nx-3
    do j=4,ny-3
      px=0.d0
      do k=1,L
        px=px+C(k)*img2(i,j+k-4)
      enddo
      imgf(i,j)=px
    enddo
  enddo
  img2(4:nx-3,4:ny-3)=imgf(4:nx-3,4:ny-3)


end subroutine img_gaussian_smooth
