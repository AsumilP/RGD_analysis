    clc
    clear all
    close all

%% Parameters 1

    ndata=1;
    flow_rate=500;
    date='20201223';
    cond=7;
    read_mode=2;
    quiv_vis=0;
    av_all_vis=1;

    dir_i='I:/Analysis/piv_output/velophasemeanfield_calc/mode/';
    dir_o='I:/Analysis/piv_output/velophasemeanfield_calc/mode/figure/';

%% Parameters 2

    nx = 191;
    ny_calc = 98;
    vec_spc_x = 8;
    vec_spc_y = 8;
    img_res_x = 80*10^(-3);
    img_res_y = 75*10^(-3);
    wmin = -5; % [m/s]
    wmax = 5; % [m/s]
    spmin = 0; % [m/s]
    spmax = 15; % [m/s]
    nincrement=3;
    quivermode=2;

%% Matrix

    dx=img_res_x*vec_spc_x; % [mm]
    dy=img_res_y*vec_spc_y; % [mm]
%     dx=img_res_x*vec_spc_x*10^-3;
%     dy=img_res_y*vec_spc_y*10^-3;

%% READ and AVERAGE

    [umax_av]=read_phaseaveraged_data_div10(flow_rate,'umax',ndata,nx,ny_calc,date,cond,read_mode,dir_i);
    [vmax_av]=read_phaseaveraged_data_div10(flow_rate,'vmax',ndata,nx,ny_calc,date,cond,read_mode,dir_i);
    [wmax_av]=read_phaseaveraged_data_div10(flow_rate,'wmax',ndata,nx,ny_calc,date,cond,read_mode,dir_i);
    [uinfdown_av]=read_phaseaveraged_data_div10(flow_rate,'uinfdown',ndata,nx,ny_calc,date,cond,read_mode,dir_i);
    [vinfdown_av]=read_phaseaveraged_data_div10(flow_rate,'vinfdown',ndata,nx,ny_calc,date,cond,read_mode,dir_i);
    [winfdown_av]=read_phaseaveraged_data_div10(flow_rate,'winfdown',ndata,nx,ny_calc,date,cond,read_mode,dir_i);
    [umin_av]=read_phaseaveraged_data_div10(flow_rate,'umin',ndata,nx,ny_calc,date,cond,read_mode,dir_i);
    [vmin_av]=read_phaseaveraged_data_div10(flow_rate,'vmin',ndata,nx,ny_calc,date,cond,read_mode,dir_i);
    [wmin_av]=read_phaseaveraged_data_div10(flow_rate,'wmin',ndata,nx,ny_calc,date,cond,read_mode,dir_i);
    [uinfup_av]=read_phaseaveraged_data_div10(flow_rate,'uinfup',ndata,nx,ny_calc,date,cond,read_mode,dir_i);
    [vinfup_av]=read_phaseaveraged_data_div10(flow_rate,'vinfup',ndata,nx,ny_calc,date,cond,read_mode,dir_i);
    [winfup_av]=read_phaseaveraged_data_div10(flow_rate,'winfup',ndata,nx,ny_calc,date,cond,read_mode,dir_i);

%% Make Figure, quiver

     if quiv_vis == 1

         for ns=1:10
             fig=figure;
             fig.Color='white';
             fig.Position=[1 1 800*(1+sqrt(5))/2 800];

             u=reshape(umax_av(:,:,ns),[nx*ny_calc 1]);
             v=reshape(vmax_av(:,:,ns),[nx*ny_calc 1]);
             w=reshape(wmax_av(:,:,ns),[nx*ny_calc 1]);
             squiver(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                          dx,dy,wmin,wmax,quivermode)

             if read_mode == 1
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_max_%d_quiv_',num2str(ns),'.png'),flow_rate)))
             elseif read_mode == 2
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_max_%d_quiv_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
             end
             close;
         end

         for ns=1:10
             fig=figure;
             fig.Color='white';
             fig.Position=[1 1 800*(1+sqrt(5))/2 800];

             u=reshape(uinfdown_av(:,:,ns),[nx*ny_calc 1]);
             v=reshape(vinfdown_av(:,:,ns),[nx*ny_calc 1]);
             w=reshape(winfdown_av(:,:,ns),[nx*ny_calc 1]);
             squiver(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                          dx,dy,wmin,wmax,quivermode)

             if read_mode == 1
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_infdown_%d_quiv_',num2str(ns),'.png'),flow_rate)))
             elseif read_mode == 2
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_infdown_%d_quiv_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
             end
             close;
         end

         for ns=1:10
             fig=figure;
             fig.Color='white';
             fig.Position=[1 1 800*(1+sqrt(5))/2 800];

             u=reshape(umin_av(:,:,ns),[nx*ny_calc 1]);
             v=reshape(vmin_av(:,:,ns),[nx*ny_calc 1]);
             w=reshape(wmin_av(:,:,ns),[nx*ny_calc 1]);
             squiver(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                          dx,dy,wmin,wmax,quivermode)

             if read_mode == 1
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_min_%d_quiv_',num2str(ns),'.png'),flow_rate)))
             elseif read_mode == 2
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_min_%d_quiv_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
             end
             close;
         end

         for ns=1:10
             fig=figure;
             fig.Color='white';
             fig.Position=[1 1 800*(1+sqrt(5))/2 800];

             u=reshape(uinfup_av(:,:,ns),[nx*ny_calc 1]);
             v=reshape(vinfup_av(:,:,ns),[nx*ny_calc 1]);
             w=reshape(winfup_av(:,:,ns),[nx*ny_calc 1]);
             squiver(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                          dx,dy,wmin,wmax,quivermode)

             if read_mode == 1
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_infup_%d_quiv_',num2str(ns),'.png'),flow_rate)))
             elseif read_mode == 2
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_infup_%d_quiv_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
             end
             close;
         end

         if av_all_vis == 1
             %
             fig=figure;
             fig.Color='white';
             fig.Position=[1 1 800*(1+sqrt(5))/2 800];

             u=reshape(mean(umax_av,3),[nx*ny_calc 1]);
             v=reshape(mean(vmax_av,3),[nx*ny_calc 1]);
             w=reshape(mean(wmax_av,3),[nx*ny_calc 1]);
             squiver(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                          dx,dy,wmin,wmax,quivermode)

             if read_mode == 1
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_max_%d_quiv_',num2str(ns),'.png'),flow_rate)))
             elseif read_mode == 2
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_max_%d_quiv_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
             end
             close;
             %
             fig=figure;
             fig.Color='white';
             fig.Position=[1 1 800*(1+sqrt(5))/2 800];

             u=reshape(mean(uinfdown_av,3),[nx*ny_calc 1]);
             v=reshape(mean(vinfdown_av,3),[nx*ny_calc 1]);
             w=reshape(mean(winfdown_av,3),[nx*ny_calc 1]);
             squiver(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                          dx,dy,wmin,wmax,quivermode)

             if read_mode == 1
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_infdown_%d_quiv_',num2str(ns),'.png'),flow_rate)))
             elseif read_mode == 2
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_infdown_%d_quiv_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
             end
             close;

             fig=figure;
             fig.Color='white';
             fig.Position=[1 1 800*(1+sqrt(5))/2 800];

             u=reshape(mean(umin_av,3),[nx*ny_calc 1]);
             v=reshape(mean(vmin_av,3),[nx*ny_calc 1]);
             w=reshape(mean(wmin_av,3),[nx*ny_calc 1]);
             squiver(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                          dx,dy,wmin,wmax,quivermode)

             if read_mode == 1
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_min_%d_quiv_',num2str(ns),'.png'),flow_rate)))
             elseif read_mode == 2
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_min_%d_quiv_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
             end
             close;

             fig=figure;
             fig.Color='white';
             fig.Position=[1 1 800*(1+sqrt(5))/2 800];

             u=reshape(mean(uinfup_av,3),[nx*ny_calc 1]);
             v=reshape(mean(vinfup_av,3),[nx*ny_calc 1]);
             w=reshape(mean(winfup_av,3),[nx*ny_calc 1]);
             squiver(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                          dx,dy,wmin,wmax,quivermode)

             if read_mode == 1
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_infup_%d_quiv_',num2str(ns),'.png'),flow_rate)))
             elseif read_mode == 2
                 saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_infup_%d_quiv_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
             end
             close;

         end

     end

%% Make Figure, streamline

     for ns=1:10
         fig=figure;
         fig.Color='white';
         fig.Position=[1 1 800*(1+sqrt(5))/2 800];

         u=reshape(umax_av(:,:,ns),[nx*ny_calc 1]);
         v=reshape(vmax_av(:,:,ns),[nx*ny_calc 1]);
         w=reshape(wmax_av(:,:,ns),[nx*ny_calc 1]);
         streamline_vis(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,...
                                 dx,dy,spmin,spmax)

         if read_mode == 1
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_max_%d_strmln_',num2str(ns),'.png'),flow_rate)))
         elseif read_mode == 2
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_max_%d_strmln_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
         end
         close;
     end

     for ns=1:10
         fig=figure;
         fig.Color='white';
         fig.Position=[1 1 800*(1+sqrt(5))/2 800];

         u=reshape(uinfdown_av(:,:,ns),[nx*ny_calc 1]);
         v=reshape(vinfdown_av(:,:,ns),[nx*ny_calc 1]);
         w=reshape(winfdown_av(:,:,ns),[nx*ny_calc 1]);
         streamline_vis(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,...
                                 dx,dy,spmin,spmax)

         if read_mode == 1
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_infdown_%d_strmln_',num2str(ns),'.png'),flow_rate)))
         elseif read_mode == 2
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_infdown_%d_strmln_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
         end
         close;
     end

     for ns=1:10
         fig=figure;
         fig.Color='white';
         fig.Position=[1 1 800*(1+sqrt(5))/2 800];

         u=reshape(umin_av(:,:,ns),[nx*ny_calc 1]);
         v=reshape(vmin_av(:,:,ns),[nx*ny_calc 1]);
         w=reshape(wmin_av(:,:,ns),[nx*ny_calc 1]);
         streamline_vis(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,...
                                 dx,dy,spmin,spmax)

         if read_mode == 1
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_min_%d_strmln_',num2str(ns),'.png'),flow_rate)))
         elseif read_mode == 2
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_min_%d_strmln_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
         end
         close;
     end

     for ns=1:10
         fig=figure;
         fig.Color='white';
         fig.Position=[1 1 800*(1+sqrt(5))/2 800];

         u=reshape(uinfup_av(:,:,ns),[nx*ny_calc 1]);
         v=reshape(vinfup_av(:,:,ns),[nx*ny_calc 1]);
         w=reshape(winfup_av(:,:,ns),[nx*ny_calc 1]);
         streamline_vis(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,...
                                 dx,dy,spmin,spmax)

         if read_mode == 1
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_infup_%d_strmln_',num2str(ns),'.png'),flow_rate)))
         elseif read_mode == 2
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_infup_%d_strmln_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
         end
         close;
     end

     if av_all_vis == 1

         fig=figure;
         fig.Color='white';
         fig.Position=[1 1 800*(1+sqrt(5))/2 800];

         u=reshape(mean(umax_av,3),[nx*ny_calc 1]);
         v=reshape(mean(vmax_av,3),[nx*ny_calc 1]);
         w=reshape(mean(wmax_av,3),[nx*ny_calc 1]);
         streamline_vis(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,...
                                 dx,dy,spmin,spmax)

         if read_mode == 1
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_max_%d_strmln_',num2str(ns),'.png'),flow_rate)))
         elseif read_mode == 2
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_max_%d_strmln_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
         end
         close;

         fig=figure;
         fig.Color='white';
         fig.Position=[1 1 800*(1+sqrt(5))/2 800];

         u=reshape(mean(uinfdown_av,3),[nx*ny_calc 1]);
         v=reshape(mean(vinfdown_av,3),[nx*ny_calc 1]);
         w=reshape(mean(winfdown_av,3),[nx*ny_calc 1]);
         streamline_vis(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,...
                                 dx,dy,spmin,spmax)

         if read_mode == 1
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_infdown_%d_strmln_',num2str(ns),'.png'),flow_rate)))
         elseif read_mode == 2
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_infdown_%d_strmln_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
         end
         close;

         fig=figure;
         fig.Color='white';
         fig.Position=[1 1 800*(1+sqrt(5))/2 800];

         u=reshape(mean(umin_av,3),[nx*ny_calc 1]);
         v=reshape(mean(vmin_av,3),[nx*ny_calc 1]);
         w=reshape(mean(wmin_av,3),[nx*ny_calc 1]);
         streamline_vis(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,...
                                 dx,dy,spmin,spmax)

         if read_mode == 1
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_min_%d_strmln_',num2str(ns),'.png'),flow_rate)))
         elseif read_mode == 2
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_min_%d_strmln_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
         end
         close;

         fig=figure;
         fig.Color='white';
         fig.Position=[1 1 800*(1+sqrt(5))/2 800];

         u=reshape(mean(uinfup_av,3),[nx*ny_calc 1]);
         v=reshape(mean(vinfup_av,3),[nx*ny_calc 1]);
         w=reshape(mean(winfup_av,3),[nx*ny_calc 1]);
         streamline_vis(u,-v,w,nx,ny_calc,1,nx,1,ny_calc,...
                                 dx,dy,spmin,spmax)

         if read_mode == 1
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_infup_%d_strmln_',num2str(ns),'.png'),flow_rate)))
         elseif read_mode == 2
             saveas(gcf,strcat(dir_o,sprintf(strcat('phasemean_all_infup_%d_strmln_',date,'_%02u_',num2str(ns),'.png'),flow_rate,cond)))
         end
         close;

     end
