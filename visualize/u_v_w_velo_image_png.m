    clc
    clear all
    close all

%% Parameters 1

    date=20201219;
    num=2;
    first_frame=1;
    frames=1;
    skip_frame=0;
    
%% Parameters 2

    quiv_vis=0;
    wmin=-5; % [m/s]
    wmax=5; % [m/s]
    spmin = 0; % [m/s]
    spmax = 15; % [m/s]
    nincrement=2;
    quivermode=2;

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

    dir=sprintf('I:/Analysis/piv_output/velomeanfield/%d/average/combined/',date);
    file_u=sprintf('spiv_fbsc_%02u_u_av.dat',num);
    file_v=sprintf('spiv_fbsc_%02u_v_av.dat',num);
    file_w=sprintf('spiv_fbsc_%02u_w_av.dat',num);

    pngname1=sprintf('spiv_quiv_%d_%02u',date,num);
    pngname2=sprintf('spiv_strmln_%d_%02u',date,num);
    figex = '.png'; % fig, png

%% Make Figure

    fid1 = fopen(strcat(dir,sprintf(file_u)),'r');
    skip_frames(fid1,first_frame,nxall*nyall,8,1);
    fid2 = fopen(strcat(dir,sprintf(file_v)),'r');
    skip_frames(fid2,first_frame,nxall*nyall,8,1);
    fid3 = fopen(strcat(dir,sprintf(file_w)),'r');
    skip_frames(fid3,first_frame,nxall*nyall,8,1);

    if first_frame + (skip_frame+1) * frames <= nzall
        
        if quiv_vis == 1
            
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            for idx=1:1:frames
                u = (fread(fid1,nxall*nyall,'double'));
                v = (fread(fid2,nxall*nyall,'double'));
                w = (fread(fid3,nxall*nyall,'double'));
                squiver(u,-v,w,nxall,nyall,nx_start,nx_end,ny_start,ny_end,nincrement,...
                            dx,dy,wmin,wmax,quivermode)
                skip_frames(fid1,skip_frame,nxall*nyall,8,2);
                skip_frames(fid2,skip_frame,nxall*nyall,8,2);
                skip_frames(fid3,skip_frame,nxall*nyall,8,2);

                fign=strcat(pngname1,sprintf('_%d',first_frame+(idx-1)*(skip_frame+1)));
                saveas(gcf, strcat(dir,fign,figex));
            end
            close;
        end
        
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

        for idx=1:1:frames
            u = (fread(fid1,nxall*nyall,'double'));
            v = (fread(fid2,nxall*nyall,'double'));
            w = (fread(fid3,nxall*nyall,'double'));
            streamline_vis(u,-v,w,nxall,nyall,nx_start,nx_end,ny_start,ny_end,...
                                   dx,dy,spmin,spmax)
            skip_frames(fid1,skip_frame,nxall*nyall,8,2);
            skip_frames(fid2,skip_frame,nxall*nyall,8,2);
            skip_frames(fid3,skip_frame,nxall*nyall,8,2);

            fign=strcat(pngname2,sprintf('_%d',first_frame+(idx-1)*(skip_frame+1)));
            saveas(gcf, strcat(dir,fign,figex));
        end
        close;
 
    else
        disp('Change frames or skip_frame!')
        first_frame + (skip_frame+1) * frames
    end
