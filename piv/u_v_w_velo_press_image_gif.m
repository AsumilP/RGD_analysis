    clc
    clear all
    close all

%% Parameters

    trans_start_time = 2.6669;
    trans_fin_time = 3.0943;
    trig_time = 3.467;
    date = 20181218;
    num = 7;
    nincrement = 2;
    quivermode = 2;

    first_frame = 15000;
    frames = 1000;
    skip_frame = 5;
    wmin = -5; % [m/s]
    wmax = 5; % [m/s]

    nxall = 217;
    nyall = 124;
    nzall = 21838;
    nx_start = 1;
    nx_end = 217;
    ny_start = 1;
    ny_end = 124;
    vec_spc_x = 8;
    vec_spc_y = 8;
    img_res_x = 75.78*10^(-3); % [mm]
    img_res_y = 70.66*10^(-3); % [mm]
    Fs_spiv = 20e3; % [Hz]
    Fs_press = 20e3; % [Hz]
    pres_samp_time = 10; % [sec]
    dx = img_res_x*vec_spc_x;
    dy = img_res_y*vec_spc_y;
    pres_datasize = Fs_press*pres_samp_time;

    file_u=sprintf('G:/Analysis/piv_output/velofield/%d/spiv_fbsc_%02u_ucl.dat',date,num);
    file_v=sprintf('G:/Analysis/piv_output/velofield/%d/spiv_fbsc_%02u_vcl.dat',date,num);
    file_w=sprintf('G:/Analysis/piv_output/velofield/%d/spiv_fbsc_%02u_wcl.dat',date,num);
    presname = sprintf('H:/Analysis/pressure/%d/calc/PDown_hps20_lps300_%d_%02u.dat',date,date,num);
    gifname=sprintf('./spiv_press_%d_%02u.gif',date,num);

%% Make Movie

    fid1 = fopen(sprintf(file_u),'r');
    skip_frames(fid1,first_frame,nxall*nyall,8,1);
    fid2 = fopen(sprintf(file_v),'r');
    skip_frames(fid2,first_frame,nxall*nyall,8,1);
    fid3 = fopen(sprintf(file_w),'r');
    skip_frames(fid3,first_frame,nxall*nyall,8,1);
    fid4 = fopen(sprintf(presname),'r');
    p = fread(fid4,pres_datasize,'double');
    fclose(fid4);

    fig = figure;
    fig.Color = 'white';
    fig.Position = [1 1 800*(1+sqrt(5))/2 800];

    if first_frame + (skip_frame+1) * frames <= nzall

        for idx=1:1:frames
            u = (fread(fid1,nxall*nyall,'double'));
            v = (fread(fid2,nxall*nyall,'double'));
            w = (fread(fid3,nxall*nyall,'double'));
            squiver_pres(u,v,w,nxall,nyall,nx_start,nx_end,ny_start,ny_end,nincrement,...
                             dx,dy,wmin,wmax,quivermode,idx,skip_frame,...
                             nzall,pres_samp_time,Fs_spiv,Fs_press,p,first_frame,...
                             trans_start_time,trans_fin_time,trig_time)
            frame = getframe(fig);
            im{idx}=frame2im(frame);
            skip_frames(fid1,skip_frame,nxall*nyall,8,2);
            skip_frames(fid2,skip_frame,nxall*nyall,8,2);
            skip_frames(fid3,skip_frame,nxall*nyall,8,2);
        end
        close;

        for idx=1:1:frames
            [A,map]= rgb2ind(im{idx},256);
            if idx == 1
                imwrite(A,map,gifname,'gif','LoopCount',Inf,'DelayTime',0.01);
            else
                imwrite(A,map,gifname,'gif','WriteMode','append','DelayTime',0.01);
            end
        end

    else
        disp('Change frames or skip_frame!')
        first_frame + (skip_frame+1) * frames
    end
