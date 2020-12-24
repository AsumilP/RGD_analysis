subroutine lagrange_1d_xi(f,x,nx,fi,xi,nxi)
  implicit none
  integer,intent(in):: nx,nxi
  real(8),intent(in):: f(nx)
  real(8),intent(in):: x(nx)
  real(8),intent(out):: fi(nxi)
  real(8),intent(in):: xi(nxi)
  integer:: i,j,k
  real(8):: L(nx,nxi)

![todo] check xi increases monotonically

  L(1:nx,1:nxi)=1.d0
  do i=1,nx
    do j=1,nx
      if (i/=j) then
        do k=1,nxi
          L(i,k)=L(i,k)*(xi(k)-x(j))/(x(i)-x(j))
        enddo
      endif
    enddo
  enddo

  fi(1:nxi)=0.d0
  do j=1,nxi
    do i=1,nx
      fi(j)=fi(j)+f(i)*L(i,j)
    enddo
  enddo

end subroutine lagrange_1d_xi

subroutine lagrange_1d(f,x,nx,fi,xi,nxi)
  implicit none
  integer,intent(in):: nx,nxi
  real(8),intent(in):: f(nx)
  real(8),intent(in):: x(nx)
  real(8),intent(out):: fi(nxi)
  real(8),intent(out):: xi(nxi)
  integer:: i
!  integer:: j,k
  real(8):: dxi
!  real(8):: L(nx,nxi)

! create coordinate for interpolated field
  dxi=(maxval(x)-minval(x))/(nxi-1)
  xi(1:nxi)=0.d0
  do i=1,nxi
    xi(i)=minval(x)+dxi*(i-1)
  enddo

  call lagrange_1d_xi(f,x,nx,fi,xi,nxi)
  
end subroutine lagrange_1d
