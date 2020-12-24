! Detect cross points on image
! Define physical coordinate on them
! Compute mapping function (currently 2nd order)
program ls
  use param
  implicit none
  real(8),parameter:: mindist_px=15.d0 ! px
  integer, parameter:: nconquer=100
  integer, parameter:: nrank = 8
  real(8),parameter:: eps=10.d0*epsilon(1.d0)
  real(8),parameter:: fac=1.5d0
  real(8),parameter:: thres_same_x=5.d0 ! px
  real(8),parameter:: thres_same_y=5.d0 ! px
  character(*),parameter:: fccci=path_of_grid_ccc//file_name_ccc
  character(*),parameter:: fcccoi=path_of_grid_ccc//file_name_ccco
  character(*),parameter:: fcoeo=path_of_coe//file_name_coe
  character(*),parameter:: fdebug=path_of_coe//file_name_head//'_point_detected.dat'

  integer:: n_nei_found
  logical:: islmax
  real(8):: ccc(nx, ny)
  real(8):: ccco(nx, ny)
  real(8):: dx
  real(8):: dy
  real(8):: x_ls_mean(nterm)
  real(8):: y_ls_mean(ndim)
  real(8):: cov_matrix(ndim, nterm, nterm)
  real(8):: cov_vector(ndim, nterm)
  real(8):: coe_vector(ndim, nterm+1)
  real(8):: aa(nterm, nterm+1)
  integer:: i
  integer:: j
  integer:: k
  integer:: l
  real(8):: ximap,yimap,l2norm
  real(8),allocatable:: x_ls(:,:) !x_ls(nterm,npoint)
  real(8),allocatable:: y_ls(:,:) !y_ls(ndim,npoint)
  real(8),allocatable:: x_crs_img_tmp(:)
  real(8),allocatable:: y_crs_img_tmp(:)



  real(8),allocatable:: x_crs_phys_tmp(:)
  real(8),allocatable:: y_crs_phys_tmp(:)
  real(8),allocatable:: x_crs_img(:)
  real(8),allocatable:: y_crs_img(:)
  real(8),allocatable:: x_crs_phys(:)
  real(8),allocatable:: y_crs_phys(:)
  integer,allocatable:: flag_phys_done(:)
  real(8),allocatable:: dist_x(:,:)
  real(8),allocatable:: dist_y(:,:)
  real(8),allocatable:: dist(:,:)
  integer:: crs_idx, nmark_tmp, nmark,nmark_tmp2
  real(8):: min_dist(nrank),min_x(nrank),min_y(nrank)
  integer:: min_idx(nrank)
  integer,allocatable::relpos_idx_n(:)
  integer,allocatable::relpos_idx_s(:)
  integer,allocatable::relpos_idx_e(:)
  integer,allocatable::relpos_idx_w(:)

  write(*,*) fccci
  open(10, file=fccci,form='binary')
  read(10) ccc
  close(10)

  write(*,*) fcccoi
  open(20, file=fcccoi, form='binary')
  read(20) ccco
  close(20)

  print *, "threshold=", threshold
  print *, "threshold_o=", threshold_o

! count local max as candidates for cross center
  nmark_tmp = 1
  do j=2, ny-1
    do i=2, nx-1
      if(ccc(i,j)>threshold) then
        call local_max(ccc,i,j,nx,ny,islmax)
        if(islmax) then
          nmark_tmp=nmark_tmp+1
        endif
      endif
    enddo
  enddo
  print *, "N# candidate of cross: ", nmark_tmp

  allocate(x_crs_img_tmp(nmark_tmp))
  allocate(y_crs_img_tmp(nmark_tmp))

  crs_idx = 1
  !< todo change it to see all pixels throw error if multiple origin is detected
 ! do j=2, ny-1 !l93 changed in 20181006
   do j=49, 932
   ! do i=2, nx-1 !l94 changed in 20181006
     do i=30, 974
       if(ccco(i,j)>threshold_o) then
        call local_max(ccco,i,j,nx,ny,islmax)
        if(islmax)then
          call local_max_sub(i,j,ccco,nx,ny,dx,dy)
          x_crs_img_tmp(crs_idx)=dble(i)+dx
          y_crs_img_tmp(crs_idx)=dble(j)+dy
          crs_idx=crs_idx+1
        endif
      endif
    enddo
  enddo
  if(crs_idx/=2)then
    if(debug>0)then
      print *, "ERROR !origin is not correctly defined!"
      print *, "crs_idx: ", crs_idx
    endif
    stop
  endif
  write(*,*) 'origin:', x_crs_img_tmp(1), y_crs_img_tmp(1)

  ! do j=2, ny-1
   do j=49, 932
   ! do i=2, nx-1
     do i=30, 974
      if(ccc(i,j)>threshold) then
        call local_max(ccc,i,j,nx,ny,islmax)
        if(islmax) then
          call local_max_sub(i,j,ccc,nx,ny,dx,dy)
          x_crs_img_tmp(crs_idx)=dble(i)+dx
          y_crs_img_tmp(crs_idx)=dble(j)+dy
          crs_idx=crs_idx+1
        endif
      endif
    enddo
  enddo

! create distance matrix like train fare table
  allocate(dist_x(nmark_tmp,nmark_tmp))
  allocate(dist_y(nmark_tmp,nmark_tmp))
  allocate(dist(nmark_tmp,nmark_tmp))
  do j=1,nmark_tmp
    do i=1,nmark_tmp
      dist_x(i,j) = x_crs_img_tmp(i)-x_crs_img_tmp(j)
      dist_y(i,j) = y_crs_img_tmp(i)-y_crs_img_tmp(j)
      dist(i,j) = sqrt( dist_x(i,j)**2.d0 + dist_y(i,j)**2.d0 ) ! you will see beautiful pattern if you plot this!
    enddo
  enddo

! index array of north|south|east|west of each point
  allocate(relpos_idx_n(nmark_tmp))
  allocate(relpos_idx_s(nmark_tmp))
  allocate(relpos_idx_e(nmark_tmp))
  allocate(relpos_idx_w(nmark_tmp))
  relpos_idx_n(1:nmark_tmp)=0
  relpos_idx_s(1:nmark_tmp)=0
  relpos_idx_e(1:nmark_tmp)=0
  relpos_idx_w(1:nmark_tmp)=0
  do j=1,nmark_tmp
    min_dist(1:nrank)=huge(1.d0)
    do i=1,nmark_tmp
      do k=1,nrank
        if( dist(i,j) < min_dist(k) .and. dist(i,j)>eps ) then
          do l=nrank,k+1,-1 ! shift ranking
            min_dist(l)=min_dist(l-1)
            min_x(l)=min_x(l-1)
            min_y(l)=min_y(l-1)
            min_idx(l)=min_idx(l-1)
          enddo
          min_dist(k)=dist(i,j) ! insert new record
          min_x(k)=x_crs_img_tmp(i)-x_crs_img_tmp(j)
          min_y(k)=y_crs_img_tmp(i)-y_crs_img_tmp(j)
          min_idx(k)=i
          exit ! escape when one element of min_dist is replaced
        endif
      enddo
    enddo
    ! here neighbours of j-th cross are sorted based on the distance

    ! try to find north neighbour
    n_nei_found=0
    do k=1,nrank
      if(abs(min_x(k)) < thres_same_x.and. &
      min_y(k)>0.and. &
      abs(min_dist(k)) < fac*minval(min_dist).and. &
      abs(min_dist(k)) > mindist_px) then ! [todo] check minimum distance may also be necessary.
        relpos_idx_n(j)=min_idx(k)
        n_nei_found=n_nei_found+1
      endif
    enddo
    if (n_nei_found==0) then
      if(debug>2)then; print *, "no north neighbor detected", x_crs_img_tmp(j), y_crs_img_tmp(j); endif
      relpos_idx_n(j)=-1
    elseif (n_nei_found>1) then
      if(debug>0)then; print *, "more than 1 north neighbor detected"; endif
      relpos_idx_n(j)=-1
!      stop
    endif

    ! south
    n_nei_found=0
    do k=1,nrank
      if(abs(min_x(k)) < thres_same_x.and. &
      min_y(k)<0.and. &
      abs(min_dist(k)) < fac*minval(min_dist) .and. &
      abs(min_dist(k)) > mindist_px) then
        relpos_idx_s(j)=min_idx(k)
        n_nei_found=n_nei_found+1
      endif
    enddo
    if (n_nei_found==0) then
      if(debug>2)then; print *, "no south neighbor detected", x_crs_img_tmp(j), y_crs_img_tmp(j); endif
      relpos_idx_s(j)=-1
    elseif (n_nei_found>1) then
      if(debug>0)then;print *, "more than 1 south neighbor detected";endif
      relpos_idx_s(j)=-1
!      stop
    endif

    ! east
    n_nei_found=0
    do k=1,nrank
      if(abs(min_y(k)) < thres_same_y.and. &
      min_x(k)>0.and. &
      abs(min_dist(k)) < fac*minval(min_dist).and. &
      abs(min_dist(k)) > mindist_px) then
        relpos_idx_e(j)=min_idx(k)
        n_nei_found=n_nei_found+1
      endif
    enddo
    if (n_nei_found==0) then
      if(debug>2)then; print *, "no east neighbor detected", x_crs_img_tmp(j), y_crs_img_tmp(j); endif
      relpos_idx_e(j)=-1
    elseif (n_nei_found>1) then
      if(debug>0)then;print *, "more than 1 east neighbor detected";endif
      relpos_idx_e(j)=-1
!      stop
    endif

    ! west
    n_nei_found=0
    do k=1,nrank
      if(abs(min_y(k)) < thres_same_y.and. &
      min_x(k)<0.and. &
      abs(min_dist(k)) < fac*minval(min_dist).and.&
      abs(min_dist(k)) > mindist_px) then
        relpos_idx_w(j)=min_idx(k)
        n_nei_found=n_nei_found+1
      endif
    enddo
    if (n_nei_found==0) then
      if(debug>2)then; print *, "no west neighbor detected", x_crs_img_tmp(j), y_crs_img_tmp(j); endif
      relpos_idx_w(j)=-1
    elseif (n_nei_found>1) then
      if(debug>0)then;print *, "more than 1 west neighbor detected";endif
      relpos_idx_w(j)=-1
!      stop
    endif
  enddo



  ! determine physical coordinate
  allocate(x_crs_phys_tmp(nmark_tmp))
  allocate(y_crs_phys_tmp(nmark_tmp))
  allocate(flag_phys_done(nmark_tmp)) ! flag indicating the physical coordinate is already determined

  x_crs_phys_tmp(1:nmark_tmp)=huge(1.d0)
  y_crs_phys_tmp(1:nmark_tmp)=huge(1.d0)
  flag_phys_done(1:nmark_tmp)=999 ! flag 999 means undetermined

! define the origin
  x_crs_phys_tmp(1)=0.d0
  y_crs_phys_tmp(1)=0.d0
  flag_phys_done(1)=1 ! flag 1 means determined

! physical coordinate of neighbors (NSEW) is set recursively (if it exists)
! based on the physical position of myself
  do j=1,nconquer ! recursive!
    do i=1,nmark_tmp
      if (flag_phys_done(i)==1) then
        if (relpos_idx_n(i)>0) then
          x_crs_phys_tmp(relpos_idx_n(i))=x_crs_phys_tmp(i)
          y_crs_phys_tmp(relpos_idx_n(i))=y_crs_phys_tmp(i)+grid_interval
          flag_phys_done(relpos_idx_n(i))=1
        endif
        if (relpos_idx_s(i)>0) then
          x_crs_phys_tmp(relpos_idx_s(i))=x_crs_phys_tmp(i)
          y_crs_phys_tmp(relpos_idx_s(i))=y_crs_phys_tmp(i)-grid_interval
          flag_phys_done(relpos_idx_s(i))=1
        endif
        if (relpos_idx_e(i)>0) then
          x_crs_phys_tmp(relpos_idx_e(i))=x_crs_phys_tmp(i)+grid_interval
          y_crs_phys_tmp(relpos_idx_e(i))=y_crs_phys_tmp(i)
          flag_phys_done(relpos_idx_e(i))=1
        endif
        if (relpos_idx_w(i)>0) then
          x_crs_phys_tmp(relpos_idx_w(i))=x_crs_phys_tmp(i)-grid_interval
          y_crs_phys_tmp(relpos_idx_w(i))=y_crs_phys_tmp(i)
          flag_phys_done(relpos_idx_w(i))=1
        endif
      endif
    enddo
  enddo

  nmark=0
  do i=1,nmark_tmp
    if (flag_phys_done(i)==1) then
      nmark=nmark+1
    endif
  enddo

  allocate(x_crs_img(nmark))
  allocate(y_crs_img(nmark))
  allocate(x_crs_phys(nmark))
  allocate(y_crs_phys(nmark))

  k=0
  do i=1,nmark_tmp
    if (flag_phys_done(i)==1) then
      k=k+1
      x_crs_img(k)=x_crs_img_tmp(i)
      y_crs_img(k)=y_crs_img_tmp(i)
      x_crs_phys(k)=x_crs_phys_tmp(i)
      y_crs_phys(k)=y_crs_phys_tmp(i)
    endif
  enddo

  print *, "k=",k
  print *, "nmark=", nmark





! solve linear system for the mapping coefficient
! [todo] name of variables are bloody misunderstandable, chenge'em
  allocate(x_ls(nterm,nmark))
  allocate(y_ls(ndim,nmark))
  x_ls(1:nterm,1:nmark) = 0.0d0
  y_ls(1:ndim,1:nmark) = 0.0d0
  x_ls_mean(1:nterm) = 0.0d0
  y_ls_mean(1:ndim) = 0.0d0
  cov_matrix(1:ndim,1:nterm,1:nterm) = 0.0d0
  cov_vector(1:ndim,1:nterm) = 0.0d0
  coe_vector(1:ndim,1:nterm+1) = 0.0d0

  call get_pixel_resolution(x_crs_phys,y_crs_phys,x_crs_img,y_crs_img,nmark)

  open(222, file=fdebug,form='binary')
      write(222) x_crs_phys,y_crs_phys,x_crs_img,y_crs_img
  close(222)

  do k = 1,nmark
    !x_ls(1,k) = x_crs_phys(k)**2
    !x_ls(2,k) = y_crs_phys(k)**2
    !x_ls(3,k) = x_crs_phys(k)*y_crs_phys(k)
    !x_ls(4,k) = x_crs_phys(k)
    !x_ls(5,k) = y_crs_phys(k)

	x_ls(1,k) = x_crs_phys(k)**4
	x_ls(2,k) = y_crs_phys(k)**4
	x_ls(3,k) = (x_crs_phys(k)**3)*y_crs_phys(k)
	x_ls(4,k) = x_crs_phys(k)*(y_crs_phys(k)**3)
	x_ls(5,k) = (x_crs_phys(k)**2)*(y_crs_phys(k)**2)

	x_ls(6,k) = x_crs_phys(k)**3

	x_ls(7,k) = y_crs_phys(k)**3

	x_ls(8,k) = (x_crs_phys(k)**2)*y_crs_phys(k)
	x_ls(9,k) = x_crs_phys(k)*(y_crs_phys(k)**2)

	x_ls(10,k) = x_crs_phys(k)**2
	x_ls(11,k) = y_crs_phys(k)**2
	x_ls(12,k) = x_crs_phys(k)*y_crs_phys(k)

	x_ls(13,k) = x_crs_phys(k)
    x_ls(14,k) = y_crs_phys(k)

    y_ls(1,k) = x_crs_img(k)
    y_ls(2,k) = y_crs_img(k)
!    write(*,'(f9.2,f9.2,f9.2,f9.2)') x_crs_phys(k),y_crs_phys(k),x_crs_img(k),y_crs_img(k)
  enddo

  ! calculation of means
  ! [todo] rewrite
  do k=1, nmark
    do i=1, nterm
      x_ls_mean(i) = x_ls_mean(i) + x_ls(i,k)
    enddo
    do i=1, ndim
      y_ls_mean(i) = y_ls_mean(i) + y_ls(i,k)
    enddo
  enddo
  do i=1, nterm
    x_ls_mean(i) = x_ls_mean(i)/dble(nmark)
  enddo
  do i=1, ndim
    y_ls_mean(i) = y_ls_mean(i)/dble(nmark)
  enddo

  ! calculation of covariances
  ! replace this with matrix operation with dgemm
  do l=1, ndim
    do j=1, nterm
      do i=1, nterm
        do k=1, nmark
          cov_matrix(l,i,j) = cov_matrix(l,i,j) + &
          (x_ls(i,k) - x_ls_mean(i))*(x_ls(j,k) - x_ls_mean(j))
        enddo
      enddo
    enddo
  enddo
  do l=1, ndim
    do i=1, nterm
      do k=1, nmark
        cov_vector(l,i) = cov_vector(l,i) + &
        (x_ls(i,k) - x_ls_mean(i))*(y_ls(l,k) - y_ls_mean(l))
      enddo
    enddo
  enddo

  ! calculation of simultaneous linear equations
  do l=1, ndim
    do j=1, nterm
      do i=1, nterm
        aa(i,j) = cov_matrix(l,i,j)
      enddo
    enddo
    do i=1, nterm
      aa(i, nterm+1) = cov_vector(l,i)
    enddo

    call gauss(nterm, aa)

    do i=1, nterm
      coe_vector(l,i) = aa(i, nterm+1)
    enddo
  enddo

  ! calculation of constant term
  do l=1, ndim
    coe_vector(l,nterm+1) = y_ls_mean(l)
    do i=1, nterm
      coe_vector(l,nterm+1) = coe_vector(l,nterm+1) &
      - coe_vector(l,i)*x_ls_mean(i)
    enddo
  enddo

  write(*,*) 'coefficient of mapping functions.'
  do l=1, ndim
    do i=1, nterm+1
      write(*,'(e15.6)') coe_vector(l,i)
    enddo
    write(*,*)
  enddo

  l2norm=0.d0
  do i=1,nmark
    call get_imgcoord(x_crs_phys(i),y_crs_phys(i),coe_vector,ndim,nterm,ximap,yimap)
    l2norm=l2norm + sqrt((ximap-x_crs_img(i))**2+(yimap-y_crs_img(i))**2)/nmark
  enddo
  print '(A,f6.2,A)', " l2norm of mapping: ", l2norm, " [px]"

  print *, "coef mapfunc written-->", fcoeo
  open(20, file=fcoeo)
  do l=1, ndim
    do i=1, nterm+1
      write(20,'(e25.10)') coe_vector(l,i)
    enddo
    write(20,*)
  enddo
  close(20)

  deallocate(x_crs_img_tmp)
  deallocate(y_crs_img_tmp)
  deallocate(dist_x)
  deallocate(dist_y)
  deallocate(dist)
  deallocate(relpos_idx_n)
  deallocate(relpos_idx_s)
  deallocate(relpos_idx_e)
  deallocate(relpos_idx_w)
  deallocate(x_crs_phys_tmp)
  deallocate(y_crs_phys_tmp)



  deallocate(flag_phys_done)
  deallocate(x_ls)
  deallocate(y_ls)
  deallocate(x_crs_img)
  deallocate(y_crs_img)
  deallocate(x_crs_phys)
  deallocate(y_crs_phys)

end program ls

! matrix multiplication dgemm having same interface as in L3 blas
subroutine dgemm(transA,transB,m,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
implicit none
character,intent(in):: transA, transB
integer, intent(in):: m,n,k,lda,ldb,ldc
real(8),intent(in):: A(:,:),B(:,:)
real(8),allocatable,intent(out):: C(:,:)
real(8),intent(in):: alpha,beta

allocate(C(m,n))
print *, transA,transB
print *, k,lda,ldb,ldc
print *, alpha,beta
print *, shape(A)
print *, shape(B)
print *, shape(C)

end subroutine dgemm


subroutine get_pixel_resolution(x_crs_phys,y_crs_phys,x_crs_img,y_crs_img,n)
  implicit none
  integer, intent(in):: n
  real(8), intent(in):: x_crs_phys(n)
  real(8), intent(in):: y_crs_phys(n)
  real(8), intent(in):: x_crs_img(n)
  real(8), intent(in):: y_crs_img(n)
  print '(A,f6.2,A)', 'pixel resolution in x:', &
    1d3*(maxval(x_crs_phys)-minval(x_crs_phys))/(maxval(x_crs_img)-minval(x_crs_img)),' um/px'
  print '(A,f6.2,A)', 'pixel resolution in y:', &
    1d3*(maxval(y_crs_phys)-minval(y_crs_phys))/(maxval(y_crs_img)-minval(y_crs_img)),' um/px'

end subroutine get_pixel_resolution

! check if ccc(i,j) is local max or not
! [todo] add routine to check boundary
subroutine local_max(ccc,i,j,nx,ny,islmax)
  implicit none
  integer,intent(in):: i,j,nx,ny
  real(8),intent(in)::ccc(nx,ny)
  logical,intent(out):: islmax

  islmax=.false.

  if(ccc(i,j)>ccc(i-1,j-1).and. &
  ccc(i,j)>ccc(i  ,j-1).and. &
  ccc(i,j)>ccc(i+1,j-1).and. &
  ccc(i,j)>ccc(i-1,j  ).and. &
  ccc(i,j)>ccc(i+1,j  ).and. &
  ccc(i,j)>ccc(i-1,j+1).and. &
  ccc(i,j)>ccc(i  ,j+1).and. &
  ccc(i,j)>ccc(i+1,j+1)) then
    islmax=.true.
  endif
end subroutine local_max

! find subpixel correlation peak by lagrange interpolation
subroutine local_max_sub(ii,jj,ccc,nx,ny,dx,dy)
  implicit none
  integer,intent(in):: ii,jj,nx,ny
  real(8),intent(in):: ccc(nx,ny)
  real(8),intent(out):: dx,dy

  integer, parameter :: order = 4   !ORDER OF INTERPOLATION (even number only)
  integer, parameter :: nxdiv = 40  !N# DIVISION per pixel for subpixel peak finding
  integer, parameter :: nydiv = 40
  integer, parameter :: nxi = nxdiv*order + 1   !number of grid points for interpolated field
  integer, parameter :: nyi = nydiv*order + 1

  integer :: i,j,x_max,y_max
  real(8) :: q_max
  real(8) :: ccc_sub(order+1,order+1)
  real(8) :: ccc_sub_i(nxi,nyi)
  integer :: ofs
  real(8) :: xxl(order+1),yyl(order+1)
  real(8) :: xi(nxi),yi(nyi)

  if (mod(order,2)/=0)then
    print *, "order should be even"
    stop
  endif
  ofs=order/2
  xxl = (/((i),i=-ofs,ofs)/)
  yyl = (/((i),i=-ofs,ofs)/)
  ccc_sub=ccc(ii-ofs:ii+ofs,jj-ofs:jj+ofs)

  call lagrange_2d(ccc_sub,xxl,yyl,order+1,order+1,ccc_sub_i,xi,yi,nxi,nyi)

  q_max = 0.0d0
  x_max = 0
  y_max = 0

  do j=1, nyi
    do i=1, nxi
      if(ccc_sub_i(i,j)>q_max) then
        q_max = ccc_sub_i(i,j)
        x_max = i
        y_max = j
      endif
    enddo
  enddo
  dx = dble(x_max-nxdiv*order/2-1)/dble(nxdiv)
  dy = dble(y_max-nydiv*order/2-1)/dble(nydiv)

end subroutine local_max_sub
