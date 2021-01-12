!get u and v,get u and v cut, after piv
!c--------------------------------------------------c
!c          ( avedevi.f90 + rmvnoise.f90 )          c
!c            imgcor                                c
!c            piv                                   c
!c   --->     get_uv_withcut.f90                    c
!c            rmverrvec_uvcut.f90                   c
!c            stereoscopic.f90                      c
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

 integer, parameter:: nvec_x= 124
 integer, parameter:: nvec_y= 124
 integer, parameter:: nztmp= 2000
 integer, parameter:: nzlast= 1838
 integer, parameter:: head_size= 0
 integer, parameter:: xorigin= 145 ![px]
 integer, parameter:: hemisize_chamb= 60 ![mm]
 integer, parameter:: imgcut_left_px= 1 ![px]
 integer, parameter:: vec_spc_x_px= 8 ![px]
 real(8), parameter:: img_res_x= 80d-3 ![mm/px]
 integer, parameter:: cond = 1
 real(8), parameter:: vector_width= img_res_x*vec_spc_x_px ![mm]
 integer, parameter:: discard_vec= int((xorigin-imgcut_left_px)/vec_spc_x_px)+1
 integer, parameter:: nvec_x_cut= int((hemisize_chamb/vector_width)+0.5)+1

 character(*), parameter:: path_of_velo = '/home/yatagi/analysis/piv_output/velofield/20190816/piv/br/'
 !character(*), parameter:: path_of_velo = '/home/yatagi/analysis/piv_output/velofield/20181218/rmvpiv/br/'
 character(*):: file_name_in*200
 character(*):: file_name_out_u*200
 character(*):: file_name_out_v*200
 character(*):: file_name_out_ucut*200
 character(*):: file_name_out_vcut*200
 character(*):: fcombi*200
 character(*):: fuo*200
 character(*):: fvo*200
 character(*):: fuco*200
 character(*):: fvco*200
 !-------------------------------
  integer:: i,j,k,l,m,n,p,q

  real(8):: craw1(nvec_x,nvec_y,nztmp)
  real(8):: craw2(nvec_x,nvec_y,nztmp)
  !real(8):: craw3(nvec_x,nvec_y,nztmp)
  !integer(2):: craw4(nvec_x,nvec_y,nztmp)
  real(8):: craw5(nvec_x,nvec_y,nzlast)
  real(8):: craw6(nvec_x,nvec_y,nzlast)
  !real(8):: craw7(nvec_x,nvec_y,nzlast)
  !integer(2):: craw8(nvec_x,nvec_y,nzlast)
  real(8):: craw1cut(nvec_x_cut,nvec_y,nztmp)
  real(8):: craw2cut(nvec_x_cut,nvec_y,nztmp)
  real(8):: craw5cut(nvec_x_cut,nvec_y,nzlast)
  real(8):: craw6cut(nvec_x_cut,nvec_y,nzlast)
  integer(1):: img_head(head_size)
  real(8):: sub1(nvec_x,nvec_y)
  real(8):: sub2(nvec_x,nvec_y)
  real(8):: sub3(nvec_x,nvec_y)
  integer(8):: sub4(nvec_x,nvec_y)
  real(8):: sub5(nvec_x,nvec_y)
  real(8):: sub6(nvec_x,nvec_y)
  real(8):: sub7(nvec_x,nvec_y)
  integer(8):: sub8(nvec_x,nvec_y)

 !-----------------------------------
    craw1=0
    craw2=0
  !  craw3=0
  !  craw4=0
    craw5=0
    craw6=0
  !  craw7=0
  !  craw8=0
    craw1cut=0
    craw2cut=0
    craw5cut=0
    craw6cut=0
    sub1=0
    sub2=0
    sub3=0
    sub4=0
    sub5=0
    sub6=0
    sub7=0
    sub8=0

  do i=1,cond
    write(file_name_out_u,"('spiv_br_',i2.2,'_u.dat')"),i
    !write(file_name_out_u,"('spiv_br_',i2.2,'_rmv_u.dat')"),i

    write(file_name_out_v,"('spiv_br_',i2.2,'_v.dat')"),i
    !write(file_name_out_v,"('spiv_br_',i2.2,'_rmv_v.dat')"),i

    write(file_name_out_ucut,"('spiv_br_',i2.2,'_ucut.dat')"),i
    !write(file_name_out_ucut,"('spiv_br_',i2.2,'_rmv_ucut.dat')"),i

    write(file_name_out_vcut,"('spiv_br_',i2.2,'_vcut.dat')"),i
    !write(file_name_out_vcut,"('spiv_br_',i2.2,'_rmv_vcut.dat')"),i

    do j=1,10
      write(file_name_in,"('spiv_br_',i2.2,'_velo',i0,'.dat')"),i,j
      !write(file_name_in,"('spiv_br_',i2.2,'_rmv_velo',i0,'.dat')"),i,j

      fcombi = path_of_velo//file_name_in
      fuo = path_of_velo//file_name_out_u
      fvo = path_of_velo//file_name_out_v
      fuco = path_of_velo//file_name_out_ucut
      fvco = path_of_velo//file_name_out_vcut

      open(45,file=fcombi,form='binary')
      do n=1,nztmp
        read(45) img_head,sub1,sub2,sub3,sub4
        do p=1,nvec_x
          do q=1,nvec_y

            if(isnan(sub1(p,q)) .eqv. .true.) then
              craw1(p,q,n)=0
            else
              craw1(p,q,n)=sub1(p,q)
            end if

            if(isnan(sub2(p,q)) .eqv. .true.) then
              craw2(p,q,n)=0
            else
              craw2(p,q,n)=sub2(p,q)
            end if

          enddo
        enddo
      enddo

      print *,'Condition number =',i
      print *,'Splitfile number =',j
      print *,'Work in Progress...'

      if (j==1) then
        write(*,*) fuo
        open(55, file=fuo, status='replace',form='binary')
        write(55) craw1
        close(55)
      else
        write(*,*) fuo
        open(55, file=fuo, position='append',form='binary')
        write(55) craw1
        close(55)
      end if

      if (j==1) then
        write(*,*) fvo
        open(65, file=fvo, status='replace',form='binary')
        write(65) craw2
        close(65)
      else
        write(*,*) fvo
        open(65, file=fvo, position='append',form='binary')
        write(65) craw2
        close(65)
      end if

      do k=1,nvec_x_cut
        do l=1,nvec_y
          do m=1,nztmp
            craw1cut(k,l,m)=craw1(k+discard_vec,l,m)
            craw2cut(k,l,m)=craw2(k+discard_vec,l,m)
          enddo
        enddo
      enddo

      if (j==1) then
        write(*,*) fuco
        open(75, file=fuco, status='replace',form='binary')
        write(75) craw1cut
        close(75)
      else
        write(*,*) fuco
        open(75, file=fuco, position='append',form='binary')
        write(75) craw1cut
        close(75)
      end if

      if (j==1) then
        write(*,*) fvco
        open(85, file=fvco, status='replace',form='binary')
        write(85) craw2cut
        close(85)
      else
        write(*,*) fvco
        open(85, file=fvco, position='append',form='binary')
        write(85) craw2cut
        close(85)
      end if

      close(45)

    enddo
  enddo

!---------------last 1838------------------
  do i=1,cond
    write(file_name_out_u,"('spiv_br_',i2.2,'_u.dat')"),i
    !write(file_name_out_u,"('spiv_br_',i2.2,'_rmv_u.dat')"),i

    write(file_name_out_v,"('spiv_br_',i2.2,'_v.dat')"),i
    !write(file_name_out_v,"('spiv_br_',i2.2,'_rmv_v.dat')"),i

    write(file_name_out_ucut,"('spiv_br_',i2.2,'_ucut.dat')"),i
    !write(file_name_out_ucut,"('spiv_br_',i2.2,'_rmv_ucut.dat')"),i

    write(file_name_out_vcut,"('spiv_br_',i2.2,'_vcut.dat')"),i
    !write(file_name_out_vcut,"('spiv_br_',i2.2,'_rmv_vcut.dat')"),i

    j=11
      write(file_name_in,"('spiv_br_',i2.2,'_velo',i0,'.dat')"),i,j
      !write(file_name_in,"('spiv_br_',i2.2,'_rmv_velo',i0,'.dat')"),i,j

      fcombi = path_of_velo//file_name_in
      fuo = path_of_velo//file_name_out_u
      fvo = path_of_velo//file_name_out_v
      fuco = path_of_velo//file_name_out_ucut
      fvco = path_of_velo//file_name_out_vcut

      open(46,file=fcombi,form='binary')
      do n=1,nzlast
        read(46) img_head,sub5,sub6,sub7,sub8
        do p=1,nvec_x
          do q=1,nvec_y

            if(isnan(sub5(p,q)) .eqv. .true.) then
              craw5(p,q,n)=0
            else
              craw5(p,q,n)=sub5(p,q)
            end if

            if(isnan(sub6(p,q)) .eqv. .true.) then
              craw6(p,q,n)=0
            else
              craw6(p,q,n)=sub6(p,q)
            end if

          enddo
        enddo
      enddo

      print *,'Condition number =',i
      print *,'Splitfile number =',j
      print *,'Work in Progress...'

      write(*,*) fuo
      open(56, file=fuo, position='append',form='binary')
      write(56) craw5
      close(56)

      write(*,*) fvo
      open(66, file=fvo, position='append',form='binary')
      write(66) craw6
      close(66)

      do k=1,nvec_x_cut
          do l=1,nvec_y
            do m=1,nzlast
              craw5cut(k,l,m)=craw5(k+discard_vec,l,m)
              craw6cut(k,l,m)=craw6(k+discard_vec,l,m)
            enddo
          enddo
       enddo

      write(*,*) fuco
      open(76, file=fuco, position='append',form='binary')
      write(76) craw5cut
      close(76)

      write(*,*) fvco
      open(86, file=fvco, position='append',form='binary')
      write(86) craw6cut
      close(86)

  enddo

  write(*,*) 'Operated Correctly!'
  print *,'nvec_x_cut =',nvec_x_cut

  stop
  end
