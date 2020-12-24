!c------------------------------------c
!c            rmvnoise                c
!c------------------------------------c

 implicit none

 integer, parameter :: nx= 1024
 integer, parameter :: ny= 1024
 integer, parameter :: nzall = 21839
 integer, parameter :: nztmp= 200
 integer, parameter :: nzlast= 39
 integer, parameter :: nznoise= 1
 integer, parameter :: head_size_tmp= 2*nx*ny*nztmp*10
 integer, parameter :: head_size_last= 2*nx*ny*nztmp*9
 integer, parameter :: cond = 7

 character(*), parameter :: path_of_in = '/home/yatagi/analysis/chem_output/20190819/chem_cor/'
 character(*), parameter :: path_of_noise_in = '/home/yatagi/analysis/chem_output/20190819/chem_cor/'
 character(*), parameter :: path_of_out = '/home/yatagi/analysis/chem_output/20190819/chem_rmv/'

!------------------------------------
 integer(8) :: i,j,k,l,m,head_size_count,p,q,r
 integer(2) :: craw1(nx,ny,nztmp)
 integer(2) :: craw2(nx,ny,nzlast)
 integer(2) :: craw3(nx,ny,nznoise)
 integer(1),allocatable:: img_head1(:)
 integer(1):: img_head3(head_size_tmp)
 integer(1):: img_head4(head_size_last)

 character(*) :: file_name_in*200
 character(*) :: file_name_noise_in*200
 character(*) :: file_name_rmv_out_01*200
 character(*) :: file_name_rmv_out_02*200
 character(*) :: file_name_rmv_out_03*200
 character(*) :: file_name_rmv_out_04*200
 character(*) :: file_name_rmv_out_05*200
 character(*) :: file_name_rmv_out_06*200
 character(*) :: file_name_rmv_out_07*200
 character(*) :: file_name_rmv_out_08*200
 character(*) :: file_name_rmv_out_09*200
 character(*) :: file_name_rmv_out_10*200
 character(*) :: file_name_rmv_out_11*200
 character(*) :: file_name_rmv_out_12*200
 character(*) :: fni*200
 character(*) :: fnni*200
 character(*) :: fnmo01*200
 character(*) :: fnmo02*200
 character(*) :: fnmo03*200
 character(*) :: fnmo04*200
 character(*) :: fnmo05*200
 character(*) :: fnmo06*200
 character(*) :: fnmo07*200
 character(*) :: fnmo08*200
 character(*) :: fnmo09*200
 character(*) :: fnmo10*200
 character(*) :: fnmo11*200
 character(*) :: fnmo12*200

 write(file_name_noise_in,"('chem_noise_cor.dat')")
 fnni = path_of_noise_in//file_name_noise_in
 open(48,file=fnni,form='binary')
 read(48) craw3
 close(48)

!-----------------------------------
 do m=1,cond
   print *,'Condition number =',m
  !-----------------input-------------------
   write(file_name_in,"('chem_',i2.2,'_cor.dat')"),m

   !-----------------output-------------------
   write(file_name_rmv_out_01,"('chem_',i2.2,'_rmv_01.dat')"),m
   write(file_name_rmv_out_02,"('chem_',i2.2,'_rmv_02.dat')"),m
   write(file_name_rmv_out_03,"('chem_',i2.2,'_rmv_03.dat')"),m
   write(file_name_rmv_out_04,"('chem_',i2.2,'_rmv_04.dat')"),m
   write(file_name_rmv_out_05,"('chem_',i2.2,'_rmv_05.dat')"),m
   write(file_name_rmv_out_06,"('chem_',i2.2,'_rmv_06.dat')"),m
   write(file_name_rmv_out_07,"('chem_',i2.2,'_rmv_07.dat')"),m
   write(file_name_rmv_out_08,"('chem_',i2.2,'_rmv_08.dat')"),m
   write(file_name_rmv_out_09,"('chem_',i2.2,'_rmv_09.dat')"),m
   write(file_name_rmv_out_10,"('chem_',i2.2,'_rmv_10.dat')"),m
   write(file_name_rmv_out_11,"('chem_',i2.2,'_rmv_11.dat')"),m
   write(file_name_rmv_out_12,"('chem_',i2.2,'_rmv_12.dat')"),m

   fni = path_of_in//file_name_in
   fnmo01 = path_of_out//file_name_rmv_out_01
   fnmo02 = path_of_out//file_name_rmv_out_02
   fnmo03 = path_of_out//file_name_rmv_out_03
   fnmo04 = path_of_out//file_name_rmv_out_04
   fnmo05 = path_of_out//file_name_rmv_out_05
   fnmo06 = path_of_out//file_name_rmv_out_06
   fnmo07 = path_of_out//file_name_rmv_out_07
   fnmo08 = path_of_out//file_name_rmv_out_08
   fnmo09 = path_of_out//file_name_rmv_out_09
   fnmo10 = path_of_out//file_name_rmv_out_10
   fnmo11 = path_of_out//file_name_rmv_out_11
   fnmo12 = path_of_out//file_name_rmv_out_12

!----------------------------------filter---------------------------------------
  !---------------1-10-------------------
   do l=1,10
     head_size_count=2*nx*ny*nztmp*(l-1)
     allocate(img_head1(head_size_count))

     print *,l
     print *,'head_size_count(1-10) =',head_size_count

     open(32,file=fni,form='binary')
     read(32) img_head1,craw1
     close(32)

     do r=1,nztmp
       do q=1,ny
         do p=1,nx
           craw1(p,q,r)=craw1(p,q,r)-craw3(p,q,1)

           if (craw1(p,q,r) .le. 0) then
             craw1(p,q,r)=0
           end if

         enddo
       enddo
     enddo

  !-------------write----------------
     write(*,*) 'Now saving...'

     if (l==1) then
       write(*,*) fnmo01
       open(82, file=fnmo01, status='replace',form='binary')
       write(82) craw1
       close(82)
     else
       write(*,*) fnmo01
       open(82, file=fnmo01, position='append',form='binary')
       write(82) craw1
       close(82)
     end if

     deallocate(img_head1)
   enddo

  !---------------11-20-------------------
   do l=1,10
      head_size_count=2*nx*ny*nztmp*(l-1)
      allocate(img_head1(head_size_count))

      print *,l
      print *,'head_size_count(11-20) =',head_size_count

      open(32,file=fni,form='binary')
      read(32) img_head3,img_head1,craw1
      close(32)

      do r=1,nztmp
        do q=1,ny
          do p=1,nx
            craw1(p,q,r)=craw1(p,q,r)-craw3(p,q,1)

            if (craw1(p,q,r) .le. 0) then
              craw1(p,q,r)=0
            end if

          enddo
        enddo
      enddo

 !-------------write----------------
      write(*,*) 'Now saving...'

      if (l==1) then
        write(*,*) fnmo02
        open(82, file=fnmo02, status='replace',form='binary')
        write(82) craw1
        close(82)
      else
        write(*,*) fnmo02
        open(82, file=fnmo02, position='append',form='binary')
        write(82) craw1
        close(82)
      end if

      deallocate(img_head1)
    enddo

 !---------------21-30----------------------
    do l=1,10
      head_size_count=2*nx*ny*nztmp*(l-1)
      allocate(img_head1(head_size_count))

      print *,l
      print *,'head_size_count(21-30) =',head_size_count

      open(32,file=fni,form='binary')
      read(32) img_head3,img_head3,img_head1,craw1
      close(32)

      do r=1,nztmp
        do q=1,ny
          do p=1,nx
            craw1(p,q,r)=craw1(p,q,r)-craw3(p,q,1)

            if (craw1(p,q,r) .le. 0) then
              craw1(p,q,r)=0
            end if

          enddo
        enddo
      enddo

 !----------------write------------------
      write(*,*) 'Now saving...'

      if (l==1) then
        write(*,*) fnmo03
        open(82, file=fnmo03, status='replace',form='binary')
        write(82) craw1
        close(82)
      else
        write(*,*) fnmo03
        open(82, file=fnmo03, position='append',form='binary')
        write(82) craw1
        close(82)
      end if

      deallocate(img_head1)
    enddo

 !---------------31-40----------------------
    do l=1,10
      head_size_count=2*nx*ny*nztmp*(l-1)
      allocate(img_head1(head_size_count))

      print *,l
      print *,'head_size_count(31-40) =',head_size_count

      open(32,file=fni,form='binary')
      read(32) img_head3,img_head3,img_head3,img_head1,craw1
      close(32)

      do r=1,nztmp
        do q=1,ny
          do p=1,nx
            craw1(p,q,r)=craw1(p,q,r)-craw3(p,q,1)

            if (craw1(p,q,r) .le. 0) then
              craw1(p,q,r)=0
            end if

          enddo
        enddo
      enddo

 !----------------write------------------
      write(*,*) 'Now saving...'

      if (l==1) then
        write(*,*) fnmo04
        open(82, file=fnmo04, status='replace',form='binary')
        write(82) craw1
        close(82)
      else
        write(*,*) fnmo04
        open(82, file=fnmo04, position='append',form='binary')
        write(82) craw1
        close(82)
      end if

      deallocate(img_head1)
    enddo

 !---------------41-50----------------------
    do l=1,10
      head_size_count=2*nx*ny*nztmp*(l-1)
      allocate(img_head1(head_size_count))

      print *,l
      print *,'head_size_count(41-50) =',head_size_count

      open(32,file=fni,form='binary')
      read(32) img_head3,img_head3,img_head3,img_head3,img_head1,craw1
      close(32)

      do r=1,nztmp
        do q=1,ny
          do p=1,nx
            craw1(p,q,r)=craw1(p,q,r)-craw3(p,q,1)

            if (craw1(p,q,r) .le. 0) then
              craw1(p,q,r)=0
            end if

          enddo
        enddo
      enddo

 !----------------write------------------
      write(*,*) 'Now saving...'

      if (l==1) then
        write(*,*) fnmo05
        open(82, file=fnmo05, status='replace',form='binary')
        write(82) craw1
        close(82)
      else
        write(*,*) fnmo05
        open(82, file=fnmo05, position='append',form='binary')
        write(82) craw1
        close(82)
      end if

      deallocate(img_head1)
    enddo

 !---------------51-60----------------------
    do l=1,10
      head_size_count=2*nx*ny*nztmp*(l-1)
      allocate(img_head1(head_size_count))

      print *,l
      print *,'head_size_count(51-60) =',head_size_count

      open(32,file=fni,form='binary')
      read(32) img_head3,img_head3,img_head3,img_head3,img_head3,img_head1,craw1
      close(32)

      do r=1,nztmp
        do q=1,ny
          do p=1,nx
            craw1(p,q,r)=craw1(p,q,r)-craw3(p,q,1)

            if (craw1(p,q,r) .le. 0) then
              craw1(p,q,r)=0
            end if

          enddo
        enddo
      enddo

 !----------------write------------------
      write(*,*) 'Now saving...'

      if (l==1) then
        write(*,*) fnmo06
        open(82, file=fnmo06, status='replace',form='binary')
        write(82) craw1
        close(82)
      else
        write(*,*) fnmo06
        open(82, file=fnmo06, position='append',form='binary')
        write(82) craw1
        close(82)
      end if

      deallocate(img_head1)
    enddo

 !---------------61-70----------------------
    do l=1,10
      head_size_count=2*nx*ny*nztmp*(l-1)
      allocate(img_head1(head_size_count))

      print *,l
      print *,'head_size_count(61-70) =',head_size_count

      open(32,file=fni,form='binary')
      read(32) img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head1,craw1
      close(32)

      do r=1,nztmp
        do q=1,ny
          do p=1,nx
            craw1(p,q,r)=craw1(p,q,r)-craw3(p,q,1)

            if (craw1(p,q,r) .le. 0) then
              craw1(p,q,r)=0
            end if

          enddo
        enddo
      enddo

 !----------------write------------------
      write(*,*) 'Now saving...'

      if (l==1) then
        write(*,*) fnmo07
        open(82, file=fnmo07, status='replace',form='binary')
        write(82) craw1
        close(82)
      else
        write(*,*) fnmo07
        open(82, file=fnmo07, position='append',form='binary')
        write(82) craw1
        close(82)
      end if

      deallocate(img_head1)
    enddo

 !---------------71-80----------------------
    do l=1,10
      head_size_count=2*nx*ny*nztmp*(l-1)
      allocate(img_head1(head_size_count))

      print *,l
      print *,'head_size_count(71-80) =',head_size_count

      open(32,file=fni,form='binary')
      read(32) img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head1,craw1
      close(32)

      do r=1,nztmp
        do q=1,ny
          do p=1,nx
            craw1(p,q,r)=craw1(p,q,r)-craw3(p,q,1)

            if (craw1(p,q,r) .le. 0) then
              craw1(p,q,r)=0
            end if

          enddo
        enddo
      enddo

 !----------------write------------------
      write(*,*) 'Now saving...'

      if (l==1) then
        write(*,*) fnmo08
        open(82, file=fnmo08, status='replace',form='binary')
        write(82) craw1
        close(82)
      else
        write(*,*) fnmo08
        open(82, file=fnmo08, position='append',form='binary')
        write(82) craw1
        close(82)
      end if

      deallocate(img_head1)
    enddo

 !---------------81-90----------------------
    do l=1,10
      head_size_count=2*nx*ny*nztmp*(l-1)
      allocate(img_head1(head_size_count))

      print *,l
      print *,'head_size_count(81-90) =',head_size_count

      open(32,file=fni,form='binary')
      read(32) img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head1,craw1
      close(32)

      do r=1,nztmp
        do q=1,ny
          do p=1,nx
            craw1(p,q,r)=craw1(p,q,r)-craw3(p,q,1)

            if (craw1(p,q,r) .le. 0) then
              craw1(p,q,r)=0
            end if

          enddo
        enddo
      enddo

 !----------------write------------------
      write(*,*) 'Now saving...'

      if (l==1) then
        write(*,*) fnmo09
        open(82, file=fnmo09, status='replace',form='binary')
        write(82) craw1
        close(82)
      else
        write(*,*) fnmo09
        open(82, file=fnmo09, position='append',form='binary')
        write(82) craw1
        close(82)
      end if

      deallocate(img_head1)
    enddo

 !---------------91-100----------------------
    do l=1,10
      head_size_count=2*nx*ny*nztmp*(l-1)
      allocate(img_head1(head_size_count))

      print *,l
      print *,'head_size_count(91-100) =',head_size_count

      open(32,file=fni,form='binary')
      read(32) img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head1,craw1
      close(32)

      do r=1,nztmp
        do q=1,ny
          do p=1,nx
            craw1(p,q,r)=craw1(p,q,r)-craw3(p,q,1)

            if (craw1(p,q,r) .le. 0) then
              craw1(p,q,r)=0
            end if

          enddo
        enddo
      enddo

 !----------------write------------------
      write(*,*) 'Now saving...'

      if (l==1) then
        write(*,*) fnmo10
        open(82, file=fnmo10, status='replace',form='binary')
        write(82) craw1
        close(82)
      else
        write(*,*) fnmo10
        open(82, file=fnmo10, position='append',form='binary')
        write(82) craw1
        close(82)
      end if

      deallocate(img_head1)
    enddo

 !---------------101-109----------------------
    do l=1,9
      head_size_count=2*nx*ny*nztmp*(l-1)
      allocate(img_head1(head_size_count))

      print *,l
      print *,'head_size_count(101-109) =',head_size_count

      open(32,file=fni,form='binary')
      read(32) img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head1,craw1
      close(32)

      do r=1,nztmp
        do q=1,ny
          do p=1,nx
            craw1(p,q,r)=craw1(p,q,r)-craw3(p,q,1)

            if (craw1(p,q,r) .le. 0) then
              craw1(p,q,r)=0
            end if

          enddo
        enddo
      enddo

 !----------------write------------------
      write(*,*) 'Now saving...'

      if (l==1) then
        write(*,*) fnmo11
        open(82, file=fnmo11, status='replace',form='binary')
        write(82) craw1
        close(82)
      else
        write(*,*) fnmo11
        open(82, file=fnmo11, position='append',form='binary')
        write(82) craw1
        close(82)
      end if

      deallocate(img_head1)
    enddo

 !-------------last 39--------------------
     head_size_count=0
     allocate(img_head1(head_size_count))

     print *,l
     print *,'head_size_count(last39) =',head_size_count

     open(32,file=fni,form='binary')
     read(32) img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head3,img_head4,img_head1,craw2
     close(32)

     do r=1,nzlast
       do q=1,ny
         do p=1,nx
           craw2(p,q,r)=craw2(p,q,r)-craw3(p,q,1)

           if (craw2(p,q,r) .le. 0) then
             craw2(p,q,r)=0
           end if

         enddo
       enddo
     enddo

 !----------------write------------------
    write(*,*) 'Now saving...'

    write(*,*) fnmo12
    ! open(82, file=fnmo12, position='replace',form='binary')
    open(82, file=fnmo12,form='binary')
    write(82) craw2
    close(82)

    deallocate(img_head1)

    write(*,*) 'Operated Correctly!'

 enddo
 stop
 end
