program imgcor
  use param
  implicit none
  integer(1) :: img_head(head_size)


  integer, parameter :: order = 3 ! only odd number

  integer :: i,j,k,l,m
  integer(2) :: raw_int(nx, ny)           !-----------------
!  real(8) :: raw_int(nx, ny)
  
  real(8) :: raw_w(order+1, order+1)
  
  real(8) :: raw_real(nx,ny)
  real(8) :: raw_tmp(nx,ny)
  
  integer(2) :: cor_int(nx_cor,ny_cor)     !--------------------
!  real(8) :: cor_int(nx_cor,ny_cor)
  real(8) :: cor_int_mean(nx_cor,ny_cor)
  real(8) :: coe_vector(ndim, nterm+1)
  real(8) :: x_img
  real(8) :: y_img
  real(8) :: x(order+1)
  real(8) :: y(order+1)
  real(8) :: xi(1)
  real(8) :: yi(1)
  real(8) :: raw_i(1,1)
  
  real(8) :: x_phys
  real(8) :: y_phys

  character(*),parameter :: fcoei=path_of_coe//file_name_coe_r
  character(*),parameter :: frawi=path_of_particle_raw//file_name_rawi//file_ext_rawi
  character(*),parameter :: frawo = path_of_particle_corrected//file_name_rawo//file_ext_rawo
  character(*),parameter :: fmean = path_of_particle_corrected//file_name_rawmean//file_ext_rawo
  
  ! display parameters                                                   c
  write(*,*) 'nx:', nx
  write(*,*) 'ny:', ny
  write(*,*) 'nnx:', nx_cor
  write(*,*) 'nny:', ny_cor
  write(*,*) 'x_0:', imgloc_physorig_x
  write(*,*) 'y_0:', imgloc_physorig_y
  write(*,*) 'ndata:', nimg_per_file
  write(*,*) 'resolutionx:', img_res_x
  write(*,*) 'resolutiony:', img_res_y
  write(*,*)

  ! input coefficients of mapping functions and raw data
  ! read mappfing function coef
      write(*,*) fcoei
      open(10, file=fcoei)
      do l=1, ndim
        do i=1, nterm+1
        read(10,*) coe_vector(l,i)
      enddo
      read(10,*)
      enddo
      close(10)

  ! open INPUT raw img file
      write(*,*) frawi
      open(20, file=frawi, form='binary')
      if (head_size/=0) then
      read(20) img_head
      endif

  ! open OUTPUT corrected img file
      write(*,*) frawo
      cor_int_mean(1:nx_cor,1:ny_cor) = 0.d0
      open(30, file=frawo, form='binary')

      do k=1,nimg_per_file             !-------------------------------------------------
        raw_int(1:nx,1:ny) = 0
        raw_real(1:nx,1:ny) = 0.d0
        raw_tmp(1:nx,1:ny) = 0.d0
        cor_int(1:nx_cor,1:ny_cor) = 0
        raw_i(1,1) = 0.d0

        read(20) raw_int
        raw_real(1:nx,1:ny)=dble(raw_int(1:nx,1:ny))

        if(xflip) then
          raw_tmp(1:nx,1:ny) = raw_real(nx:1:-1,1:ny)
          raw_real(1:nx,1:ny)=raw_tmp(1:nx,1:ny)
        endif

        if(yflip) then
          raw_tmp(1:nx,1:ny) = raw_real(1:nx,ny:1:-1)
          raw_real(1:nx,1:ny)=raw_tmp(1:nx,1:ny)
        endif
 
        do j=1, ny_cor
          do i=1, nx_cor
        ! coordinate of object plane
            x_phys = dble(i - imgloc_physorig_x)*img_res_x
            y_phys = dble(j - imgloc_physorig_y)*img_res_y

        call get_imgcoord(x_phys,y_phys,coe_vector,ndim,nterm,x_img,y_img)

        ! out of image
        if(x_img-order/2 < 1.or.x_img+order/2 > nx) cycle
        if(y_img-order/2 < 1.or.y_img+order/2 > ny) cycle

        ! get intensity
        do l=1, order + 1
          do m=1, order + 1
            x(m)=m-order/2-1
            y(l)=l-order/2-1
            raw_w(m,l) = raw_real(floor(x_img)+m-order/2-1,floor(y_img)+l-order/2-1)
          enddo
        enddo
        xi=x_img-floor(x_img)
        yi=y_img-floor(y_img)

        call lagrange_2d_xiyi(raw_w,x,y,order+1,order+1,raw_i,xi,yi,1,1)

        if(raw_i(1,1) < 0.0d0) then
          raw_i(1,1) = 0.0d0
        endif

        cor_int(i,j) = idnint(raw_i(1,1))
        cor_int_mean(i,j) = cor_int_mean(i,j)+dble(cor_int(i,j))/dble(nimg_per_file)

      enddo
      enddo
      write(30) cor_int
      enddo                   !-------------------------

      close(20)
      close(30)
  
      !write(*,*) fmean
  
      !open(40, file=fmean, form='binary')
      !  write(40) cor_int_mean
      !close(40)

end program imgcor
