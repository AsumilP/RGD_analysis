!< \brief detect peak in correlation map
subroutine detect_peak_corr_map(ixcorr,niw_xl,niw_yl,iimax,jjmax,ppmax,xx,yy,rank,fflag)
  implicit none
  integer, intent(in):: rank
  integer, intent(in):: niw_xl,niw_yl
  real(8), intent(in):: ixcorr(niw_xl,niw_yl)
  integer, intent(out):: iimax(rank)
  integer, intent(out):: jjmax(rank)
  real(8), intent(out):: ppmax(rank)
  real(8), intent(out):: xx(rank)
  real(8), intent(out):: yy(rank)
  integer(8), intent(out):: fflag(rank)

  !  integer,allocatable:: iimax(:)
  !  integer,allocatable:: jjmax(:)
  !  real(8),allocatable:: ppmax(:)
  !  real(8),allocatable:: xx(:)
  !  real(8),allocatable:: yy(:)
  integer:: i,j
  integer:: imax,jmax
  real(8):: pmax,x,y
  real(8):: distance_from_pmax1
  real(8):: distance_from_pmax2
  real(8):: distance_far_enough=10.d0

  !  allocate(iimax(rank))
  !  allocate(jjmax(rank))
  !  allocate(ppmax(rank))
  !  allocate(xx(rank))
  !  allocate(yy(rank))

  imax=0
  jmax=0
  pmax=0.d0
  X=0.d0
  Y=0.d0

  ppmax(1:rank)=0.d0

  do j=1,niw_yl
    do i=1,niw_xl
      if(pmax < ixcorr(i,j)) then
        pmax= ixcorr(i,j)
        x=dble(I-(niw_xl/2+1))
        y=dble(J-(niw_yl/2+1))
        imax=i
        jmax=j
      endif
    enddo
  enddo
  ppmax(1)=pmax
  iimax(1)=imax
  jjmax(1)=jmax
  xx(1)=x
  yy(1)=y

  if((imax==1).or.(imax==niw_xl)) then
    fflag(1)=52
  !    print *, 'correlation peak is on the X_edge'
  elseif((jmax==1).or.(jmax==niw_yl)) then
    fflag(1)=54
  !    print *, 'correlation peak is on the Y_edge'
  elseif(pmax==0.0D0) then
    fflag(1)=56
  !    print *, 'No particles detected'
  elseif(ixcorr(imax-1,jmax)<=0.0D0.or.ixcorr(imax+1,jmax)<=0.0D0.or.ixcorr(imax,jmax-1)<=0.0D0.or.ixcorr(imax,jmax+1)<=0.0D0) then
    fflag(1)=58
  !    print *, 'correlation shape is strange'
  else
    fflag(1)=1
  endif

  if (rank>1) then
    pmax=0.d0
    imax=0
    jmax=0
    do j=1,niw_yl
      do i=1,niw_xl
        distance_from_pmax1=sqrt(dble((i-iimax(1))**2+(j-jjmax(1))**2))
        if(pmax < ixcorr(i,j).and.distance_from_pmax1>distance_far_enough) then
          pmax= ixcorr(i,j)
          x=dble(I-(niw_xl/2+1))
          y=dble(J-(niw_yl/2+1))
          imax=i
          jmax=j
        endif
      enddo
    enddo
    ppmax(2)=pmax
    iimax(2)=imax
    jjmax(2)=jmax
    xx(2)=x
    yy(2)=y
    if((imax==1).or.(imax==niw_xl)) then
      fflag(2)=52
    !    print *, 'correlation peak is on the X_edge'
    elseif((jmax==1).or.(jmax==niw_yl)) then
      fflag(2)=54
    !    print *, 'correlation peak is on the Y_edge'
    elseif(pmax==0.0D0) then
      fflag(2)=56
    !    print *, 'No particles detected'
    elseif(ixcorr(imax-1,jmax)<=0.0D0.or.ixcorr(imax+1,jmax)<=0.0D0 &
    .or. ixcorr(imax,jmax-1)<=0.0D0.or.ixcorr(imax,jmax+1)<=0.0D0) then
      fflag(2)=58
    !    print *, 'correlation shape is strange'
    else
      fflag(2)=1
    endif

  endif

  if (rank>2) then
    pmax=0.d0
    imax=0
    jmax=0
    do j=1,niw_yl
      do i=1,niw_xl
        distance_from_pmax1=sqrt(dble((i-iimax(1))**2+(j-jjmax(1))**2))
        distance_from_pmax2=sqrt(dble((i-iimax(2))**2+(j-jjmax(2))**2))
        if(pmax < ixcorr(i,j).and.distance_from_pmax1>distance_far_enough &
        .and.distance_from_pmax2>distance_far_enough) then
          pmax= ixcorr(i,j)
          x=dble(I-(niw_xl/2+1))
          y=dble(J-(niw_yl/2+1))
          imax=i
          jmax=j
        endif
      enddo
    enddo
    ppmax(3)=pmax
    iimax(3)=imax
    jjmax(3)=jmax
    xx(3)=x
    yy(3)=y
    if((imax==1).or.(imax==niw_xl)) then
      fflag(3)=52
    !    print *, 'correlation peak is on the X_edge'
    elseif((jmax==1).or.(jmax==niw_yl)) then
      fflag(3)=54
    !    print *, 'correlation peak is on the Y_edge'
    elseif(pmax==0.0D0) then
      fflag(3)=56
    !    print *, 'No particles detected'
    elseif(ixcorr(imax-1,jmax)<=0.0D0.or.ixcorr(imax+1,jmax)<=0.0D0 &
    .or.ixcorr(imax,jmax-1)<=0.0D0.or.ixcorr(imax,jmax+1)<=0.0D0) then
      fflag(3)=58
    !    print *, 'correlation shape is strange'
    else
      fflag(3)=1
    endif

  endif
end subroutine detect_peak_corr_map

