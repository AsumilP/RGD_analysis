!average, standard deviation, average + standard deviation
 implicit none

 integer, parameter:: nx = 191
 integer, parameter:: ny = 123
 integer, parameter:: nz = 21838
 integer, parameter:: head_size = 0
 integer, parameter:: cond = 7    ! 1 for grid

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

 ! character(*), parameter :: path_of_file_in = '/home/yatagi/analysis/rawimg/20201215/raw/'
 ! character(*), parameter :: path_of_file_out = '/home/yatagi/analysis/rawimg/20201215/imgcor/'

 character(*), parameter :: path_of_file_in = '/home/yatagi/analysis/piv_output/velofield/20201223/comblps/'
 character(*), parameter :: path_of_file_out = '/home/yatagi/analysis/piv_output/velofield/20201223/average/'

 ! character(*), parameter :: path_of_file_in = '/home/yatagi/mnt/20201223/raw/'
 ! character(*), parameter :: path_of_file_out = '/home/yatagi/mnt/20201223/imgcor/'
!------------------------------------
 integer:: i,j,k,l
 real(8):: craw(nx,ny,nz)
 real(8):: subsum(nx,ny)
 real(8):: subdevifloat(nx,ny)
 real(8):: subdisp(nx,ny)
 real(8):: subemphfloat(nx,ny)
 real(8):: submeanfloat(nx,ny)
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

  ! write(file_name_in,"('chem_grid.dat')")
  ! write(file_name_in,"('plif_noise.dat')")
  ! write(file_name_in,"('spiv_bl_grid.dat')")
  ! write(file_name_in,"('spiv_br_grid.dat')")
  ! write(file_name_in,"('spiv_fl_grid.dat')")
  ! write(file_name_in,"('spiv_fr_grid.dat')")

  ! write(file_name_in,"('spiv_fbsc_',i2.2,'_ucl.dat')"),l
  ! write(file_name_in,"('spiv_fbsc_',i2.2,'_vcl.dat')"),l
  write(file_name_in,"('spiv_fbsc_',i2.2,'_wcl.dat')"),l

  ! write(file_name_in,"('spiv_fr_',i2.2,'.mraw')"),l

   !-----------------output-------------------

  ! write(file_name_ave_out,"('chem_grid_av.dat')")
  ! write(file_name_ave_out,"('plif_noise_av.dat')")
  ! write(file_name_ave_out,"('spiv_bl_grid_av.dat')")
  ! write(file_name_ave_out,"('spiv_br_grid_av.dat')")
  ! write(file_name_ave_out,"('spiv_fl_grid_av.dat')")
  ! write(file_name_ave_out,"('spiv_fr_grid_av.dat')")

  ! write(file_name_devi_out,"('chem_grid_devi.dat')")
  ! write(file_name_devi_out,"('plif_noise_devi.dat')")
  ! write(file_name_devi_out,"('spiv_bl_grid_devi.dat')")
  ! write(file_name_devi_out,"('spiv_br_grid_devi.dat')")
  ! write(file_name_devi_out,"('spiv_fl_grid_devi.dat')")
  ! write(file_name_devi_out,"('spiv_fr_grid_devi.dat')")

  ! write(file_name_emph_out,"('chem_grid_emph.dat')")
  ! write(file_name_emph_out,"('plif_noise_emph.dat')")
  ! write(file_name_emph_out,"('spiv_bl_grid_emph.dat')")
  ! write(file_name_emph_out,"('spiv_br_grid_emph.dat')")
  ! write(file_name_emph_out,"('spiv_fl_grid_emph.dat')")
  ! write(file_name_emph_out,"('spiv_fr_grid_emph.dat')")

  ! write(file_name_ave_out,"('spiv_fbsc_',i2.2,'_ucl_av.dat')"),l
  ! write(file_name_devi_out,"('spiv_fbsc_',i2.2,'_ucl_devi.dat')"),l
  ! write(file_name_emph_out,"('spiv_fbsc_',i2.2,'_ucl_emph.dat')"),l
  ! write(file_name_ave_out,"('spiv_fbsc_',i2.2,'_vcl_av.dat')"),l
  ! write(file_name_devi_out,"('spiv_fbsc_',i2.2,'_vcl_devi.dat')"),l
  ! write(file_name_emph_out,"('spiv_fbsc_',i2.2,'_vcl_emph.dat')"),l
  write(file_name_ave_out,"('spiv_fbsc_',i2.2,'_wcl_av.dat')"),l
  write(file_name_devi_out,"('spiv_fbsc_',i2.2,'_wcl_devi.dat')"),l
  write(file_name_emph_out,"('spiv_fbsc_',i2.2,'_wcl_emph.dat')"),l

  ! write(file_name_ave_out,"('spiv_fr_',i2.2,'_av.dat')"),l
  ! write(file_name_devi_out,"('spiv_fr_',i2.2,'_devi.dat')"),l
  ! write(file_name_emph_out,"('spiv_fr_',i2.2,'_emph.dat')"),l

   file_in = path_of_file_in//file_name_in
   ave_out = path_of_file_out//file_name_ave_out
   devi_out = path_of_file_out//file_name_devi_out
   emph_out = path_of_file_out//file_name_emph_out

   open(60,file=file_in,form='binary')
   read(60) img_head,craw

!--------------average---------------
    subsum=0
    do i=1,nx
      do j=1,ny
        do k=1,nz
          subsum(i,j)=subsum(i,j)+craw(i,j,k)
        enddo
      enddo
    enddo

    do i=1,nx
      do j=1,ny
        submeanfloat(i,j)=subsum(i,j)/nz
      enddo
    enddo

!--------------deviation---------------
    subdisp=0
    do i=1,nx
      do j=1,ny
        do k=1,nz
          subdisp(i,j)=subdisp(i,j)+(craw(i,j,k)-submeanfloat(i,j))**2/nz
        enddo
      enddo
    enddo

    do i=1,nx
      do j=1,ny
        subdevifloat(i,j)=sqrt(subdisp(i,j))
      enddo
    enddo

!-------------ave+devi------------------
    do i=1,nx
      do j=1,ny
        subemphfloat(i,j)=subdevifloat(i,j)+submeanfloat(i,j)
      enddo
    enddo

!-------------wrirte--------------------
  write(*,*) 'Now saving...'

  write(*,*) ave_out ! average
  open(70, file=ave_out, form='binary')
  write(70) submeanfloat
  close(70)

  write(*,*) devi_out ! standard deviation
  open(80, file=devi_out, form='binary')
  write(80) subdevifloat
  close(80)

  write(*,*) emph_out ! empasis ave+devi
  open(90, file=emph_out, form='binary')
  write(90) subemphfloat
  close(90)

 enddo

 write(*,*) 'Operated Correctly!'
 stop
 end
