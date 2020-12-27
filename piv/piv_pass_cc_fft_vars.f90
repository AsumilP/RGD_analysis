module fft_vars_module
  implicit none
  real(8), save :: wif3,wib3
  real(8), save :: wrf5,wif5,wrb5,wib5,wr2f5,wi2f5,wr2b5,wi2b5
  real(8), save :: wif6,wib6
  real(8), save :: wrf8,wrb8
  real(8), save :: wrf9,wif9,wrb9,wib9,wr2f9,wi2f9,wr2b9,wi2b9,wr3f9,wi3f9,wr3b9,wi3b9,wr4f9,wi4f9,wr4b9,wi4b9
end module fft_vars_module

module fft_shared
  implicit none
  INTEGER,allocatable,save:: IFX(:),IFY(:)
  real(8),allocatable,save:: TRFX(:),TRBX(:),TIFX(:),TIBX(:)
  real(8),allocatable,save:: TRFY(:),TRBY(:),TIFY(:),TIBY(:)
  INTEGER,allocatable,save:: LISTI1(:,:),LISTJ1(:,:),LISTK1(:,:)
  INTEGER,allocatable,save:: LISTI2(:,:),LISTJ2(:,:),LISTK2(:,:)
end module fft_shared
