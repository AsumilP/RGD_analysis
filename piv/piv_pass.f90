!< \brief piv pass
!! @param [in] img1 image 1
!! @param [in] img2 image 2
subroutine piv_pass( img1,img2,niw_xl,niw_yl, &
xi_piv,yi_piv,disp_x,disp_y,ccc,flag,pass_idx)
  use piv_const
  use piv_param
  use piv_vars
  implicit none
  real(8), intent(in):: img1(inx,iny)
  real(8), intent(in):: img2(inx,iny)
  integer, intent(in):: niw_xl,niw_yl
  real(8), intent(in):: xi_piv(nvec_x)
  real(8), intent(in):: yi_piv(nvec_y)
  real(8), intent(inout):: disp_x(nvec_x,nvec_y)
  real(8), intent(inout):: disp_y(nvec_x,nvec_y)
  real(8), intent(out):: ccc(nvec_x,nvec_y)
  integer(8), intent(out):: flag(nvec_x,nvec_y)
  integer, intent(in):: pass_idx

  integer,parameter:: rank=3 !< how many highest peaks of correlations are kept
  integer:: idx_nvx,idx_nvy
  integer:: imax(rank),jmax(rank)
  integer(8)::flag_s(rank)
  real(8):: pmax(rank),xs(rank),ys(rank)

  real(8),allocatable :: iw1(:,:)
  real(8),allocatable :: iw2(:,:)
  real(8),allocatable :: ixcorr(:,:)

  real(8),allocatable :: disp_x_n(:,:,:)
  real(8),allocatable :: disp_y_n(:,:,:)
  real(8),allocatable :: ccc_n(:,:,:)
  integer(8),allocatable :: flag_n(:,:,:)

  integer :: i
  integer :: xi_shift, yi_shift
  integer :: niw_xx, niw_yy

  ccc(1:nvec_x,1:nvec_y)=0.d0
  flag(1:nvec_x,1:nvec_y)=0

  allocate(disp_x_n(nvec_x,nvec_y,rank))
  allocate(disp_y_n(nvec_x,nvec_y,rank))
  allocate(ccc_n(nvec_x,nvec_y,rank))
  allocate(flag_n(nvec_x,nvec_y,rank))

!  # ifdef debug
!  print *, "xi_piv(1):", xi_piv(1)
!  print *, "yi_piv(1):", yi_piv(1)
!  # endif

  niw_xx=niw_xl
  niw_yy=niw_yl

! double loop for velocity vectors in piv plane
  do idx_nvy=1,nvec_y
    do idx_nvx=1,nvec_x
      if (pass_idx == n_pass .and. m_piv_grid == 2) then
        niw_xx=niw_x_final(idx_nvx)
        niw_yy=niw_y_final(idx_nvy)
      endif

      allocate(iw1(niw_xx,niw_yy))
      allocate(iw2(niw_xx,niw_yy))
      allocate(ixcorr(niw_xx,niw_yy))

      ixcorr(1:niw_xx,1:niw_yy)=0.d0
      call compute_shift_i(disp_x(idx_nvx,idx_nvy),disp_y(idx_nvx,idx_nvy),xi_shift,yi_shift)

      call prepare_iw (img1,inx,iny,iw1,niw_xx,niw_yy,&
      xi_piv(idx_nvx),yi_piv(idx_nvy),-xi_shift,-yi_shift)

      call prepare_iw (img2,inx,iny,iw2,niw_xx,niw_yy,&
      xi_piv(idx_nvx),yi_piv(idx_nvy),xi_shift,yi_shift)

# ifdef debug
 if (pass_idx==3.and.idx_nvy==41.and.idx_nvx==41) then
    open(100,file='ixcorr1',access='stream')
    write(100) ixcorr
    close(100)
        open(100,file='iw1',access='stream')
    write(100) iw1
    close(100)
        open(100,file='iw2',access='stream')
    write(100) iw2
    close(100)
  endif
# endif

      if (niw_xx==niw_yy) then
        call cross_correlate_fft_mt(iw1,iw2,niw_xx,ixcorr)
      else
        call cross_correlate_fft_rect_slow(iw1,iw2,niw_xx,niw_yy,ixcorr)
      endif

# ifdef debug
 if (pass_idx==3.and.idx_nvy==41.and.idx_nvx==41) then
    open(100,file='ixcorr2',access='stream')
    write(100) ixcorr
    close(100)
  endif
# endif

      call detect_peak_corr_map(ixcorr,niw_xx,niw_yy,imax,jmax,pmax,xs,ys,rank,flag_s)

      do i=1,rank
        if(mod(int(flag_s(i)),2)==1) then ! odd flag means good sign;)
          if (opt_sub_px == SUB_PX_GAUSSIAN_1D) then
            call subpixel_gaussian(ixcorr,niw_xx,niw_yy,imax(i),jmax(i),xs(i),ys(i))
          elseif (opt_sub_px == SUB_PX_GAUSSIAN_2D) then
            call subpixel_gaussian_2d(ixcorr,niw_xx,niw_yy,imax(i),jmax(i),xs(i),ys(i))
          elseif (opt_sub_px == SUB_PX_NONE) then
              print *,"warning: sub pixel interpolation is omitted"
              xs(:)=0.d0
              ys(:)=0.d0
          endif
        endif
        disp_x_n(idx_nvx,idx_nvy,i)=xs(i)-2.d0*xi_shift ! xi_shift doubled because of both windows shifting
        disp_y_n(idx_nvx,idx_nvy,i)=ys(i)-2.d0*yi_shift ! yi_shift doubled because of both windows shifting
        ccc_n(idx_nvx,idx_nvy,i)=pmax(i)
        flag_n(idx_nvx,idx_nvy,i)=flag_s(i)
      enddo


    deallocate(iw1)
    deallocate(iw2)
    deallocate(ixcorr)

    enddo
  enddo

  call remove_outlier( disp_x_n,disp_y_n,ccc_n,flag_n,disp_x,disp_y,ccc,flag,nvec_x,nvec_y,rank)


  deallocate(disp_x_n)
  deallocate(disp_y_n)
  deallocate(ccc_n)
  deallocate(flag_n)

end subroutine piv_pass
