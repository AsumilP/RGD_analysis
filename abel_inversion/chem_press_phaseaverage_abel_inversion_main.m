    clc
    clear all
    close all

%% Parameters 1

    ndata=1;
    flow_rate=500;
    date='20201223';
%     cond=6;
    read_mode=2;
    av_all=1;

    dir_i='D:/Analysis/chem_output/chem_phasemean/mode/';
    dir_o='D:/Analysis/chem_output/chem_phasemean_calc/mode/calc_abel/';
    fig_savedirectory='D:/Analysis/chem_output/chem_phasemean_calc/mode/calc_abel/figure/';
    
    for cond = [4 5 6 7]

%% Parameters 2

        nx=1024; % [px]
        ny=1024; % [px]
%         origin_x=500; % [px]
%         origin_y=640; % [px]
%         origin_height=46; %[mm]
%         img_res_x=120*10^(-3); % [mm/px]
%         img_res_y=120*10^(-3); % [mm/px]
        origin_x=500; % [px]
        origin_y=792; % [px]
        origin_height=20; %[mm]
        img_res_x=150*10^(-3); % [mm/px]
        img_res_y=150*10^(-3); % [mm/px]
        col_min=0;
        col_max=7;
%         col_max_dif=3;
        visx_start=-60; %[mm]
        visx_end=60; %[mm]
        visy_start=0; %[mm]
        visy_end=120; %[mm]
        vis='hot';
        origin_height_px=origin_height/img_res_y; %[px]
        abel_xrange=origin_x+1:2*origin_x;

%% READ and AVERAGE

        [max_av_read]=read_phaseaveraged_data_div10(flow_rate,'max',ndata,nx,ny,date,cond,read_mode,dir_i);
        [infdown_av_read]=read_phaseaveraged_data_div10(flow_rate,'infdown',ndata,nx,ny,date,cond,read_mode,dir_i);
        [min_av_read]=read_phaseaveraged_data_div10(flow_rate,'min',ndata,nx,ny,date,cond,read_mode,dir_i);
        [infup_av_read]=read_phaseaveraged_data_div10(flow_rate,'infup',ndata,nx,ny,date,cond,read_mode,dir_i);
     
        for j=1:1:10
            max_av(:,:,j)=transpose(max_av_read(:,:,j));
            infdown_av(:,:,j)=transpose(infdown_av_read(:,:,j));
            min_av(:,:,j)=transpose(min_av_read(:,:,j));
            infup_av(:,:,j)=transpose(infup_av_read(:,:,j));
        end
        
%% Calc. abel inversion & SAVE
% MAX

        if av_all == 0
            tic
            %
            for ns=1:10
                for j=1:origin_height_px+origin_y
                    abel_max(j,:,ns)=abel_inversion(max_av(j,abel_xrange,ns),length(abel_xrange),30,0,0);
                end
            end
         
            if read_mode == 1
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_max_%d_chem_abel_',num2str(ns),'.dat'),flow_rate)),'w');
                fwrite(fileID,abel_max,'double');
                fclose(fileID);
            elseif read_mode == 2
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_max_%d_chem_abel_',date,'_%02u_',num2str(ns),'.dat'),flow_rate,cond)),'w');
                fwrite(fileID,abel_max,'double');
                fclose(fileID);
            end
         
            %
            for ns=1:10
                for j=1:origin_height_px+origin_y
                    abel_infdown(j,:,ns)=abel_inversion(infdown_av(j,abel_xrange,ns),length(abel_xrange),30,0,0);
                end
            end
         
            if read_mode == 1
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_infdown_%d_chem_abel_',num2str(ns),'.dat'),flow_rate)),'w');
                fwrite(fileID,abel_infdown,'double');
                fclose(fileID);
            elseif read_mode == 2
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_infdown_%d_chem_abel_',date,'_%02u_',num2str(ns),'.dat'),flow_rate,cond)),'w');
                fwrite(fileID,abel_infdown,'double');
                fclose(fileID);
            end
         
            %
            for ns=1:10
                for j=1:origin_height_px+origin_y
                    abel_min(j,:,ns)=abel_inversion(min_av(j,abel_xrange,ns),length(abel_xrange),30,0,0);
                end
            end
         
            if read_mode == 1
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_min_%d_chem_abel_',num2str(ns),'.dat'),flow_rate)),'w');
                fwrite(fileID,abel_min,'double');
                fclose(fileID);
            elseif read_mode == 2
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_min_%d_chem_abel_',date,'_%02u_',num2str(ns),'.dat'),flow_rate,cond)),'w');
                fwrite(fileID,abel_min,'double');
                fclose(fileID);
            end
         
            %
            for ns=1:10
                for j=1:origin_height_px+origin_y
                    abel_infup(j,:,ns)=abel_inversion(infup_av(j,abel_xrange,ns),length(abel_xrange),30,0,0);
                end
            end
         
            if read_mode == 1
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_infup_%d_chem_abel_',num2str(ns),'.dat'),flow_rate)),'w');
                fwrite(fileID,abel_infup,'double');
                fclose(fileID);
            elseif read_mode == 2
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_infup_%d_chem_abel_',date,'_%02u_',num2str(ns),'.dat'),flow_rate,cond)),'w');
                fwrite(fileID,abel_infup,'double');
                fclose(fileID);
            end
         
            toc
         
 
        elseif av_all == 1
         
            max_av_calc=mean(max_av,3);
            infdown_av_calc=mean(infdown_av,3);
            min_av_calc=mean(min_av,3);
            infup_av_calc=mean(infup_av,3);
         
            tic
            %
            for j=1:origin_height_px+origin_y
                abel_max(j,:)=abel_inversion(max_av_calc(j,abel_xrange),length(abel_xrange),30,0,0);
            end
         
            if read_mode == 1
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_max_%d_chem_abel_all.dat'),flow_rate)),'w');
                fwrite(fileID,abel_max,'double');
                fclose(fileID);
            elseif read_mode == 2
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_max_%d_chem_abel_',date,'_%02u_all.dat'),flow_rate,cond)),'w');
                fwrite(fileID,abel_max,'double');
                fclose(fileID);
            end
         
            %
            for j=1:origin_height_px+origin_y
                abel_infdown(j,:)=abel_inversion(infdown_av_calc(j,abel_xrange),length(abel_xrange),30,0,0);
            end
         
            if read_mode == 1
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_infdown_%d_chem_abel_all.dat'),flow_rate)),'w');
                fwrite(fileID,abel_infdown,'double');
                fclose(fileID);
            elseif read_mode == 2
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_infdown_%d_chem_abel_',date,'_%02u_all.dat'),flow_rate,cond)),'w');
                fwrite(fileID,abel_infdown,'double');
                fclose(fileID);
            end
         
            %
            for j=1:origin_height_px+origin_y
                abel_min(j,:)=abel_inversion(min_av_calc(j,abel_xrange),length(abel_xrange),30,0,0);
            end
         
            if read_mode == 1
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_min_%d_chem_abel_all.dat'),flow_rate)),'w');
                fwrite(fileID,abel_min,'double');
                fclose(fileID);
            elseif read_mode == 2
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_min_%d_chem_abel_',date,'_%02u_all.dat'),flow_rate,cond)),'w');
                fwrite(fileID,abel_min,'double');
                fclose(fileID);
            end
         
            %
            for j=1:origin_height_px+origin_y
                abel_infup(j,:)=abel_inversion(infup_av_calc(j,abel_xrange),length(abel_xrange),30,0,0);
            end
         
            if read_mode == 1
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_infup_%d_chem_abel_all.dat'),flow_rate)),'w');
                fwrite(fileID,abel_infup,'double');
                fclose(fileID);
            elseif read_mode == 2
                fileID=fopen(strcat(dir_o,sprintf(strcat('phasemean_infup_%d_chem_abel_',date,'_%02u_all.dat'),flow_rate,cond)),'w');
                fwrite(fileID,abel_infup,'double');
                fclose(fileID);
            end
       
            toc
        end

%% Make Figure

        if av_all == 0
          
            for ns=1:10
                fig=figure;
                fig.Color='white';
                fig.Position=[1 1 800 800];
              
                image_vis=transpose(cat(2,fliplr(abel_max(:,:,ns)),abel_max(:,:,ns)));
                I=reshape(image_vis,[2*origin_x*floor(origin_height_px+origin_y) 1]);
                chem_vis(I,origin_x*2,floor(origin_height_px+origin_y),origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                                visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
                          
                if read_mode == 1
                    saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_max_%d_chem_abel_',num2str(ns),'.png'),flow_rate)))
                elseif read_mode == 2
                    saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_max_%d_chem_abel_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
                end
                close;
            end
          
            for ns=1:10
                fig=figure;
                fig.Color='white';
                fig.Position=[1 1 800 800];
              
                image_vis=transpose(cat(2,fliplr(abel_infdown(:,:,ns)),abel_infdown(:,:,ns)));
                I=reshape(image_vis,[2*origin_x*floor(origin_height_px+origin_y) 1]);
                chem_vis(I,origin_x*2,floor(origin_height_px+origin_y),origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                                visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
                          
                if read_mode == 1
                    saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_infdown_%d_chem_abel_',num2str(ns),'.png'),flow_rate)))
                elseif read_mode == 2
                    saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_infdown_%d_chem_abel_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
                end
                close;
            end
          
            for ns=1:10
                fig=figure;
                fig.Color='white';
                fig.Position=[1 1 800 800];
              
                image_vis=transpose(cat(2,fliplr(abel_min(:,:,ns)),abel_min(:,:,ns)));
                I=reshape(image_vis,[2*origin_x*floor(origin_height_px+origin_y) 1]);
                chem_vis(I,origin_x*2,floor(origin_height_px+origin_y),origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                                visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
                          
                if read_mode == 1
                    saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_min_%d_chem_abel_',num2str(ns),'.png'),flow_rate)))
                elseif read_mode == 2
                    saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_min_%d_chem_abel_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
                end
                close;
            end
          
            for ns=1:10
                fig=figure;
                fig.Color='white';
                fig.Position=[1 1 800 800];
              
                image_vis=transpose(cat(2,fliplr(abel_infup(:,:,ns)),abel_infup(:,:,ns)));
                I=reshape(image_vis,[2*origin_x*floor(origin_height_px+origin_y) 1]);
                chem_vis(I,origin_x*2,floor(origin_height_px+origin_y),origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                                visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
                          
                if read_mode == 1
                    saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_infup_%d_chem_abel_',num2str(ns),'.png'),flow_rate)))
                elseif read_mode == 2
                    saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_infup_%d_chem_abel_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
                end
                close;
            end
          
          
        elseif av_all == 1
          
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800 800];

            image_vis=transpose(cat(2,fliplr(abel_max(:,:)),abel_max(:,:)));
            I=reshape(image_vis,[2*origin_x*floor(origin_height_px+origin_y) 1]);
            chem_vis(I,origin_x*2,floor(origin_height_px+origin_y),origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                            visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
                          
            if read_mode == 1
                saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_max_%d_chem_abel_all.png'),flow_rate)))
            elseif read_mode == 2
                saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_max_%d_chem_abel_',date,'_%02u_all.png'),flow_rate,cond)))
            end
            close;
          
            %
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800 800];
              
            image_vis=transpose(cat(2,fliplr(abel_infdown(:,:)),abel_infdown(:,:)));
            I=reshape(image_vis,[2*origin_x*floor(origin_height_px+origin_y) 1]);
            chem_vis(I,origin_x*2,floor(origin_height_px+origin_y),origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                            visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
                          
            if read_mode == 1
                saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_infdown_%d_chem_abel_all.png'),flow_rate)))
            elseif read_mode == 2
                saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_infdown_%d_chem_abel_',date,'_%02u_all.png'),flow_rate,cond)))
            end
            close;
          
            %
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800 800];

            image_vis=transpose(cat(2,fliplr(abel_min(:,:)),abel_min(:,:)));
            I=reshape(image_vis,[2*origin_x*floor(origin_height_px+origin_y) 1]);
            chem_vis(I,origin_x*2,floor(origin_height_px+origin_y),origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                            visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
                          
            if read_mode == 1
                saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_min_%d_chem_abel_all.png'),flow_rate)))
            elseif read_mode == 2
                saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_min_%d_chem_abel_',date,'_%02u_all.png'),flow_rate,cond)))
            end
            close;
          
            %
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800 800];
              
            image_vis=transpose(cat(2,fliplr(abel_infup(:,:)),abel_infup(:,:)));
            I=reshape(image_vis,[2*origin_x*floor(origin_height_px+origin_y) 1]);
            chem_vis(I,origin_x*2,floor(origin_height_px+origin_y),origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                            visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
                          
            if read_mode == 1
                saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_infup_%d_chem_abel_all.png'),flow_rate)))
            elseif read_mode == 2
                saveas(gcf,strcat(fig_savedirectory,sprintf(strcat('phasemean_infup_%d_chem_abel_',date,'_%02u_all.png'),flow_rate,cond)))
            end
            close;

        end
        
    end
