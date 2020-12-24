c------------------------------------------------------------
c    Gaussの消去法
c------------------------------------------------------------
      subroutine gauss(n,dx1)
      implicit none

      integer i, j, k, n
      integer fv
      real(8) dx1, dx2, dr, dd

      dimension dx1(n,n+1),dx2(n,n+1)
c--- set fv=1 to output check data
      fv = 0
c------------------------------------------------------------
c     do i=1,n
c       if(dx1(1,i).eq.0.0d0) then 
c           nzero=i
c           goto
c       endif
c     enddo
c-----Swap Data-----------------------------------------------
c
c
c
c
c-----三角行列化-----------------------------------------------
      do i=1, n-1
        do k=i+1, n
          dr = dx1(k,i)/dx1(i,i)
          do j=1, n+1
            dx1(k,j) = dx1(k,j) - dx1(i,j)*dr
          enddo
        enddo
      enddo
c------test-------------------
      if(fv.eq.1) then 
        do i=1, n
          write(*,'(10e15.2)') ( dx1(i,j),j=1,n+1)
        enddo
        write(*,*)
      endif
c-----対角行列化-------------------------------------------------
      do i=n, 2, -1
        do k=1, i-1
          dr = dx1(k,i)/dx1(i,i)
          do j=1, n+1
            dx1(k,j) = dx1(k,j) - dx1(i,j)*dr
          enddo
        enddo
      enddo
c------test-------------------
      if(fv.eq.1) then 
        do i=1, n
          write(*,'(10e15.2)') ( dx1(i,j),j=1,n+1)
        enddo
        write(*,*)
      endif
c----- 単位行列化------------------------------------------------
      do i=1, n
        dd = dx1(i,i)
        do j=1, n+1
          dx1(i,j) = dx1(i,j)/dd
        enddo
      enddo
c------test-------------------
      if(fv.eq.1) then 
        do i=1, n
          write(*,'(10e15.2)') ( dx1(i,j),j=1,n+1)
        enddo
        write(*,*)
      endif
c----------------------------------------------------------------
      return
      end
