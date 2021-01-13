!stereoscopic PIV,  after rmverrvec
!c--------------------------------------------------c
!c          ( avedevi.f90 + rmvnoise.f90 )          c
!c            imgcor                                c
!c            piv                                   c
!c            get_uv_withcut.f90                    c
!c            rmverrvec_uvcut.f90                   c
!c   --->     stereoscopic.f90                      c
!c            cutflipcombine.f90                    c
!c            rmverrvec_uvwcomb.f90                 c
!c                                                  c
!c              1. search_max.f90                   c
!c                                                  c
!c              2. split_time.f90                   c
!c               2.1 calc_umean_rms.f90             c
!c               2.2 calc_scales_Q.f90              c
!c--------------------------------------------------c
 implicit none

 integer, parameter :: nvec_x_cut= 95  !number of vectors
 integer, parameter :: nvec_y= 124
 integer, parameter :: nz= 21838     !number of vector maps
 real(8), parameter :: x0= 340.0d-3  ![m] distance between z axis and center of lens
 real(8), parameter :: d= 760.0d-3 ![m] distance between measurement plane and center of lens
 real(8), parameter :: img_res_x= 80.00d-6  ! [m/pixel]
 real(8), parameter :: img_res_y= 75.00d-6  ! [m/pixel]
 integer, parameter :: vec_spc_x_px= 8 ![px]
 integer, parameter :: vec_spc_y_px= 8 ![px]
 real(8), parameter :: dt    = 50.0d-6  !(sec)
 integer, parameter :: cond = 11

 character(*), parameter :: path_of_velo_l = '/home/yatagi/analysis/piv_output/velofield/20201214/bl/'
! character(*), parameter :: path_of_velo_l = '/home/yatagi/analysis/piv_output/velofield/20181218/rmvpiv/bl/'
 character(*), parameter :: path_of_velo_r = '/home/yatagi/analysis/piv_output/velofield/20201214/br/'
! character(*), parameter :: path_of_velo_r = '/home/yatagi/analysis/piv_output/velofield/20181218/rmvpiv/br/'
 character(*), parameter :: path_of_velo_o = '/home/yatagi/analysis/piv_output/velofield/20201214/bs/'
! character(*), parameter :: path_of_velo_o = '/home/yatagi/analysis/piv_output/velofield/20181218/rmvpiv/bs/'

 real(8), parameter :: lax= img_res_x*vec_spc_x_px*(nvec_x_cut-1)  ![m] !length of measurement region
 real(8), parameter :: lay= img_res_y*vec_spc_y_px*(nvec_y-1)  ![m] !length of measurement region
 integer(8) :: i,j,k,l
 real(8) :: x,y
 real(8) :: ur(nvec_x_cut,nvec_y,nz),ul(nvec_x_cut,nvec_y,nz),vr(nvec_x_cut,nvec_y,nz),vl(nvec_x_cut,nvec_y,nz)
 real(8) :: dxl(nvec_x_cut,nvec_y),dyl(nvec_x_cut,nvec_y),dxr(nvec_x_cut,nvec_y),dyr(nvec_x_cut,nvec_y)
 real(8) :: dx(nvec_x_cut,nvec_y),dy(nvec_x_cut,nvec_y),dz(nvec_x_cut,nvec_y)
 real(8) :: u(nvec_x_cut,nvec_y),v(nvec_x_cut,nvec_y),w(nvec_x_cut,nvec_y)
 character(*) :: file_name_in_ul*200
 character(*) :: file_name_in_ur*200
 character(*) :: file_name_in_vl*200
 character(*) :: file_name_in_vr*200
 character(*) :: file_name_out_u*200
 character(*) :: file_name_out_v*200
 character(*) :: file_name_out_w*200
 character(*) :: fiul*200
 character(*) :: fiur*200
 character(*) :: fivl*200
 character(*) :: fivr*200
 character(*) :: fous*200
 character(*) :: fovs*200
 character(*) :: fows*200

!---------------------------------------------------------------------
do l=1,cond
  !-----------------input-------------------

  write(file_name_in_ul,"('spiv_bl_',i2.2,'_ucl.dat')"),l
!  write(file_name_in_ul,"('spiv_bl_',i2.2,'_rmv_ucl.dat')"),l

  write(file_name_in_vl,"('spiv_bl_',i2.2,'_vcl.dat')"),l
!  write(file_name_in_vl,"('spiv_bl_',i2.2,'_rmv_vcl.dat')"),l

  write(file_name_in_ur,"('spiv_br_',i2.2,'_ucl.dat')"),l
!  write(file_name_in_ur,"('spiv_br_',i2.2,'_rmv_ucl.dat')"),l

  write(file_name_in_vr,"('spiv_br_',i2.2,'_vcl.dat')"),l
!  write(file_name_in_vr,"('spiv_br_',i2.2,'_rmv_vcl.dat')"),l

 !-----------------output-------------------

  write(file_name_out_u,"('spiv_bs_',i2.2,'_u.dat')"),l
!  write(file_name_out_u,"('spiv_bs_',i2.2,'_rmv_u.dat')"),l

  write(file_name_out_v,"('spiv_bs_',i2.2,'_v.dat')"),l
!  write(file_name_out_v,"('spiv_bs_',i2.2,'_rmv_v.dat')"),l

  write(file_name_out_w,"('spiv_bs_',i2.2,'_w.dat')"),l
!  write(file_name_out_w,"('spiv_bs_',i2.2,'_rmv_w.dat')"),l


   fiul = path_of_velo_l//file_name_in_ul
   fivl = path_of_velo_l//file_name_in_vl
   fiur = path_of_velo_r//file_name_in_ur
   fivr = path_of_velo_r//file_name_in_vr
   fous = path_of_velo_o//file_name_out_u
   fovs = path_of_velo_o//file_name_out_v
   fows = path_of_velo_o//file_name_out_w

  write(*,*) 'now reading velocity data...'

  write(*,*) fiul
  open(15,file=fiul,form='binary')
  read(15) ul
  close(15)

  write(*,*) fivl
  open(25,file=fivl,form='binary')
  read(25) vl
  close(25)

  write(*,*) fiur
  open(35,file=fiur,form='binary')
  read(35) ur
  close(35)

  write(*,*) fivr
  open(45,file=fivr,form='binary')
  read(45) vr
  close(45)

   do k=1,nz

     do j=1,nvec_y
       do i=1,nvec_x_cut
         dxr(i,j)=ur(i,j,k)*dt
         dxl(i,j)=ul(i,j,k)*dt
         dyr(i,j)=vr(i,j,k)*dt
         dyl(i,j)=vl(i,j,k)*dt
       enddo
     enddo

     ! print *,'Condition number =',l
     ! print *,'Number of sheets =',k
     ! write(*,*) 'now determine the displacement in 3-directions...'

       do j=1,nvec_y
         do i=1,nvec_x_cut
           ! x = dble(i-1)/dble(nvec_x_cut)*lax-lax/2.0d0
           ! y = dble(j-1)/dble(nvec_y)*lay-lay/2.0d0

           x = dble(i)*lax/dble(nvec_x_cut-1) - 0.5*lax/dble(nvec_x_cut-1)
           y = lay - dble(j-2)*lay/dble(nvec_y-1)

!           dz(i,j) = d*(dxr(i,j) - dxl(i,j))/((x - x0) + (x - x0))                   ! model 1, model 2
           dz(i,j) = d*(dxr(i,j) - dxl(i,j))/(2*(x - x0) + dxr(i,j) + dxl(i,j))      ! model 3

!           dx(i,j) = 0.5d0*(dxr(i,j) + dxl(i,j))                                     ! model 1
!           dx(i,j) = 0.5d0*(dxr(i,j) + dxl(i,j)) - 2.0d0*dz(i,j)*dz(i,j)*(d**2.0d0+x**2.0d0)**1.5d0 /(d**2.0d0*(d**2.0d0+x**2.0d0)-x**2.0d0*(dz(i,j))**2.0d0)       ! model 2
           dx(i,j) = ((x - x0)*(dxr(i,j) + dxl(i,j)) + 2*dxr(i,j)*dxl(i,j))/(2*(x - x0) + dxr(i,j) + dxl(i,j))    ! model 3

!           dy(i,j) = 0.5d0*(dyr(i,j) + dyl(i,j))                                     ! model 1
!           dy(i,j) = 0.5d0*(dyr(i,j) + dyl(i,j)) - 2.0d0*dz(i,j)*dz(i,j)*(d**2.0d0+y**2.0d0)**1.5d0 /(d**2.0d0*(d**2.0d0+y**2.0d0)-y**2.0d0*(dz(i,j))**2.0d0)       ! model 2
           dy(i,j) = (y*(dyr(i,j) + dyl(i,j)) + 2*dyr(i,j)*dyl(i,j)) /(2*y + dyr(i,j) + dyl(i,j))    ! model 3

          enddo
        enddo

     ! write(*,*) 'now determine the velocity in 3-directions...'

     do j=1,nvec_y
       do i=1,nvec_x_cut
         u(i,j)=dx(i,j)/dt
         v(i,j)=dy(i,j)/dt
         w(i,j)=dz(i,j)/dt
       enddo
     enddo

     ! write(*,*) 'now saving...'

    if (k==1) then
      ! write(*,*) fous
      open(55, file=fous, status='replace',form='binary')
      write(55) u
      close(55)
    else
      ! write(*,*) fous
      open(55, file=fous, position='append',form='binary')
      write(55) u
      close(55)
    end if

    if (k==1) then
      ! write(*,*) fovs
      open(65, file=fovs, status='replace',form='binary')
      write(65) v
      close(65)
    else
      ! write(*,*) fovs
      open(65, file=fovs, position='append',form='binary')
      write(65) v
      close(65)
    end if

    if (k==1) then
      ! write(*,*) fows
      open(75, file=fows, status='replace',form='binary')
      write(75) w
      close(75)
    else
      ! write(*,*) fows
      open(75, file=fows, position='append',form='binary')
      write(75) w
      close(75)
    end if

  enddo
enddo

write(*,*) 'Operated Correctly!'

stop
end
