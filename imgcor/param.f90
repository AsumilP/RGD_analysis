  module param
  implicit none
  !param shared
  integer, parameter :: nterm = 14
  integer, parameter :: ndim = 2! 2 (X and Y)

  ! param for camera
  integer, parameter :: nx = 1024   !PIXEL RESOLUTION
  integer, parameter :: ny = 1024
  ! logical, parameter :: xflip = .false. ! flip image in x, plif, br, fl
  logical, parameter :: xflip = .true. ! true for chem, bl, fr
  logical, parameter :: yflip = .false.  ! flip image in y, always false
  logical, parameter :: iflip = .true.  ! flip image intensity: enable to set cross as bright (white cross on black background)
  integer, parameter :: flag_skip = 0 ! camera bit depth
  integer, parameter :: nbit_c = 16 ! camera bit depth
  integer, parameter :: nbit_r = 12 ! record bit depth which is assumed to be 16 bit for ES4020
  integer, parameter :: head_size = 0 ! header size [Byte]

  ! param for xc
  integer, parameter :: nxc = 13 !INTERROGATION SIZE
  integer, parameter :: nyc = 13 !
  integer, parameter :: width_x = 2
  integer, parameter :: width_y = 2
  integer, parameter :: radius = 13 !NOT diameter
  ! param for ls
  real(8), parameter :: threshold = 0.72d0  ! for ccc
  real(8), parameter :: threshold_o = 0.60d0 ! for ccco
  real(8), parameter :: grid_interval = 2.0d0  ! [mm]


 !!! param for imgcor  ---------------------------------------

  integer, parameter :: nx_cor = 1024
  integer, parameter :: ny_cor = 1024
  !integer, parameter :: nx_cor = 1024   ! pixel resolution (after)
  !integer, parameter :: ny_cor = 980
  integer, parameter :: imgloc_physorig_x = 130 ! position of physical origin in corrected image
  integer, parameter :: imgloc_physorig_y = 370
  ! integer, parameter :: nimg_per_file = 1 !imgcor for cold flow
  integer, parameter :: nimg_per_file = 21839  ! number of image, grid
  !integer, parameter :: nimg_per_file = 10
  real(8), parameter :: img_res_x = 80d-3  ! [mm/pixel]
  real(8), parameter :: img_res_y = 75d-3  ! [mm/pixel]


  ! param for file

!  character(*), parameter:: cam_n = '1'
! character(*), parameter:: gpos = '7' !!grid position
!  character(*), parameter:: quantity = '140'!!quantity of flow
!  character(*), parameter:: rev = '1'
   character(*), parameter:: file_name_head ='grid_ch'
!  character(*), parameter:: file_name_head_particle = 'cam'//cam_n//'_q'//quantity

 ! 'q'//quantity//'_cam'//cam_n//'_r'//rev

!!  character(*), parameter:: file_name_head_particle = file_name_head

  !! xc
  character(*), parameter:: path_of_grid_raw = '/home/yatagi/mnt/20201219/imgcor/' !input file directory
  character(*), parameter:: path_of_grid_ccc = '/home/yatagi/mnt/20201219/imgcor/' !output file directory
  ! character(*), parameter:: file_name_raw = 'chem_grid_av.dat'      !input file name
  ! character(*), parameter:: file_name_ccc = 'chem_ccc.dat'     !output file name
  ! character(*), parameter:: file_name_ccco = 'chem_cco.dat' !output file name
  ! character(*), parameter:: file_name_raw = 'spiv_fl_grid_av.dat'      !input file name
  ! character(*), parameter:: file_name_ccc = 'spiv_fl_ccc.dat'     !output file name
  ! character(*), parameter:: file_name_ccco = 'spiv_fl_cco.dat' !output file name
  character(*), parameter:: file_name_raw = 'spiv_fr_grid_av.dat'      !input file name
  character(*), parameter:: file_name_ccc = 'spiv_fr_ccc.dat'     !output file name
  character(*), parameter:: file_name_ccco = 'spiv_fr_cco.dat' !output file name
  ! character(*), parameter:: file_name_raw = 'spiv_br_grid_av.dat'      !input file name
  ! character(*), parameter:: file_name_ccc = 'spiv_br_ccc.dat'     !output file name
  ! character(*), parameter:: file_name_ccco = 'spiv_br_cco.dat' !output file name

  !! ls
  character(*), parameter:: path_of_coe = '/home/yatagi/grid_cor/20201218/fr/' !output
  ! character(*), parameter:: path_of_coe = '/home/yatagi/mnt/20201218/imgcor/' !output
  ! character(*), parameter:: file_name_coe ='chem_grid_cor.txt'
  ! character(*), parameter:: file_name_coe ='spiv_fl_grid_cor.txt'
  character(*), parameter:: file_name_coe ='spiv_fr_grid_cor.txt'
  ! character(*), parameter:: file_name_coe ='spiv_br_grid_cor.txt'

  !! imgcor

   !!Have to Change whether grid or particle-------------------------------------------------------
  !character(*), parameter:: path_of_particle_raw = '/home/yatagi/analysis/grid_output/20190227/spiv_bl/'!for grid
  character(*), parameter:: path_of_particle_raw = '/home/yatagi/mnt/20201218/raw/' !for flow
  !character(*), parameter:: path_of_particle_raw = '/home/yatagi/analysis/piv_output/rmvnoise_particle/20181218/spiv_fr/'

  ! character(*), parameter:: file_name_rawi = 'chem_grid_av' !input file name
  ! character(*), parameter:: file_name_rawi = 'spiv_fr_grid_av' !input file name
  character(*), parameter:: file_name_rawi = 'spiv_fr_16'  !for cold flow

  character(*), parameter:: file_name_rawmean  ='x2_mean'                 !output file name --> mean
   !!end--------------------------------------------------------------------------------------------

  character(*), parameter:: file_name_coe_r = file_name_coe
  !character(*), parameter:: file_name_coe_r = 'chem_grid_cor.txt'
                                        !change with path_of_coe at ls

  ! character(*), parameter:: path_of_particle_corrected = '/home/yatagi/analysis/grid_output/20190228/spiv_fr/'
  !character(*), parameter:: path_of_particle_corrected = '/home/yatagi/analysis/chem_output/20181129/'
  !character(*), parameter:: path_of_particle_corrected = '/home/yatagi/analysis/plif_output/20190821/plif_cor/'
  character(*), parameter:: path_of_particle_corrected = '/home/yatagi/mnt/20201218/imgcor/'
  !character(*), parameter:: path_of_particle_corrected = '/home/yatagi/analysis/piv_output/flow_cor/20181218/rmvnoise_cor/spiv_fr/'

  !character(*), parameter:: file_name_rawo  = file_name_rawi
  ! character(*), parameter:: file_name_rawo  = 'chem_grid_cor' !output name
  character(*), parameter:: file_name_rawo  = 'spiv_fr_16_cor' !output name

  !character(*), parameter:: file_name_rawi  = file_name_head_particle
  !character(*), parameter:: file_name_rawo  = file_name_head_particle
  !character(*), parameter:: file_name_rawmean  =file_name_head_particle//'c_gpos'//gpos//'_mean'
  !character(*), parameter:: file_name_rawo  = file_name_head


  character(*), parameter:: file_ext_rawi  = '.mraw' !grid-dat, cold-mraw
  ! character(*), parameter:: file_ext_rawi  = '.mraw' !grid-dat, cold-mraw
  character(*), parameter:: file_ext_rawo  = '.dat'




  ! param in general
  integer, parameter :: debug = 1 ! debug level, 0: quiet, 1:helpful, 2: verbose, 3: nauseous
end module param
