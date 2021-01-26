    clc
    clear all
    close all

%% Parameters 1

     n400 = 6;
     n450 = 17;
     n500 = 9;

    savedirectory='E:/chem_output/chem_phasemean_trans_calc/figure/';

%% Parameters 2

    nx = 1024; % [px]
    ny = 1024; % [px]
    origin_x = 500; % [px]
    origin_y = 640; % [px]
    origin_height = 46; %[mm]
    img_res_x = 120*10^(-3); % [mm/px]
    img_res_y = 120*10^(-3); % [mm/px]
    col_max=3000;
    vis='hot';
    col_max_dif=500;

%% Matrix

    Pixels=nx*ny;
    origin_height_px=origin_height/img_res_y; %[px]
    xmin=-origin_x*img_res_x; %[mm]
    ymax=origin_height+origin_y*img_res_y; %[mm]
    wx=zeros(2,1);
    wy=zeros(2,1);
    N=[ny nx];
    scrsz=get(groot,'ScreenSize');

%% Decide Axes

     for i=1:2*origin_x+1
         x(i,:)= xmin+img_res_x*(i-1);
     end

     for i=1:origin_y+origin_height_px+1
         y(i,:)=ymax-img_res_y*(i-1);
     end

     y=sort(y);
     xmax=max(x);
     ymin=min(y);

     wx(1,1)=xmin;
     wx(2,1)=xmax;
     wy(1,1)=ymin;
     wy(2,1)=ymax;

%% READ and AVERAGE, MAX
% 400, max
     max_400av=0;
     for i=1:1:n400
         formatspec = 'phasemean_max_400_%d.dat';
         fid = fopen(sprintf(formatspec,i),'r');
         for   j=1:1:10
                I = fread(fid,Pixels,'double');
                u(:,:,j)=reshape(I,N);
         end
         fclose(fid);

        max_400av = max_400av + u/n400;
     end

% 450, max
     max_450av=0;
     for i=1:1:n450
         formatspec = 'phasemean_max_450_%d.dat';
         fid = fopen(sprintf(formatspec,i),'r');
         for   j=1:1:10
                I = fread(fid,Pixels,'double');
                u(:,:,j)=reshape(I,N);
         end
         fclose(fid);

        max_450av = max_450av + u/n450;
     end

% 500, max
     max_500av=0;
     for i=1:1:n500
         formatspec = 'phasemean_max_500_%d.dat';
         fid = fopen(sprintf(formatspec,i),'r');
         for   j=1:1:10
                I = fread(fid,Pixels,'double');
                u(:,:,j)=reshape(I,N);
         end
         fclose(fid);

        max_500av = max_500av + u/n500;
     end

%% READ and AVERAGE, infdown
% 400, infdown
     infdown_400av=0;
     for i=1:1:n400
         formatspec = 'phasemean_infdown_400_%d.dat';
         fid = fopen(sprintf(formatspec,i),'r');
         for   j=1:1:10
                I = fread(fid,Pixels,'double');
                u(:,:,j)=reshape(I,N);
         end
         fclose(fid);

        infdown_400av = infdown_400av + u/n400;
     end

% 450, infdown
     infdown_450av=0;
     for i=1:1:n450
         formatspec = 'phasemean_infdown_450_%d.dat';
         fid = fopen(sprintf(formatspec,i),'r');
         for   j=1:1:10
                I = fread(fid,Pixels,'double');
                u(:,:,j)=reshape(I,N);
         end
         fclose(fid);

        infdown_450av = infdown_450av + u/n450;
     end

% 500, infdown
     infdown_500av=0;
     for i=1:1:n500
         formatspec = 'phasemean_infdown_500_%d.dat';
         fid = fopen(sprintf(formatspec,i),'r');
         for   j=1:1:10
                I = fread(fid,Pixels,'double');
                u(:,:,j)=reshape(I,N);
         end
         fclose(fid);

        infdown_500av = infdown_500av + u/n500;
     end

%% READ and AVERAGE, min
% 400, min
     min_400av=0;
     for i=1:1:n400
         formatspec = 'phasemean_min_400_%d.dat';
         fid = fopen(sprintf(formatspec,i),'r');
         for   j=1:1:10
                I = fread(fid,Pixels,'double');
                u(:,:,j)=reshape(I,N);
         end
         fclose(fid);

        min_400av = min_400av + u/n400;
     end

% 450, min
     min_450av=0;
     for i=1:1:n450
         formatspec = 'phasemean_min_450_%d.dat';
         fid = fopen(sprintf(formatspec,i),'r');
         for   j=1:1:10
                I = fread(fid,Pixels,'double');
                u(:,:,j)=reshape(I,N);
         end
         fclose(fid);

        min_450av = min_450av + u/n450;
     end

% 500, min
     min_500av=0;
     for i=1:1:n500
         formatspec = 'phasemean_min_500_%d.dat';
         fid = fopen(sprintf(formatspec,i),'r');
         for   j=1:1:10
                I = fread(fid,Pixels,'double');
                u(:,:,j)=reshape(I,N);
         end
         fclose(fid);

        min_500av = min_500av + u/n500;
     end

%% READ and AVERAGE, infup
% 400, infup
     infup_400av=0;
     for i=1:1:n400
         formatspec = 'phasemean_infup_400_%d.dat';
         fid = fopen(sprintf(formatspec,i),'r');
         for   j=1:1:10
                I = fread(fid,Pixels,'double');
                u(:,:,j)=reshape(I,N);
         end
         fclose(fid);

        infup_400av = infup_400av + u/n400;
     end

% 450, infup
     infup_450av=0;
     for i=1:1:n450
         formatspec = 'phasemean_infup_450_%d.dat';
         fid = fopen(sprintf(formatspec,i),'r');
         for   j=1:1:10
                I = fread(fid,Pixels,'double');
                u(:,:,j)=reshape(I,N);
         end
         fclose(fid);

        infup_450av = infup_450av + u/n450;
     end

% 500, infup
     infup_500av=0;
     for i=1:1:n500
         formatspec = 'phasemean_infup_500_%d.dat';
         fid = fopen(sprintf(formatspec,i),'r');
         for   j=1:1:10
                I = fread(fid,Pixels,'double');
                u(:,:,j)=reshape(I,N);
         end
         fclose(fid);

        infup_500av = infup_500av + u/n500;
     end

 %% Make Figure, MAX, 400

      for ns=1:10

        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

       ax=gca;
       image_vis = max_400av(1:origin_height_px+origin_y,1:2*origin_x,ns);
       IMAGE = imagesc(wx,wy,image_vis(:,:),[0 col_max]);
       colormap(ax,vis)
       xtickformat('%.2f')
       xticks([-60 -40 -20 0 20 40 60])
       set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

       ytickformat('%.2f')
       yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
       set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

       c=colorbar;
       c.Ticks=[0 1000 2000 3000];
       c.TickLabels={'0','1000','2000','3000'};
       c.TickLabelInterpreter='latex';
       c.Label.FontSize = 25;
       c.Label.String = '\it \fontname{Times New Roman}';
       c.Location = 'eastoutside';
       c.AxisLocation='out';

       xlabel('\it \fontname{Times New Roman} x \rm[mm]')
       ylabel('\it \fontname{Times New Roman} y \rm[mm]')
       set(gca,'FontName','Times New Roman','FontSize',25)
       hold on

       xlim([-60 60])
       ylim([ymin ymax])
       hold off

       pbaspect([1 1 1])

       saveas(gcf,strcat(savedirectory,strcat("phasemean_max_400L_",num2str(ns),'.png')))
       close;

      end

 %% Make Figure, MAX, 450

      for ns=1:10

        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

       ax=gca;
       image_vis = max_450av(1:origin_height_px+origin_y,1:2*origin_x,ns);
       IMAGE = imagesc(wx,wy,image_vis(:,:),[0 col_max]);
       colormap(ax,vis)
       xtickformat('%.2f')
       xticks([-60 -40 -20 0 20 40 60])
       set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

       ytickformat('%.2f')
       yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
       set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

       c=colorbar;
       c.Ticks=[0 1000 2000 3000];
       c.TickLabels={'0','1000','2000','3000'};
       c.TickLabelInterpreter='latex';
       c.Label.FontSize = 25;
       c.Label.String = '\it \fontname{Times New Roman}';
       c.Location = 'eastoutside';
       c.AxisLocation='out';

       xlabel('\it \fontname{Times New Roman} x \rm[mm]')
       ylabel('\it \fontname{Times New Roman} y \rm[mm]')
       set(gca,'FontName','Times New Roman','FontSize',25)
       hold on

       xlim([-60 60])
       ylim([ymin ymax])
       hold off

       pbaspect([1 1 1])

       saveas(gcf,strcat(savedirectory,strcat("phasemean_max_450L_",num2str(ns),'.png')))
       close;

      end

 %% Make Figure, MAX, 500

      for ns=1:10

        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

       ax=gca;
       image_vis = max_500av(1:origin_height_px+origin_y,1:2*origin_x,ns);
       IMAGE = imagesc(wx,wy,image_vis(:,:),[0 col_max]);
       colormap(ax,vis)
       xtickformat('%.2f')
       xticks([-60 -40 -20 0 20 40 60])
       set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

       ytickformat('%.2f')
       yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
       set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

       c=colorbar;
       c.Ticks=[0 1000 2000 3000];
       c.TickLabels={'0','1000','2000','3000'};
       c.TickLabelInterpreter='latex';
       c.Label.FontSize = 25;
       c.Label.String = '\it \fontname{Times New Roman}';
       c.Location = 'eastoutside';
       c.AxisLocation='out';

       xlabel('\it \fontname{Times New Roman} x \rm[mm]')
       ylabel('\it \fontname{Times New Roman} y \rm[mm]')
       set(gca,'FontName','Times New Roman','FontSize',25)
       hold on

       xlim([-60 60])
       ylim([ymin ymax])
       hold off

       pbaspect([1 1 1])

       saveas(gcf,strcat(savedirectory,strcat("phasemean_max_500L_",num2str(ns),'.png')))
       close;

      end

%% Make Figure, MIN, 400

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = min_400av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[0 col_max]);
      colormap(ax,vis)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[0 1000 2000 3000];
      c.TickLabels={'0','1000','2000','3000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_min_400L_",num2str(ns),'.png')))
      close;

     end

%% Make Figure, MIN, 450

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = min_450av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[0 col_max]);
      colormap(ax,vis)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[0 1000 2000 3000];
      c.TickLabels={'0','1000','2000','3000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_min_450L_",num2str(ns),'.png')))
      close;

     end

%% Make Figure, MIN, 500

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = min_500av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[0 col_max]);
      colormap(ax,vis)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[0 1000 2000 3000];
      c.TickLabels={'0','1000','2000','3000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_min_500L_",num2str(ns),'.png')))
      close;

     end

%% Make Figure, infdown, 400

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = infdown_400av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[0 col_max]);
      colormap(ax,vis)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[0 1000 2000 3000];
      c.TickLabels={'0','1000','2000','3000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_400L_",num2str(ns),'.png')))
      close;

     end

%% Make Figure, infdown, 450

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = infdown_450av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[0 col_max]);
      colormap(ax,vis)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[0 1000 2000 3000];
      c.TickLabels={'0','1000','2000','3000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_450L_",num2str(ns),'.png')))
      close;

     end

%% Make Figure, infdown, 500

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = infdown_500av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[0 col_max]);
      colormap(ax,vis)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[0 1000 2000 3000];
      c.TickLabels={'0','1000','2000','3000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_500L_",num2str(ns),'.png')))
      close;

     end

%% Make Figure, infup, 400

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = infup_400av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[0 col_max]);
      colormap(ax,vis)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[0 1000 2000 3000];
      c.TickLabels={'0','1000','2000','3000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_400L_",num2str(ns),'.png')))
      close;

     end

%% Make Figure, infup, 450

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = infup_450av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[0 col_max]);
      colormap(ax,vis)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[0 1000 2000 3000];
      c.TickLabels={'0','1000','2000','3000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_450L_",num2str(ns),'.png')))
      close;

     end

%% Make Figure, infup, 500

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = infup_500av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[0 col_max]);
      colormap(ax,vis)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[0 1000 2000 3000];
      c.TickLabels={'0','1000','2000','3000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_500L_",num2str(ns),'.png')))
      close;

     end

 %% Make Figure, MAX, 400 - 450

      for ns=1:10

        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

       ax=gca;
       image_vis = max_400av(1:origin_height_px+origin_y,1:2*origin_x,ns) - max_450av(1:origin_height_px+origin_y,1:2*origin_x,ns);
       IMAGE = imagesc(wx,wy,image_vis(:,:),[-col_max_dif col_max_dif]);
       load('MyColormap_for_w','mymap')
       colormap(ax,mymap)
       xtickformat('%.2f')
       xticks([-60 -40 -20 0 20 40 60])
       set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

       ytickformat('%.2f')
       yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
       set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

       c=colorbar;
       c.Ticks=[-1000 -500 0 500 1000];
       c.TickLabels={'-1000','-500','0','500','1000'};
       c.TickLabelInterpreter='latex';
       c.Label.FontSize = 25;
       c.Label.String = '\it \fontname{Times New Roman}';
       c.Location = 'eastoutside';
       c.AxisLocation='out';

       xlabel('\it \fontname{Times New Roman} x \rm[mm]')
       ylabel('\it \fontname{Times New Roman} y \rm[mm]')
       set(gca,'FontName','Times New Roman','FontSize',25)
       hold on

       xlim([-60 60])
       ylim([ymin ymax])
       hold off

       pbaspect([1 1 1])

       saveas(gcf,strcat(savedirectory,strcat("phasemean_max_400L-450L_",num2str(ns),'.png')))
       close;

      end

 %% Make Figure, MAX, 400 - 500

      for ns=1:10

        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

       ax=gca;
       image_vis = max_400av(1:origin_height_px+origin_y,1:2*origin_x,ns) - max_500av(1:origin_height_px+origin_y,1:2*origin_x,ns);
       IMAGE = imagesc(wx,wy,image_vis(:,:),[-col_max_dif col_max_dif]);
       load('MyColormap_for_w','mymap')
       colormap(ax,mymap)
       xtickformat('%.2f')
       xticks([-60 -40 -20 0 20 40 60])
       set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

       ytickformat('%.2f')
       yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
       set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

       c=colorbar;
       c.Ticks=[-1000 -500 0 500 1000];
       c.TickLabels={'-1000','-500','0','500','1000'};
       c.TickLabelInterpreter='latex';
       c.Label.FontSize = 25;
       c.Label.String = '\it \fontname{Times New Roman}';
       c.Location = 'eastoutside';
       c.AxisLocation='out';

       xlabel('\it \fontname{Times New Roman} x \rm[mm]')
       ylabel('\it \fontname{Times New Roman} y \rm[mm]')
       set(gca,'FontName','Times New Roman','FontSize',25)
       hold on

       xlim([-60 60])
       ylim([ymin ymax])
       hold off

       pbaspect([1 1 1])

       saveas(gcf,strcat(savedirectory,strcat("phasemean_max_400L-500L_",num2str(ns),'.png')))
       close;

      end

%% Make Figure, MIN, 400 - 450

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = min_400av(1:origin_height_px+origin_y,1:2*origin_x,ns) - min_450av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[-col_max_dif col_max_dif]);
      load('MyColormap_for_w','mymap')
      colormap(ax,mymap)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[-1000 -500 0 500 1000];
      c.TickLabels={'-1000','-500','0','500','1000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_min_400L-450L_",num2str(ns),'.png')))
      close;

     end

%% Make Figure, MIN, 400 - 500

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = min_400av(1:origin_height_px+origin_y,1:2*origin_x,ns) - min_500av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[-col_max_dif col_max_dif]);
      load('MyColormap_for_w','mymap')
      colormap(ax,mymap)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[-1000 -500 0 500 1000];
      c.TickLabels={'-1000','-500','0','500','1000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_min_400L-500L_",num2str(ns),'.png')))
      close;

     end

%% Make Figure, infdown, 400 - 450

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = infdown_400av(1:origin_height_px+origin_y,1:2*origin_x,ns) - infdown_450av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[-col_max_dif col_max_dif]);
      load('MyColormap_for_w','mymap')
      colormap(ax,mymap)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[-1000 -500 0 500 1000];
      c.TickLabels={'-1000','-500','0','500','1000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_400L-450L_",num2str(ns),'.png')))
      close;

     end

%% Make Figure, infdown, 400 - 500

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = infdown_400av(1:origin_height_px+origin_y,1:2*origin_x,ns) - infdown_500av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[-col_max_dif col_max_dif]);
      load('MyColormap_for_w','mymap')
      colormap(ax,mymap)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[-1000 -500 0 500 1000];
      c.TickLabels={'-1000','-500','0','500','1000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_infdown_400L-500L_",num2str(ns),'.png')))
      close;

     end

%% Make Figure, infup, 400 - 450

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = infup_400av(1:origin_height_px+origin_y,1:2*origin_x,ns) - infup_450av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[-col_max_dif col_max_dif]);
      load('MyColormap_for_w','mymap')
      colormap(ax,mymap)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[-1000 -500 0 500 1000];
      c.TickLabels={'-1000','-500','0','500','1000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_400L-450L_",num2str(ns),'.png')))
      close;

     end

%% Make Figure, infup, 400 - 500

     for ns=1:10

       fig=figure;
       fig.Color='white';
       fig.Position=[1 1 800 800];

      ax=gca;
      image_vis = infup_400av(1:origin_height_px+origin_y,1:2*origin_x,ns) - infup_500av(1:origin_height_px+origin_y,1:2*origin_x,ns);
      IMAGE = imagesc(wx,wy,image_vis(:,:),[-col_max_dif col_max_dif]);
      load('MyColormap_for_w','mymap')
      colormap(ax,mymap)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
      set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

      c=colorbar;
      c.Ticks=[-1000 -500 0 500 1000];
      c.TickLabels={'-1000','-500','0','500','1000'};
      c.TickLabelInterpreter='latex';
      c.Label.FontSize = 25;
      c.Label.String = '\it \fontname{Times New Roman}';
      c.Location = 'eastoutside';
      c.AxisLocation='out';

      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
      set(gca,'FontName','Times New Roman','FontSize',25)
      hold on

      xlim([-60 60])
      ylim([ymin ymax])
      hold off

      pbaspect([1 1 1])

      saveas(gcf,strcat(savedirectory,strcat("phasemean_infup_400L-500L_",num2str(ns),'.png')))
      close;

     end
