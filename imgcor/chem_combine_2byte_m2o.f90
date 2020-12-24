!c------------------------------------c
!c          chem combine              c
!c------------------------------------c
  implicit none

  integer, parameter :: nx = 1024
  integer, parameter :: ny = 1024
  ! integer, parameter :: nzall = 21839 ! separated by 2000*10+1800*1+39*1
  integer, parameter :: nztmp = 200 ! 2000 is 200*(10loop), 1800 is 200*(9loop)
  integer, parameter :: nzlast = 39
  integer, parameter :: cond = 7
  integer, parameter :: sumpart = 12 ! do not change

  character(*), parameter :: path_of_chem_i = '/home/yatagi/analysis/chem_output/20190819/chem_rmv/'
  character(*), parameter :: path_of_chem_o = '/home/yatagi/mnt/chem_output/20190819/chem_rmv/'

!-------------------------------------------------------------------------------
  integer(8) :: h,i,j,k,l,m,n,head_size_count
  integer(2) :: minusin1(nx,ny,nztmp)
  integer(2) :: minusin2(nx,ny,nzlast)
  integer(2) :: zeroout1(nx,ny,nztmp)
  integer(2) :: zeroout2(nx,ny,nzlast)
  integer(1),allocatable :: img_head1(:)

  character(*) :: file_name_minus_in*200
  character(*) :: file_name_zero_out*200
  character(*) :: fnmi*200
  character(*) :: fnpo*200

!-------------------------------------------------------------------------------
   do n=1,cond
     do h=1,sumpart

       print *,'Condition number =',n
       print *,'Partition number =',h
    !-----------------input-------------------
       write(file_name_minus_in,"('chem_',i2.2,'_rmv_',i2.2,'.dat')"),n,h
       write(file_name_zero_out,"('chem_',i2.2,'_rmv.dat')"),n
    !-----------------output-------------------
       fnmi= path_of_chem_i//file_name_minus_in
       fnpo= path_of_chem_o//file_name_zero_out

!-------------------------------------------------------------------------------
      if (h==1)then
        do l=1,10

          head_size_count=2*nx*ny*nztmp*(l-1)
          allocate(img_head1(head_size_count))

          print *,l
          print *,'head_size_count =',head_size_count

          open(32,file=fnmi,form='binary')
          read(32) img_head1,minusin1
          close(32)

          call minus2zero_200(zeroout1,minusin1)

          write(*,*) 'Now saving...'

          if (l==1) then
            write(*,*) fnpo
            open(82, file=fnpo, status='replace',form='binary')
            write(82) zeroout1
            close(82)
          else
            write(*,*) fnpo
            open(82, file=fnpo, position='append',form='binary')
            write(82) zeroout1
            close(82)
          end if

          deallocate(img_head1)
        enddo

      else if (h .ge. 2 .and. h.le.sumpart-2) then
        do l=1,10

          head_size_count=2*nx*ny*nztmp*(l-1)
          allocate(img_head1(head_size_count))

          print *,l
          print *,'head_size_count =',head_size_count

          open(32,file=fnmi,form='binary')
          read(32) img_head1,minusin1
          close(32)

          call minus2zero_200(zeroout1,minusin1)

          write(*,*) 'Now saving...'

          write(*,*) fnpo
          open(82, file=fnpo, position='append',form='binary')
          write(82) zeroout1
          close(82)

          deallocate(img_head1)
        enddo

      else if (h.eq.sumpart-1) then
        do l=1,9

          head_size_count=2*nx*ny*nztmp*(l-1)
          allocate(img_head1(head_size_count))

          print *,'sumpart =',sumpart-1
          print *,l
          print *,'head_size_count =',head_size_count

          open(32,file=fnmi,form='binary')
          read(32) img_head1,minusin1
          close(32)

          call minus2zero_200(zeroout1,minusin1)

          write(*,*) 'Now saving...'

          write(*,*) fnpo
          open(82, file=fnpo, position='append',form='binary')
          write(82) zeroout1
          close(82)

          deallocate(img_head1)
        enddo

      else if (h.eq.sumpart) then

        print *,'sumpart =',sumpart

        open(32,file=fnmi,form='binary')
        read(32) minusin2
        close(32)

        call minus2zero_39(zeroout2,minusin2)

        write(*,*) 'Now saving...'

        write(*,*) fnpo
        open(82, file=fnpo, position='append',form='binary')
        write(82) zeroout2
        close(82)

      end if

    enddo
  enddo

  write(*,*) 'chem combine fin'
  stop
  end

!-------------------------------SUBROUTINES-------------------------------------
!c------------------------------------c
!c          minus to zero             c
!c------------------------------------c
  subroutine minus2zero_200(zeroout,minusin)

  integer, parameter :: nx = 1024
  integer, parameter :: ny = 1024
  integer, parameter :: nz = 200

  integer(8) :: i,j,k
  integer(2) :: minusin(nx,ny,nz)
  integer(2) :: zeroout(nx,ny,nz)

  zeroout=0.0d0

!c------------------------------------c
  do k=1,nz
    do j=1,ny
      do i=1,nx
        if ( minusin(i,j,k) .le. 0 ) then
          zeroout(i,j,k)=0
        else
          zeroout(i,j,k)=minusin(i,j,k)
        end if
      enddo
    enddo
  enddo

  return
  end

!-------------------------------------------------------------------------------
!c------------------------------------c
!c          minus to zero             c
!c------------------------------------c
  subroutine minus2zero_39(zeroout,minusin)

  integer, parameter :: nx = 1024
  integer, parameter :: ny = 1024
  integer, parameter :: nz = 39

  integer(8) :: i,j,k
  integer(2) :: minusin(nx,ny,nz)
  integer(2) :: zeroout(nx,ny,nz)

  zeroout=0.0d0

!c------------------------------------c
  do k=1,nz
    do j=1,ny
      do i=1,nx
        if ( minusin(i,j,k) .le. 0 ) then
          zeroout(i,j,k)=0
        else
          zeroout(i,j,k)=minusin(i,j,k)
        end if
      enddo
    enddo
  enddo

  return
  end
