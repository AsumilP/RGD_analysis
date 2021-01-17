    clc
    clear all
    close all

%% Parameters 1

    nincrement=2;
    quivermode=2;
    
    date=20201223;
    num=7;
    first_frame=1;
    frames=1;
    skip_frame=0;
    wmin = -5; % [m/s]
    wmax = 5; % [m/s]
    
    nxall=191;
    nyall=123;
    nzall=21838;
    nx_start=1;
    nx_end=191;
    ny_start=8;
    ny_end=105;
    vec_spc_x=8;
    vec_spc_y=8;
    img_res_x=80*10^(-3); % [mm]
    img_res_y=75*10^(-3); % [mm]
    dx=img_res_x*vec_spc_x;
    dy=img_res_y*vec_spc_y;
    
    dir=sprintf('C:/Users/yatagi/Desktop/work/piv_output/%d/average/combined/',date);
    file_u=sprintf('spiv_fbsc_%02u_u_av.dat',num);
    file_v=sprintf('spiv_fbsc_%02u_v_av.dat',num);
    file_w=sprintf('spiv_fbsc_%02u_w_av.dat',num);

    pngname=sprintf('spiv_%d_%02u',date,num);
    figex = '.png'; % fig, png

%% Make Figure

    fid1 = fopen(strcat(dir,sprintf(file_u)),'r');
    skip_frames(fid1,first_frame,nxall*nyall,8,1);
    fid2 = fopen(strcat(dir,sprintf(file_v)),'r');
    skip_frames(fid2,first_frame,nxall*nyall,8,1);
    fid3 = fopen(strcat(dir,sprintf(file_w)),'r');
    skip_frames(fid3,first_frame,nxall*nyall,8,1);

    fig=figure;
    fig.Color='white';
    fig.Position=[1 1 800*(1+sqrt(5))/2 800];
    
    if first_frame + (skip_frame+1) * frames <= nzall

        for idx=1:1:frames
            u = (fread(fid1,nxall*nyall,'double'));
            v = (fread(fid2,nxall*nyall,'double'));
            w = (fread(fid3,nxall*nyall,'double'));
            squiver(u,-v,w,nxall,nyall,nx_start,nx_end,ny_start,ny_end,nincrement,...
                         dx,dy,wmin,wmax,quivermode,idx,skip_frame)
            skip_frames(fid1,skip_frame,nxall*nyall,8,2);
            skip_frames(fid2,skip_frame,nxall*nyall,8,2);
            skip_frames(fid3,skip_frame,nxall*nyall,8,2);
            
            fign=strcat(pngname,sprintf('_%d',first_frame+(idx-1)*(skip_frame+1)));
            saveas(gcf, strcat(dir,fign,figex));
            
        end
        
    else
        disp('Change frames or skip_frame!')
        first_frame + (skip_frame+1) * frames
    end           
 