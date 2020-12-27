!< brief check available nfft
subroutine check_nfft(c_nfft)
  implicit none
  integer, intent(in):: c_nfft
  integer, parameter :: N_nfft = 43
  integer, parameter :: nfft_list(N_nfft) = &
  (/12,15,16,18,20,24,25,27,30,32,36,40,45,48,50,54,60,64,72,75,80,81,90,96, &
   100,108,120,125,128,135,144,150,160,162,180,192,200,216,225,240,243,250,256/)

  integer :: idx_closest_nfft(1), closest_nfft

  integer :: rlist_res(N_nfft)
  integer :: rlist_resmin
  rlist_res=abs(nfft_list-c_nfft)

  idx_closest_nfft=minloc(rlist_res)
  closest_nfft=nfft_list(idx_closest_nfft(1))

  if (closest_nfft/=c_nfft) then
    print "(A,i4)", 'NO FFT RADIX COMBINATION IS DEFINED FOR NIW=',c_nfft
    print "(A,i4)", 'CLOSEST AVAILABLE ONE IS =', closest_nfft
    STOP
  endif


end subroutine check_nfft

!< brief setting fft radix
subroutine get_fft_radix_size(nfft,nfx)
  implicit none
  integer,intent(in):: nfft
  integer,intent(out):: nfx

  if (nfft==12) then
    nfx=3
  elseif (nfft==15) then
    nfx=2
  elseif(nfft==16) then
    nfx=3
  elseif(nfft==18) then
    nfx=3
  elseif(nfft==20) then
    nfx=3
  elseif(nfft==24) then
    nfx=3
  elseif (nfft==25) then
    nfx=2
  elseif (nfft==27) then
    nfx=3
  elseif(nfft==30) then
    nfx=3
  elseif(nfft==32) then
    nfx=3
  elseif(nfft==36) then
    nfx=3
  elseif(nfft==40) then
    nfx=3
  elseif(nfft==45) then
    nfx=3
  elseif(nfft==48) then
    nfx=3
  elseif(nfft==50) then
    nfx=3
  elseif(nfft==54) then
    nfx=3
  elseif(nfft==60) then
    nfx=3
  elseif(nfft==64) then
    nfx=3
  elseif(nfft==72) then
    nfx=3
  elseif(nfft==75) then
    nfx=3
  elseif(nfft==80) then
    nfx=3
  elseif(nfft==81) then
    nfx=3
  elseif(nfft==90) then
    nfx=3
  elseif (nfft==96) then
    nfx=3
  elseif (nfft==100) then
    nfx=3
  elseif (nfft==108) then
    nfx=3
  elseif (nfft==120) then
    nfx=3
  elseif (nfft==125) then
    nfx=3
  elseif (nfft==128) then
    nfx=3
  elseif (nfft==135) then
    nfx=3
  elseif (nfft==144) then
    nfx=3
  elseif (nfft==150) then
    nfx=3
  elseif (nfft==160) then
    nfx=3
  elseif (nfft==162) then
    nfx=3
  elseif (nfft==180) then
    nfx=3
  elseif (nfft==192) then
    nfx=3
  elseif (nfft==200) then
    nfx=3
  elseif (nfft==216) then
    nfx=3
  elseif (nfft==225) then
    nfx=3
  elseif (nfft==240) then
    nfx=3
  elseif (nfft==243) then
    nfx=3
  elseif (nfft==250) then
    nfx=4
  elseif (nfft==256) then
    nfx=3
  else
    print "(A,i4)", 'NO FFT RADIX COMBINATION IS DEFINED FOR NIW=',nfft
    STOP
  endif

end subroutine get_fft_radix_size

!< brief setting fft radix
subroutine get_fft_radix(nfft,nfx,ifx)
  implicit none
  integer,intent(in):: nfft
  integer,intent(in):: nfx
  integer,intent(out):: ifx(nfx)

  if (nfft==12) then
    ifx(1)=2
    ifx(2)=2
    ifx(3)=3
  elseif (nfft==15) then
    ifx(1)=3
    ifx(2)=5
  elseif(nfft==16) then
    ifx(1)=2
    ifx(2)=2
    ifx(3)=4
  elseif(nfft==18) then
    ifx(1)=2
    ifx(2)=3
    ifx(3)=3
  elseif(nfft==20) then
    ifx(1)=2
    ifx(2)=2
    ifx(3)=5
  elseif(nfft==24) then
    ifx(1)=2
    ifx(2)=3
    ifx(3)=4
  elseif(nfft==25) then
    ifx(1)=5
    ifx(2)=5
  elseif(nfft==27) then
    ifx(1)=3
    ifx(2)=3
    ifx(3)=3
  elseif(nfft==30) then
    ifx(1)=2
    ifx(2)=3
    ifx(3)=5
  elseif(nfft==32) then
    ifx(1)=2
    ifx(2)=4
    ifx(3)=4
  elseif(nfft==36) then
    ifx(1)=3
    ifx(2)=3
    ifx(3)=4
  elseif(nfft==40) then
    ifx(1)=2
    ifx(2)=4
    ifx(3)=5
  elseif(nfft==45) then
    ifx(1)=3
    ifx(2)=3
    ifx(3)=5
  elseif(nfft==48) then
    ifx(1)=3
    ifx(2)=4
    ifx(3)=4
  elseif(nfft==50) then
    ifx(1)=2
    ifx(2)=5
    ifx(3)=5
  elseif(nfft==54) then
    ifx(1)=3
    ifx(2)=3
    ifx(3)=6
  elseif(nfft==60) then
    ifx(1)=3
    ifx(2)=4
    ifx(3)=5
  elseif(nfft==64) then
    ifx(1)=4
    ifx(2)=4
    ifx(3)=4
  elseif(nfft==72) then
    ifx(1)=3
    ifx(2)=4
    ifx(3)=6
  elseif(nfft==75) then
    ifx(1)=3
    ifx(2)=5
    ifx(3)=5
  elseif(nfft==80) then
    ifx(1)=4
    ifx(2)=4
    ifx(3)=5
  elseif(nfft==81) then
    ifx(1)=3
    ifx(2)=3
    ifx(3)=9
  elseif(nfft==90) then
    ifx(1)=3
    ifx(2)=5
    ifx(3)=6
  elseif (nfft==96) then
    ifx(1)=4
    ifx(2)=4
    ifx(3)=6
  elseif (nfft==100) then
    ifx(1)=4
    ifx(2)=5
    ifx(3)=5
  elseif (nfft==108) then
    ifx(1)=3
    ifx(2)=6
    ifx(3)=6
  elseif (nfft==120) then
    ifx(1)=4
    ifx(2)=5
    ifx(3)=6
  elseif (nfft==125) then
    ifx(1)=5
    ifx(2)=5
    ifx(3)=5
  elseif (nfft==128) then
    ifx(1)=4
    ifx(2)=4
    ifx(3)=8
  elseif (nfft==135) then
    ifx(1)=3
    ifx(2)=5
    ifx(3)=9
  elseif (nfft==144) then
    ifx(1)=4
    ifx(2)=6
    ifx(3)=6
  elseif (nfft==150) then
    ifx(1)=5
    ifx(2)=5
    ifx(3)=6
  elseif (nfft==160) then
    ifx(1)=4
    ifx(2)=5
    ifx(3)=8
  elseif (nfft==162) then
    ifx(1)=3
    ifx(2)=6
    ifx(3)=9
  elseif (nfft==180) then
    ifx(1)=4
    ifx(2)=5
    ifx(3)=9
  elseif (nfft==192) then
    ifx(1)=4
    ifx(2)=6
    ifx(3)=8
  elseif (nfft==200) then
    ifx(1)=5
    ifx(2)=5
    ifx(3)=8
  elseif (nfft==216) then
    ifx(1)=4
    ifx(2)=6
    ifx(3)=9
  elseif (nfft==225) then
    ifx(1)=5
    ifx(2)=5
    ifx(3)=9
  elseif (nfft==240) then
    ifx(1)=5
    ifx(2)=6
    ifx(3)=8
  elseif (nfft==243) then
    ifx(1)=3
    ifx(2)=9
    ifx(3)=9
  elseif (nfft==250) then
    ifx(1)=2
    ifx(2)=5
    ifx(3)=5
    ifx(4)=5
  elseif (nfft==256) then
    ifx(1)=4
    ifx(2)=8
    ifx(3)=8
  else
    print "(A,i4)", 'NO FFT RADIX COMBINATION IS DEFINED FOR NIW=',nfft
    STOP
  endif

end subroutine get_fft_radix
