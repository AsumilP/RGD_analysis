!> \brief comute median
!! @param[in] xx is input vector
!! @param[in] x_size is the size of input vector
!! @param[out] med is median value
!! @todo low inplement better sort algorithm
subroutine median(xx,x_size,med)
  implicit none
  integer,intent(in)::x_size
  real(8),intent(in)::xx(x_size)
  real(8),intent(out)::med
  real(8)::x(x_size)
  real(8)::y(x_size)
  real(8)::mmax
  integer::i,j,imax,idx
  real(8):: big
  big=2.d0**64
  mmax=-big
  med=0.d0
  x(:)=xx(:)
  !! simple sort: find biggest one, take it to new array and set it very small in original. then repeat it.
  do j=1,x_size
    mmax=-big
    do i=1,x_size
      if(mmax<x(i))then
        mmax=x(i)
        imax=i
      endif
    enddo
    y(j)=x(imax)
    x(imax)=-big
  enddo

  idx=x_size/2
  if (mod(x_size,2)==1)then
    med=y(idx+1) !! return center value if the size is odd
  else
    med=0.5*(y(idx)+y(idx+1)) !! return mean of two center values if the size is even
  endif

end subroutine median

!> \brief perform normalized median test:
!! in particle image velocimetey practical guide p.185,
!! Westerweel & Scarano 2005 Exp. Fluids 39 pp.1096-1100.
!! @param[in] disp
!! @param[out] flag
!! @todo
subroutine normalized_median_test(disp,flag,nvec_x,nvec_y)
  implicit none
  integer,intent(in):: nvec_x,nvec_y
  real(8),intent(in):: disp(nvec_x,nvec_y)
  integer(8),intent(inout):: flag(nvec_x,nvec_y)
  real(8):: eps_th, eps_0, eps_crit
  real(8):: umed,rmed
  real(8),allocatable:: neighbor(:), norm_neighbor(:)
  integer:: i,j,k,l,idx,nei_count
  eps_th=0.15d0
  eps_0=2.0d0 !< normalized threashould in the paper (Westerweel & Scalano 2005 Exp Fluids)

  ! center
  do j=2,nvec_y-1
    do i=2,nvec_x-1
      nei_count=0

      do l=1,3
        do k=1,3
          if ((.not.(l==2.and.k==2)).and. flag(i-2+k,j-2+l)==1 ) then
            nei_count=nei_count+1
          endif
        enddo
      enddo

!print *, "nei_count", nei_count

if (nei_count >= 3) then

      allocate(neighbor(nei_count))

      idx=1
      do l=1,3
        do k=1,3
          if ((.not.(l==2.and.k==2)).and. flag(i-2+k,j-2+l)==1 ) then
            neighbor(idx)=disp(i-2+k,j-2+l)
            idx=idx+1
          endif
        enddo
      enddo

      call median(neighbor,size(neighbor),umed)

      allocate(norm_neighbor(nei_count))

      do k=1,size(neighbor)
        norm_neighbor(k)=abs(neighbor(k)-umed)
      enddo
      call median(norm_neighbor,size(norm_neighbor),rmed)

!  print *, "umed:", umed-disp(i,j), ", rmed:", rmed
      eps_crit=abs(disp(i,j)-umed)/(rmed+eps_th)

      if (eps_crit>eps_0) then
        flag(i,j)=2
      endif

      deallocate(neighbor)
      deallocate(norm_neighbor)
else
  flag(i,j)=2
endif

    enddo
  enddo

  allocate(neighbor(5))
  ! left edge
  do j=2,nvec_y-1
    do i=1,1
      idx=1
      do l=1,3
        do k=1,2
          if (.not.(l==2.and.k==1)) then
            neighbor(idx)=disp(i-1+k,j-2+l)
            idx=idx+1
          endif
        enddo
      enddo
      call median(neighbor,size(neighbor),umed)
      do k=1,size(neighbor)
        neighbor(k)=abs(neighbor(k)-umed)
      enddo
      call median(neighbor,size(neighbor),rmed)
      eps_crit=abs(disp(i,j)-umed)/(rmed+eps_th)
      if (eps_crit>eps_0) then
        flag(i,j)=2
      endif
    enddo
  enddo
  ! right edge
  do j=2,nvec_y-1
    do i=nvec_x,nvec_x
      idx=1
      do l=1,3
        do k=1,2
          if (.not.(l==2.and.k==2)) then
            neighbor(idx)=disp(i-2+k,j-2+l)
            idx=idx+1
          endif
        enddo
      enddo
      call median(neighbor,size(neighbor),umed)
      do k=1,size(neighbor)
        neighbor(k)=abs(neighbor(k)-umed)
      enddo
      call median(neighbor,size(neighbor),rmed)
      eps_crit=abs(disp(i,j)-umed)/(rmed+eps_th)
      if (eps_crit>eps_0) then
        flag(i,j)=2
      endif
    enddo
  enddo
  ! top edge
  do j=1,1
    do i=2,nvec_x-1
      idx=1
      do l=1,2
        do k=1,3
          if (.not.(l==1.and.k==2)) then
            neighbor(idx)=disp(i-2+k,j-1+l)
            idx=idx+1
          endif
        enddo
      enddo
      call median(neighbor,size(neighbor),umed)
      do k=1,size(neighbor)
        neighbor(k)=abs(neighbor(k)-umed)
      enddo
      call median(neighbor,size(neighbor),rmed)
      eps_crit=abs(disp(i,j)-umed)/(rmed+eps_th)
      if (eps_crit>eps_0) then
        flag(i,j)=2
      endif
    enddo
  enddo
  ! bottom edge
  do j=nvec_y,nvec_y
    do i=2,nvec_x-1
      idx=1
      do l=1,2
        do k=1,3
          if (.not.(l==2.and.k==2)) then
            neighbor(idx)=disp(i-2+k,j-2+l)
            idx=idx+1
          endif
        enddo
      enddo
      call median(neighbor,size(neighbor),umed)
      do k=1,size(neighbor)
        neighbor(k)=abs(neighbor(k)-umed)
      enddo
      call median(neighbor,size(neighbor),rmed)
      eps_crit=abs(disp(i,j)-umed)/(rmed+eps_th)
      if (eps_crit>eps_0) then
        flag(i,j)=2
      endif
    enddo
  enddo
  deallocate(neighbor)
  allocate(neighbor(3))
  ! top_left_corner
  do j=1,1
    do i=1,1
      idx=1
      do l=1,2
        do k=1,2
          if (.not.(l==1.and.k==1)) then
            neighbor(idx)=disp(i-1+k,j-1+l)
            idx=idx+1
          endif
        enddo
      enddo
      call median(neighbor,size(neighbor),umed)
      do k=1,size(neighbor)
        neighbor(k)=abs(neighbor(k)-umed)
      enddo
      call median(neighbor,size(neighbor),rmed)
      eps_crit=abs(disp(i,j)-umed)/(rmed+eps_th)
      if (eps_crit>eps_0) then
        flag(i,j)=2
      endif
    enddo
  enddo
  ! top_right_corner
  do j=1,1
    do i=nvec_x,nvec_x
      idx=1
      do l=1,2
        do k=1,2
          if (.not.(l==1.and.k==2)) then
            neighbor(idx)=disp(i-2+k,j-1+l)
            idx=idx+1
          endif
        enddo
      enddo
      call median(neighbor,size(neighbor),umed)
      do k=1,size(neighbor)
        neighbor(k)=abs(neighbor(k)-umed)
      enddo
      call median(neighbor,size(neighbor),rmed)
      eps_crit=abs(disp(i,j)-umed)/(rmed+eps_th)
      if (eps_crit>eps_0) then
        flag(i,j)=2
      endif
    enddo
  enddo
  ! bottom_right_corner
  do j=nvec_y,nvec_y
    do i=nvec_x,nvec_x
      idx=1
      do l=1,2
        do k=1,2
          if (.not.(l==2.and.k==2)) then
            neighbor(idx)=disp(i-2+k,j-2+l)
            idx=idx+1
          endif
        enddo
      enddo
      call median(neighbor,size(neighbor),umed)
      do k=1,size(neighbor)
        neighbor(k)=abs(neighbor(k)-umed)
      enddo
      call median(neighbor,size(neighbor),rmed)
      eps_crit=abs(disp(i,j)-umed)/(rmed+eps_th)
      if (eps_crit>eps_0) then
        flag(i,j)=2
      endif
    enddo
  enddo
  ! bottom_left_corner
  do j=nvec_y,nvec_y
    do i=1,1
      idx=1
      do l=1,2
        do k=1,2
          if (.not.(l==2.and.k==1)) then
            neighbor(idx)=disp(i-1+k,j-2+l)
            idx=idx+1
          endif
        enddo
      enddo
      call median(neighbor,size(neighbor),umed)
      do k=1,size(neighbor)
        neighbor(k)=abs(neighbor(k)-umed)
      enddo
      call median(neighbor,size(neighbor),rmed)
      eps_crit=abs(disp(i,j)-umed)/(rmed+eps_th)
      if (eps_crit>eps_0) then
        flag(i,j)=2
      endif
    enddo
  enddo
  deallocate(neighbor)

end subroutine normalized_median_test

!> \brief remove outlier vector
subroutine remove_outlier( &
disp_x_n,disp_y_n,ccc_n,flag_n, &
disp_x,disp_y,ccc,flag, &
nvec_x,nvec_y,rank)
  implicit none
  integer, intent(in):: nvec_x,nvec_y,rank

  real(8), intent(in):: disp_x_n(nvec_x,nvec_y,rank)
  real(8), intent(in):: disp_y_n(nvec_x,nvec_y,rank)
  real(8), intent(in):: ccc_n(nvec_x,nvec_y,rank)
  integer(8), intent(in):: flag_n(nvec_x,nvec_y,rank)

  real(8), intent(out):: disp_x(nvec_x,nvec_y)
  real(8), intent(out):: disp_y(nvec_x,nvec_y)
  real(8), intent(out):: ccc(nvec_x,nvec_y)
  integer(8), intent(out):: flag(nvec_x,nvec_y)

  real(8) :: disp_abs(nvec_x,nvec_y)

  integer:: i,j
  integer:: counter

  disp_x(1:nvec_x,1:nvec_y)=disp_x_n(1:nvec_x,1:nvec_y,1)
  disp_y(1:nvec_x,1:nvec_y)=disp_y_n(1:nvec_x,1:nvec_y,1)
  ccc(1:nvec_x,1:nvec_y)=ccc_n(1:nvec_x,1:nvec_y,1)
  flag(1:nvec_x,1:nvec_y)=flag_n(1:nvec_x,1:nvec_y,1)

  disp_abs(1:nvec_x,1:nvec_y)=sqrt(disp_x(1:nvec_x,1:nvec_y)**2+disp_y(1:nvec_x,1:nvec_y)**2)
  call normalized_median_test(disp_abs,flag,nvec_x,nvec_y)

  !! count outliers
  counter=0
  do j=1,nvec_y
    do i=1,nvec_x
      if (mod(int(flag(i,j)),2)==0) then
        counter=counter+1
      endif
    enddo
  enddo
  if (counter > 0) then
    print *, "number of outliers detected by median filter: ", counter, "/", nvec_x*nvec_y
    print *, "they are replaced by 2nd peak of correlation. flag 17 is given."
  else
    print *, "no outliers are found"
  endif
  do j=1,nvec_y
    do i=1,nvec_x
      if (mod(int(flag(i,j)),2)==0) then
        disp_x(i,j)=disp_x_n(i,j,2)
        disp_y(i,j)=disp_y_n(i,j,2)
        ccc(i,j)=ccc_n(i,j,2)
        flag(i,j)=17
      endif
    enddo
  enddo
  disp_abs(1:nvec_x,1:nvec_y)=sqrt(disp_x(1:nvec_x,1:nvec_y)**2+disp_y(1:nvec_x,1:nvec_y)**2)
  call normalized_median_test(disp_abs,flag,nvec_x,nvec_y)
  counter=0
  do j=1,nvec_y
    do i=1,nvec_x
      if (mod(int(flag(i,j)),2)==0) then
        counter=counter+1
      endif
    enddo
  enddo
  if (counter > 0) then
    print *, "number of outliers detected by median filter: ", counter, "/", nvec_x*nvec_y
    print *, "they are replaced by 3rd peak of correlation. flag 33 is given."
  else
    print *, "all the outliers are replaced by the displacement of 2nd peak"
  endif

  do j=1,nvec_y
    do i=1,nvec_x
      if (mod(int(flag(i,j)),2)==0) then
        disp_x(i,j)=disp_x_n(i,j,3)
        disp_y(i,j)=disp_y_n(i,j,3)
        ccc(i,j)=ccc_n(i,j,3)
        flag(i,j)=33
      endif
    enddo
  enddo
  disp_abs(1:nvec_x,1:nvec_y)=sqrt(disp_x(1:nvec_x,1:nvec_y)**2+disp_y(1:nvec_x,1:nvec_y)**2)
  call normalized_median_test(disp_abs,flag,nvec_x,nvec_y)
  counter=0
  do j=1,nvec_y
    do i=1,nvec_x
      if (mod(int(flag(i,j)),2)==0) then
        counter=counter+1
      endif
    enddo
  enddo
  if (counter > 0) then
    print *, "number of outliers detected by median filter: ", counter, "/", nvec_x*nvec_y
    print *, "they are replaced by mean of neighbors. flag 4 is given."
  else
    print *, "all the outliers are replaced by the displacement of 3rd peak"
  endif

  call replace_outlier(disp_x,disp_y,ccc,flag,nvec_x,nvec_y)

end subroutine remove_outlier


!> \brief replace outlier by the average of good neighbor
subroutine replace_outlier(disp_x,disp_y,ccc,flag,nvec_x,nvec_y)
  implicit none
  integer,intent(in):: nvec_x
  integer,intent(in):: nvec_y
  real(8),intent(inout):: disp_x(nvec_x,nvec_y)
  real(8),intent(inout):: disp_y(nvec_x,nvec_y)
  real(8),intent(inout):: ccc(nvec_x,nvec_y)
  integer(8),intent(inout):: flag(nvec_x,nvec_y)

  integer :: i,j,k,l,idx
  real(8):: x_ave,y_ave

  !! replace outliers by average of neighbors
  !! center
  do j=2,nvec_y-1
    do i=2,nvec_x-1
      if (mod(int(flag(i,j)),2)==0) then
        idx=0
        x_ave=0.d0
        y_ave=0.d0
        do l=1,3
          do k=1,3
            !            print *, "mod:",mod(int(flag(i-2+k,j-2+l)),2)
            if (mod(int(flag(i-2+k,j-2+l)),2)==1) then
              x_ave=x_ave+disp_x(i-2+k,j-2+l)
              y_ave=y_ave+disp_y(i-2+k,j-2+l)
              idx=idx+1
            endif
          enddo
        enddo
        if (idx/=0) then
          disp_x(i,j)=x_ave/dble(idx)
          disp_y(i,j)=y_ave/dble(idx)
!          ccc(i,j)=0
          flag(i,j)=4
        else
!          ccc(i,j)=0
          flag(i,j)=44
        endif
      endif
    enddo
  enddo

  !! top
  do j=1,1
    do i=2,nvec_x-1
      if (mod(int(flag(i,j)),2)==0) then
        idx=0
        x_ave=0.d0
        y_ave=0.d0
        do l=1,2
          do k=1,3
            !            print *, "mod:",mod(int(flag(i-2+k,j-2+l)),2)
            if (mod(int(flag(i-2+k,j-1+l)),2)==1) then
              x_ave=x_ave+disp_x(i-2+k,j-1+l)
              y_ave=y_ave+disp_y(i-2+k,j-1+l)
              idx=idx+1
            endif
          enddo
        enddo
        if (idx/=0) then
          disp_x(i,j)=x_ave/dble(idx)
          disp_y(i,j)=y_ave/dble(idx)
!          ccc(i,j)=0
          flag(i,j)=4
        else
!          ccc(i,j)=0
          flag(i,j)=44
        endif
      endif
    enddo
  enddo

  !! bottom
  do j=nvec_y,nvec_y
    do i=2,nvec_x-1
      if (mod(int(flag(i,j)),2)==0) then
        idx=0
        x_ave=0.d0
        y_ave=0.d0
        do l=1,2
          do k=1,3
            !            print *, "mod:",mod(int(flag(i-2+k,j-2+l)),2)
            if (mod(int(flag(i-2+k,j-2+l)),2)==1) then
              x_ave=x_ave+disp_x(i-2+k,j-2+l)
              y_ave=y_ave+disp_y(i-2+k,j-2+l)
              idx=idx+1
            endif
          enddo
        enddo
        if (idx/=0) then
          disp_x(i,j)=x_ave/dble(idx)
          disp_y(i,j)=y_ave/dble(idx)
 !         ccc(i,j)=0
          flag(i,j)=4
        else
 !         ccc(i,j)=0
          flag(i,j)=44
        endif
      endif
    enddo
  enddo

  !! left
  do j=2,nvec_y-1
    do i=1,1
      if (mod(int(flag(i,j)),2)==0) then
        idx=0
        x_ave=0.d0
        y_ave=0.d0
        do l=1,3
          do k=1,2
            !            print *, "mod:",mod(int(flag(i-2+k,j-2+l)),2)
            if (mod(int(flag(i-1+k,j-2+l)),2)==1) then
              x_ave=x_ave+disp_x(i-1+k,j-2+l)
              y_ave=y_ave+disp_y(i-1+k,j-2+l)
              idx=idx+1
            endif
          enddo
        enddo
        if (idx/=0) then
          disp_x(i,j)=x_ave/dble(idx)
          disp_y(i,j)=y_ave/dble(idx)
  !        ccc(i,j)=0
          flag(i,j)=4
        else
  !        ccc(i,j)=0
          flag(i,j)=44
        endif
      endif
    enddo
  enddo

  !! right
  do j=2,nvec_y-1
    do i=nvec_x,nvec_x
      if (mod(int(flag(i,j)),2)==0) then
        idx=0
        x_ave=0.d0
        y_ave=0.d0
        do l=1,3
          do k=1,2
            !            print *, "mod:",mod(int(flag(i-2+k,j-2+l)),2)
            if (mod(int(flag(i-2+k,j-2+l)),2)==1) then
              x_ave=x_ave+disp_x(i-2+k,j-2+l)
              y_ave=y_ave+disp_y(i-2+k,j-2+l)
              idx=idx+1
            endif
          enddo
        enddo
        if (idx/=0) then
          disp_x(i,j)=x_ave/dble(idx)
          disp_y(i,j)=y_ave/dble(idx)
   !       ccc(i,j)=0
          flag(i,j)=4
        else
   !       ccc(i,j)=0
          flag(i,j)=44
        endif
      endif
    enddo
  enddo


  !! top left
  do j=1,1
    do i=1,1
      if (mod(int(flag(i,j)),2)==0) then
        idx=0
        x_ave=0.d0
        y_ave=0.d0
        do l=1,2
          do k=1,2
            !            print *, "mod:",mod(int(flag(i-2+k,j-2+l)),2)
            if (mod(int(flag(i-1+k,j-1+l)),2)==1) then
              x_ave=x_ave+disp_x(i-1+k,j-1+l)
              y_ave=y_ave+disp_y(i-1+k,j-1+l)
              idx=idx+1
            endif
          enddo
        enddo
        if (idx/=0) then
          disp_x(i,j)=x_ave/dble(idx)
          disp_y(i,j)=y_ave/dble(idx)
!          ccc(i,j)=0
          flag(i,j)=4
        else
!          ccc(i,j)=0
          flag(i,j)=44
        endif
      endif
    enddo
  enddo

  !! bottom left
  do j=nvec_y,nvec_y
    do i=1,1
      if (mod(int(flag(i,j)),2)==0) then
        idx=0
        x_ave=0.d0
        y_ave=0.d0
        do l=1,2
          do k=1,2
            !            print *, "mod:",mod(int(flag(i-2+k,j-2+l)),2)
            if (mod(int(flag(i-1+k,j-2+l)),2)==1) then
              x_ave=x_ave+disp_x(i-1+k,j-2+l)
              y_ave=y_ave+disp_y(i-1+k,j-2+l)
              idx=idx+1
            endif
          enddo
        enddo
        if (idx/=0) then
          disp_x(i,j)=x_ave/dble(idx)
          disp_y(i,j)=y_ave/dble(idx)
 !         ccc(i,j)=0
          flag(i,j)=4
        else
 !         ccc(i,j)=0
          flag(i,j)=44
        endif
      endif
    enddo
  enddo

  !! top right
  do j=1,1
    do i=nvec_x,nvec_x
      if (mod(int(flag(i,j)),2)==0) then
        idx=0
        x_ave=0.d0
        y_ave=0.d0
        do l=1,2
          do k=1,2
            !            print *, "mod:",mod(int(flag(i-2+k,j-2+l)),2)
            if (mod(int(flag(i-2+k,j-1+l)),2)==1) then
              x_ave=x_ave+disp_x(i-2+k,j-1+l)
              y_ave=y_ave+disp_y(i-2+k,j-1+l)
              idx=idx+1
            endif
          enddo
        enddo
        if (idx/=0) then
          disp_x(i,j)=x_ave/dble(idx)
          disp_y(i,j)=y_ave/dble(idx)
 !         ccc(i,j)=0
          flag(i,j)=4
        else
 !         ccc(i,j)=0
          flag(i,j)=44
        endif
      endif
    enddo
  enddo

  !! bottom right
  do j=nvec_y,nvec_y
    do i=nvec_x,nvec_x
      if (mod(int(flag(i,j)),2)==0) then
        idx=0
        x_ave=0.d0
        y_ave=0.d0
        do l=1,2
          do k=1,2
            !            print *, "mod:",mod(int(flag(i-2+k,j-2+l)),2)
            if (mod(int(flag(i-2+k,j-2+l)),2)==1) then
              x_ave=x_ave+disp_x(i-2+k,j-2+l)
              y_ave=y_ave+disp_y(i-2+k,j-2+l)
              idx=idx+1
            endif
          enddo
        enddo
        if (idx/=0) then
          disp_x(i,j)=x_ave/dble(idx)
          disp_y(i,j)=y_ave/dble(idx)
!          ccc(i,j)=0
          flag(i,j)=4
        else
!          ccc(i,j)=0
          flag(i,j)=44
        endif
      endif
    enddo
  enddo
end subroutine replace_outlier
