! compute img coordinate from physical
subroutine get_imgcoord(xp,yp,coef,ndim,nterm,xi,yi)
  implicit none
  integer,intent(in):: ndim,nterm
  real(8),intent(in)::  xp,yp,coef(ndim,nterm+1)
  real(8),intent(out):: xi, yi
 ! xi = &
 ! coef(1,1)*xp**2 &
 ! + coef(1,2)*yp**2 &
 ! + coef(1,3)*xp*yp &
 ! + coef(1,4)*xp &
 ! + coef(1,5)*yp &
 ! + coef(1,6)
 ! yi = coef(2,1)*xp**2 &
 ! + coef(2,2)*yp**2 &
 ! + coef(2,3)*xp*yp &
 ! + coef(2,4)*xp &
 ! + coef(2,5)*yp &
 ! + coef(2,6)
 
 xi = &
 coef(1,1)*xp**4 &
+ coef(1,2)*yp**4 &
+ coef(1,3)*(xp**3)*yp &
+ coef(1,4)*xp*(yp**3) &
+ coef(1,5)*(xp**2)*(yp**2) &
+ coef(1,6)*xp**3 &
+ coef(1,7)*yp**3 &
+ coef(1,8)*(xp**2)*yp &
+ coef(1,9)*xp*(yp**2) &
+ coef(1,10)*xp**2 &
+ coef(1,11)*yp**2 &
+ coef(1,12)*yp*xp &
+ coef(1,13)*xp &
+ coef(1,14)*yp &
+ coef(1,15)

 yi = &
 coef(2,1)*xp**4 &
+ coef(2,2)*yp**4 &
+ coef(2,3)*(xp**3)*yp &
+ coef(2,4)*xp*(yp**3) &
+ coef(2,5)*(xp**2)*(yp**2) &
+ coef(2,6)*xp**3 &
+ coef(2,7)*yp**3 &
+ coef(2,8)*(xp**2)*yp &
+ coef(2,9)*xp*(yp**2) &
+ coef(2,10)*xp**2 &
+ coef(2,11)*yp**2 &
+ coef(2,12)*yp*xp &
+ coef(2,13)*xp &
+ coef(2,14)*yp &
+ coef(2,15)



end subroutine get_imgcoord
