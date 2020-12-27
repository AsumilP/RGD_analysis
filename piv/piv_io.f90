subroutine write_pivdata_fbin(disp_x,disp_y,ccc,flag,outfilepath,append)
  use piv_param
  implicit none
  real(8),intent(in):: disp_x(nvec_x,nvec_y)
  real(8),intent(in):: disp_y(nvec_x,nvec_y)
  real(8),intent(in):: ccc(nvec_x,nvec_y)
  integer(8),intent(in):: flag(nvec_x,nvec_y)
  character(*),intent(in):: outfilepath
  logical,intent(in):: append

  if (append) then
!    print *, "append!"
   open(10,file=trim(outfilepath),access='stream',position='append',form='unformatted')
  else
!    print *, "overwrite!"
   open(10,file=trim(outfilepath),access='stream',status='replace',form='unformatted')
  endif

  write(10) disp_x, disp_y, ccc, flag

  close(10)

end subroutine write_pivdata_fbin

!! parameter is_odd controlling if the first image should be skipped or not is specified in piv_param.f90
subroutine read_fbinimgpair(img1,img2,nx,ny,img_filepath,piv_idx)
  use piv_param
  implicit none
  integer,intent(in):: nx
  integer,intent(in):: ny
  real(8),intent(inout):: img1(nx,ny)
  real(8),intent(inout):: img2(nx,ny)
  character(*), intent(in):: img_filepath
  integer,intent(in)::piv_idx
  integer(2):: iimg1(nx,ny)
  integer(2):: iimg2(nx,ny)
!  integer(2):: itmp(nx,ny)
!  integer:: i,j,status
  real(8):: tic, toc !> elapsed time measurement
  integer(8):: byte_per_img,nimg_jump,nbytejump
  call cpu_time( tic )

  byte_per_img = inx*iny*2
  nimg_jump = piv_idx-1
  nbytejump = byte_per_img*nimg_jump+nbytehead

  if (is_odd) then
    nbytejump = nbytejump+byte_per_img
  endif

  print *, "idx: ",piv_idx
  print *, "nbj: ",nbytejump/1024/1024, "MB"

  nbytejump=nbytejump+1
  open(30,file=img_filepath,access="stream",form='unformatted')
  read(30,pos=nbytejump) iimg1
  read(30) iimg2
  close(30)
  img1=dble(iimg1)
  img2=dble(iimg2)

  call cpu_time( toc )

end  subroutine read_fbinimgpair


subroutine read_fbinimg(img,nx,ny,img_filepath)
  use piv_param
  implicit none
  integer,intent(in):: nx
  integer,intent(in):: ny
  real(8),intent(inout):: img(nx,ny)
  character(*), intent(in):: img_filepath
  integer(2):: iimg(nx,ny)

  open(30,file=img_filepath,access="stream",form='unformatted')
  read(30) iimg
  close(30)
  img=dble(iimg)
end  subroutine read_fbinimg
