!average, standard deviation, average + standard deviation
 implicit none

 integer, parameter:: nx = 1024
 integer, parameter:: ny = 1024
 integer, parameter:: nz = 430
 integer, parameter:: head_size = 0
 integer, parameter:: cond = 1    ! 1 for grid

 ! character(*), parameter :: path_of_file_in = '/home/yatagi/analysis/rawimg/20190227/chem/chem_grid/'
 ! character(*), parameter :: path_of_file_in = '/home/yatagi/analysis/rawimg/20190301/plif/plif_grid/'
 ! character(*), parameter :: path_of_file_in = '/home/yatagi/analysis/rawimg/20190301/spiv_bl/spiv_bl_grid/'
 ! character(*), parameter :: path_of_file_in = '/home/yatagi/analysis/rawimg/20190301/spiv_br/spiv_br_grid/'
 ! character(*), parameter :: path_of_file_in = '/home/yatagi/analysis/rawimg/20190301/spiv_fl/spiv_fl_grid/'
 ! character(*), parameter :: path_of_file_in = '/home/yatagi/analysis/rawimg/20190301/spiv_fr/spiv_fr_grid/'

 ! character(*), parameter :: path_of_file_out = '/home/yatagi/analysis/grid_output/20190227/chem/'
 ! character(*), parameter :: path_of_file_out = '/home/yatagi/analysis/grid_output/20190227/plif/'
 ! character(*), parameter :: path_of_file_out = '/home/yatagi/analysis/grid_output/20190301/spiv_bl/'
 ! character(*), parameter :: path_of_file_out = '/home/yatagi/analysis/grid_output/20190301/spiv_br/'
 ! character(*), parameter :: path_of_file_out = '/home/yatagi/analysis/grid_output/20190301/spiv_fl/'
 ! character(*), parameter :: path_of_file_out = '/home/yatagi/analysis/grid_output/20190301/spiv_fr/'

 ! character(*), parameter :: path_of_file_in = '/home/yatagi/analysis/rawimg/20181218/spiv_fr/'
 ! character(*), parameter :: path_of_file_out = '/home/yatagi/analysis/piv_output/rmvnoise_particle/20181218/spiv_fr/'

 ! character(*), parameter :: path_of_file_in = '/home/yatagi/analysis/rawimg/20190301/plif/'
 ! character(*), parameter :: path_of_file_out = '/home/yatagi/analysis/grid_output/20190301/plif/'

 character(*), parameter :: path_of_file_in = '/home/yatagi/mnt/20201221/raw/'
 character(*), parameter :: path_of_file_out = '/home/yatagi/mnt/20201221/imgcor/'
!------------------------------------
 integer:: i,j,k,l
 integer(2):: craw(nx,ny,nz)
 real:: subb(nx,ny,nz)
 real:: subsum(nx,ny)
 real:: subdevifloat(nx,ny)
 integer(2):: subdeviint(nx,ny)
 real:: subdisp(nx,ny)
 real:: subemphfloat(nx,ny)
 integer(2):: subemphint(nx,ny)
 real:: submeanfloat(nx,ny)
 integer(2):: submeanint(nx,ny)
 integer(1):: img_head(head_size)
 character(*):: file_name_in*200
 character(*):: file_name_ave_out*200
 character(*):: file_name_devi_out*200
 character(*):: file_name_emph_out*200
 character(*):: file_in*200
 character(*):: ave_out*200
 character(*):: devi_out*200
 character(*):: emph_out*200

!-----------------------------------
 do l=1,cond

     print *,'Condition number =',l

  !-----------------input-------------------

  ! write(file_name_in,"('chem_grid.mraw')")
  ! write(file_name_in,"('plif_noise.mraw')")
  ! write(file_name_in,"('spiv_bl_grid.mraw')")
  ! write(file_name_in,"('spiv_br_grid.mraw')")
  ! write(file_name_in,"('spiv_fl_grid.mraw')")
  ! write(file_name_in,"('spiv_fr_grid.mraw')")

   ! write(file_name_in,"('spiv_fr_',i2.2,'.mraw')"),l

   ! write(file_name_in,"('chem_grid.dat')")
   ! write(file_name_in,"('plif_noise.dat')")
   write(file_name_in,"('spiv_bl_grid.dat')")
   ! write(file_name_in,"('spiv_br_grid.dat')")
   ! write(file_name_in,"('spiv_fl_grid.dat')")
   ! write(file_name_in,"('spiv_fr_grid.dat')")

    ! write(file_name_in,"('spiv_fr_',i2.2,'.dat')"),l

   !-----------------output-------------------

  ! write(file_name_ave_out,"('chem_grid_av.dat')")
  ! write(file_name_ave_out,"('plif_noise_av.dat')")
  write(file_name_ave_out,"('spiv_bl_grid_av.dat')")
  ! write(file_name_ave_out,"('spiv_br_grid_av.dat')")
  ! write(file_name_ave_out,"('spiv_fl_grid_av.dat')")
  ! write(file_name_ave_out,"('spiv_fr_grid_av.dat')")

  ! write(file_name_devi_out,"('chem_grid_devi.dat')")
  ! write(file_name_devi_out,"('plif_noise_devi.dat')")
  write(file_name_devi_out,"('spiv_bl_grid_devi.dat')")
  ! write(file_name_devi_out,"('spiv_br_grid_devi.dat')")
  ! write(file_name_devi_out,"('spiv_fl_grid_devi.dat')")
  ! write(file_name_devi_out,"('spiv_fr_grid_devi.dat')")

  ! write(file_name_emph_out,"('chem_grid_emph.dat')")
  ! write(file_name_emph_out,"('plif_noise_emph.dat')")
  write(file_name_emph_out,"('spiv_bl_grid_emph.dat')")
  ! write(file_name_emph_out,"('spiv_br_grid_emph.dat')")
  ! write(file_name_emph_out,"('spiv_fl_grid_emph.dat')")
  ! write(file_name_emph_out,"('spiv_fr_grid_emph.dat')")

  ! write(file_name_ave_out,"('spiv_fr_',i2.2,'_av.dat')"),l
  ! write(file_name_devi_out,"('spiv_fr_',i2.2,'_devi.dat')"),l
  ! write(file_name_emph_out,"('spiv_fr_',i2.2,'_emph.dat')"),l

   file_in = path_of_file_in//file_name_in
   ave_out = path_of_file_out//file_name_ave_out
   devi_out = path_of_file_out//file_name_devi_out
   emph_out = path_of_file_out//file_name_emph_out

   open(60,file=file_in,form='binary')
   read(60) img_head,craw
   subb=real(craw)

!--------------average---------------
    subsum=0
    do i=1,nx
      do j=1,ny
        do k=1,nz
          subsum(i,j)=subsum(i,j)+subb(i,j,k)
        enddo
      enddo
    enddo

    do i=1,nx
      do j=1,ny
        submeanfloat(i,j)=subsum(i,j)/nz
      enddo
    enddo

    do i=1,nx
      do j=1,ny
        submeanint(i,j)=nint(submeanfloat(i,j))
      enddo
    enddo

!--------------deviation---------------
    subdisp=0
    do i=1,nx
      do j=1,ny
        do k=1,nz
          subdisp(i,j)=subdisp(i,j)+(subb(i,j,k)-submeanfloat(i,j))**2/nz
        enddo
      enddo
    enddo

    do i=1,nx
      do j=1,ny
        subdevifloat(i,j)=sqrt(subdisp(i,j))
      enddo
    enddo

    do i=1,nx
      do j=1,ny
        subdeviint(i,j)=nint(subdevifloat(i,j))
      enddo
    enddo

!-------------ave+devi------------------
    do i=1,nx
      do j=1,ny
        subemphfloat(i,j)=subdevifloat(i,j)+submeanfloat(i,j)
      enddo
    enddo

    do i=1,nx
      do j=1,ny
        subemphint(i,j)=nint(subemphfloat(i,j))
      enddo
    enddo

!-------------wrirte--------------------
  write(*,*) 'Now saving...'

  write(*,*) ave_out ! average
  open(70, file=ave_out, form='binary')
  write(70) submeanint
  close(70)

  write(*,*) devi_out ! standard deviation
  open(80, file=devi_out, form='binary')
  write(80) subdeviint
  close(80)

  write(*,*) emph_out ! empasis ave+devi
  open(90, file=emph_out, form='binary')
  write(90) subemphint
  close(90)

 enddo

 write(*,*) 'Operated Correctly!'
 stop
 end
