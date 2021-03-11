    clc
    clear all
    close all

%% Parameters 1

    type=1; % 1.trans, 2.all
    flow_rate=500;
    equivalence_ratio=0.68;%%%
    specific_f=0;%%%
    duct_l=1185;
    hpsfreq=20;
    lpsfreq=300;
    date=20190821;
    num=3;

    %SPIV
    dir_i=sprintf('I:/Analysis/piv_output/velofield/%d/comblps',date);
    % dir_i=sprintf('I:/Analysis/piv_output/velofield/%d/combined',date);
    if type == 1
      dir_o=sprintf('E:/Analysis/piv_output/velophasemeanfield/trans/');
      dir_f=sprintf('E:/Analysis/piv_output/velophasemeanfield/trans/figure/%d_%02u/',date,num);
    elseif type == 2
      dir_o=sprintf('E:/Analysis/piv_output/chem_phasemean/mode/');
      dir_f=sprintf('E:/Analysis/piv_output/chem_phasemean/mode/figure/%d_%02u/',date,num);
    end

    dir_p=sprintf('I:/Analysis/pressure/%d/calc/',date);

%% Parameters 2

    calc_start_time=1.7444; % mode=1, trans_start_time
    calc_fin_time=1.9723; % mode=1, trans_fin_time
    trig_time=2.3932; % mode=1
    % calc_start_time=3.0647; % mode=2
    % calc_fin_time=calc_start_time+1.09195; % mode=2
    % trig_time=calc_start_time; % mode=2

    nx=191;
    ny=121;
    % ny=123;
    ny_start=4;
    ny_end=101;
    % ny_start=8;
    % ny_end=105;
    ny_calc=ny_end - ny_start +1;
    nzall=21838;
    Fs_press=20e3;
    Fs_spiv=20e3;
    pres_samp_time=10; % [sec]
    div=10;
    vec_spc_x=8;
    vec_spc_y=8;
    img_res_x=80*10^(-3);
    img_res_y=75*10^(-3);
    wmin=-10; % [m/s]
    wmax=10; % [m/s]
    nincrement=3;
    quivermode=1;

%% Parameters 3

    vissw=1;
    svsw=1;
    maxcnt_st1=1;
    maxcnt_st2=1;
    maxcnt_st3=1;
    maxcnt_st4=1;
    maxcnt_st5=1;
    maxcnt_st6=1;
    maxcnt_st7=1;
    maxcnt_st8=1;
    maxcnt_st9=1;
    maxcnt_st10=1;
    infdowncnt_st1=1;
    infdowncnt_st2=1;
    infdowncnt_st3=1;
    infdowncnt_st4=1;
    infdowncnt_st5=1;
    infdowncnt_st6=1;
    infdowncnt_st7=1;
    infdowncnt_st8=1;
    infdowncnt_st9=1;
    infdowncnt_st10=1;
    mincnt_st1=1;
    mincnt_st2=1;
    mincnt_st3=1;
    mincnt_st4=1;
    mincnt_st5=1;
    mincnt_st6=1;
    mincnt_st7=1;
    mincnt_st8=1;
    mincnt_st9=1;
    mincnt_st10=1;
    infupcnt_st1=1;
    infupcnt_st2=1;
    infupcnt_st3=1;
    infupcnt_st4=1;
    infupcnt_st5=1;
    infupcnt_st6=1;
    infupcnt_st7=1;
    infupcnt_st8=1;
    infupcnt_st9=1;
    infupcnt_st10=1;

%% Matrix

    Sts_spiv=1/Fs_spiv; % [sec]
    Sts_press=1/Fs_press; % [sec]
    pres_datasize=Fs_press*pres_samp_time;
    taxis=Sts_press:Sts_press:pres_samp_time;
    dx=img_res_x*vec_spc_x; % [mm]
    dy=img_res_y*vec_spc_y; % [mm]
    if type == 1
      cam_start_time = trig_time - Sts_spiv*nzall
      cam_start_data=floor(trig_time/Sts_press)-nzall
      before_transition_data=floor(nzall -(trig_time - calc_start_time)/Sts_press)
      while_transition_data = floor((calc_fin_time - calc_start_time)/Sts_press)
      calc_data=floor((calc_fin_time - calc_start_time)/(div*Sts_press))
      fn_ui=sprintf('spiv_fbsc_%02u_ucl.dat',num);
      fn_vi=sprintf('spiv_fbsc_%02u_vcl.dat',num);
      fn_wi=sprintf('spiv_fbsc_%02u_wcl.dat',num);
      % fn_ui=sprintf('spiv_fbsc_%02u_u.dat',num);
      % fn_vi=sprintf('spiv_fbsc_%02u_v.dat',num);
      % fn_wi=sprintf('spiv_fbsc_%02u_w.dat',num);
      fn_p=sprintf('PDown_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
      fn_umax=sprintf('phasemean_umax_%d_%d_%02u',flow_rate,date,num);
      fn_uinfdown=sprintf('phasemean_uinfdown_%d_%d_%02u',flow_rate,date,num);
      fn_umin=sprintf('phasemean_umin_%d_%d_%02u',flow_rate,date,num);
      fn_uinfup=sprintf('phasemean_uinfup_%d_%d_%02u',flow_rate,date,num);
      fn_vmax=sprintf('phasemean_vmax_%d_%d_%02u',flow_rate,date,num);
      fn_vinfdown=sprintf('phasemean_vinfdown_%d_%d_%02u',flow_rate,date,num);
      fn_vmin=sprintf('phasemean_vmin_%d_%d_%02u',flow_rate,date,num);
      fn_vinfup=sprintf('phasemean_vinfup_%d_%d_%02u',flow_rate,date,num);
      fn_wmax=sprintf('phasemean_wmax_%d_%d_%02u',flow_rate,date,num);
      fn_winfdown=sprintf('phasemean_winfdown_%d_%d_%02u',flow_rate,date,num);
      fn_wmin=sprintf('phasemean_wmin_%d_%d_%02u',flow_rate,date,num);
      fn_winfup=sprintf('phasemean_winfup_%d_%d_%02u',flow_rate,date,num);
      fn_max=sprintf('phasemean_max_%d_%d_%02u',flow_rate,date,num);
      fn_infdown=sprintf('phasemean_infdown_%d_%d_%02u',flow_rate,date,num);
      fn_min=sprintf('phasemean_min_%d_%d_%02u',flow_rate,date,num);
      fn_infup=sprintf('phasemean_infup_%d_%d_%02u',flow_rate,date,num);
    elseif type == 2
      cam_start_time = trig_time
      cam_start_data = floor(trig_time/Sts_press)
      before_transition_data = floor((calc_start_time - trig_time)/Sts_spiv)
      while_transition_data = floor((calc_fin_time - calc_start_time)/Sts_spiv)
      calc_data = floor((calc_fin_time - calc_start_time)/(div*Sts_spiv))
      % fn_ui=sprintf('spiv_fbsc_%02u_ucl.dat',num);
      % fn_vi=sprintf('spiv_fbsc_%02u_vcl.dat',num);
      % fn_wi=sprintf('spiv_fbsc_%02u_wcl.dat',num);
      % fn_ui=sprintf('spiv_fbsc_%02u_u.dat',num);
      % fn_vi=sprintf('spiv_fbsc_%02u_v.dat',num);
      % fn_wi=sprintf('spiv_fbsc_%02u_w.dat',num);
      % fn_p=sprintf('PDown_%d_%.2f_piv_%dHz_d%d_hps%d_lps%d.dat',flow_rate,equivalence_ratio,specific_f,duct_l,hpsfreq,lpsfreq);
      % fn_umax=sprintf('phasemean_umax_%d_%d_%02u',flow_rate,date,num);
      % fn_uinfdown=sprintf('phasemean_uinfdown_%d_%d_%02u',flow_rate,date,num);
      % fn_umin=sprintf('phasemean_umin_%d_%d_%02u',flow_rate,date,num);
      % fn_uinfup=sprintf('phasemean_uinfup_%d_%d_%02u',flow_rate,date,num);
      % fn_vmax=sprintf('phasemean_vmax_%d_%d_%02u',flow_rate,date,num);
      % fn_vinfdown=sprintf('phasemean_vinfdown_%d_%d_%02u',flow_rate,date,num);
      % fn_vmin=sprintf('phasemean_vmin_%d_%d_%02u',flow_rate,date,num);
      % fn_vinfup=sprintf('phasemean_vinfup_%d_%d_%02u',flow_rate,date,num);
      % fn_wmax=sprintf('phasemean_wmax_%d_%d_%02u',flow_rate,date,num);
      % fn_winfdown=sprintf('phasemean_winfdown_%d_%d_%02u',flow_rate,date,num);
      % fn_wmin=sprintf('phasemean_wmin_%d_%d_%02u',flow_rate,date,num);
      % fn_winfup=sprintf('phasemean_winfup_%d_%d_%02u',flow_rate,date,num);
    end

%% Search phases

    [p_fil,locs_presmax,pks_pres,locs_inflectdown,locs_presmin,locs_inflectup] = search_phase(dir_p,fn_p,pres_datasize);

%% check phases

    phase_vis(taxis,p_fil,calc_start_time,calc_fin_time,locs_presmax,pks_pres,locs_inflectdown,locs_presmin,locs_inflectup)

%% Calculation, PHASE MEAN, max

    velo_pick_phase_dist(dir_i,fn_ui,fn_vi,fn_wi,dir_o,fn_umax,fn_vmax,fn_wmax,fn_max,...
             locs_presmax,cam_start_data,before_transition_data,calc_start_time,...
             calc_data,nx,ny,ny_calc,maxcnt_st1,maxcnt_st2,maxcnt_st3,maxcnt_st4,maxcnt_st5,...
             maxcnt_st6,maxcnt_st7,maxcnt_st8,maxcnt_st9,maxcnt_st10,vissw,svsw,...
             nincrement,dx,dy,wmin,wmax,quivermode,dir_f)

%% Calculation, PHASE MEAN, inflectdown

    velo_pick_phase_dist(dir_i,fn_ui,fn_vi,fn_wi,dir_o,fn_uinfdown,fn_vinfdown,fn_winfdown,fn_infdown,...
             locs_inflectdown,cam_start_data,before_transition_data,calc_start_time,...
             calc_data,nx,ny,ny_calc,infdowncnt_st1,infdowncnt_st2,infdowncnt_st3,infdowncnt_st4,infdowncnt_st5,...
             infdowncnt_st6,infdowncnt_st7,infdowncnt_st8,infdowncnt_st9,infdowncnt_st10,vissw,svsw,...
             nincrement,dx,dy,wmin,wmax,quivermode,dir_f)

%% Calculation, PHASE MEAN, min

    velo_pick_phase_dist(dir_i,fn_ui,fn_vi,fn_wi,dir_o,fn_umin,fn_vmin,fn_wmin,fn_min,...
             locs_presmin,cam_start_data,before_transition_data,calc_start_time,...
             calc_data,nx,ny,ny_calc,mincnt_st1,mincnt_st2,mincnt_st3,mincnt_st4,mincnt_st5,...
             mincnt_st6,mincnt_st7,mincnt_st8,mincnt_st9,mincnt_st10,vissw,svsw,...
             nincrement,dx,dy,wmin,wmax,quivermode,dir_f)

%% Calculation, PHASE MEAN, inflectup

    velo_pick_phase_dist(dir_i,fn_ui,fn_vi,fn_wi,dir_o,fn_uinfup,fn_vinfup,fn_winfup,fn_infup,...
             locs_inflectup,cam_start_data,before_transition_data,calc_start_time,...
             calc_data,nx,ny,ny_calc,infupcnt_st1,infupcnt_st2,infupcnt_st3,infupcnt_st4,infupcnt_st5,...
             infupcnt_st6,infupcnt_st7,infupcnt_st8,infupcnt_st9,infupcnt_st10,vissw,svsw,...
             nincrement,dx,dy,wmin,wmax,quivermode,dir_f)
