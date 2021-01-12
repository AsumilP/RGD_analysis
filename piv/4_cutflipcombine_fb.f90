!cut the lawer side, flip the forward plane, combine f-r
!c--------------------------------------------------c
!c          ( avedevi.f90 + rmvnoise.f90 )          c
!c            imgcor                                c
!c            piv                                   c
!c            get_uv_withcut.f90                    c
!c            rmverrvec_uvcut.f90                   c
!c            stereoscopic.f90                      c
!c   --->     cutflipcombine.f90                    c
!c            rmverrvec_uvwcomb.f90                 c
!c                                                  c
!c              1. search_max.f90                   c
!c                                                  c
!c              2. split_time.f90                   c
!c               2.1 calc_umean_rms.f90             c
!c               2.2 calc_scales_Q.f90              c
!c--------------------------------------------------c
 implicit none

 integer, parameter :: nvec_x_f= 105
 integer, parameter :: nvec_x_b= 114
 integer, parameter :: nvec_x_fit= 105  !lower nvec_x
 integer, parameter :: nvec_y= 124
 integer, parameter :: nz= 21838
 integer, parameter :: cond = 11
 integer, parameter :: origin_height = 46 ![mm] from the bottom, 2*23 by grid 20181218
 integer, parameter :: yorigin= 315 ![px]
 integer, parameter :: imgcut_top_px= 1 ![px]
 integer, parameter :: vec_spc_y_px= 8 ![px]
 real(8), parameter :: img_res_y = 69.00d-3  ! [mm/pixel]

 integer, parameter :: origin_vec_y= int( (yorigin - imgcut_top_px) / vec_spc_y_px ) +1
 integer, parameter :: bottom_vec=  origin_vec_y + int( origin_height / (vec_spc_y_px*img_res_y) )    ! = 126 (20181218) SHOULD NOT BE OUTNUMBERED by nvec_y

 character(*), parameter :: path_of_velof_i = '/home/yatagi/analysis/piv_output/velofield/20190301/piv/fs/'
! character(*), parameter :: path_of_velof_i = '/home/yatagi/analysis/piv_output/velofield/20181218/rmvpiv/fs/'
 character(*), parameter :: path_of_velob_i = '/home/yatagi/analysis/piv_output/velofield/20190301/piv/bs/'
! character(*), parameter :: path_of_velob_i = '/home/yatagi/analysis/piv_output/velofield/20181218/rmvpiv/bs/'
 character(*), parameter :: path_of_velo_o = '/home/yatagi/analysis/piv_output/velofield/20190301/piv/combined/'
! character(*), parameter :: path_of_velo_o = '/home/yatagi/analysis/piv_output/velofield/20181218/rmvpiv/combined/'

!-------------------------------------------------------------------------------
 integer(8) :: i,j,k,l
 character(*) :: file_name_fu_in*200
 character(*) :: file_name_fv_in*200
 character(*) :: file_name_fw_in*200
 character(*) :: file_name_bu_in*200
 character(*) :: file_name_bv_in*200
 character(*) :: file_name_bw_in*200
 character(*) :: file_name_u_out*200
 character(*) :: file_name_v_out*200
 character(*) :: file_name_w_out*200
 character(*) :: ffui*200
 character(*) :: ffvi*200
 character(*) :: ffwi*200
 character(*) :: fbui*200
 character(*) :: fbvi*200
 character(*) :: fbwi*200
 character(*) :: fcuo*200
 character(*) :: fcvo*200
 character(*) :: fcwo*200
 real(8) :: craw1(nvec_x_f,nvec_y,nz)
 real(8) :: craw2(nvec_x_b,nvec_y,nz)
 real(8) :: craw3(nvec_x_fit*2+1,bottom_vec,nz)
 real(8) :: craw4(nvec_x_fit*2+1,nvec_y,nz)

 !------------------------------------------------------------------------------
   craw1=0
   craw2=0
   craw3=0
   craw4=0

  do l=1,cond
  !-----------------input-------------------

    write(file_name_fu_in,"('spiv_fs_',i2.2,'_u.dat')"),l
!    write(file_name_fu_in,"('spiv_fs_',i2.2,'_rmv_u.dat')"),l

    write(file_name_fv_in,"('spiv_fs_',i2.2,'_v.dat')"),l
!    write(file_name_fv_in,"('spiv_fs_',i2.2,'_rmv_v.dat')"),l

    write(file_name_fw_in,"('spiv_fs_',i2.2,'_w.dat')"),l
!    write(file_name_fw_in,"('spiv_fs_',i2.2,'_rmv_w.dat')"),l

    write(file_name_bu_in,"('spiv_bs_',i2.2,'_u.dat')"),l
!    write(file_name_bu_in,"('spiv_bs_',i2.2,'_rmv_u.dat')"),l

    write(file_name_bv_in,"('spiv_bs_',i2.2,'_v.dat')"),l
!    write(file_name_bv_in,"('spiv_bs_',i2.2,'_rmv_v.dat')"),l

    write(file_name_bw_in,"('spiv_bs_',i2.2,'_w.dat')"),l
!    write(file_name_bw_in,"('spiv_bs_',i2.2,'_rmv_w.dat')"),l

 !-----------------output-------------------

    write(file_name_u_out,"('spiv_fbsc_',i2.2,'_u.dat')"),l
!    write(file_name_u_out,"('spiv_fbsc_',i2.2,'_rmv_u.dat')"),l

    write(file_name_v_out,"('spiv_fbsc_',i2.2,'_v.dat')"),l
!    write(file_name_v_out,"('spiv_fbsc_',i2.2,'_rmv_v.dat')"),l

    write(file_name_w_out,"('spiv_fbsc_',i2.2,'_w.dat')"),l
!    write(file_name_w_out,"('spiv_fbsc_',i2.2,'_rmv_w.dat')"),l

    ffui = path_of_velof_i//file_name_fu_in
    ffvi = path_of_velof_i//file_name_fv_in
    ffwi = path_of_velof_i//file_name_fw_in
    fbui = path_of_velob_i//file_name_bu_in
    fbvi = path_of_velob_i//file_name_bv_in
    fbwi = path_of_velob_i//file_name_bw_in
    fcuo = path_of_velo_o//file_name_u_out
    fcvo = path_of_velo_o//file_name_v_out
    fcwo = path_of_velo_o//file_name_w_out

    print *,'Condition number =',l

!------------------------------------ u --------------------------------------

    write(*,*) 'now reading velocity data u...'

    write(*,*) ffui
    open(15,file=ffui,form='binary')
    read(15) craw1
    close(15)

    write(*,*) fbui
    open(25,file=fbui,form='binary')
    read(25) craw2
    close(25)

    write(*,*) 'now combining velocity data u...'

    if (bottom_vec .le. nvec_y)  then !  bottom_vec <= nvec_y

      do k=1,nz
        do j=1,bottom_vec
          do i=1,nvec_x_fit
            craw3(i,j,k) = -1*craw1(nvec_x_fit-i+1,j,k)
          enddo
        enddo
      enddo

      do k=1,nz
        do j=1,bottom_vec
          do i=1,nvec_x_fit
            craw3(nvec_x_fit+1+i,j,k) = craw2(i,j,k)
          enddo
        enddo
      enddo

      do k=1,nz
        do j=1,bottom_vec
          craw3(nvec_x_fit+1,j,k) = 0.5*(craw3(nvec_x_fit,j,k)+craw3(nvec_x_fit+2,j,k))
        enddo
      enddo


      write(*,*) 'now saving u, bottom_vec'

      write(*,*) fcuo
      open(35, file=fcuo,form='binary')
      write(35) craw3
      close(35)

    else

      do k=1,nz
        do j=1,nvec_y
          do i=1,nvec_x_fit
            craw4(i,j,k) = -1*craw1(nvec_x_fit-i+1,j,k)
          enddo
        enddo
      enddo

      do k=1,nz
        do j=1,nvec_y
          do i=1,nvec_x_fit
            craw4(nvec_x_fit+1+i,j,k) = craw2(i,j,k)
          enddo
        enddo
      enddo

      do k=1,nz
        do j=1,nvec_y
          craw4(nvec_x_fit+1,j,k) = 0.5*(craw4(nvec_x_fit,j,k)+craw4(nvec_x_fit+2,j,k))
        enddo
      enddo

      write(*,*) 'now saving u, nvec_y'

      write(*,*) fcuo
      open(35, file=fcuo,form='binary')
      write(35) craw4
      close(35)

    end if

!------------------------------------ v --------------------------------------
     write(*,*) 'now reading velocity data v...'

     write(*,*) ffvi
     open(45,file=ffvi,form='binary')
     read(45) craw1
     close(45)

     write(*,*) fbvi
     open(55,file=fbvi,form='binary')
     read(55) craw2
     close(55)

     write(*,*) 'now combining velocity data v...'

    if (bottom_vec .le. nvec_y)  then !  bottom_vec <= nvec_y

       do k=1,nz
         do j=1,bottom_vec
           do i=1,nvec_x_fit
             craw3(i,j,k) = -1*craw1(nvec_x_fit-i+1,j,k)
           enddo
         enddo
       enddo

       do k=1,nz
         do j=1,bottom_vec
           do i=1,nvec_x_fit
             craw3(nvec_x_fit+1+i,j,k) = -1*craw2(i,j,k)
           enddo
         enddo
       enddo

       do k=1,nz
         do j=1,bottom_vec
           craw3(nvec_x_fit+1,j,k) = 0.5*(craw3(nvec_x_fit,j,k)+craw3(nvec_x_fit+2,j,k))
         enddo
       enddo

       write(*,*) 'now saving v, bottom_vec'

       write(*,*) fcvo
       open(65, file=fcvo,form='binary')
       write(65) craw3
       close(65)

     else

       do k=1,nz
         do j=1,nvec_y
           do i=1,nvec_x_fit
             craw4(i,j,k) = -1*craw1(nvec_x_fit-i+1,j,k)
           enddo
         enddo
       enddo

       do k=1,nz
         do j=1,nvec_y
           do i=1,nvec_x_fit
             craw4(nvec_x_fit+1+i,j,k) = -1*craw2(i,j,k)
           enddo
         enddo
       enddo

       do k=1,nz
         do j=1,nvec_y
           craw4(nvec_x_fit+1,j,k) = 0.5*(craw4(nvec_x_fit,j,k)+craw4(nvec_x_fit+2,j,k))
         enddo
       enddo

       write(*,*) 'now saving v, nvec_y'

       write(*,*) fcvo
       open(65, file=fcvo,form='binary')
       write(65) craw4
       close(65)

     end if

!------------------------------------ w --------------------------------------
     write(*,*) 'now reading velocity data w...'

     write(*,*) ffwi
     open(75,file=ffwi,form='binary')
     read(75) craw1
     close(75)

     write(*,*) fbwi
     open(85,file=fbwi,form='binary')
     read(85) craw2
     close(85)

     write(*,*) 'now combining velocity data w...'

    if (bottom_vec .le. nvec_y)  then !  bottom_vec <= nvec_y

       do k=1,nz
         do j=1,bottom_vec
           do i=1,nvec_x_fit
             craw3(i,j,k) = -1*craw1(nvec_x_fit-i+1,j,k)
           enddo
         enddo
       enddo

       do k=1,nz
         do j=1,bottom_vec
           do i=1,nvec_x_fit
             ! craw3(nvec_x_fit+1+i,j,k) = craw2(i,j,k)
             craw3(nvec_x_fit+1+i,j,k) = -1*craw2(i,j,k)
           enddo
         enddo
       enddo

       do k=1,nz
         do j=1,bottom_vec
           craw3(nvec_x_fit+1,j,k) = 0.5*(craw3(nvec_x_fit,j,k)+craw3(nvec_x_fit+2,j,k))
         enddo
       enddo

       write(*,*) 'now saving w, bottom_vec'

       write(*,*) fcwo
       open(95, file=fcwo,form='binary')
       write(95) craw3
       close(95)

     else

       do k=1,nz
         do j=1,nvec_y
           do i=1,nvec_x_fit
             craw4(i,j,k) = -1*craw1(nvec_x_fit-i+1,j,k)
           enddo
         enddo
       enddo

       do k=1,nz
         do j=1,nvec_y
           do i=1,nvec_x_fit
             ! craw4(nvec_x_fit+1+i,j,k) = craw2(i,j,k)
             craw4(nvec_x_fit+1+i,j,k) = -1*craw2(i,j,k)
           enddo
         enddo
       enddo

       do k=1,nz
         do j=1,nvec_y
           craw4(nvec_x_fit+1,j,k) = 0.5*(craw4(nvec_x_fit,j,k)+craw4(nvec_x_fit+2,j,k))
         enddo
       enddo

       write(*,*) 'now saving w, nvec_y'

       write(*,*) fcwo
       open(95, file=fcwo,form='binary')
       write(95) craw4
       close(95)

     end if

  enddo

  write(*,*) 'Operated Correctly!'
  print *,'nvec_x_fit_dbl+1 =',2*nvec_x_fit+1
  print *,'nvec_y =',nvec_y
  print *,'bottom_vec =',bottom_vec

  stop
  end
