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
    NYU= 1.333e-5; % [m^2/s]
    wmin = -5; % [m/s]
    wmax = 5; % [m/s]
    spmin = 0; % [m/s]
    spmax = 15; % [m/s]
    nincrement=3;
    quivermode=2;

%% Matrix

    dx=img_res_x*vec_spc_x;
    dy=img_res_y*vec_spc_y;
%     dx=img_res_x*vec_spc_x*10^-3;
%     dy=img_res_y*vec_spc_y*10^-3;
    omega=zeros(ny_calc,nx);
    dudx=zeros(ny_calc,nx);
    dvdx=zeros(ny_calc,nx);
    dudy=zeros(ny_calc,nx);
    dvdy=zeros(ny_calc,nx);
    strain_u=zeros(ny_calc,nx);
    strain_v=zeros(ny_calc,nx);
    eig11=zeros(ny_calc,nx);
    eig22=zeros(ny_calc,nx);
    eps=zeros(ny_calc,nx);
    
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
     
%% CALC, Strain, Kolmogorov Scale
% 
% %% infdown, 400
% 
%         for ns=1:10
% % du/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dudx(j,i)=(-25*uinfdown_400av(j,1,ns)+48*uinfdown_400av(j,2,ns)-36*uinfdown_400av(j,3,ns)+16*uinfdown_400av(j,4,ns)-3*uinfdown_400av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dudx(j,i)=(-3*uinfdown_400av(j,1,ns)-10*uinfdown_400av(j,2,ns)+18*uinfdown_400av(j,3,ns)-6*uinfdown_400av(j,4,ns)+uinfdown_400av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dudx(j,i)=(3*uinfdown_400av(j,nx,ns)+10*uinfdown_400av(j,nx-1,ns)-18*uinfdown_400av(j,nx-2,ns)+6*uinfdown_400av(j,nx-3,ns)-uinfdown_400av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dudx(j,i)=(25*uinfdown_400av(j,nx,ns)-48*uinfdown_400av(j,nx-1,ns)+36*uinfdown_400av(j,nx-2,ns)-16*uinfdown_400av(j,nx-3,ns)+3*uinfdown_400av(j,nx-4,ns))/(12*dx);
%                     else
%                         dudx(j,i)=(uinfdown_400av(j,i-2,ns)-8*uinfdown_400av(j,i-1,ns)+8*uinfdown_400av(j,i+1,ns)-uinfdown_400av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % dv/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dvdx(j,i)=(-25*vinfdown_400av(j,1,ns)+48*vinfdown_400av(j,2,ns)-36*vinfdown_400av(j,3,ns)+16*vinfdown_400av(j,4,ns)-3*vinfdown_400av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dvdx(j,i)=(-3*vinfdown_400av(j,1,ns)-10*vinfdown_400av(j,2,ns)+18*vinfdown_400av(j,3,ns)-6*vinfdown_400av(j,4,ns)+vinfdown_400av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dvdx(j,i)=(3*vinfdown_400av(j,nx,ns)+10*vinfdown_400av(j,nx-1,ns)-18*vinfdown_400av(j,nx-2,ns)+6*vinfdown_400av(j,nx-3,ns)-vinfdown_400av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dvdx(j,i)=(25*vinfdown_400av(j,nx,ns)-48*vinfdown_400av(j,nx-1,ns)+36*vinfdown_400av(j,nx-2,ns)-16*vinfdown_400av(j,nx-3,ns)+3*vinfdown_400av(j,nx-4,ns))/(12*dx);
%                     else
%                         dvdx(j,i)=(vinfdown_400av(j,i-2,ns)-8*vinfdown_400av(j,i-1,ns)+8*vinfdown_400av(j,i+1,ns)-vinfdown_400av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % du/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dudy(j,i)=-(-25*uinfdown_400av(1,i,ns)+48*uinfdown_400av(2,i,ns)-36*uinfdown_400av(3,i,ns)+16*uinfdown_400av(4,i,ns)-3*uinfdown_400av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dudy(j,i)=-(-3*uinfdown_400av(1,i,ns)-10*uinfdown_400av(2,i,ns)+18*uinfdown_400av(3,i,ns)-6*uinfdown_400av(4,i,ns)+uinfdown_400av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dudy(j,i)=-(3*uinfdown_400av(ny_calc,i,ns)+10*uinfdown_400av(ny_calc-1,i,ns)-18*uinfdown_400av(ny_calc-2,i,ns)+6*uinfdown_400av(ny_calc-3,i,ns)-uinfdown_400av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dudy(j,i)=-(25*uinfdown_400av(ny_calc,i,ns)-48*uinfdown_400av(ny_calc-1,i,ns)+36*uinfdown_400av(ny_calc-2,i,ns)-16*uinfdown_400av(ny_calc-3,i,ns)+3*uinfdown_400av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dudy(j,i)=-(uinfdown_400av(j-2,i,ns)-8*uinfdown_400av(j-1,i,ns)+8*uinfdown_400av(j+1,i,ns)-uinfdown_400av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % dv/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dvdy(j,i)=-(-25*vinfdown_400av(1,i,ns)+48*vinfdown_400av(2,i,ns)-36*vinfdown_400av(3,i,ns)+16*vinfdown_400av(4,i,ns)-3*vinfdown_400av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dvdy(j,i)=-(-3*vinfdown_400av(1,i,ns)-10*vinfdown_400av(2,i,ns)+18*vinfdown_400av(3,i,ns)-6*vinfdown_400av(4,i,ns)+vinfdown_400av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dvdy(j,i)=-(3*vinfdown_400av(ny_calc,i,ns)+10*vinfdown_400av(ny_calc-1,i,ns)-18*vinfdown_400av(ny_calc-2,i,ns)+6*vinfdown_400av(ny_calc-3,i,ns)-vinfdown_400av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dvdy(j,i)=-(25*vinfdown_400av(ny_calc,i,ns)-48*vinfdown_400av(ny_calc-1,i,ns)+36*vinfdown_400av(ny_calc-2,i,ns)-16*vinfdown_400av(ny_calc-3,i,ns)+3*vinfdown_400av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dvdy(j,i)=-(vinfdown_400av(j-2,i,ns)-8*vinfdown_400av(j-1,i,ns)+8*vinfdown_400av(j+1,i,ns)-vinfdown_400av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % omega
%             for j=1:ny_calc
%                 for i=1:nx
%                     omega(j,i)=dvdx(j,i)-dudy(j,i);
%                 end
%             end
% 
% % Sij, strain
%             for j=1:ny_calc
%                 for i=1:nx
%                     Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
%                     [V,D]=eig(Sij);
%                     if D(1,1) > D(2,2)
%                         strain_u(j,i)=V(1,1);
%                         strain_v(j,i)=V(2,1);
%                         eig11(j,i)=D(1,1);
%                         eig22(j,i)=D(2,2);
%                     elseif D(1,1) < D(2,2)
%                         strain_u(j,i)=V(1,2);
%                         strain_v(j,i)=V(2,2);
%                         eig11(j,i)=D(2,2);
%                         eig22(j,i)=D(1,1);
%                     end
%                 end
%             end
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
%             load('MyColormap_for_w','mymap')
%             colormap(ax,mymap)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[-4000 0 4000];
%             c.TickLabels={'-4000','0','4000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold on
%             
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_400L_omega_",num2str(ns),'.png')))
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_400L_omega_strain_",num2str(ns),'.png')))
%             close;
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 1000 2000];
%             c.TickLabels={'0','1000','2000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             hold on
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_400L_strain_",num2str(ns),'.png')))
%             close;
% 
% % dissipation rate
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
%                 end
%             end
% 
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 100 200];
%             c.TickLabels={'0','100','200'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_400L_dissipationrate_",num2str(ns),'.png')))
%             close;
% 
% % Kolmogorov Scale
%             eps_av=0;
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps_av=eps_av+eps(j,i)/(ny_calc*nx);
%                 end
%             end
% 
%             eta_infdown_400(ns)=((NYU^3)/eps_av)^0.25
% 
%         end
% 
% %% infup, 400
% 
%         for ns=1:10
% % du/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dudx(j,i)=(-25*uinfup_400av(j,1,ns)+48*uinfup_400av(j,2,ns)-36*uinfup_400av(j,3,ns)+16*uinfup_400av(j,4,ns)-3*uinfup_400av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dudx(j,i)=(-3*uinfup_400av(j,1,ns)-10*uinfup_400av(j,2,ns)+18*uinfup_400av(j,3,ns)-6*uinfup_400av(j,4,ns)+uinfup_400av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dudx(j,i)=(3*uinfup_400av(j,nx,ns)+10*uinfup_400av(j,nx-1,ns)-18*uinfup_400av(j,nx-2,ns)+6*uinfup_400av(j,nx-3,ns)-uinfup_400av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dudx(j,i)=(25*uinfup_400av(j,nx,ns)-48*uinfup_400av(j,nx-1,ns)+36*uinfup_400av(j,nx-2,ns)-16*uinfup_400av(j,nx-3,ns)+3*uinfup_400av(j,nx-4,ns))/(12*dx);
%                     else
%                         dudx(j,i)=(uinfup_400av(j,i-2,ns)-8*uinfup_400av(j,i-1,ns)+8*uinfup_400av(j,i+1,ns)-uinfup_400av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % dv/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dvdx(j,i)=(-25*vinfup_400av(j,1,ns)+48*vinfup_400av(j,2,ns)-36*vinfup_400av(j,3,ns)+16*vinfup_400av(j,4,ns)-3*vinfup_400av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dvdx(j,i)=(-3*vinfup_400av(j,1,ns)-10*vinfup_400av(j,2,ns)+18*vinfup_400av(j,3,ns)-6*vinfup_400av(j,4,ns)+vinfup_400av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dvdx(j,i)=(3*vinfup_400av(j,nx,ns)+10*vinfup_400av(j,nx-1,ns)-18*vinfup_400av(j,nx-2,ns)+6*vinfup_400av(j,nx-3,ns)-vinfup_400av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dvdx(j,i)=(25*vinfup_400av(j,nx,ns)-48*vinfup_400av(j,nx-1,ns)+36*vinfup_400av(j,nx-2,ns)-16*vinfup_400av(j,nx-3,ns)+3*vinfup_400av(j,nx-4,ns))/(12*dx);
%                     else
%                         dvdx(j,i)=(vinfup_400av(j,i-2,ns)-8*vinfup_400av(j,i-1,ns)+8*vinfup_400av(j,i+1,ns)-vinfup_400av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % du/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dudy(j,i)=-(-25*uinfup_400av(1,i,ns)+48*uinfup_400av(2,i,ns)-36*uinfup_400av(3,i,ns)+16*uinfup_400av(4,i,ns)-3*uinfup_400av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dudy(j,i)=-(-3*uinfup_400av(1,i,ns)-10*uinfup_400av(2,i,ns)+18*uinfup_400av(3,i,ns)-6*uinfup_400av(4,i,ns)+uinfup_400av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dudy(j,i)=-(3*uinfup_400av(ny_calc,i,ns)+10*uinfup_400av(ny_calc-1,i,ns)-18*uinfup_400av(ny_calc-2,i,ns)+6*uinfup_400av(ny_calc-3,i,ns)-uinfup_400av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dudy(j,i)=-(25*uinfup_400av(ny_calc,i,ns)-48*uinfup_400av(ny_calc-1,i,ns)+36*uinfup_400av(ny_calc-2,i,ns)-16*uinfup_400av(ny_calc-3,i,ns)+3*uinfup_400av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dudy(j,i)=-(uinfup_400av(j-2,i,ns)-8*uinfup_400av(j-1,i,ns)+8*uinfup_400av(j+1,i,ns)-uinfup_400av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % dv/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dvdy(j,i)=-(-25*vinfup_400av(1,i,ns)+48*vinfup_400av(2,i,ns)-36*vinfup_400av(3,i,ns)+16*vinfup_400av(4,i,ns)-3*vinfup_400av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dvdy(j,i)=-(-3*vinfup_400av(1,i,ns)-10*vinfup_400av(2,i,ns)+18*vinfup_400av(3,i,ns)-6*vinfup_400av(4,i,ns)+vinfup_400av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dvdy(j,i)=-(3*vinfup_400av(ny_calc,i,ns)+10*vinfup_400av(ny_calc-1,i,ns)-18*vinfup_400av(ny_calc-2,i,ns)+6*vinfup_400av(ny_calc-3,i,ns)-vinfup_400av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dvdy(j,i)=-(25*vinfup_400av(ny_calc,i,ns)-48*vinfup_400av(ny_calc-1,i,ns)+36*vinfup_400av(ny_calc-2,i,ns)-16*vinfup_400av(ny_calc-3,i,ns)+3*vinfup_400av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dvdy(j,i)=-(vinfup_400av(j-2,i,ns)-8*vinfup_400av(j-1,i,ns)+8*vinfup_400av(j+1,i,ns)-vinfup_400av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % omega
%             for j=1:ny_calc
%                 for i=1:nx
%                     omega(j,i)=dvdx(j,i)-dudy(j,i);
%                 end
%             end
% 
% % Sij, strain
%             for j=1:ny_calc
%                 for i=1:nx
%                     Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
%                     [V,D]=eig(Sij);
%                     if D(1,1) > D(2,2)
%                         strain_u(j,i)=V(1,1);
%                         strain_v(j,i)=V(2,1);
%                         eig11(j,i)=D(1,1);
%                         eig22(j,i)=D(2,2);
%                     elseif D(1,1) < D(2,2)
%                         strain_u(j,i)=V(1,2);
%                         strain_v(j,i)=V(2,2);
%                         eig11(j,i)=D(2,2);
%                         eig22(j,i)=D(1,1);
%                     end
%                 end
%             end
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
%             load('MyColormap_for_w','mymap')
%             colormap(ax,mymap)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[-4000 0 4000];
%             c.TickLabels={'-4000','0','4000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold on
%             
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_400L_omega_",num2str(ns),'.png')))
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_400L_omega_strain_",num2str(ns),'.png')))
%             close;
%  %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 1000 2000];
%             c.TickLabels={'0','1000','2000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             hold on
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_400L_strain_",num2str(ns),'.png')))
%             close;
% 
% % dissipation rate
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
%                 end
%             end
% 
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 100 200];
%             c.TickLabels={'0','100','200'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_400L_dissipationrate_",num2str(ns),'.png')))
%             close;
% 
% % Kolmogorov Scale
%             eps_av=0;
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps_av=eps_av+eps(j,i)/(ny_calc*nx);
%                 end
%             end
% 
%             eta_infup_400(ns)=((NYU^3)/eps_av)^0.25
% 
%         end
% 
% %% max, 400
% 
%         for ns=1:10
% % du/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dudx(j,i)=(-25*umax_400av(j,1,ns)+48*umax_400av(j,2,ns)-36*umax_400av(j,3,ns)+16*umax_400av(j,4,ns)-3*umax_400av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dudx(j,i)=(-3*umax_400av(j,1,ns)-10*umax_400av(j,2,ns)+18*umax_400av(j,3,ns)-6*umax_400av(j,4,ns)+umax_400av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dudx(j,i)=(3*umax_400av(j,nx,ns)+10*umax_400av(j,nx-1,ns)-18*umax_400av(j,nx-2,ns)+6*umax_400av(j,nx-3,ns)-umax_400av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dudx(j,i)=(25*umax_400av(j,nx,ns)-48*umax_400av(j,nx-1,ns)+36*umax_400av(j,nx-2,ns)-16*umax_400av(j,nx-3,ns)+3*umax_400av(j,nx-4,ns))/(12*dx);
%                     else
%                         dudx(j,i)=(umax_400av(j,i-2,ns)-8*umax_400av(j,i-1,ns)+8*umax_400av(j,i+1,ns)-umax_400av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % dv/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dvdx(j,i)=(-25*vmax_400av(j,1,ns)+48*vmax_400av(j,2,ns)-36*vmax_400av(j,3,ns)+16*vmax_400av(j,4,ns)-3*vmax_400av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dvdx(j,i)=(-3*vmax_400av(j,1,ns)-10*vmax_400av(j,2,ns)+18*vmax_400av(j,3,ns)-6*vmax_400av(j,4,ns)+vmax_400av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dvdx(j,i)=(3*vmax_400av(j,nx,ns)+10*vmax_400av(j,nx-1,ns)-18*vmax_400av(j,nx-2,ns)+6*vmax_400av(j,nx-3,ns)-vmax_400av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dvdx(j,i)=(25*vmax_400av(j,nx,ns)-48*vmax_400av(j,nx-1,ns)+36*vmax_400av(j,nx-2,ns)-16*vmax_400av(j,nx-3,ns)+3*vmax_400av(j,nx-4,ns))/(12*dx);
%                     else
%                         dvdx(j,i)=(vmax_400av(j,i-2,ns)-8*vmax_400av(j,i-1,ns)+8*vmax_400av(j,i+1,ns)-vmax_400av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % du/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dudy(j,i)=-(-25*umax_400av(1,i,ns)+48*umax_400av(2,i,ns)-36*umax_400av(3,i,ns)+16*umax_400av(4,i,ns)-3*umax_400av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dudy(j,i)=-(-3*umax_400av(1,i,ns)-10*umax_400av(2,i,ns)+18*umax_400av(3,i,ns)-6*umax_400av(4,i,ns)+umax_400av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dudy(j,i)=-(3*umax_400av(ny_calc,i,ns)+10*umax_400av(ny_calc-1,i,ns)-18*umax_400av(ny_calc-2,i,ns)+6*umax_400av(ny_calc-3,i,ns)-umax_400av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dudy(j,i)=-(25*umax_400av(ny_calc,i,ns)-48*umax_400av(ny_calc-1,i,ns)+36*umax_400av(ny_calc-2,i,ns)-16*umax_400av(ny_calc-3,i,ns)+3*umax_400av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dudy(j,i)=-(umax_400av(j-2,i,ns)-8*umax_400av(j-1,i,ns)+8*umax_400av(j+1,i,ns)-umax_400av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % dv/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dvdy(j,i)=-(-25*vmax_400av(1,i,ns)+48*vmax_400av(2,i,ns)-36*vmax_400av(3,i,ns)+16*vmax_400av(4,i,ns)-3*vmax_400av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dvdy(j,i)=-(-3*vmax_400av(1,i,ns)-10*vmax_400av(2,i,ns)+18*vmax_400av(3,i,ns)-6*vmax_400av(4,i,ns)+vmax_400av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dvdy(j,i)=-(3*vmax_400av(ny_calc,i,ns)+10*vmax_400av(ny_calc-1,i,ns)-18*vmax_400av(ny_calc-2,i,ns)+6*vmax_400av(ny_calc-3,i,ns)-vmax_400av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dvdy(j,i)=-(25*vmax_400av(ny_calc,i,ns)-48*vmax_400av(ny_calc-1,i,ns)+36*vmax_400av(ny_calc-2,i,ns)-16*vmax_400av(ny_calc-3,i,ns)+3*vmax_400av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dvdy(j,i)=-(vmax_400av(j-2,i,ns)-8*vmax_400av(j-1,i,ns)+8*vmax_400av(j+1,i,ns)-vmax_400av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % omega
%             for j=1:ny_calc
%                 for i=1:nx
%                     omega(j,i)=dvdx(j,i)-dudy(j,i);
%                 end
%             end
% 
% % Sij, strain
%             for j=1:ny_calc
%                 for i=1:nx
%                     Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
%                     [V,D]=eig(Sij);
%                     if D(1,1) > D(2,2)
%                         strain_u(j,i)=V(1,1);
%                         strain_v(j,i)=V(2,1);
%                         eig11(j,i)=D(1,1);
%                         eig22(j,i)=D(2,2);
%                     elseif D(1,1) < D(2,2)
%                         strain_u(j,i)=V(1,2);
%                         strain_v(j,i)=V(2,2);
%                         eig11(j,i)=D(2,2);
%                         eig22(j,i)=D(1,1);
%                     end
%                 end
%             end
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
%             load('MyColormap_for_w','mymap')
%             colormap(ax,mymap)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[-4000 0 4000];
%             c.TickLabels={'-4000','0','4000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold on
%             
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_max_400L_omega_",num2str(ns),'.png')))
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_max_400L_omega_strain_",num2str(ns),'.png')))
%             close;
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 1000 2000];
%             c.TickLabels={'0','1000','2000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             hold on
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_max_400L_strain_",num2str(ns),'.png')))
%             close;
% 
% % dissipation rate
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
%                 end
%             end
% 
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 100 200];
%             c.TickLabels={'0','100','200'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_max_400L_dissipationrate_",num2str(ns),'.png')))
%             close;
% 
% % Kolmogorov Scale
%             eps_av=0;
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps_av=eps_av+eps(j,i)/(ny_calc*nx);
%                 end
%             end
% 
%             eta_max_400(ns)=((NYU^3)/eps_av)^0.25
% 
%         end
% 
% %% min, 400
% 
%         for ns=1:10
% % du/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dudx(j,i)=(-25*umin_400av(j,1,ns)+48*umin_400av(j,2,ns)-36*umin_400av(j,3,ns)+16*umin_400av(j,4,ns)-3*umin_400av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dudx(j,i)=(-3*umin_400av(j,1,ns)-10*umin_400av(j,2,ns)+18*umin_400av(j,3,ns)-6*umin_400av(j,4,ns)+umin_400av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dudx(j,i)=(3*umin_400av(j,nx,ns)+10*umin_400av(j,nx-1,ns)-18*umin_400av(j,nx-2,ns)+6*umin_400av(j,nx-3,ns)-umin_400av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dudx(j,i)=(25*umin_400av(j,nx,ns)-48*umin_400av(j,nx-1,ns)+36*umin_400av(j,nx-2,ns)-16*umin_400av(j,nx-3,ns)+3*umin_400av(j,nx-4,ns))/(12*dx);
%                     else
%                         dudx(j,i)=(umin_400av(j,i-2,ns)-8*umin_400av(j,i-1,ns)+8*umin_400av(j,i+1,ns)-umin_400av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % dv/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dvdx(j,i)=(-25*vmin_400av(j,1,ns)+48*vmin_400av(j,2,ns)-36*vmin_400av(j,3,ns)+16*vmin_400av(j,4,ns)-3*vmin_400av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dvdx(j,i)=(-3*vmin_400av(j,1,ns)-10*vmin_400av(j,2,ns)+18*vmin_400av(j,3,ns)-6*vmin_400av(j,4,ns)+vmin_400av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dvdx(j,i)=(3*vmin_400av(j,nx,ns)+10*vmin_400av(j,nx-1,ns)-18*vmin_400av(j,nx-2,ns)+6*vmin_400av(j,nx-3,ns)-vmin_400av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dvdx(j,i)=(25*vmin_400av(j,nx,ns)-48*vmin_400av(j,nx-1,ns)+36*vmin_400av(j,nx-2,ns)-16*vmin_400av(j,nx-3,ns)+3*vmin_400av(j,nx-4,ns))/(12*dx);
%                     else
%                         dvdx(j,i)=(vmin_400av(j,i-2,ns)-8*vmin_400av(j,i-1,ns)+8*vmin_400av(j,i+1,ns)-vmin_400av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % du/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dudy(j,i)=-(-25*umin_400av(1,i,ns)+48*umin_400av(2,i,ns)-36*umin_400av(3,i,ns)+16*umin_400av(4,i,ns)-3*umin_400av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dudy(j,i)=-(-3*umin_400av(1,i,ns)-10*umin_400av(2,i,ns)+18*umin_400av(3,i,ns)-6*umin_400av(4,i,ns)+umin_400av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dudy(j,i)=-(3*umin_400av(ny_calc,i,ns)+10*umin_400av(ny_calc-1,i,ns)-18*umin_400av(ny_calc-2,i,ns)+6*umin_400av(ny_calc-3,i,ns)-umin_400av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dudy(j,i)=-(25*umin_400av(ny_calc,i,ns)-48*umin_400av(ny_calc-1,i,ns)+36*umin_400av(ny_calc-2,i,ns)-16*umin_400av(ny_calc-3,i,ns)+3*umin_400av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dudy(j,i)=-(umin_400av(j-2,i,ns)-8*umin_400av(j-1,i,ns)+8*umin_400av(j+1,i,ns)-umin_400av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % dv/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dvdy(j,i)=-(-25*vmin_400av(1,i,ns)+48*vmin_400av(2,i,ns)-36*vmin_400av(3,i,ns)+16*vmin_400av(4,i,ns)-3*vmin_400av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dvdy(j,i)=-(-3*vmin_400av(1,i,ns)-10*vmin_400av(2,i,ns)+18*vmin_400av(3,i,ns)-6*vmin_400av(4,i,ns)+vmin_400av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dvdy(j,i)=-(3*vmin_400av(ny_calc,i,ns)+10*vmin_400av(ny_calc-1,i,ns)-18*vmin_400av(ny_calc-2,i,ns)+6*vmin_400av(ny_calc-3,i,ns)-vmin_400av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dvdy(j,i)=-(25*vmin_400av(ny_calc,i,ns)-48*vmin_400av(ny_calc-1,i,ns)+36*vmin_400av(ny_calc-2,i,ns)-16*vmin_400av(ny_calc-3,i,ns)+3*vmin_400av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dvdy(j,i)=-(vmin_400av(j-2,i,ns)-8*vmin_400av(j-1,i,ns)+8*vmin_400av(j+1,i,ns)-vmin_400av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % omega
%             for j=1:ny_calc
%                 for i=1:nx
%                     omega(j,i)=dvdx(j,i)-dudy(j,i);
%                 end
%             end
% 
% % Sij, strain
%             for j=1:ny_calc
%                 for i=1:nx
%                     Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
%                     [V,D]=eig(Sij);
%                     if D(1,1) > D(2,2)
%                         strain_u(j,i)=V(1,1);
%                         strain_v(j,i)=V(2,1);
%                         eig11(j,i)=D(1,1);
%                         eig22(j,i)=D(2,2);
%                     elseif D(1,1) < D(2,2)
%                         strain_u(j,i)=V(1,2);
%                         strain_v(j,i)=V(2,2);
%                         eig11(j,i)=D(2,2);
%                         eig22(j,i)=D(1,1);
%                     end
%                 end
%             end
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
%             load('MyColormap_for_w','mymap')
%             colormap(ax,mymap)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[-4000 0 4000];
%             c.TickLabels={'-4000','0','4000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold on
%             
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_min_400L_omega_",num2str(ns),'.png')))
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_min_400L_omega_strain_",num2str(ns),'.png')))
%             close;
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 1000 2000];
%             c.TickLabels={'0','1000','2000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             hold on
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_min_400L_strain_",num2str(ns),'.png')))
%             close;
% 
% % dissipation rate
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
%                 end
%             end
% 
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 100 200];
%             c.TickLabels={'0','100','200'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_min_400L_dissipationrate_",num2str(ns),'.png')))
%             close;
% 
% % Kolmogorov Scale
%             eps_av=0;
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps_av=eps_av+eps(j,i)/(ny_calc*nx);
%                 end
%             end
% 
%             eta_min_400(ns)=((NYU^3)/eps_av)^0.25
% 
%         end
% 
% %% infdown, 450
% 
%         for ns=1:10
% % du/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dudx(j,i)=(-25*uinfdown_450av(j,1,ns)+48*uinfdown_450av(j,2,ns)-36*uinfdown_450av(j,3,ns)+16*uinfdown_450av(j,4,ns)-3*uinfdown_450av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dudx(j,i)=(-3*uinfdown_450av(j,1,ns)-10*uinfdown_450av(j,2,ns)+18*uinfdown_450av(j,3,ns)-6*uinfdown_450av(j,4,ns)+uinfdown_450av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dudx(j,i)=(3*uinfdown_450av(j,nx,ns)+10*uinfdown_450av(j,nx-1,ns)-18*uinfdown_450av(j,nx-2,ns)+6*uinfdown_450av(j,nx-3,ns)-uinfdown_450av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dudx(j,i)=(25*uinfdown_450av(j,nx,ns)-48*uinfdown_450av(j,nx-1,ns)+36*uinfdown_450av(j,nx-2,ns)-16*uinfdown_450av(j,nx-3,ns)+3*uinfdown_450av(j,nx-4,ns))/(12*dx);
%                     else
%                         dudx(j,i)=(uinfdown_450av(j,i-2,ns)-8*uinfdown_450av(j,i-1,ns)+8*uinfdown_450av(j,i+1,ns)-uinfdown_450av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % dv/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dvdx(j,i)=(-25*vinfdown_450av(j,1,ns)+48*vinfdown_450av(j,2,ns)-36*vinfdown_450av(j,3,ns)+16*vinfdown_450av(j,4,ns)-3*vinfdown_450av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dvdx(j,i)=(-3*vinfdown_450av(j,1,ns)-10*vinfdown_450av(j,2,ns)+18*vinfdown_450av(j,3,ns)-6*vinfdown_450av(j,4,ns)+vinfdown_450av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dvdx(j,i)=(3*vinfdown_450av(j,nx,ns)+10*vinfdown_450av(j,nx-1,ns)-18*vinfdown_450av(j,nx-2,ns)+6*vinfdown_450av(j,nx-3,ns)-vinfdown_450av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dvdx(j,i)=(25*vinfdown_450av(j,nx,ns)-48*vinfdown_450av(j,nx-1,ns)+36*vinfdown_450av(j,nx-2,ns)-16*vinfdown_450av(j,nx-3,ns)+3*vinfdown_450av(j,nx-4,ns))/(12*dx);
%                     else
%                         dvdx(j,i)=(vinfdown_450av(j,i-2,ns)-8*vinfdown_450av(j,i-1,ns)+8*vinfdown_450av(j,i+1,ns)-vinfdown_450av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % du/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dudy(j,i)=-(-25*uinfdown_450av(1,i,ns)+48*uinfdown_450av(2,i,ns)-36*uinfdown_450av(3,i,ns)+16*uinfdown_450av(4,i,ns)-3*uinfdown_450av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dudy(j,i)=-(-3*uinfdown_450av(1,i,ns)-10*uinfdown_450av(2,i,ns)+18*uinfdown_450av(3,i,ns)-6*uinfdown_450av(4,i,ns)+uinfdown_450av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dudy(j,i)=-(3*uinfdown_450av(ny_calc,i,ns)+10*uinfdown_450av(ny_calc-1,i,ns)-18*uinfdown_450av(ny_calc-2,i,ns)+6*uinfdown_450av(ny_calc-3,i,ns)-uinfdown_450av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dudy(j,i)=-(25*uinfdown_450av(ny_calc,i,ns)-48*uinfdown_450av(ny_calc-1,i,ns)+36*uinfdown_450av(ny_calc-2,i,ns)-16*uinfdown_450av(ny_calc-3,i,ns)+3*uinfdown_450av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dudy(j,i)=-(uinfdown_450av(j-2,i,ns)-8*uinfdown_450av(j-1,i,ns)+8*uinfdown_450av(j+1,i,ns)-uinfdown_450av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % dv/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dvdy(j,i)=-(-25*vinfdown_450av(1,i,ns)+48*vinfdown_450av(2,i,ns)-36*vinfdown_450av(3,i,ns)+16*vinfdown_450av(4,i,ns)-3*vinfdown_450av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dvdy(j,i)=-(-3*vinfdown_450av(1,i,ns)-10*vinfdown_450av(2,i,ns)+18*vinfdown_450av(3,i,ns)-6*vinfdown_450av(4,i,ns)+vinfdown_450av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dvdy(j,i)=-(3*vinfdown_450av(ny_calc,i,ns)+10*vinfdown_450av(ny_calc-1,i,ns)-18*vinfdown_450av(ny_calc-2,i,ns)+6*vinfdown_450av(ny_calc-3,i,ns)-vinfdown_450av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dvdy(j,i)=-(25*vinfdown_450av(ny_calc,i,ns)-48*vinfdown_450av(ny_calc-1,i,ns)+36*vinfdown_450av(ny_calc-2,i,ns)-16*vinfdown_450av(ny_calc-3,i,ns)+3*vinfdown_450av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dvdy(j,i)=-(vinfdown_450av(j-2,i,ns)-8*vinfdown_450av(j-1,i,ns)+8*vinfdown_450av(j+1,i,ns)-vinfdown_450av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % omega
%             for j=1:ny_calc
%                 for i=1:nx
%                     omega(j,i)=dvdx(j,i)-dudy(j,i);
%                 end
%             end
% 
% % Sij, strain
%             for j=1:ny_calc
%                 for i=1:nx
%                     Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
%                     [V,D]=eig(Sij);
%                     if D(1,1) > D(2,2)
%                         strain_u(j,i)=V(1,1);
%                         strain_v(j,i)=V(2,1);
%                         eig11(j,i)=D(1,1);
%                         eig22(j,i)=D(2,2);
%                     elseif D(1,1) < D(2,2)
%                         strain_u(j,i)=V(1,2);
%                         strain_v(j,i)=V(2,2);
%                         eig11(j,i)=D(2,2);
%                         eig22(j,i)=D(1,1);
%                     end
%                 end
%             end
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
%             load('MyColormap_for_w','mymap')
%             colormap(ax,mymap)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[-4000 0 4000];
%             c.TickLabels={'-4000','0','4000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold on
%             
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_450L_omega_",num2str(ns),'.png')))
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_450L_omega_strain_",num2str(ns),'.png')))
%             close;
%  %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 1000 2000];
%             c.TickLabels={'0','1000','2000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             hold on
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_450L_strain_",num2str(ns),'.png')))
%             close;
% 
% % dissipation rate
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
%                 end
%             end
% 
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 100 200];
%             c.TickLabels={'0','100','200'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_450L_dissipationrate_",num2str(ns),'.png')))
%             close;
% 
% % Kolmogorov Scale
%             eps_av=0;
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps_av=eps_av+eps(j,i)/(ny_calc*nx);
%                 end
%             end
% 
%             eta_infdown_450(ns)=((NYU^3)/eps_av)^0.25
% 
%         end
% 
% %% infup, 450
% 
%         for ns=1:10
% % du/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dudx(j,i)=(-25*uinfup_450av(j,1,ns)+48*uinfup_450av(j,2,ns)-36*uinfup_450av(j,3,ns)+16*uinfup_450av(j,4,ns)-3*uinfup_450av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dudx(j,i)=(-3*uinfup_450av(j,1,ns)-10*uinfup_450av(j,2,ns)+18*uinfup_450av(j,3,ns)-6*uinfup_450av(j,4,ns)+uinfup_450av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dudx(j,i)=(3*uinfup_450av(j,nx,ns)+10*uinfup_450av(j,nx-1,ns)-18*uinfup_450av(j,nx-2,ns)+6*uinfup_450av(j,nx-3,ns)-uinfup_450av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dudx(j,i)=(25*uinfup_450av(j,nx,ns)-48*uinfup_450av(j,nx-1,ns)+36*uinfup_450av(j,nx-2,ns)-16*uinfup_450av(j,nx-3,ns)+3*uinfup_450av(j,nx-4,ns))/(12*dx);
%                     else
%                         dudx(j,i)=(uinfup_450av(j,i-2,ns)-8*uinfup_450av(j,i-1,ns)+8*uinfup_450av(j,i+1,ns)-uinfup_450av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % dv/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dvdx(j,i)=(-25*vinfup_450av(j,1,ns)+48*vinfup_450av(j,2,ns)-36*vinfup_450av(j,3,ns)+16*vinfup_450av(j,4,ns)-3*vinfup_450av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dvdx(j,i)=(-3*vinfup_450av(j,1,ns)-10*vinfup_450av(j,2,ns)+18*vinfup_450av(j,3,ns)-6*vinfup_450av(j,4,ns)+vinfup_450av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dvdx(j,i)=(3*vinfup_450av(j,nx,ns)+10*vinfup_450av(j,nx-1,ns)-18*vinfup_450av(j,nx-2,ns)+6*vinfup_450av(j,nx-3,ns)-vinfup_450av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dvdx(j,i)=(25*vinfup_450av(j,nx,ns)-48*vinfup_450av(j,nx-1,ns)+36*vinfup_450av(j,nx-2,ns)-16*vinfup_450av(j,nx-3,ns)+3*vinfup_450av(j,nx-4,ns))/(12*dx);
%                     else
%                         dvdx(j,i)=(vinfup_450av(j,i-2,ns)-8*vinfup_450av(j,i-1,ns)+8*vinfup_450av(j,i+1,ns)-vinfup_450av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % du/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dudy(j,i)=-(-25*uinfup_450av(1,i,ns)+48*uinfup_450av(2,i,ns)-36*uinfup_450av(3,i,ns)+16*uinfup_450av(4,i,ns)-3*uinfup_450av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dudy(j,i)=-(-3*uinfup_450av(1,i,ns)-10*uinfup_450av(2,i,ns)+18*uinfup_450av(3,i,ns)-6*uinfup_450av(4,i,ns)+uinfup_450av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dudy(j,i)=-(3*uinfup_450av(ny_calc,i,ns)+10*uinfup_450av(ny_calc-1,i,ns)-18*uinfup_450av(ny_calc-2,i,ns)+6*uinfup_450av(ny_calc-3,i,ns)-uinfup_450av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dudy(j,i)=-(25*uinfup_450av(ny_calc,i,ns)-48*uinfup_450av(ny_calc-1,i,ns)+36*uinfup_450av(ny_calc-2,i,ns)-16*uinfup_450av(ny_calc-3,i,ns)+3*uinfup_450av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dudy(j,i)=-(uinfup_450av(j-2,i,ns)-8*uinfup_450av(j-1,i,ns)+8*uinfup_450av(j+1,i,ns)-uinfup_450av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % dv/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dvdy(j,i)=-(-25*vinfup_450av(1,i,ns)+48*vinfup_450av(2,i,ns)-36*vinfup_450av(3,i,ns)+16*vinfup_450av(4,i,ns)-3*vinfup_450av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dvdy(j,i)=-(-3*vinfup_450av(1,i,ns)-10*vinfup_450av(2,i,ns)+18*vinfup_450av(3,i,ns)-6*vinfup_450av(4,i,ns)+vinfup_450av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dvdy(j,i)=-(3*vinfup_450av(ny_calc,i,ns)+10*vinfup_450av(ny_calc-1,i,ns)-18*vinfup_450av(ny_calc-2,i,ns)+6*vinfup_450av(ny_calc-3,i,ns)-vinfup_450av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dvdy(j,i)=-(25*vinfup_450av(ny_calc,i,ns)-48*vinfup_450av(ny_calc-1,i,ns)+36*vinfup_450av(ny_calc-2,i,ns)-16*vinfup_450av(ny_calc-3,i,ns)+3*vinfup_450av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dvdy(j,i)=-(vinfup_450av(j-2,i,ns)-8*vinfup_450av(j-1,i,ns)+8*vinfup_450av(j+1,i,ns)-vinfup_450av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % omega
%             for j=1:ny_calc
%                 for i=1:nx
%                     omega(j,i)=dvdx(j,i)-dudy(j,i);
%                 end
%             end
% 
% % Sij, strain
%             for j=1:ny_calc
%                 for i=1:nx
%                     Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
%                     [V,D]=eig(Sij);
%                     if D(1,1) > D(2,2)
%                         strain_u(j,i)=V(1,1);
%                         strain_v(j,i)=V(2,1);
%                         eig11(j,i)=D(1,1);
%                         eig22(j,i)=D(2,2);
%                     elseif D(1,1) < D(2,2)
%                         strain_u(j,i)=V(1,2);
%                         strain_v(j,i)=V(2,2);
%                         eig11(j,i)=D(2,2);
%                         eig22(j,i)=D(1,1);
%                     end
%                 end
%             end
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
%             load('MyColormap_for_w','mymap')
%             colormap(ax,mymap)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[-4000 0 4000];
%             c.TickLabels={'-4000','0','4000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold on
%             
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_450L_omega_",num2str(ns),'.png')))
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_450L_omega_strain_",num2str(ns),'.png')))
%             close;
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 1000 2000];
%             c.TickLabels={'0','1000','2000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             hold on
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_450L_strain_",num2str(ns),'.png')))
%             close;
% 
% % dissipation rate
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
%                 end
%             end
% 
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 100 200];
%             c.TickLabels={'0','100','200'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_450L_dissipationrate_",num2str(ns),'.png')))
%             close;
% 
% % Kolmogorov Scale
%             eps_av=0;
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps_av=eps_av+eps(j,i)/(ny_calc*nx);
%                 end
%             end
% 
%             eta_infup_450(ns)=((NYU^3)/eps_av)^0.25
% 
%         end
% 
% %% max, 450
% 
%         for ns=1:10
% % du/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dudx(j,i)=(-25*umax_450av(j,1,ns)+48*umax_450av(j,2,ns)-36*umax_450av(j,3,ns)+16*umax_450av(j,4,ns)-3*umax_450av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dudx(j,i)=(-3*umax_450av(j,1,ns)-10*umax_450av(j,2,ns)+18*umax_450av(j,3,ns)-6*umax_450av(j,4,ns)+umax_450av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dudx(j,i)=(3*umax_450av(j,nx,ns)+10*umax_450av(j,nx-1,ns)-18*umax_450av(j,nx-2,ns)+6*umax_450av(j,nx-3,ns)-umax_450av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dudx(j,i)=(25*umax_450av(j,nx,ns)-48*umax_450av(j,nx-1,ns)+36*umax_450av(j,nx-2,ns)-16*umax_450av(j,nx-3,ns)+3*umax_450av(j,nx-4,ns))/(12*dx);
%                     else
%                         dudx(j,i)=(umax_450av(j,i-2,ns)-8*umax_450av(j,i-1,ns)+8*umax_450av(j,i+1,ns)-umax_450av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % dv/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dvdx(j,i)=(-25*vmax_450av(j,1,ns)+48*vmax_450av(j,2,ns)-36*vmax_450av(j,3,ns)+16*vmax_450av(j,4,ns)-3*vmax_450av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dvdx(j,i)=(-3*vmax_450av(j,1,ns)-10*vmax_450av(j,2,ns)+18*vmax_450av(j,3,ns)-6*vmax_450av(j,4,ns)+vmax_450av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dvdx(j,i)=(3*vmax_450av(j,nx,ns)+10*vmax_450av(j,nx-1,ns)-18*vmax_450av(j,nx-2,ns)+6*vmax_450av(j,nx-3,ns)-vmax_450av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dvdx(j,i)=(25*vmax_450av(j,nx,ns)-48*vmax_450av(j,nx-1,ns)+36*vmax_450av(j,nx-2,ns)-16*vmax_450av(j,nx-3,ns)+3*vmax_450av(j,nx-4,ns))/(12*dx);
%                     else
%                         dvdx(j,i)=(vmax_450av(j,i-2,ns)-8*vmax_450av(j,i-1,ns)+8*vmax_450av(j,i+1,ns)-vmax_450av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % du/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dudy(j,i)=-(-25*umax_450av(1,i,ns)+48*umax_450av(2,i,ns)-36*umax_450av(3,i,ns)+16*umax_450av(4,i,ns)-3*umax_450av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dudy(j,i)=-(-3*umax_450av(1,i,ns)-10*umax_450av(2,i,ns)+18*umax_450av(3,i,ns)-6*umax_450av(4,i,ns)+umax_450av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dudy(j,i)=-(3*umax_450av(ny_calc,i,ns)+10*umax_450av(ny_calc-1,i,ns)-18*umax_450av(ny_calc-2,i,ns)+6*umax_450av(ny_calc-3,i,ns)-umax_450av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dudy(j,i)=-(25*umax_450av(ny_calc,i,ns)-48*umax_450av(ny_calc-1,i,ns)+36*umax_450av(ny_calc-2,i,ns)-16*umax_450av(ny_calc-3,i,ns)+3*umax_450av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dudy(j,i)=-(umax_450av(j-2,i,ns)-8*umax_450av(j-1,i,ns)+8*umax_450av(j+1,i,ns)-umax_450av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % dv/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dvdy(j,i)=-(-25*vmax_450av(1,i,ns)+48*vmax_450av(2,i,ns)-36*vmax_450av(3,i,ns)+16*vmax_450av(4,i,ns)-3*vmax_450av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dvdy(j,i)=-(-3*vmax_450av(1,i,ns)-10*vmax_450av(2,i,ns)+18*vmax_450av(3,i,ns)-6*vmax_450av(4,i,ns)+vmax_450av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dvdy(j,i)=-(3*vmax_450av(ny_calc,i,ns)+10*vmax_450av(ny_calc-1,i,ns)-18*vmax_450av(ny_calc-2,i,ns)+6*vmax_450av(ny_calc-3,i,ns)-vmax_450av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dvdy(j,i)=-(25*vmax_450av(ny_calc,i,ns)-48*vmax_450av(ny_calc-1,i,ns)+36*vmax_450av(ny_calc-2,i,ns)-16*vmax_450av(ny_calc-3,i,ns)+3*vmax_450av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dvdy(j,i)=-(vmax_450av(j-2,i,ns)-8*vmax_450av(j-1,i,ns)+8*vmax_450av(j+1,i,ns)-vmax_450av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
%  % omega
%             for j=1:ny_calc
%                 for i=1:nx
%                     omega(j,i)=dvdx(j,i)-dudy(j,i);
%                 end
%             end
% 
% % Sij, strain
%             for j=1:ny_calc
%                 for i=1:nx
%                     Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
%                     [V,D]=eig(Sij);
%                     if D(1,1) > D(2,2)
%                         strain_u(j,i)=V(1,1);
%                         strain_v(j,i)=V(2,1);
%                         eig11(j,i)=D(1,1);
%                         eig22(j,i)=D(2,2);
%                     elseif D(1,1) < D(2,2)
%                         strain_u(j,i)=V(1,2);
%                         strain_v(j,i)=V(2,2);
%                         eig11(j,i)=D(2,2);
%                         eig22(j,i)=D(1,1);
%                     end
%                 end
%             end
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
%             load('MyColormap_for_w','mymap')
%             colormap(ax,mymap)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[-4000 0 4000];
%             c.TickLabels={'-4000','0','4000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold on
%             
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_max_450L_omega_",num2str(ns),'.png')))
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_max_450L_omega_strain_",num2str(ns),'.png')))
%             close;
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 1000 2000];
%             c.TickLabels={'0','1000','2000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             hold on
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_max_450L_strain_",num2str(ns),'.png')))
%             close;
% 
% % dissipation rate
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
%                 end
%             end
% 
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 100 200];
%             c.TickLabels={'0','100','200'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_max_450L_dissipationrate_",num2str(ns),'.png')))
%             close;
% 
% % Kolmogorov Scale
%             eps_av=0;
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps_av=eps_av+eps(j,i)/(ny_calc*nx);
%                 end
%             end
% 
%             eta_max_450(ns)=((NYU^3)/eps_av)^0.25
% 
%         end
% 
% %% min, 450
% 
%         for ns=1:10
% % du/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dudx(j,i)=(-25*umin_450av(j,1,ns)+48*umin_450av(j,2,ns)-36*umin_450av(j,3,ns)+16*umin_450av(j,4,ns)-3*umin_450av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dudx(j,i)=(-3*umin_450av(j,1,ns)-10*umin_450av(j,2,ns)+18*umin_450av(j,3,ns)-6*umin_450av(j,4,ns)+umin_450av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dudx(j,i)=(3*umin_450av(j,nx,ns)+10*umin_450av(j,nx-1,ns)-18*umin_450av(j,nx-2,ns)+6*umin_450av(j,nx-3,ns)-umin_450av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dudx(j,i)=(25*umin_450av(j,nx,ns)-48*umin_450av(j,nx-1,ns)+36*umin_450av(j,nx-2,ns)-16*umin_450av(j,nx-3,ns)+3*umin_450av(j,nx-4,ns))/(12*dx);
%                     else
%                         dudx(j,i)=(umin_450av(j,i-2,ns)-8*umin_450av(j,i-1,ns)+8*umin_450av(j,i+1,ns)-umin_450av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % dv/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dvdx(j,i)=(-25*vmin_450av(j,1,ns)+48*vmin_450av(j,2,ns)-36*vmin_450av(j,3,ns)+16*vmin_450av(j,4,ns)-3*vmin_450av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dvdx(j,i)=(-3*vmin_450av(j,1,ns)-10*vmin_450av(j,2,ns)+18*vmin_450av(j,3,ns)-6*vmin_450av(j,4,ns)+vmin_450av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dvdx(j,i)=(3*vmin_450av(j,nx,ns)+10*vmin_450av(j,nx-1,ns)-18*vmin_450av(j,nx-2,ns)+6*vmin_450av(j,nx-3,ns)-vmin_450av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dvdx(j,i)=(25*vmin_450av(j,nx,ns)-48*vmin_450av(j,nx-1,ns)+36*vmin_450av(j,nx-2,ns)-16*vmin_450av(j,nx-3,ns)+3*vmin_450av(j,nx-4,ns))/(12*dx);
%                     else
%                         dvdx(j,i)=(vmin_450av(j,i-2,ns)-8*vmin_450av(j,i-1,ns)+8*vmin_450av(j,i+1,ns)-vmin_450av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % du/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dudy(j,i)=-(-25*umin_450av(1,i,ns)+48*umin_450av(2,i,ns)-36*umin_450av(3,i,ns)+16*umin_450av(4,i,ns)-3*umin_450av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dudy(j,i)=-(-3*umin_450av(1,i,ns)-10*umin_450av(2,i,ns)+18*umin_450av(3,i,ns)-6*umin_450av(4,i,ns)+umin_450av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dudy(j,i)=-(3*umin_450av(ny_calc,i,ns)+10*umin_450av(ny_calc-1,i,ns)-18*umin_450av(ny_calc-2,i,ns)+6*umin_450av(ny_calc-3,i,ns)-umin_450av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dudy(j,i)=-(25*umin_450av(ny_calc,i,ns)-48*umin_450av(ny_calc-1,i,ns)+36*umin_450av(ny_calc-2,i,ns)-16*umin_450av(ny_calc-3,i,ns)+3*umin_450av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dudy(j,i)=-(umin_450av(j-2,i,ns)-8*umin_450av(j-1,i,ns)+8*umin_450av(j+1,i,ns)-umin_450av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % dv/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dvdy(j,i)=-(-25*vmin_450av(1,i,ns)+48*vmin_450av(2,i,ns)-36*vmin_450av(3,i,ns)+16*vmin_450av(4,i,ns)-3*vmin_450av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dvdy(j,i)=-(-3*vmin_450av(1,i,ns)-10*vmin_450av(2,i,ns)+18*vmin_450av(3,i,ns)-6*vmin_450av(4,i,ns)+vmin_450av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dvdy(j,i)=-(3*vmin_450av(ny_calc,i,ns)+10*vmin_450av(ny_calc-1,i,ns)-18*vmin_450av(ny_calc-2,i,ns)+6*vmin_450av(ny_calc-3,i,ns)-vmin_450av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dvdy(j,i)=-(25*vmin_450av(ny_calc,i,ns)-48*vmin_450av(ny_calc-1,i,ns)+36*vmin_450av(ny_calc-2,i,ns)-16*vmin_450av(ny_calc-3,i,ns)+3*vmin_450av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dvdy(j,i)=-(vmin_450av(j-2,i,ns)-8*vmin_450av(j-1,i,ns)+8*vmin_450av(j+1,i,ns)-vmin_450av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % omega
%             for j=1:ny_calc
%                 for i=1:nx
%                     omega(j,i)=dvdx(j,i)-dudy(j,i);
%                 end
%             end
% 
% % Sij, strain
%             for j=1:ny_calc
%                 for i=1:nx
%                     Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
%                     [V,D]=eig(Sij);
%                     if D(1,1) > D(2,2)
%                         strain_u(j,i)=V(1,1);
%                         strain_v(j,i)=V(2,1);
%                         eig11(j,i)=D(1,1);
%                         eig22(j,i)=D(2,2);
%                     elseif D(1,1) < D(2,2)
%                         strain_u(j,i)=V(1,2);
%                         strain_v(j,i)=V(2,2);
%                         eig11(j,i)=D(2,2);
%                         eig22(j,i)=D(1,1);
%                     end
%                 end
%             end
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
%             load('MyColormap_for_w','mymap')
%             colormap(ax,mymap)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[-4000 0 4000];
%             c.TickLabels={'-4000','0','4000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold on
%             
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_min_450L_omega_",num2str(ns),'.png')))
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_min_450L_omega_strain_",num2str(ns),'.png')))
%             close;
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 1000 2000];
%             c.TickLabels={'0','1000','2000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             hold on
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_min_450L_strain_",num2str(ns),'.png')))
%             close;
% 
% % dissipation rate
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
%                 end
%             end
% 
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 100 200];
%             c.TickLabels={'0','100','200'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_min_450L_dissipationrate_",num2str(ns),'.png')))
%             close;
% 
% % Kolmogorov Scale
%             eps_av=0;
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps_av=eps_av+eps(j,i)/(ny_calc*nx);
%                 end
%             end
% 
%             eta_min_450(ns)=((NYU^3)/eps_av)^0.25
% 
%         end
% 
% %% infdown, 500
% 
%         for ns=1:10
% % du/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dudx(j,i)=(-25*uinfdown_500av(j,1,ns)+48*uinfdown_500av(j,2,ns)-36*uinfdown_500av(j,3,ns)+16*uinfdown_500av(j,4,ns)-3*uinfdown_500av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dudx(j,i)=(-3*uinfdown_500av(j,1,ns)-10*uinfdown_500av(j,2,ns)+18*uinfdown_500av(j,3,ns)-6*uinfdown_500av(j,4,ns)+uinfdown_500av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dudx(j,i)=(3*uinfdown_500av(j,nx,ns)+10*uinfdown_500av(j,nx-1,ns)-18*uinfdown_500av(j,nx-2,ns)+6*uinfdown_500av(j,nx-3,ns)-uinfdown_500av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dudx(j,i)=(25*uinfdown_500av(j,nx,ns)-48*uinfdown_500av(j,nx-1,ns)+36*uinfdown_500av(j,nx-2,ns)-16*uinfdown_500av(j,nx-3,ns)+3*uinfdown_500av(j,nx-4,ns))/(12*dx);
%                     else
%                         dudx(j,i)=(uinfdown_500av(j,i-2,ns)-8*uinfdown_500av(j,i-1,ns)+8*uinfdown_500av(j,i+1,ns)-uinfdown_500av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % dv/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dvdx(j,i)=(-25*vinfdown_500av(j,1,ns)+48*vinfdown_500av(j,2,ns)-36*vinfdown_500av(j,3,ns)+16*vinfdown_500av(j,4,ns)-3*vinfdown_500av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dvdx(j,i)=(-3*vinfdown_500av(j,1,ns)-10*vinfdown_500av(j,2,ns)+18*vinfdown_500av(j,3,ns)-6*vinfdown_500av(j,4,ns)+vinfdown_500av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dvdx(j,i)=(3*vinfdown_500av(j,nx,ns)+10*vinfdown_500av(j,nx-1,ns)-18*vinfdown_500av(j,nx-2,ns)+6*vinfdown_500av(j,nx-3,ns)-vinfdown_500av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dvdx(j,i)=(25*vinfdown_500av(j,nx,ns)-48*vinfdown_500av(j,nx-1,ns)+36*vinfdown_500av(j,nx-2,ns)-16*vinfdown_500av(j,nx-3,ns)+3*vinfdown_500av(j,nx-4,ns))/(12*dx);
%                     else
%                         dvdx(j,i)=(vinfdown_500av(j,i-2,ns)-8*vinfdown_500av(j,i-1,ns)+8*vinfdown_500av(j,i+1,ns)-vinfdown_500av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % du/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dudy(j,i)=-(-25*uinfdown_500av(1,i,ns)+48*uinfdown_500av(2,i,ns)-36*uinfdown_500av(3,i,ns)+16*uinfdown_500av(4,i,ns)-3*uinfdown_500av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dudy(j,i)=-(-3*uinfdown_500av(1,i,ns)-10*uinfdown_500av(2,i,ns)+18*uinfdown_500av(3,i,ns)-6*uinfdown_500av(4,i,ns)+uinfdown_500av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dudy(j,i)=-(3*uinfdown_500av(ny_calc,i,ns)+10*uinfdown_500av(ny_calc-1,i,ns)-18*uinfdown_500av(ny_calc-2,i,ns)+6*uinfdown_500av(ny_calc-3,i,ns)-uinfdown_500av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dudy(j,i)=-(25*uinfdown_500av(ny_calc,i,ns)-48*uinfdown_500av(ny_calc-1,i,ns)+36*uinfdown_500av(ny_calc-2,i,ns)-16*uinfdown_500av(ny_calc-3,i,ns)+3*uinfdown_500av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dudy(j,i)=-(uinfdown_500av(j-2,i,ns)-8*uinfdown_500av(j-1,i,ns)+8*uinfdown_500av(j+1,i,ns)-uinfdown_500av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % dv/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dvdy(j,i)=-(-25*vinfdown_500av(1,i,ns)+48*vinfdown_500av(2,i,ns)-36*vinfdown_500av(3,i,ns)+16*vinfdown_500av(4,i,ns)-3*vinfdown_500av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dvdy(j,i)=-(-3*vinfdown_500av(1,i,ns)-10*vinfdown_500av(2,i,ns)+18*vinfdown_500av(3,i,ns)-6*vinfdown_500av(4,i,ns)+vinfdown_500av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dvdy(j,i)=-(3*vinfdown_500av(ny_calc,i,ns)+10*vinfdown_500av(ny_calc-1,i,ns)-18*vinfdown_500av(ny_calc-2,i,ns)+6*vinfdown_500av(ny_calc-3,i,ns)-vinfdown_500av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dvdy(j,i)=-(25*vinfdown_500av(ny_calc,i,ns)-48*vinfdown_500av(ny_calc-1,i,ns)+36*vinfdown_500av(ny_calc-2,i,ns)-16*vinfdown_500av(ny_calc-3,i,ns)+3*vinfdown_500av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dvdy(j,i)=-(vinfdown_500av(j-2,i,ns)-8*vinfdown_500av(j-1,i,ns)+8*vinfdown_500av(j+1,i,ns)-vinfdown_500av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % omega
%             for j=1:ny_calc
%                 for i=1:nx
%                     omega(j,i)=dvdx(j,i)-dudy(j,i);
%                 end
%             end
% 
% % Sij, strain
%             for j=1:ny_calc
%                 for i=1:nx
%                     Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
%                     [V,D]=eig(Sij);
%                     if D(1,1) > D(2,2)
%                         strain_u(j,i)=V(1,1);
%                         strain_v(j,i)=V(2,1);
%                         eig11(j,i)=D(1,1);
%                         eig22(j,i)=D(2,2);
%                     elseif D(1,1) < D(2,2)
%                         strain_u(j,i)=V(1,2);
%                         strain_v(j,i)=V(2,2);
%                         eig11(j,i)=D(2,2);
%                         eig22(j,i)=D(1,1);
%                     end
%                 end
%             end
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
%             load('MyColormap_for_w','mymap')
%             colormap(ax,mymap)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[-4000 0 4000];
%             c.TickLabels={'-4000','0','4000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold on
%             
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_500L_omega_",num2str(ns),'.png')))
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_500L_omega_strain_",num2str(ns),'.png')))
%             close;
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 1000 2000];
%             c.TickLabels={'0','1000','2000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             hold on
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_500L_strain_",num2str(ns),'.png')))
%             close;
% 
% % dissipation rate
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
%                 end
%             end
% 
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 100 200];
%             c.TickLabels={'0','100','200'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_500L_dissipationrate_",num2str(ns),'.png')))
%             close;
% 
% % Kolmogorov Scale
%             eps_av=0;
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps_av=eps_av+eps(j,i)/(ny_calc*nx);
%                 end
%             end
% 
%             eta_infdown_500(ns)=((NYU^3)/eps_av)^0.25
% 
%         end
% 
% %% infup, 500
% 
%         for ns=1:10
% % du/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dudx(j,i)=(-25*uinfup_500av(j,1,ns)+48*uinfup_500av(j,2,ns)-36*uinfup_500av(j,3,ns)+16*uinfup_500av(j,4,ns)-3*uinfup_500av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dudx(j,i)=(-3*uinfup_500av(j,1,ns)-10*uinfup_500av(j,2,ns)+18*uinfup_500av(j,3,ns)-6*uinfup_500av(j,4,ns)+uinfup_500av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dudx(j,i)=(3*uinfup_500av(j,nx,ns)+10*uinfup_500av(j,nx-1,ns)-18*uinfup_500av(j,nx-2,ns)+6*uinfup_500av(j,nx-3,ns)-uinfup_500av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dudx(j,i)=(25*uinfup_500av(j,nx,ns)-48*uinfup_500av(j,nx-1,ns)+36*uinfup_500av(j,nx-2,ns)-16*uinfup_500av(j,nx-3,ns)+3*uinfup_500av(j,nx-4,ns))/(12*dx);
%                     else
%                         dudx(j,i)=(uinfup_500av(j,i-2,ns)-8*uinfup_500av(j,i-1,ns)+8*uinfup_500av(j,i+1,ns)-uinfup_500av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % dv/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dvdx(j,i)=(-25*vinfup_500av(j,1,ns)+48*vinfup_500av(j,2,ns)-36*vinfup_500av(j,3,ns)+16*vinfup_500av(j,4,ns)-3*vinfup_500av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dvdx(j,i)=(-3*vinfup_500av(j,1,ns)-10*vinfup_500av(j,2,ns)+18*vinfup_500av(j,3,ns)-6*vinfup_500av(j,4,ns)+vinfup_500av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dvdx(j,i)=(3*vinfup_500av(j,nx,ns)+10*vinfup_500av(j,nx-1,ns)-18*vinfup_500av(j,nx-2,ns)+6*vinfup_500av(j,nx-3,ns)-vinfup_500av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dvdx(j,i)=(25*vinfup_500av(j,nx,ns)-48*vinfup_500av(j,nx-1,ns)+36*vinfup_500av(j,nx-2,ns)-16*vinfup_500av(j,nx-3,ns)+3*vinfup_500av(j,nx-4,ns))/(12*dx);
%                     else
%                         dvdx(j,i)=(vinfup_500av(j,i-2,ns)-8*vinfup_500av(j,i-1,ns)+8*vinfup_500av(j,i+1,ns)-vinfup_500av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % du/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dudy(j,i)=-(-25*uinfup_500av(1,i,ns)+48*uinfup_500av(2,i,ns)-36*uinfup_500av(3,i,ns)+16*uinfup_500av(4,i,ns)-3*uinfup_500av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dudy(j,i)=-(-3*uinfup_500av(1,i,ns)-10*uinfup_500av(2,i,ns)+18*uinfup_500av(3,i,ns)-6*uinfup_500av(4,i,ns)+uinfup_500av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dudy(j,i)=-(3*uinfup_500av(ny_calc,i,ns)+10*uinfup_500av(ny_calc-1,i,ns)-18*uinfup_500av(ny_calc-2,i,ns)+6*uinfup_500av(ny_calc-3,i,ns)-uinfup_500av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dudy(j,i)=-(25*uinfup_500av(ny_calc,i,ns)-48*uinfup_500av(ny_calc-1,i,ns)+36*uinfup_500av(ny_calc-2,i,ns)-16*uinfup_500av(ny_calc-3,i,ns)+3*uinfup_500av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dudy(j,i)=-(uinfup_500av(j-2,i,ns)-8*uinfup_500av(j-1,i,ns)+8*uinfup_500av(j+1,i,ns)-uinfup_500av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % dv/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dvdy(j,i)=-(-25*vinfup_500av(1,i,ns)+48*vinfup_500av(2,i,ns)-36*vinfup_500av(3,i,ns)+16*vinfup_500av(4,i,ns)-3*vinfup_500av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dvdy(j,i)=-(-3*vinfup_500av(1,i,ns)-10*vinfup_500av(2,i,ns)+18*vinfup_500av(3,i,ns)-6*vinfup_500av(4,i,ns)+vinfup_500av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dvdy(j,i)=-(3*vinfup_500av(ny_calc,i,ns)+10*vinfup_500av(ny_calc-1,i,ns)-18*vinfup_500av(ny_calc-2,i,ns)+6*vinfup_500av(ny_calc-3,i,ns)-vinfup_500av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dvdy(j,i)=-(25*vinfup_500av(ny_calc,i,ns)-48*vinfup_500av(ny_calc-1,i,ns)+36*vinfup_500av(ny_calc-2,i,ns)-16*vinfup_500av(ny_calc-3,i,ns)+3*vinfup_500av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dvdy(j,i)=-(vinfup_500av(j-2,i,ns)-8*vinfup_500av(j-1,i,ns)+8*vinfup_500av(j+1,i,ns)-vinfup_500av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
%  % omega
%             for j=1:ny_calc
%                 for i=1:nx
%                     omega(j,i)=dvdx(j,i)-dudy(j,i);
%                 end
%             end
% 
% % Sij, strain
%             for j=1:ny_calc
%                 for i=1:nx
%                     Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
%                     [V,D]=eig(Sij);
%                     if D(1,1) > D(2,2)
%                         strain_u(j,i)=V(1,1);
%                         strain_v(j,i)=V(2,1);
%                         eig11(j,i)=D(1,1);
%                         eig22(j,i)=D(2,2);
%                     elseif D(1,1) < D(2,2)
%                         strain_u(j,i)=V(1,2);
%                         strain_v(j,i)=V(2,2);
%                         eig11(j,i)=D(2,2);
%                         eig22(j,i)=D(1,1);
%                     end
%                 end
%             end
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
%             load('MyColormap_for_w','mymap')
%             colormap(ax,mymap)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[-4000 0 4000];
%             c.TickLabels={'-4000','0','4000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold on
%             
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_500L_omega_",num2str(ns),'.png')))
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_500L_omega_strain_",num2str(ns),'.png')))
%             close;
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 1000 2000];
%             c.TickLabels={'0','1000','2000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             hold on
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_500L_strain_",num2str(ns),'.png')))
%             close;
% 
% % dissipation rate
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
%                 end
%             end
% 
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 100 200];
%             c.TickLabels={'0','100','200'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_500L_dissipationrate_",num2str(ns),'.png')))
%             close;
% 
% % Kolmogorov Scale
%             eps_av=0;
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps_av=eps_av+eps(j,i)/(ny_calc*nx);
%                 end
%             end
% 
%             eta_infup_500(ns)=((NYU^3)/eps_av)^0.25
% 
%         end
% 
% %% max, 500
% 
%         for ns=1:10
% % du/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dudx(j,i)=(-25*umax_500av(j,1,ns)+48*umax_500av(j,2,ns)-36*umax_500av(j,3,ns)+16*umax_500av(j,4,ns)-3*umax_500av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dudx(j,i)=(-3*umax_500av(j,1,ns)-10*umax_500av(j,2,ns)+18*umax_500av(j,3,ns)-6*umax_500av(j,4,ns)+umax_500av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dudx(j,i)=(3*umax_500av(j,nx,ns)+10*umax_500av(j,nx-1,ns)-18*umax_500av(j,nx-2,ns)+6*umax_500av(j,nx-3,ns)-umax_500av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dudx(j,i)=(25*umax_500av(j,nx,ns)-48*umax_500av(j,nx-1,ns)+36*umax_500av(j,nx-2,ns)-16*umax_500av(j,nx-3,ns)+3*umax_500av(j,nx-4,ns))/(12*dx);
%                     else
%                         dudx(j,i)=(umax_500av(j,i-2,ns)-8*umax_500av(j,i-1,ns)+8*umax_500av(j,i+1,ns)-umax_500av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % dv/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dvdx(j,i)=(-25*vmax_500av(j,1,ns)+48*vmax_500av(j,2,ns)-36*vmax_500av(j,3,ns)+16*vmax_500av(j,4,ns)-3*vmax_500av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dvdx(j,i)=(-3*vmax_500av(j,1,ns)-10*vmax_500av(j,2,ns)+18*vmax_500av(j,3,ns)-6*vmax_500av(j,4,ns)+vmax_500av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dvdx(j,i)=(3*vmax_500av(j,nx,ns)+10*vmax_500av(j,nx-1,ns)-18*vmax_500av(j,nx-2,ns)+6*vmax_500av(j,nx-3,ns)-vmax_500av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dvdx(j,i)=(25*vmax_500av(j,nx,ns)-48*vmax_500av(j,nx-1,ns)+36*vmax_500av(j,nx-2,ns)-16*vmax_500av(j,nx-3,ns)+3*vmax_500av(j,nx-4,ns))/(12*dx);
%                     else
%                         dvdx(j,i)=(vmax_500av(j,i-2,ns)-8*vmax_500av(j,i-1,ns)+8*vmax_500av(j,i+1,ns)-vmax_500av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % du/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dudy(j,i)=-(-25*umax_500av(1,i,ns)+48*umax_500av(2,i,ns)-36*umax_500av(3,i,ns)+16*umax_500av(4,i,ns)-3*umax_500av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dudy(j,i)=-(-3*umax_500av(1,i,ns)-10*umax_500av(2,i,ns)+18*umax_500av(3,i,ns)-6*umax_500av(4,i,ns)+umax_500av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dudy(j,i)=-(3*umax_500av(ny_calc,i,ns)+10*umax_500av(ny_calc-1,i,ns)-18*umax_500av(ny_calc-2,i,ns)+6*umax_500av(ny_calc-3,i,ns)-umax_500av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dudy(j,i)=-(25*umax_500av(ny_calc,i,ns)-48*umax_500av(ny_calc-1,i,ns)+36*umax_500av(ny_calc-2,i,ns)-16*umax_500av(ny_calc-3,i,ns)+3*umax_500av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dudy(j,i)=-(umax_500av(j-2,i,ns)-8*umax_500av(j-1,i,ns)+8*umax_500av(j+1,i,ns)-umax_500av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % dv/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dvdy(j,i)=-(-25*vmax_500av(1,i,ns)+48*vmax_500av(2,i,ns)-36*vmax_500av(3,i,ns)+16*vmax_500av(4,i,ns)-3*vmax_500av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dvdy(j,i)=-(-3*vmax_500av(1,i,ns)-10*vmax_500av(2,i,ns)+18*vmax_500av(3,i,ns)-6*vmax_500av(4,i,ns)+vmax_500av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dvdy(j,i)=-(3*vmax_500av(ny_calc,i,ns)+10*vmax_500av(ny_calc-1,i,ns)-18*vmax_500av(ny_calc-2,i,ns)+6*vmax_500av(ny_calc-3,i,ns)-vmax_500av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dvdy(j,i)=-(25*vmax_500av(ny_calc,i,ns)-48*vmax_500av(ny_calc-1,i,ns)+36*vmax_500av(ny_calc-2,i,ns)-16*vmax_500av(ny_calc-3,i,ns)+3*vmax_500av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dvdy(j,i)=-(vmax_500av(j-2,i,ns)-8*vmax_500av(j-1,i,ns)+8*vmax_500av(j+1,i,ns)-vmax_500av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
%  % omega
%             for j=1:ny_calc
%                 for i=1:nx
%                     omega(j,i)=dvdx(j,i)-dudy(j,i);
%                 end
%             end
% 
% % Sij, strain
%             for j=1:ny_calc
%                 for i=1:nx
%                     Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
%                     [V,D]=eig(Sij);
%                     if D(1,1) > D(2,2)
%                         strain_u(j,i)=V(1,1);
%                         strain_v(j,i)=V(2,1);
%                         eig11(j,i)=D(1,1);
%                         eig22(j,i)=D(2,2);
%                     elseif D(1,1) < D(2,2)
%                         strain_u(j,i)=V(1,2);
%                         strain_v(j,i)=V(2,2);
%                         eig11(j,i)=D(2,2);
%                         eig22(j,i)=D(1,1);
%                     end
%                 end
%             end
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
%             load('MyColormap_for_w','mymap')
%             colormap(ax,mymap)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[-4000 0 4000];
%             c.TickLabels={'-4000','0','4000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold on
%             
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_max_500L_omega_",num2str(ns),'.png')))
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_max_500L_omega_strain_",num2str(ns),'.png')))
%             close;
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 1000 2000];
%             c.TickLabels={'0','1000','2000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             hold on
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_max_500L_strain_",num2str(ns),'.png')))
%             close;
% 
% % dissipation rate
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
%                 end
%             end
% 
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 100 200];
%             c.TickLabels={'0','100','200'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_max_500L_dissipationrate_",num2str(ns),'.png')))
%             close;
% 
% % Kolmogorov Scale
%             eps_av=0;
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps_av=eps_av+eps(j,i)/(ny_calc*nx);
%                 end
%             end
% 
%             eta_max_500(ns)=((NYU^3)/eps_av)^0.25
% 
%         end
% 
% %% min, 500
% 
%         for ns=1:10
% % du/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dudx(j,i)=(-25*umin_500av(j,1,ns)+48*umin_500av(j,2,ns)-36*umin_500av(j,3,ns)+16*umin_500av(j,4,ns)-3*umin_500av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dudx(j,i)=(-3*umin_500av(j,1,ns)-10*umin_500av(j,2,ns)+18*umin_500av(j,3,ns)-6*umin_500av(j,4,ns)+umin_500av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dudx(j,i)=(3*umin_500av(j,nx,ns)+10*umin_500av(j,nx-1,ns)-18*umin_500av(j,nx-2,ns)+6*umin_500av(j,nx-3,ns)-umin_500av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dudx(j,i)=(25*umin_500av(j,nx,ns)-48*umin_500av(j,nx-1,ns)+36*umin_500av(j,nx-2,ns)-16*umin_500av(j,nx-3,ns)+3*umin_500av(j,nx-4,ns))/(12*dx);
%                     else
%                         dudx(j,i)=(umin_500av(j,i-2,ns)-8*umin_500av(j,i-1,ns)+8*umin_500av(j,i+1,ns)-umin_500av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % dv/dx
%             for j=1:ny_calc
%                 for i=1:nx
%                     if i==1
%                         dvdx(j,i)=(-25*vmin_500av(j,1,ns)+48*vmin_500av(j,2,ns)-36*vmin_500av(j,3,ns)+16*vmin_500av(j,4,ns)-3*vmin_500av(j,5,ns))/(12*dx);
%                     elseif i==2
%                         dvdx(j,i)=(-3*vmin_500av(j,1,ns)-10*vmin_500av(j,2,ns)+18*vmin_500av(j,3,ns)-6*vmin_500av(j,4,ns)+vmin_500av(j,5,ns))/(12*dx);
%                     elseif i==nx-1
%                         dvdx(j,i)=(3*vmin_500av(j,nx,ns)+10*vmin_500av(j,nx-1,ns)-18*vmin_500av(j,nx-2,ns)+6*vmin_500av(j,nx-3,ns)-vmin_500av(j,nx-4,ns))/(12*dx);
%                     elseif i==nx
%                         dvdx(j,i)=(25*vmin_500av(j,nx,ns)-48*vmin_500av(j,nx-1,ns)+36*vmin_500av(j,nx-2,ns)-16*vmin_500av(j,nx-3,ns)+3*vmin_500av(j,nx-4,ns))/(12*dx);
%                     else
%                         dvdx(j,i)=(vmin_500av(j,i-2,ns)-8*vmin_500av(j,i-1,ns)+8*vmin_500av(j,i+1,ns)-vmin_500av(j,i+2,ns))/(12*dx);
%                     end
%                 end
%             end
% 
% % du/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dudy(j,i)=-(-25*umin_500av(1,i,ns)+48*umin_500av(2,i,ns)-36*umin_500av(3,i,ns)+16*umin_500av(4,i,ns)-3*umin_500av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dudy(j,i)=-(-3*umin_500av(1,i,ns)-10*umin_500av(2,i,ns)+18*umin_500av(3,i,ns)-6*umin_500av(4,i,ns)+umin_500av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dudy(j,i)=-(3*umin_500av(ny_calc,i,ns)+10*umin_500av(ny_calc-1,i,ns)-18*umin_500av(ny_calc-2,i,ns)+6*umin_500av(ny_calc-3,i,ns)-umin_500av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dudy(j,i)=-(25*umin_500av(ny_calc,i,ns)-48*umin_500av(ny_calc-1,i,ns)+36*umin_500av(ny_calc-2,i,ns)-16*umin_500av(ny_calc-3,i,ns)+3*umin_500av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dudy(j,i)=-(umin_500av(j-2,i,ns)-8*umin_500av(j-1,i,ns)+8*umin_500av(j+1,i,ns)-umin_500av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
% % dv/dy
%             for i=1:nx
%                 for j=1:ny_calc
%                     if j==1
%                         dvdy(j,i)=-(-25*vmin_500av(1,i,ns)+48*vmin_500av(2,i,ns)-36*vmin_500av(3,i,ns)+16*vmin_500av(4,i,ns)-3*vmin_500av(5,i,ns))/(12*dy);
%                     elseif j==2
%                         dvdy(j,i)=-(-3*vmin_500av(1,i,ns)-10*vmin_500av(2,i,ns)+18*vmin_500av(3,i,ns)-6*vmin_500av(4,i,ns)+vmin_500av(5,i,ns))/(12*dy);
%                     elseif j==ny_calc-1
%                         dvdy(j,i)=-(3*vmin_500av(ny_calc,i,ns)+10*vmin_500av(ny_calc-1,i,ns)-18*vmin_500av(ny_calc-2,i,ns)+6*vmin_500av(ny_calc-3,i,ns)-vmin_500av(ny_calc-4,i,ns))/(12*dy);
%                     elseif j==ny_calc
%                         dvdy(j,i)=-(25*vmin_500av(ny_calc,i,ns)-48*vmin_500av(ny_calc-1,i,ns)+36*vmin_500av(ny_calc-2,i,ns)-16*vmin_500av(ny_calc-3,i,ns)+3*vmin_500av(ny_calc-4,i,ns))/(12*dy);
%                     else
%                         dvdy(j,i)=-(vmin_500av(j-2,i,ns)-8*vmin_500av(j-1,i,ns)+8*vmin_500av(j+1,i,ns)-vmin_500av(j+2,i,ns))/(12*dy);
%                     end
%                 end
%             end
% 
%  % omega
%             for j=1:ny_calc
%                 for i=1:nx
%                     omega(j,i)=dvdx(j,i)-dudy(j,i);
%                 end
%             end
% 
% % Sij, strain
%             for j=1:ny_calc
%                 for i=1:nx
%                     Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
%                     [V,D]=eig(Sij);
%                     if D(1,1) > D(2,2)
%                         strain_u(j,i)=V(1,1);
%                         strain_v(j,i)=V(2,1);
%                         eig11(j,i)=D(1,1);
%                         eig22(j,i)=D(2,2);
%                     elseif D(1,1) < D(2,2)
%                         strain_u(j,i)=V(1,2);
%                         strain_v(j,i)=V(2,2);
%                         eig11(j,i)=D(2,2);
%                         eig22(j,i)=D(1,1);
%                     end
%                 end
%             end
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
%             load('MyColormap_for_w','mymap')
%             colormap(ax,mymap)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[-4000 0 4000];
%             c.TickLabels={'-4000','0','4000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold on
%             
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_min_500L_omega_",num2str(ns),'.png')))
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_min_500L_omega_strain_",num2str(ns),'.png')))
%             close;
% %
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             for j=1:floor(nx/nincrement)
%                 for i=1:floor(ny_calc/nincrement)
%                     uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                     vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
%                 end
%             end
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 1000 2000];
%             c.TickLabels={'0','1000','2000'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             hold on
% 
%             ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
%             hold on
%             ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
%             xlim([-60 60])
%             ylim([ymin ymax])
%             hold off
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_min_500L_strain_",num2str(ns),'.png')))
%             close;
% 
% % dissipation rate
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
%                 end
%             end
% 
%             fig=figure;
%             fig.Color='white';
%             fig.Position=[1 1 800*(1+sqrt(5))/2 800];
% 
%             ax=gca;
%             IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
%             colormap(ax,jet)
%             xtickformat('%.2f')
%             xticks([-60 -40 -20 0 20 40 60])
%             set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
% 
%             ytickformat('%.2f')
%             yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%             set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
% 
%             c=colorbar;
%             c.Ticks=[0 100 200];
%             c.TickLabels={'0','100','200'};
%             c.TickLabelInterpreter='latex';
%             c.Label.FontSize = 25;
%             c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
%             c.Location = 'eastoutside';
%             c.AxisLocation='out';
% 
%             xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%             ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%             set(gca,'FontName','Times New Roman','FontSize',25)
%             xlim([-60 60])
%             ylim([ymin ymax])
% 
%             saveas(gcf,strcat(savedirectory,strcat("phasemean_min_500L_dissipationrate_",num2str(ns),'.png')))
%             close;
% 
% % Kolmogorov Scale
%             eps_av=0;
%             for j=1:ny_calc
%                 for i=1:nx
%                     eps_av=eps_av+eps(j,i)/(ny_calc*nx);
%                 end
%             end
% 
%             eta_min_500(ns)=((NYU^3)/eps_av)^0.25
% 
%         end
