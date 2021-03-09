    clc
    clear all
    close all

%% Parameters 1

    type=1; % 1.trans, 2.all
    flow_rate=400;
    equivalence_ratio=0.68;%%%
    specific_f=0;%%%
    duct_l=1185;
    hpsfreq=20;
    lpsfreq=300;
    date=20190819;
    num=3;

    %CHEM.
    dir_i=sprintf('D:/Analysis/chem_output/chem_rmv/%d/',date);
    if type == 1
      dir_o=sprintf('E:/Analysis/chem_output/chem_phasemean/trans/');
      dir_f=sprintf('E:/Analysis/chem_output/chem_phasemean/trans/figure/%d_%02u/',date,num);
    elseif type == 2
      dir_o=sprintf('E:/Analysis/chem_output/chem_phasemean/mode/');
      dir_f=sprintf('E:/Analysis/chem_output/chem_phasemean/mode/figure/%d_%02u/',date,num);
    end

    %PLIF
    % dir_i=sprintf('H:/Analysis/plif_output/plif_med/%d/',date);
    % if type == 1
    %   dir_o=sprintf('H:/Analysis/plif_output/plif_phasemean/trans/');
    %   dir_f=sprintf('H:/Analysis/plif_output/plif_phasemean/trans/figure/%d_%02u/',date,num);
    % elseif type == 2
    %   dir_o=sprintf('H:/Analysis/plif_output/plif_phasemean/mode/');
    %   dir_f=sprintf('H:/Analysis/plif_output/plif_phasemean/mode/figure/%d_%02u/',date,num);
    % end

    dir_p=sprintf('I:/Analysis/pressure/%d/calc/',date);

%% Parameters 2

    calc_start_time=3.5123; % mode=1, trans_start_time
    calc_fin_time=3.8974; % mode=1, trans_fin_time
    trig_time=4.1197; % mode=1
    % calc_start_time=3.0647; % mode=2
    % calc_fin_time=calc_start_time+1.09195; % mode=2
    % trig_time=calc_start_time; % mode=2

    nx=1024;
    ny=1024;
    nzall=21839;
    Fs=10e3;
    Fs_press=20e3;
    Fs_spiv=20e3;
    pres_samp_time=10; % [sec]
    div=10;
    origin_x=500; % [px]
    origin_y=640; % [px]
    origin_height=46; %[mm]
    img_res_x=120*10^(-3); % [mm/px]
    img_res_y=120*10^(-3); % [mm/px]
    col_min=0;
    col_max=3000;
    % col_max=800; %PLIF
    visx_start=-60; %[mm]
    visx_end=60; %[mm]
    visy_start=0; %[mm]
    visy_end=120; %[mm]
    vis='hot';


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

    Sts=1/Fs; % [sec]
    Sts_spiv=1/Fs_spiv; % [sec]
    Sts_press=1/Fs_press; % [sec]
    origin_height_px=origin_height/img_res_y; % [px]
    pres_datasize=Fs_press*pres_samp_time;
    taxis=Sts_press:Sts_press:pres_samp_time;
    if type == 1
      cam_start_time = trig_time - Sts_spiv*nzall
      cam_start_time_chem = trig_time - Sts*nzall
      cam_start_data=floor(trig_time/Sts_press)-nzall
      cam_start_data_chem=floor(trig_time/Sts_press)-nzall*Sts/Sts_press
      before_transition_data=floor(nzall -(trig_time - calc_start_time)/Sts_press)
      before_transition_data_chem=floor(nzall -(trig_time - calc_start_time)/Sts)
      while_transition_data_chem=floor((calc_fin_time - calc_start_time)/Sts)
      calc_data=floor((calc_fin_time - calc_start_time)/(div*Sts_press))
      % fn_i=sprintf('chem_%02u_cor.dat',num);
      fn_i=sprintf('chem_%02u_rmv.dat',num);
      % fn_i=sprintf('plif_%02u_med.dat',num);
      fn_p=sprintf('PDown_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
      fn_max=sprintf('phasemean_max_%d_%d_%02u',flow_rate,date,num);
      fn_infdown=sprintf('phasemean_infdown_%d_%d_%02u',flow_rate,date,num);
      fn_min=sprintf('phasemean_min_%d_%d_%02u',flow_rate,date,num);
      fn_infup=sprintf('phasemean_infup_%d_%d_%02u',flow_rate,date,num);
    elseif type == 2
      cam_start_time = trig_time
      cam_start_time_chem = trig_time
      cam_start_data = floor(trig_time/Sts_press)
      cam_start_data_chem=floor(trig_time/Sts_press)
      before_transition_data = floor((calc_start_time - trig_time)/Sts_spiv)
      before_transition_data_chem=floor((calc_start_time - trig_time)/Sts)
      while_transition_data = floor((calc_fin_time - calc_start_time)/Sts_spiv)
      while_transition_data_chem=floor((calc_fin_time - calc_start_time)/Sts)
      calc_data = floor((calc_fin_time - calc_start_time)/(div*Sts_spiv))
      % fn_i=sprintf('chem_%02u_cor.dat',num);
      % fn_i=sprintf('chem_%02u_rmv.dat',num);
      % fn_i=sprintf('plif_%02u_med.dat',num);
      % fn_p=sprintf('PDown_%d_%.2f_piv_%dHz_d%d_hps%d_lps%d.dat',flow_rate,equivalence_ratio,specific_f,duct_l,hpsfreq,lpsfreq);
      % fn_max=sprintf('phasemean_max_%d_%d_%02u.dat',flow_rate,date,num);
      % fn_infdown=sprintf('phasemean_infdown_%d_%d_%02u.dat',flow_rate,date,num);
      % fn_min=sprintf('phasemean_min_%d_%d_%02u.dat',flow_rate,date,num);
      % fn_infup=sprintf('phasemean_infup_%d_%d_%02u.dat',flow_rate,date,num);
    end

%% Search phases

    [p_fil,locs_presmax,pks_pres,locs_inflectdown,locs_presmin,locs_inflectup] = search_phase(dir_p,fn_p,pres_datasize);

%% check phases

    phase_vis(taxis,p_fil,calc_start_time,calc_fin_time,locs_presmax,pks_pres,locs_inflectdown,locs_presmin,locs_inflectup)

%% Calculation, PHASE MEAN, max

    chemplif_pick_phase_dist(dir_i,fn_i,dir_o,fn_max,locs_presmax,cam_start_data,before_transition_data,...
             before_transition_data_chem,calc_start_time,calc_data,Sts_press,Sts,nx,ny,maxcnt_st1,...
             maxcnt_st2,maxcnt_st3,maxcnt_st4,maxcnt_st5,maxcnt_st6,maxcnt_st7,maxcnt_st8,maxcnt_st9,...
             maxcnt_st10,vissw,svsw,origin_x,origin_y,origin_height,img_res_x,img_res_y,visx_start,...
             visx_end,visy_start,visy_end,col_min,col_max,vis,dir_f)

%% Calculation, PHASE MEAN, inflectdown

    chemplif_pick_phase_dist(dir_i,fn_i,dir_o,fn_infdown,locs_inflectdown,cam_start_data,before_transition_data,...
             before_transition_data_chem,calc_start_time,calc_data,Sts_press,Sts,nx,ny,infdowncnt_st1,...
             infdowncnt_st2,infdowncnt_st3,infdowncnt_st4,infdowncnt_st5,infdowncnt_st6,infdowncnt_st7,...
             infdowncnt_st8,infdowncnt_st9,infdowncnt_st10,vissw,svsw,origin_x,origin_y,...
             origin_height,img_res_x,img_res_y,visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis,dir_f)

%% Calculation, PHASE MEAN, min

    chemplif_pick_phase_dist(dir_i,fn_i,dir_o,fn_min,locs_presmin,cam_start_data,before_transition_data,...
             before_transition_data_chem,calc_start_time,calc_data,Sts_press,Sts,nx,ny,mincnt_st1,...
             mincnt_st2,mincnt_st3,mincnt_st4,mincnt_st5,mincnt_st6,mincnt_st7,mincnt_st8,mincnt_st9,...
             mincnt_st10,vissw,svsw,origin_x,origin_y,origin_height,img_res_x,img_res_y,visx_start,...
             visx_end,visy_start,visy_end,col_min,col_max,vis,dir_f)

%% Calculation, PHASE MEAN, inflectup

    chemplif_pick_phase_dist(dir_i,fn_i,dir_o,fn_infup,locs_inflectup,cam_start_data,before_transition_data,...
             before_transition_data_chem,calc_start_time,calc_data,Sts_press,Sts,nx,ny,infupcnt_st1,...
             infupcnt_st2,infupcnt_st3,infupcnt_st4,infupcnt_st5,infupcnt_st6,infupcnt_st7,...
             infupcnt_st8,infupcnt_st9,infupcnt_st10,vissw,svsw,origin_x,origin_y,...
             origin_height,img_res_x,img_res_y,visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis,dir_f)
