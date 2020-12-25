!average, standard deviation, average + standard deviation
 implicit none

 integer, parameter:: nx = 1024
 integer, parameter:: ny = 1024
 ! integer, parameter:: nzall = 21839
 integer, parameter:: nztmp1 = 200
 integer, parameter:: nztmp2 = 39
 integer, parameter:: cond_start = 1    ! 1 for grid
 integer, parameter:: cond_end = 16    ! 1 for grid
 integer, parameter:: head_size_tmp1 = nx*ny*nztmp1*10
 integer, parameter:: head_size_tmp2 = nx*ny*nztmp1*9

 character(*), parameter:: path_of_file_in = '/home/yatagi/mnt/20201218/raw_old/'
 character(*), parameter:: path_of_file_out = '/home/yatagi/mnt/20201218/raw/'
!------------------------------------
 integer(8):: h,l,m,head_size_count
 integer(1):: craw1(nx,ny,nztmp1)
 integer(1):: craw2(nx,ny,nztmp2)
 real:: craw3(nx,ny,nztmp1)
 real:: craw4(nx,ny,nztmp2)
 integer(2):: chdata1(nx,ny,nztmp1)
 integer(2):: chdata2(nx,ny,nztmp2)
 integer(1),allocatable :: img_head1(:)
 integer(1):: img_head2(head_size_tmp1)
 integer(1):: img_head3(head_size_tmp2)
 character(*):: file_name_in*200
 character(*):: file_name_ch_out*200
 character(*):: file_in*200
 character(*):: ch_out*200

!-----------------------------------
 do l = cond_start,cond_end

    print *,'Condition number =',l

  !-----------------input-------------------

    ! write(file_name_in,"('chem_grid_02.mraw')")
    ! write(file_name_in,"('plif_noise.mraw')")
    ! write(file_name_in,"('spiv_bl_grid.mraw')")
    ! write(file_name_in,"('spiv_br_grid.mraw')")
    ! write(file_name_in,"('spiv_fl_grid.mraw')")
    ! write(file_name_in,"('spiv_fr_grid.mraw')")

    write(file_name_in,"('spiv_bl_',i2.2,'.mraw')"),l

   !-----------------output-------------------

    ! write(file_name_ch_out,"('chem_grid.mraw')")
    ! write(file_name_ch_out,"('plif_noise.mraw')")
    ! write(file_name_ch_out,"('spiv_bl_grid.mraw')")
    ! write(file_name_ch_out,"('spiv_br_grid.mraw')")
    ! write(file_name_ch_out,"('spiv_fl_grid.mraw')")
    ! write(file_name_ch_out,"('spiv_fr_grid.mraw')")

    write(file_name_ch_out,"('spiv_bl_',i2.2,'.mraw')"),l

    file_in = path_of_file_in//file_name_in
    ch_out = path_of_file_out//file_name_ch_out

!---------------------------------bitchange-------------------------------------
!---------------1-10-------------------
    do m = 1,10
      head_size_count = nx*ny*nztmp1*(m-1)
      allocate(img_head1(head_size_count))

      print *,'part, head_size_count(1-10) =',m,head_size_count

      open(60,file=file_in,form='binary')
      read(60) img_head1,craw1
      close(60)

      craw3 = real(craw1)
      chdata1 = nint(craw3)

      if (m==1) then
        write(*,*) ch_out
        open(82, file=ch_out, status='replace',form='binary')
        write(82) chdata1
        close(82)
      else
        open(83, file=ch_out, position='append',form='binary')
        write(83) chdata1
        close(83)
      endif

      deallocate(img_head1)

    enddo
!---------------11-20------------------
    do m = 1,10
      head_size_count = nx*ny*nztmp1*(m-1)
      allocate(img_head1(head_size_count))

      print *,'part, head_size_count(11-20) =',m,head_size_count

      open(32,file=file_in,form='binary')
      read(32) img_head2,img_head1,craw1
      close(32)

      craw3 = real(craw1)
      chdata1 = nint(craw3)

      open(83, file=ch_out, position='append',form='binary')
      write(83) chdata1
      close(83)

      deallocate(img_head1)

    enddo
!---------------21-30----------------------
    do m = 1,10
      head_size_count = nx*ny*nztmp1*(m-1)
      allocate(img_head1(head_size_count))

      print *,'part, head_size_count(21-30) =',m,head_size_count

      open(32,file=file_in,form='binary')
      read(32) img_head2,img_head2,img_head1,craw1
      close(32)

      craw3 = real(craw1)
      chdata1 = nint(craw3)

      open(83, file=ch_out, position='append',form='binary')
      write(83) chdata1
      close(83)

      deallocate(img_head1)

    enddo
!---------------31-40----------------------
    do m = 1,10
      head_size_count = nx*ny*nztmp1*(m-1)
      allocate(img_head1(head_size_count))

      print *,'part, head_size_count(31-40) =',m,head_size_count

      open(32,file=file_in,form='binary')
      read(32) img_head2,img_head2,img_head2,img_head1,craw1
      close(32)

      craw3 = real(craw1)
      chdata1 = nint(craw3)

      open(83, file=ch_out, position='append',form='binary')
      write(83) chdata1
      close(83)

      deallocate(img_head1)

    enddo
!---------------41-50----------------------
    do m = 1,10
      head_size_count = nx*ny*nztmp1*(m-1)
      allocate(img_head1(head_size_count))

      print *,'part, head_size_count(41-50) =',m,head_size_count

      open(32,file=file_in,form='binary')
      read(32) img_head2,img_head2,img_head2,img_head2,img_head1,craw1
      close(32)

      craw3 = real(craw1)
      chdata1 = nint(craw3)

      open(83, file=ch_out, position='append',form='binary')
      write(83) chdata1
      close(83)

      deallocate(img_head1)

    enddo
!---------------51-60----------------------
    do m = 1,10
      head_size_count = nx*ny*nztmp1*(m-1)
      allocate(img_head1(head_size_count))

      print *,'part, head_size_count(51-60) =',m,head_size_count

      open(32,file=file_in,form='binary')
      read(32) img_head2,img_head2,img_head2,img_head2,img_head2,img_head1,craw1
      close(32)

      craw3 = real(craw1)
      chdata1 = nint(craw3)

      open(83, file=ch_out, position='append',form='binary')
      write(83) chdata1
      close(83)

      deallocate(img_head1)

    enddo
!---------------61-70----------------------
    do m = 1,10
      head_size_count = nx*ny*nztmp1*(m-1)
      allocate(img_head1(head_size_count))

      print *,'part, head_size_count(61-70) =',m,head_size_count

      open(32,file=file_in,form='binary')
      read(32) img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head1,craw1
      close(32)

      craw3 = real(craw1)
      chdata1 = nint(craw3)

      open(83, file=ch_out, position='append',form='binary')
      write(83) chdata1
      close(83)

      deallocate(img_head1)

    enddo
!---------------71-80----------------------
    do m = 1,10
      head_size_count = nx*ny*nztmp1*(m-1)
      allocate(img_head1(head_size_count))

      print *,'part, head_size_count(71-80) =',m,head_size_count

      open(32,file=file_in,form='binary')
      read(32) img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head1,craw1
      close(32)

      craw3 = real(craw1)
      chdata1 = nint(craw3)

      open(83, file=ch_out, position='append',form='binary')
      write(83) chdata1
      close(83)

      deallocate(img_head1)

    enddo
!---------------81-90----------------------
    do m = 1,10
      head_size_count = nx*ny*nztmp1*(m-1)
      allocate(img_head1(head_size_count))

      print *,'part, head_size_count(81-90) =',m,head_size_count

      open(32,file=file_in,form='binary')
      read(32) img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head1,craw1
      close(32)

      craw3 = real(craw1)
      chdata1 = nint(craw3)

      open(83, file=ch_out, position='append',form='binary')
      write(83) chdata1
      close(83)

      deallocate(img_head1)

    enddo
!---------------91-100----------------------
    do m = 1,10
      head_size_count = nx*ny*nztmp1*(m-1)
      allocate(img_head1(head_size_count))

      print *,'part, head_size_count(91-100) =',m,head_size_count

      open(32,file=file_in,form='binary')
      read(32) img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head1,craw1
      close(32)

      craw3 = real(craw1)
      chdata1 = nint(craw3)

      open(83, file=ch_out, position='append',form='binary')
      write(83) chdata1
      close(83)

      deallocate(img_head1)

    enddo
!---------------101-109----------------------
    do m = 1,9
      head_size_count = nx*ny*nztmp1*(m-1)
      allocate(img_head1(head_size_count))

      print *,'part, head_size_count(101-109) =',m,head_size_count

      open(32,file=file_in,form='binary')
      read(32) img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head1,craw1
      close(32)

      craw3 = real(craw1)
      chdata1 = nint(craw3)

      open(83, file=ch_out, position='append',form='binary')
      write(83) chdata1
      close(83)

      deallocate(img_head1)

    enddo
!-------------last 39--------------------
    head_size_count = 0
    allocate(img_head1(head_size_count))

    print *,'last, head_size_count(last39) =',head_size_count

    open(32,file=file_in,form='binary')
    read(32) img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head2,img_head3,img_head1,craw2
    close(32)

    craw4 = real(craw2)
    chdata2 = nint(craw4)

    open(83, file=ch_out, position='append',form='binary')
    write(83) chdata2
    close(83)

    deallocate(img_head1)

 enddo

 write(*,*) 'Operated Correctly!'
 stop
 end
