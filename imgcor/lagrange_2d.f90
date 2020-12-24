subroutine lagrange_2d_xiyi(f,x,y,nx,ny,ff,xi,yi,nxi,nyi)
  implicit none
  integer,intent(in):: nx,ny,nxi,nyi
  real(8),intent(in):: x(nx),y(ny)
  real(8),intent(in):: f(nx,ny)
  real(8),intent(in):: xi(nxi),yi(nyi)
  real(8),intent(out):: ff(nxi,nyi)

  real(8):: fix(nxi),fiy(nyi)
  real(8):: fixy(nxi,ny),fixys(ny)
  integer:: i

! interpolate in x
  do i=1,ny
    call lagrange_1d_xi(f(:,i),x,nx,fix,xi,nxi)
    fixy(:,i)=fix
  enddo

! interpolate in y
  do i=1,nxi
    fixys=fixy(i,:)
    call lagrange_1d_xi(fixys,y,ny,fiy,yi,nyi)
    ff(i,:)=fiy
  enddo

end subroutine lagrange_2d_xiyi

subroutine lagrange_2d(f,x,y,nx,ny,ff,xi,yi,nxi,nyi)
  implicit none
  integer,intent(in):: nx,ny,nxi,nyi
  real(8),intent(in):: x(nx),y(ny)
  real(8),intent(in):: f(nx,ny)
  real(8),intent(out):: xi(nxi),yi(nyi)
  real(8),intent(out):: ff(nxi,nyi)

  real(8):: fix(nxi),fiy(nyi)
  real(8):: fixy(nxi,ny),fixys(ny)
  integer:: i

! interpolate in x
  do i=1,ny
    call lagrange_1d(f(:,i),x,nx,fix,xi,nxi)
    fixy(:,i)=fix
  enddo

! interpolate in y
  do i=1,nxi
    fixys=fixy(i,:)
    call lagrange_1d(fixys,y,ny,fiy,yi,nyi)
    ff(i,:)=fiy
  enddo  

end subroutine lagrange_2d
