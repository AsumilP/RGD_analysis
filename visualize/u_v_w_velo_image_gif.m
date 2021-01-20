    clc
    clear all
    close all

%% Parameters 1

    nincrement=2;
    quivermode=1;
    
    date=20201223;
    num=1;
    first_frame=1;
    frames=10;
    skip_frame=30;
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
    
    dir=sprintf('I:/Analysis/piv_output/velofield/%d/combined/',date);
    file_u=sprintf('spiv_fbsc_%02u_u.dat',num);
    file_v=sprintf('spiv_fbsc_%02u_v.dat',num);
    file_w=sprintf('spiv_fbsc_%02u_w.dat',num);

    gifname=sprintf('spiv_%d_%02u.gif',date,num);

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
            frame = getframe(fig);
            im{idx}=frame2im(frame);
            skip_frames(fid1,skip_frame,nxall*nyall,8,2);
            skip_frames(fid2,skip_frame,nxall*nyall,8,2);
            skip_frames(fid3,skip_frame,nxall*nyall,8,2);            
        end
        
        for idx=1:1:frames
            [A,map]= rgb2ind(im{idx},256);
            if idx == 1
                imwrite(A,map,strcat(dir,gifname),'gif','LoopCount',Inf,'DelayTime',0.01);
            else
                imwrite(A,map,strcat(dir,gifname),'gif','WriteMode','append','DelayTime',0.01);
            end
        end
        
    else
        disp('Change frames or skip_frame!')
        first_frame + (skip_frame+1) * frames
    end           
 