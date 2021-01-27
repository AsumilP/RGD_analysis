    clc
    clear all
    close all

%% Parameters 1

    ndata=1;
    flow_rate=500;
    date='20201217';
    cond=6;
    read_mode=2;
    av_all_vis=1;
    
    dir_i='G:/chem_phasemean/mode/';
    dir_o='G:/chem_phasemean/mode/figure/';

%% Parameters 2

    nx=1024; % [px]
    ny=1024; % [px]
    origin_x=500; % [px]
    origin_y=640; % [px]
    origin_height=46; %[mm]
    img_res_x=120*10^(-3); % [mm/px]
    img_res_y=120*10^(-3); % [mm/px]
%     origin_x=500; % [px]
%     origin_y=792; % [px]
%     origin_height=20; %[mm]
%     img_res_x=150*10^(-3); % [mm/px]
%     img_res_y=150*10^(-3); % [mm/px]
    col_min=0;
    col_max=3000;
    col_max_dif=500;
    visx_start=-60; %[mm]
    visx_end=60; %[mm]
    visy_start=0; %[mm]
    visy_end=120; %[mm]
    vis='hot';

%% READ and AVERAGE

     [max_av]=read_phaseaveraged_data_div10(flow_rate,'max',ndata,nx,ny,date,cond,read_mode,dir_i);
     [infdown_av]=read_phaseaveraged_data_div10(flow_rate,'infdown',ndata,nx,ny,date,cond,read_mode,dir_i);
     [min_av]=read_phaseaveraged_data_div10(flow_rate,'min',ndata,nx,ny,date,cond,read_mode,dir_i);
     [infup_av]=read_phaseaveraged_data_div10(flow_rate,'infup',ndata,nx,ny,date,cond,read_mode,dir_i);

 %% Make Figure

      for ns=1:10
          fig=figure;
          fig.Color='white';
          fig.Position=[1 1 800 800];
          
          I=reshape(max_av(:,:,ns),[nx*ny 1]);
          chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                           visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)

          if read_mode == 1
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_max_%d_chem_',num2str(ns),'.png'),flow_rate)))
          elseif read_mode == 2
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_max_%d_chem_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
          end
          close;
      end
      
      for ns=1:10
          fig=figure;
          fig.Color='white';
          fig.Position=[1 1 800 800];
          
          I=reshape(infdown_av(:,:,ns),[nx*ny 1]);
          chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                           visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)

          if read_mode == 1
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_infdown_%d_chem_',num2str(ns),'.png'),flow_rate)))
          elseif read_mode == 2
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_infdown_%d_chem_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
          end
          close;
      end
      
      for ns=1:10
          fig=figure;
          fig.Color='white';
          fig.Position=[1 1 800 800];
          
          I=reshape(min_av(:,:,ns),[nx*ny 1]);
          chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                           visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)

          if read_mode == 1
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_min_%d_chem_',num2str(ns),'.png'),flow_rate)))
          elseif read_mode == 2
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_min_%d_chem_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
          end
          close;
      end
      
      for ns=1:10
          fig=figure;
          fig.Color='white';
          fig.Position=[1 1 800 800];
          
          I=reshape(infup_av(:,:,ns),[nx*ny 1]);
          chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                           visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)

          if read_mode == 1
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_infup_%d_chem_',num2str(ns),'.png'),flow_rate)))
          elseif read_mode == 2
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_infup_%d_chem_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
          end
          close;
      end
      
      if av_all_vis == 1
          
          %
          fig=figure;
          fig.Color='white';
          fig.Position=[1 1 800 800];
          
          I=reshape(mean(max_av,3),[nx*ny 1]);
          chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                           visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)

          if read_mode == 1
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_max_%d_chem_',num2str(ns),'.png'),flow_rate)))
          elseif read_mode == 2
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_max_%d_chem_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
          end
          close;
          
          %
          fig=figure;
          fig.Color='white';
          fig.Position=[1 1 800 800];
          
          I=reshape(mean(infdown_av,3),[nx*ny 1]);
          chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                           visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)

          if read_mode == 1
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_infdown_%d_chem_',num2str(ns),'.png'),flow_rate)))
          elseif read_mode == 2
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_infdown_%d_chem_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
          end
          close;
          
          %
          fig=figure;
          fig.Color='white';
          fig.Position=[1 1 800 800];
          
          I=reshape(mean(min_av,3),[nx*ny 1]);
          chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                           visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)

          if read_mode == 1
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_min_%d_chem_',num2str(ns),'.png'),flow_rate)))
          elseif read_mode == 2
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_min_%d_chem_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
          end
          close;
          
          %
          fig=figure;
          fig.Color='white';
          fig.Position=[1 1 800 800];
          
          I=reshape(mean(infup_av,3),[nx*ny 1]);
          chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                           visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)

          if read_mode == 1
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_infup_%d_chem_',num2str(ns),'.png'),flow_rate)))
          elseif read_mode == 2
              saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_infup_%d_chem_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
          end
          close;
             
      end