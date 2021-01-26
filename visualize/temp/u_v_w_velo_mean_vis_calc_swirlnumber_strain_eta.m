    clear all
    close all
    clc

%% PARAMETERS

     n400=6;
     n450=12;
     n500=6;
     n400_cold=1;
     n450_cold=3;
     n500_cold=3;
     nincrement=4;

     savedirectory='C:/Users/atagi/Desktop/modified/velomeanfield_calc/figure/';
     filename_zones = strcat(savedirectory,'omega_zones.dat');

%% PARAMETERS 2

     nx = 191;
     ny_calc = 98;
     vec_spc_x = 8;
     vec_spc_y = 8;
     img_res_x = 80*10^(-3);
     img_res_y = 75*10^(-3);
     din = 7.5e-3; % [m]
     dout = 15e-3; % [m]
     NYU= 1.333e-5; % [m^2/s]

%% MATRIX

     Pixels=nx*ny_calc;
     X=img_res_x*vec_spc_x;
     Y=img_res_y*vec_spc_y;
     dx=img_res_x*vec_spc_x*10^-3;
     dy=img_res_y*vec_spc_y*10^-3;
     xmin=-(0.5*(nx-1))*X+X;
     xmax=0.5*(nx-1)*X+X;
     ymin=Y*19; % ATTENTION, CUT
     ymax=Y*116; % ATTENTION, CUT
     wx=zeros(2,1);
     wy=zeros(2,1);
     velo=zeros(ny_calc,nx);
     omega=zeros(ny_calc,nx);
     zones=zeros(ny_calc,nx);
     zones1=zeros(ny_calc,nx);
     zones2=zeros(ny_calc,nx);
     zones3=zeros(ny_calc,nx);
     zones4=ones(ny_calc,nx);
     dudx=zeros(ny_calc,nx);
     dvdx=zeros(ny_calc,nx);
     dudy=zeros(ny_calc,nx);
     dvdy=zeros(ny_calc,nx);
     dzndx=zeros(ny_calc,nx);
     strain_u=zeros(ny_calc,nx);
     strain_v=zeros(ny_calc,nx);
     eig11=zeros(ny_calc,nx);
     eig22=zeros(ny_calc,nx);
     eps=zeros(ny_calc,nx);
     N=[ny_calc nx];
     scrsz=get(groot,'ScreenSize');

%% Decide Axes

     for i=1:floor(nx/nincrement)
         x(i,:)= xmin+X*nincrement*(i-1)+X;
     end

     for i=1:floor(ny_calc/nincrement)
         y(i,:)=ymax-Y*nincrement*(i-1);
     end

     y=sort(y);

     for i=1:floor(nx)
         xstream(i,:)= xmin+X*(i-1)+X;
     end

     for i=1:floor(ny_calc)
         ystream(i,:)=ymax-Y*(i-1);
     end

     ystream=sort(ystream);

     [sx,sy]=meshgrid(xstream,ystream);

     wx(1,1)=xmin;
     wx(2,1)=xmax;
     wy(1,1)=ymin;
     wy(2,1)=ymax;

%% READ and AVERAGE

% 400, u, before, mean
     u_b_400av=0;
     for i=1:1:n400
        formatspec = '400_bmean_u_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        u_b_400av = u_b_400av + velo/n400;
     end

% 400, v, before, mean
     v_b_400av=0;
     for i=1:1:n400
        formatspec = '400_bmean_v_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        v_b_400av = v_b_400av + velo/n400;
     end

% 400, w, before, mean
     w_b_400av=0;
     for i=1:1:n400
        formatspec = '400_bmean_w_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        w_b_400av = w_b_400av + velo/n400;
     end

% 450, u, before, mean
     u_b_450av=0;
     for i=1:1:n450
        formatspec = '450_bmean_u_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        u_b_450av = u_b_450av + velo/n450;
     end

% 450, v, before, mean
     v_b_450av=0;
     for i=1:1:n450
        formatspec = '450_bmean_v_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        v_b_450av = v_b_450av + velo/n450;
     end

% 450, w, before, mean
     w_b_450av=0;
     for i=1:1:n450
        formatspec = '450_bmean_w_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        w_b_450av = w_b_450av + velo/n450;
     end

% 500, u, before, mean
     u_b_500av=0;
     for i=1:1:n500
        formatspec = '500_bmean_u_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        u_b_500av = u_b_500av + velo/n500;
     end

% 500, v, before, mean
     v_b_500av=0;
     for i=1:1:n500
        formatspec = '500_bmean_v_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        v_b_500av = v_b_500av + velo/n500;
     end

% 500, w, before, mean
     w_b_500av=0;
     for i=1:1:n500
        formatspec = '500_bmean_w_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        w_b_500av = w_b_500av + velo/n500;
     end

% cold flow
% 400, u, cold, mean
     u_cold_400av=0;
     for i=1:1:n400_cold
        formatspec = '400_cold_mean_u_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        u_cold_400av = u_cold_400av + velo/n400_cold;
     end

% 400, v, cold, mean
     v_cold_400av=0;
     for i=1:1:n400_cold
        formatspec = '400_cold_mean_v_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        v_cold_400av = v_cold_400av + velo/n400_cold;
     end

% 400, w, cold, mean
     w_cold_400av=0;
     for i=1:1:n400_cold
        formatspec = '400_cold_mean_w_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        w_cold_400av = w_cold_400av + velo/n400_cold;
     end

% 450, u, cold, mean
     u_cold_450av=0;
     for i=1:1:n450_cold
        formatspec = '450_cold_mean_u_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        u_cold_450av = u_cold_450av + velo/n450_cold;
     end

% 450, v, cold, mean
     v_cold_450av=0;
     for i=1:1:n450_cold
        formatspec = '450_cold_mean_v_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        v_cold_450av = v_cold_450av + velo/n450_cold;
     end

% 450, w, cold, mean
     w_cold_450av=0;
     for i=1:1:n450_cold
        formatspec = '450_cold_mean_w_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        w_cold_450av = w_cold_450av + velo/n450_cold;
     end

% 500, u, cold, mean
     u_cold_500av=0;
     for i=1:1:n500_cold
        formatspec = '500_cold_mean_u_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        u_cold_500av = u_cold_500av + velo/n500_cold;
     end

% 500, v, cold, mean
     v_cold_500av=0;
     for i=1:1:n500_cold
        formatspec = '500_cold_mean_v_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        v_cold_500av = v_cold_500av + velo/n500_cold;
     end

% 500, w, cold, mean
     w_cold_500av=0;
     for i=1:1:n500_cold
        formatspec = '500_cold_mean_w_%d.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        I = fread(fid,Pixels,'double');
        velo=reshape(I,N);
        velo=permute(reshape(velo,N),[2 1]);
        fclose(fid);

        w_cold_500av = w_cold_500av + velo/n500_cold;
     end

     u_b_400av = fliplr(rot90(u_b_400av,3));
     v_b_400av = fliplr(rot90(v_b_400av,3));
     w_b_400av = fliplr(rot90(w_b_400av,3));
     u_b_450av = fliplr(rot90(u_b_450av,3));
     v_b_450av = fliplr(rot90(v_b_450av,3));
     w_b_450av = fliplr(rot90(w_b_450av,3));
     u_b_500av = fliplr(rot90(u_b_500av,3));
     v_b_500av = fliplr(rot90(v_b_500av,3));
     w_b_500av = fliplr(rot90(w_b_500av,3));
     u_cold_400av = fliplr(rot90(u_cold_400av,3));
     v_cold_400av = fliplr(rot90(v_cold_400av,3));
     w_cold_400av = fliplr(rot90(w_cold_400av,3));
     u_cold_450av = fliplr(rot90(u_cold_450av,3));
     v_cold_450av = fliplr(rot90(v_cold_450av,3));
     w_cold_450av = fliplr(rot90(w_cold_450av,3));
     u_cold_500av = fliplr(rot90(u_cold_500av,3));
     v_cold_500av = fliplr(rot90(v_cold_500av,3));
     w_cold_500av = fliplr(rot90(w_cold_500av,3));

%% MAKE FIGURE, ncquiverref2
%
% %400, before, mean
%      fig=figure;
%      fig.Color='white';
%      fig.Position=[1 1 800*(1+sqrt(5))/2 800];
%
%      for j=1:floor(nx/nincrement)
%            for i=1:floor(ny_calc/nincrement)
%               uplot(i,j)= u_b_400av(nincrement*(i-1)+1,nincrement*(j-1)+1);
%               vplot(i,j)= v_b_400av(nincrement*(i-1)+1,nincrement*(j-1)+1);
%            end
%      end
%
%      ax=gca;
%      IMAGE = imagesc(wx,wy,w_b_400av(:,:),[-10 10]);
%      load('MyColormap_for_w','mymap')
%      colormap(ax,mymap)
%      xtickformat('%.2f')
%      xticks([-60 -40 -20 0 20 40 60])
%      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
%
%      ytickformat('%.2f')
%      yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%      set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
%
%      c=colorbar;
%      c.Ticks=[-10 -5  0 5 10];
%      c.TickLabels={'-10','-5.0','0.0','5.0','10'};
%      c.TickLabelInterpreter='latex';
%      c.Label.FontSize = 25;
%      c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
%      c.Location = 'eastoutside';
%      c.AxisLocation='out';
%
%      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%      set(gca,'FontName','Times New Roman','FontSize',25)
%      hold on
%
%      ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
%      xlim([-60 60])
%      ylim([ymin ymax])
%      hold off
%
%      saveas(gcf,strcat(savedirectory,'400_before_osc_mean1.png'))
%      close;
%
% %450, before, mean
%      fig=figure;
%      fig.Color='white';
%      fig.Position=[1 1 800*(1+sqrt(5))/2 800];
%
%      for j=1:floor(nx/nincrement)
%            for i=1:floor(ny_calc/nincrement)
%               uplot(i,j)= u_b_450av(nincrement*(i-1)+1,nincrement*(j-1)+1);
%               vplot(i,j)= v_b_450av(nincrement*(i-1)+1,nincrement*(j-1)+1);
%            end
%      end
%
%      ax=gca;
%      IMAGE = imagesc(wx,wy,w_b_450av(:,:),[-10 10]);
%      load('MyColormap_for_w','mymap')
%      colormap(ax,mymap)
%      xtickformat('%.2f')
%      xticks([-60 -40 -20 0 20 40 60])
%      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
%
%      ytickformat('%.2f')
%      yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%      set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
%
%      c=colorbar;
%      c.Ticks=[-10 -5  0 5 10];
%      c.TickLabels={'-10','-5.0','0.0','5.0','10'};
%      c.TickLabelInterpreter='latex';
%      c.Label.FontSize = 25;
%      c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
%      c.Location = 'eastoutside';
%      c.AxisLocation='out';
%
%      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%      set(gca,'FontName','Times New Roman','FontSize',25)
%      hold on
%
%      ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
%      xlim([-60 60])
%      ylim([ymin ymax])
%      hold off
%
%      saveas(gcf,strcat(savedirectory,'450_before_osc_mean1.png'))
%      close;
%
%  %500, before, mean
%      fig=figure;
%      fig.Color='white';
%      fig.Position=[1 1 800*(1+sqrt(5))/2 800];
%
%      for j=1:floor(nx/nincrement)
%            for i=1:floor(ny_calc/nincrement)
%               uplot(i,j)= u_b_500av(nincrement*(i-1)+1,nincrement*(j-1)+1);
%               vplot(i,j)= v_b_500av(nincrement*(i-1)+1,nincrement*(j-1)+1);
%            end
%      end
%
%      ax=gca;
%      IMAGE = imagesc(wx,wy,w_b_500av(:,:),[-10 10]);
%      load('MyColormap_for_w','mymap')
%      colormap(ax,mymap)
%      xtickformat('%.2f')
%      xticks([-60 -40 -20 0 20 40 60])
%      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
%
%      ytickformat('%.2f')
%      yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%      set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
%
%      c=colorbar;
%      c.Ticks=[-10 -5  0 5 10];
%      c.TickLabels={'-10','-5.0','0.0','5.0','10'};
%      c.TickLabelInterpreter='latex';
%      c.Label.FontSize = 25;
%      c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
%      c.Location = 'eastoutside';
%      c.AxisLocation='out';
%
%      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%      set(gca,'FontName','Times New Roman','FontSize',25)
%      hold on
%
%      ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
%      xlim([-60 60])
%      ylim([ymin ymax])
%      hold off
%
%      saveas(gcf,strcat(savedirectory,'500_before_osc_mean.png'))
%      close;
%
% %400, cold, mean
%      fig=figure;
%      fig.Color='white';
%      fig.Position=[1 1 800*(1+sqrt(5))/2 800];
%
%      for j=1:floor(nx/nincrement)
%            for i=1:floor(ny_calc/nincrement)
%               uplot(i,j)= u_cold_400av(nincrement*(i-1)+1,nincrement*(j-1)+1);
%               vplot(i,j)= v_cold_400av(nincrement*(i-1)+1,nincrement*(j-1)+1);
%            end
%      end
%
%      ax=gca;
%      IMAGE = imagesc(wx,wy,w_cold_400av(:,:),[-10 10]);
%      load('MyColormap_for_w','mymap')
%      colormap(ax,mymap)
%      xtickformat('%.2f')
%      xticks([-60 -40 -20 0 20 40 60])
%      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
%
%      ytickformat('%.2f')
%      yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%      set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
%
%      c=colorbar;
%      c.Ticks=[-10 -5  0 5 10];
%      c.TickLabels={'-10','-5.0','0.0','5.0','10'};
%      c.TickLabelInterpreter='latex';
%      c.Label.FontSize = 25;
%      c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
%      c.Location = 'eastoutside';
%      c.AxisLocation='out';
%
%      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%      set(gca,'FontName','Times New Roman','FontSize',25)
%      hold on
%
%      ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
%      xlim([-60 60])
%      ylim([ymin ymax])
%      hold off
%
%      saveas(gcf,strcat(savedirectory,'400_cold_mean1.png'))
%      close;
%
% %450, cold, mean
%      fig=figure;
%      fig.Color='white';
%      fig.Position=[1 1 800*(1+sqrt(5))/2 800];
%
%      for j=1:floor(nx/nincrement)
%            for i=1:floor(ny_calc/nincrement)
%               uplot(i,j)= u_cold_450av(nincrement*(i-1)+1,nincrement*(j-1)+1);
%               vplot(i,j)= v_cold_450av(nincrement*(i-1)+1,nincrement*(j-1)+1);
%            end
%      end
%
%      ax=gca;
%      IMAGE = imagesc(wx,wy,w_cold_450av(:,:),[-10 10]);
%      load('MyColormap_for_w','mymap')
%      colormap(ax,mymap)
%      xtickformat('%.2f')
%      xticks([-60 -40 -20 0 20 40 60])
%      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
%
%      ytickformat('%.2f')
%      yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%      set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
%
%      c=colorbar;
%      c.Ticks=[-10 -5  0 5 10];
%      c.TickLabels={'-10','-5.0','0.0','5.0','10'};
%      c.TickLabelInterpreter='latex';
%      c.Label.FontSize = 25;
%      c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
%      c.Location = 'eastoutside';
%      c.AxisLocation='out';
%
%      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%      set(gca,'FontName','Times New Roman','FontSize',25)
%      hold on
%
%      ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
%      xlim([-60 60])
%      ylim([ymin ymax])
%      hold off
%
%      saveas(gcf,strcat(savedirectory,'450_cold_mean1.png'))
%      close;
%
%  %500, cold, mean
%      fig=figure;
%      fig.Color='white';
%      fig.Position=[1 1 800*(1+sqrt(5))/2 800];
%
%      for j=1:floor(nx/nincrement)
%            for i=1:floor(ny_calc/nincrement)
%               uplot(i,j)= u_cold_500av(nincrement*(i-1)+1,nincrement*(j-1)+1);
%               vplot(i,j)= v_cold_500av(nincrement*(i-1)+1,nincrement*(j-1)+1);
%            end
%      end
%
%      ax=gca;
%      IMAGE = imagesc(wx,wy,w_cold_500av(:,:),[-10 10]);
%      load('MyColormap_for_w','mymap')
%      colormap(ax,mymap)
%      xtickformat('%.2f')
%      xticks([-60 -40 -20 0 20 40 60])
%      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
%
%      ytickformat('%.2f')
%      yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%      set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
%
%      c=colorbar;
%      c.Ticks=[-10 -5  0 5 10];
%      c.TickLabels={'-10','-5.0','0.0','5.0','10'};
%      c.TickLabelInterpreter='latex';
%      c.Label.FontSize = 25;
%      c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
%      c.Location = 'eastoutside';
%      c.AxisLocation='out';
%
%      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%      set(gca,'FontName','Times New Roman','FontSize',25)
%      hold on
%
%      ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
%      xlim([-60 60])
%      ylim([ymin ymax])
%      hold off
%
%      saveas(gcf,strcat(savedirectory,'500_cold_mean1.png'))
%      close;
%
%% MAKE FIGURE, streamline
%
% %400, before, mean
%      fig=figure;
%      fig.Color='white';
%      fig.Position=[1 1 800*(1+sqrt(5))/2 800];
%
%      ax=gca;
%      speed = sqrt(u_b_400av.^2+v_b_400av.^2+w_b_400av.^2);
%      IMAGE = imagesc(wx,wy,speed(:,:),[0 20]);
%      colormap(ax,jet)
%      xtickformat('%.2f')
%      xticks([-60 -40 -20 0 20 40 60])
%      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
%
%      ytickformat('%.2f')
%      yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%      set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
%
%      c=colorbar;
%      c.Ticks=[0 5 10 15 20];
%      c.TickLabels={'0.0','5.0','10','15','20'};
%      c.TickLabelInterpreter='latex';
%      c.Label.FontSize = 25;
%      c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
%      c.Location = 'eastoutside';
%      c.AxisLocation='out';
%
%      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%      set(gca,'FontName','Times New Roman','FontSize',25)
%      hold on
%
%      hlines=streamslice(sx,sy,u_b_400av,-v_b_400av,3,'arrows');
%      set(hlines,'Color','w','LineWidth',1.5)
%
%      xlim([-60 60])
%      ylim([ymin ymax])
%      hold off
%
%      saveas(gcf,strcat(savedirectory,'400_before_osc_mean2.png'))
%      close;
%
%  %450, before, mean
%      fig=figure;
%      fig.Color='white';
%      fig.Position=[1 1 800*(1+sqrt(5))/2 800];
%
%      ax=gca;
%      speed = sqrt(u_b_450av.^2+v_b_450av.^2+w_b_450av.^2);
%      IMAGE = imagesc(wx,wy,speed(:,:),[0 20]);
%      colormap(ax,jet)
%      xtickformat('%.2f')
%      xticks([-60 -40 -20 0 20 40 60])
%      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
%
%      ytickformat('%.2f')
%      yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%      set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
%
%      c=colorbar;
%      c.Ticks=[0 5 10 15 20];
%      c.TickLabels={'0.0','5.0','10','15','20'};
%      c.TickLabelInterpreter='latex';
%      c.Label.FontSize = 25;
%      c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
%      c.Location = 'eastoutside';
%      c.AxisLocation='out';
%
%      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%      set(gca,'FontName','Times New Roman','FontSize',25)
%      hold on
%
%      hlines=streamslice(sx,sy,u_b_450av,-v_b_450av,3,'arrows');
%      set(hlines,'Color','w','LineWidth',1.5)
%
%      xlim([-60 60])
%      ylim([ymin ymax])
%      hold off
%
%      saveas(gcf,strcat(savedirectory,'450_before_osc_mean2.png'))
%      close;
%
%  %500, before, mean
%      fig=figure;
%      fig.Color='white';
%      fig.Position=[1 1 800*(1+sqrt(5))/2 800];
%
%      ax=gca;
%      speed = sqrt(u_b_500av.^2+v_b_500av.^2+w_b_500av.^2);
%      IMAGE = imagesc(wx,wy,speed(:,:),[0 20]);
%      colormap(ax,jet)
%      xtickformat('%.2f')
%      xticks([-60 -40 -20 0 20 40 60])
%      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
%
%      ytickformat('%.2f')
%      yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%      set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
%
%      c=colorbar;
%      c.Ticks=[0 5 10 15 20];
%      c.TickLabels={'0.0','5.0','10','15','20'};
%      c.TickLabelInterpreter='latex';
%      c.Label.FontSize = 25;
%      c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
%      c.Location = 'eastoutside';
%      c.AxisLocation='out';
%
%      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%      set(gca,'FontName','Times New Roman','FontSize',25)
%      hold on
%
%      hlines=streamslice(sx,sy,u_b_500av,-v_b_500av,3,'arrows');
%      set(hlines,'Color','w','LineWidth',1.5)
%
%      xlim([-60 60])
%      ylim([ymin ymax])
%      hold off
%
%      saveas(gcf,strcat(savedirectory,'500_before_osc_mean2.png'))
%      close;
%
%  %400, cold, mean
%      fig=figure;
%      fig.Color='white';
%      fig.Position=[1 1 800*(1+sqrt(5))/2 800];
%
%      ax=gca;
%      speed = sqrt(u_cold_400av.^2+v_cold_400av.^2+w_cold_400av.^2);
%      IMAGE = imagesc(wx,wy,speed(:,:),[0 20]);
%      colormap(ax,jet)
%      xtickformat('%.2f')
%      xticks([-60 -40 -20 0 20 40 60])
%      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
%
%      ytickformat('%.2f')
%      yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%      set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
%
%      c=colorbar;
%      c.Ticks=[0 5 10 15 20];
%      c.TickLabels={'0.0','5.0','10','15','20'};
%      c.TickLabelInterpreter='latex';
%      c.Label.FontSize = 25;
%      c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
%      c.Location = 'eastoutside';
%      c.AxisLocation='out';
%
%      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%      set(gca,'FontName','Times New Roman','FontSize',25)
%      hold on
%
%      hlines=streamslice(sx,sy,u_cold_400av,-v_cold_400av,3,'arrows');
%      set(hlines,'Color','w','LineWidth',1.5)
%
%      xlim([-60 60])
%      ylim([ymin ymax])
%      hold off
%
%      saveas(gcf,strcat(savedirectory,'400_cold_mean2.png'))
%      close;
%
%  %450, cold, mean
%      fig=figure;
%      fig.Color='white';
%      fig.Position=[1 1 800*(1+sqrt(5))/2 800];
%
%      ax=gca;
%      speed = sqrt(u_cold_450av.^2+v_cold_450av.^2+w_cold_450av.^2);
%      IMAGE = imagesc(wx,wy,speed(:,:),[0 20]);
%      colormap(ax,jet)
%      xtickformat('%.2f')
%      xticks([-60 -40 -20 0 20 40 60])
%      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
%
%      ytickformat('%.2f')
%      yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%      set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
%
%      c=colorbar;
%      c.Ticks=[0 5 10 15 20];
%      c.TickLabels={'0.0','5.0','10','15','20'};
%      c.TickLabelInterpreter='latex';
%      c.Label.FontSize = 25;
%      c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
%      c.Location = 'eastoutside';
%      c.AxisLocation='out';
%
%      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%      set(gca,'FontName','Times New Roman','FontSize',25)
%      hold on
%
%      hlines=streamslice(sx,sy,u_cold_450av,-v_cold_450av,3,'arrows');
%      set(hlines,'Color','w','LineWidth',1.5)
%
%      xlim([-60 60])
%      ylim([ymin ymax])
%      hold off
%
%      saveas(gcf,strcat(savedirectory,'450_cold_mean2.png'))
%      close;
%
%  %500, cold, mean
%      fig=figure;
%      fig.Color='white';
%      fig.Position=[1 1 800*(1+sqrt(5))/2 800];
%
%      ax=gca;
%      speed = sqrt(u_cold_500av.^2+v_cold_500av.^2+w_cold_500av.^2);
%      IMAGE = imagesc(wx,wy,speed(:,:),[0 20]);
%      colormap(ax,jet)
%      xtickformat('%.2f')
%      xticks([-60 -40 -20 0 20 40 60])
%      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
%
%      ytickformat('%.2f')
%      yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
%      set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
%
%      c=colorbar;
%      c.Ticks=[0 5 10 15 20];
%      c.TickLabels={'0.0','5.0','10','15','20'};
%      c.TickLabelInterpreter='latex';
%      c.Label.FontSize = 25;
%      c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
%      c.Location = 'eastoutside';
%      c.AxisLocation='out';
%
%      xlabel('\it \fontname{Times New Roman} x \rm[mm]')
%      ylabel('\it \fontname{Times New Roman} y \rm[mm]')
%      set(gca,'FontName','Times New Roman','FontSize',25)
%      hold on
%
%      hlines=streamslice(sx,sy,u_cold_500av,-v_cold_500av,3,'arrows');
%      set(hlines,'Color','w','LineWidth',1.5)
%
%      xlim([-60 60])
%      ylim([ymin ymax])
%      hold off
%
%      saveas(gcf,strcat(savedirectory,'500_cold_mean2.png'))
%      close;
%
%% Calc, Swirl Number

%400, before, mean
     numeratorleft=0;
     denominatorleft=0;
     numeratorright=0;
     denominatorright=0;

     for k=1:1:13
         numeratorleft = numeratorleft + abs(v_b_400av(ny_calc,69+k))*abs(w_b_400av(ny_calc,69+k))*((din+(i-1)*dx)^2)*dx;
         denominatorleft = denominatorleft + (dout-din)*(v_b_400av(ny_calc,69+k)^2)*(din+(i-1)*dx)*dx;
         numeratorright = numeratorright + abs(v_b_400av(ny_calc,107+k))*abs(w_b_400av(ny_calc,107+k))*((din+(i-1)*dx)^2)*dx;
         denominatorright = denominatorright + (dout-din)*(v_b_400av(ny_calc,107+k)^2)*(din+(i-1)*dx)*dx;
     end

     S_400_comb=0.5*(numeratorleft/denominatorleft + numeratorright/denominatorright)

%450, before, mean
     numeratorleft=0;
     denominatorleft=0;
     numeratorright=0;
     denominatorright=0;

     for k=1:1:13
         numeratorleft = numeratorleft + abs(v_b_450av(ny_calc,69+k))*abs(w_b_450av(ny_calc,69+k))*((din+(i-1)*dx)^2)*dx;
         denominatorleft = denominatorleft + (dout-din)*(v_b_450av(ny_calc,69+k)^2)*(din+(i-1)*dx)*dx;
         numeratorright = numeratorright + abs(v_b_450av(ny_calc,107+k))*abs(w_b_450av(ny_calc,107+k))*((din+(i-1)*dx)^2)*dx;
         denominatorright = denominatorright + (dout-din)*(v_b_450av(ny_calc,107+k)^2)*(din+(i-1)*dx)*dx;
     end

     S_450_comb=0.5*(numeratorleft/denominatorleft + numeratorright/denominatorright)

%500, before, mean
     numeratorleft=0;
     denominatorleft=0;
     numeratorright=0;
     denominatorright=0;

     for k=1:1:13
         numeratorleft = numeratorleft + abs(v_b_500av(ny_calc,69+k))*abs(w_b_500av(ny_calc,69+k))*((din+(i-1)*dx)^2)*dx;
         denominatorleft = denominatorleft + (dout-din)*(v_b_500av(ny_calc,69+k)^2)*(din+(i-1)*dx)*dx;
         numeratorright = numeratorright + abs(v_b_500av(ny_calc,107+k))*abs(w_b_500av(ny_calc,107+k))*((din+(i-1)*dx)^2)*dx;
         denominatorright = denominatorright + (dout-din)*(v_b_500av(ny_calc,107+k)^2)*(din+(i-1)*dx)*dx;
     end

     S_500_comb=0.5*(numeratorleft/denominatorleft + numeratorright/denominatorright)

%400, cold, mean
     numeratorleft=0;
     denominatorleft=0;
     numeratorright=0;
     denominatorright=0;

     for k=1:1:13
         numeratorleft = numeratorleft + abs(v_cold_400av(ny_calc,74+k))*abs(w_cold_400av(ny_calc,74+k))*((din+(i-1)*dx)^2)*dx;
         denominatorleft = denominatorleft + (dout-din)*(v_cold_400av(ny_calc,74+k)^2)*(din+(i-1)*dx)*dx;
         numeratorright = numeratorright + abs(v_cold_400av(ny_calc,100+k))*abs(w_cold_400av(ny_calc,100+k))*((din+(i-1)*dx)^2)*dx;
         denominatorright = denominatorright + (dout-din)*(v_cold_400av(ny_calc,100+k)^2)*(din+(i-1)*dx)*dx;
     end

     S_400_cold=0.5*(numeratorleft/denominatorleft + numeratorright/denominatorright)

%450, before, mean
     numeratorleft=0;
     denominatorleft=0;
     numeratorright=0;
     denominatorright=0;

     for k=1:1:13
         numeratorleft = numeratorleft + abs(v_cold_450av(ny_calc,74+k))*abs(w_cold_450av(ny_calc,74+k))*((din+(i-1)*dx)^2)*dx;
         denominatorleft = denominatorleft + (dout-din)*(v_cold_450av(ny_calc,74+k)^2)*(din+(i-1)*dx)*dx;
         numeratorright = numeratorright + abs(v_cold_450av(ny_calc,100+k))*abs(w_cold_450av(ny_calc,100+k))*((din+(i-1)*dx)^2)*dx;
         denominatorright = denominatorright + (dout-din)*(v_cold_450av(ny_calc,100+k)^2)*(din+(i-1)*dx)*dx;
     end

     S_450_cold=0.5*(numeratorleft/denominatorleft + numeratorright/denominatorright)

%500, before, mean
     numeratorleft=0;
     denominatorleft=0;
     numeratorright=0;
     denominatorright=0;

     for k=1:1:13
         numeratorleft = numeratorleft + abs(v_cold_500av(ny_calc,74+k))*abs(w_cold_500av(ny_calc,74+k))*((din+(i-1)*dx)^2)*dx;
         denominatorleft = denominatorleft + (dout-din)*(v_cold_500av(ny_calc,74+k)^2)*(din+(i-1)*dx)*dx;
         numeratorright = numeratorright + abs(v_cold_500av(ny_calc,100+k))*abs(w_cold_500av(ny_calc,100+k))*((din+(i-1)*dx)^2)*dx;
         denominatorright = denominatorright + (dout-din)*(v_cold_500av(ny_calc,100+k)^2)*(din+(i-1)*dx)*dx;
     end

     S_500_cold=0.5*(numeratorleft/denominatorleft + numeratorright/denominatorright)

%% CALC, Strain, Kolmogorov Scale

%% cold, 400
% du/dx
            for j=1:ny_calc
                for i=1:nx
                    if i==1
                        dudx(j,i)=(-25*u_cold_400av(j,1)+48*u_cold_400av(j,2)-36*u_cold_400av(j,3)+16*u_cold_400av(j,4)-3*u_cold_400av(j,5))/(12*dx);
                    elseif i==2
                        dudx(j,i)=(-3*u_cold_400av(j,1)-10*u_cold_400av(j,2)+18*u_cold_400av(j,3)-6*u_cold_400av(j,4)+u_cold_400av(j,5))/(12*dx);
                    elseif i==nx-1
                        dudx(j,i)=(3*u_cold_400av(j,nx)+10*u_cold_400av(j,nx-1)-18*u_cold_400av(j,nx-2)+6*u_cold_400av(j,nx-3)-u_cold_400av(j,nx-4))/(12*dx);
                    elseif i==nx
                        dudx(j,i)=(25*u_cold_400av(j,nx)-48*u_cold_400av(j,nx-1)+36*u_cold_400av(j,nx-2)-16*u_cold_400av(j,nx-3)+3*u_cold_400av(j,nx-4))/(12*dx);
                    else
                        dudx(j,i)=(u_cold_400av(j,i-2)-8*u_cold_400av(j,i-1)+8*u_cold_400av(j,i+1)-u_cold_400av(j,i+2))/(12*dx);
                    end
                end
            end

% dv/dx
            for j=1:ny_calc
                for i=1:nx
                    if i==1
                        dvdx(j,i)=(-25*v_cold_400av(j,1)+48*v_cold_400av(j,2)-36*v_cold_400av(j,3)+16*v_cold_400av(j,4)-3*v_cold_400av(j,5))/(12*dx);
                    elseif i==2
                        dvdx(j,i)=(-3*v_cold_400av(j,1)-10*v_cold_400av(j,2)+18*v_cold_400av(j,3)-6*v_cold_400av(j,4)+v_cold_400av(j,5))/(12*dx);
                    elseif i==nx-1
                        dvdx(j,i)=(3*v_cold_400av(j,nx)+10*v_cold_400av(j,nx-1)-18*v_cold_400av(j,nx-2)+6*v_cold_400av(j,nx-3)-v_cold_400av(j,nx-4))/(12*dx);
                    elseif i==nx
                        dvdx(j,i)=(25*v_cold_400av(j,nx)-48*v_cold_400av(j,nx-1)+36*v_cold_400av(j,nx-2)-16*v_cold_400av(j,nx-3)+3*v_cold_400av(j,nx-4))/(12*dx);
                    else
                        dvdx(j,i)=(v_cold_400av(j,i-2)-8*v_cold_400av(j,i-1)+8*v_cold_400av(j,i+1)-v_cold_400av(j,i+2))/(12*dx);
                    end
                end
            end

% du/dy
            for i=1:nx
                for j=1:ny_calc
                    if j==1
                        dudy(j,i)=-(-25*u_cold_400av(1,i)+48*u_cold_400av(2,i)-36*u_cold_400av(3,i)+16*u_cold_400av(4,i)-3*u_cold_400av(5,i))/(12*dy);
                    elseif j==2
                        dudy(j,i)=-(-3*u_cold_400av(1,i)-10*u_cold_400av(2,i)+18*u_cold_400av(3,i)-6*u_cold_400av(4,i)+u_cold_400av(5,i))/(12*dy);
                    elseif j==ny_calc-1
                        dudy(j,i)=-(3*u_cold_400av(ny_calc,i)+10*u_cold_400av(ny_calc-1,i)-18*u_cold_400av(ny_calc-2,i)+6*u_cold_400av(ny_calc-3,i)-u_cold_400av(ny_calc-4,i))/(12*dy);
                    elseif j==ny_calc
                        dudy(j,i)=-(25*u_cold_400av(ny_calc,i)-48*u_cold_400av(ny_calc-1,i)+36*u_cold_400av(ny_calc-2,i)-16*u_cold_400av(ny_calc-3,i)+3*u_cold_400av(ny_calc-4,i))/(12*dy);
                    else
                        dudy(j,i)=-(u_cold_400av(j-2,i)-8*u_cold_400av(j-1,i)+8*u_cold_400av(j+1,i)-u_cold_400av(j+2,i))/(12*dy);
                    end
                end
            end

% dv/dy
            for i=1:nx
                for j=1:ny_calc
                    if j==1
                        dvdy(j,i)=-(-25*v_cold_400av(1,i)+48*v_cold_400av(2,i)-36*v_cold_400av(3,i)+16*v_cold_400av(4,i)-3*v_cold_400av(5,i))/(12*dy);
                    elseif j==2
                        dvdy(j,i)=-(-3*v_cold_400av(1,i)-10*v_cold_400av(2,i)+18*v_cold_400av(3,i)-6*v_cold_400av(4,i)+v_cold_400av(5,i))/(12*dy);
                    elseif j==ny_calc-1
                        dvdy(j,i)=-(3*v_cold_400av(ny_calc,i)+10*v_cold_400av(ny_calc-1,i)-18*v_cold_400av(ny_calc-2,i)+6*v_cold_400av(ny_calc-3,i)-v_cold_400av(ny_calc-4,i))/(12*dy);
                    elseif j==ny_calc
                        dvdy(j,i)=-(25*v_cold_400av(ny_calc,i)-48*v_cold_400av(ny_calc-1,i)+36*v_cold_400av(ny_calc-2,i)-16*v_cold_400av(ny_calc-3,i)+3*v_cold_400av(ny_calc-4,i))/(12*dy);
                    else
                        dvdy(j,i)=-(v_cold_400av(j-2,i)-8*v_cold_400av(j-1,i)+8*v_cold_400av(j+1,i)-v_cold_400av(j+2,i))/(12*dy);
                    end
                end
            end

% omega
           for j=1:ny_calc
               for i=1:nx
                   omega(j,i)=dvdx(j,i)-dudy(j,i);
               end
           end

           omega_cold_400=omega;

% Sij, strain
            for j=1:ny_calc
                for i=1:nx
                    Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
                    [V,D]=eig(Sij);
                    if D(1,1) > D(2,2)
                        strain_u(j,i)=V(1,1);
                        strain_v(j,i)=V(2,1);
                        eig11(j,i)=D(1,1);
                        eig22(j,i)=D(2,2);
                    elseif D(1,1) < D(2,2)
                        strain_u(j,i)=V(1,2);
                        strain_v(j,i)=V(2,2);
                        eig11(j,i)=D(2,2);
                        eig22(j,i)=D(1,1);
                    end
                end
            end
%
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            for j=1:floor(nx/nincrement)
                for i=1:floor(ny_calc/nincrement)
                    uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                    vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                end
            end

            ax=gca;
            IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
            load('MyColormap_for_w','mymap')
            colormap(ax,mymap)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[-4000 0 4000];
            c.TickLabels={'-4000','0','4000'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            hold on

            ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
            hold on
            ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
            xlim([-60 60])
            ylim([ymin ymax])
            hold off

            saveas(gcf,strcat(savedirectory,strcat("400_cold_omega_strain",'.png')))
            close;
%
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            for j=1:floor(nx/nincrement)
                for i=1:floor(ny_calc/nincrement)
                    uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                    vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                end
            end

            ax=gca;
            IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
            colormap(ax,jet)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[0 1000 2000];
            c.TickLabels={'0','1000','2000'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            hold on

            ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
            hold on
            ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
            xlim([-60 60])
            ylim([ymin ymax])
            hold off

            saveas(gcf,strcat(savedirectory,strcat("400_cold_strain",'.png')))
            close;

% dissipation rate
            for j=1:ny_calc
                for i=1:nx
                    eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
                end
            end

            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            ax=gca;
            IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
            colormap(ax,jet)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[0 100 200];
            c.TickLabels={'0','100','200'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            xlim([-60 60])
            ylim([ymin ymax])

            saveas(gcf,strcat(savedirectory,strcat("400_cold_dissipationrate",'.png')))
            close;

% Kolmogorov Scale
            eps_av=0;
            for j=1:ny_calc
                for i=1:nx
                    eps_av=eps_av+eps(j,i)/(ny_calc*nx);
                end
            end

            eta_cold_400=((NYU^3)/eps_av)^0.25

%% cold, 450
% du/dx
            for j=1:ny_calc
                for i=1:nx
                    if i==1
                        dudx(j,i)=(-25*u_cold_450av(j,1)+48*u_cold_450av(j,2)-36*u_cold_450av(j,3)+16*u_cold_450av(j,4)-3*u_cold_450av(j,5))/(12*dx);
                    elseif i==2
                        dudx(j,i)=(-3*u_cold_450av(j,1)-10*u_cold_450av(j,2)+18*u_cold_450av(j,3)-6*u_cold_450av(j,4)+u_cold_450av(j,5))/(12*dx);
                    elseif i==nx-1
                        dudx(j,i)=(3*u_cold_450av(j,nx)+10*u_cold_450av(j,nx-1)-18*u_cold_450av(j,nx-2)+6*u_cold_450av(j,nx-3)-u_cold_450av(j,nx-4))/(12*dx);
                    elseif i==nx
                        dudx(j,i)=(25*u_cold_450av(j,nx)-48*u_cold_450av(j,nx-1)+36*u_cold_450av(j,nx-2)-16*u_cold_450av(j,nx-3)+3*u_cold_450av(j,nx-4))/(12*dx);
                    else
                        dudx(j,i)=(u_cold_450av(j,i-2)-8*u_cold_450av(j,i-1)+8*u_cold_450av(j,i+1)-u_cold_450av(j,i+2))/(12*dx);
                    end
                end
            end

% dv/dx
            for j=1:ny_calc
                for i=1:nx
                    if i==1
                        dvdx(j,i)=(-25*v_cold_450av(j,1)+48*v_cold_450av(j,2)-36*v_cold_450av(j,3)+16*v_cold_450av(j,4)-3*v_cold_450av(j,5))/(12*dx);
                    elseif i==2
                        dvdx(j,i)=(-3*v_cold_450av(j,1)-10*v_cold_450av(j,2)+18*v_cold_450av(j,3)-6*v_cold_450av(j,4)+v_cold_450av(j,5))/(12*dx);
                    elseif i==nx-1
                        dvdx(j,i)=(3*v_cold_450av(j,nx)+10*v_cold_450av(j,nx-1)-18*v_cold_450av(j,nx-2)+6*v_cold_450av(j,nx-3)-v_cold_450av(j,nx-4))/(12*dx);
                    elseif i==nx
                        dvdx(j,i)=(25*v_cold_450av(j,nx)-48*v_cold_450av(j,nx-1)+36*v_cold_450av(j,nx-2)-16*v_cold_450av(j,nx-3)+3*v_cold_450av(j,nx-4))/(12*dx);
                    else
                        dvdx(j,i)=(v_cold_450av(j,i-2)-8*v_cold_450av(j,i-1)+8*v_cold_450av(j,i+1)-v_cold_450av(j,i+2))/(12*dx);
                    end
                end
            end

% du/dy
            for i=1:nx
                for j=1:ny_calc
                    if j==1
                        dudy(j,i)=-(-25*u_cold_450av(1,i)+48*u_cold_450av(2,i)-36*u_cold_450av(3,i)+16*u_cold_450av(4,i)-3*u_cold_450av(5,i))/(12*dy);
                    elseif j==2
                        dudy(j,i)=-(-3*u_cold_450av(1,i)-10*u_cold_450av(2,i)+18*u_cold_450av(3,i)-6*u_cold_450av(4,i)+u_cold_450av(5,i))/(12*dy);
                    elseif j==ny_calc-1
                        dudy(j,i)=-(3*u_cold_450av(ny_calc,i)+10*u_cold_450av(ny_calc-1,i)-18*u_cold_450av(ny_calc-2,i)+6*u_cold_450av(ny_calc-3,i)-u_cold_450av(ny_calc-4,i))/(12*dy);
                    elseif j==ny_calc
                        dudy(j,i)=-(25*u_cold_450av(ny_calc,i)-48*u_cold_450av(ny_calc-1,i)+36*u_cold_450av(ny_calc-2,i)-16*u_cold_450av(ny_calc-3,i)+3*u_cold_450av(ny_calc-4,i))/(12*dy);
                    else
                        dudy(j,i)=-(u_cold_450av(j-2,i)-8*u_cold_450av(j-1,i)+8*u_cold_450av(j+1,i)-u_cold_450av(j+2,i))/(12*dy);
                    end
                end
            end

% dv/dy
            for i=1:nx
                for j=1:ny_calc
                    if j==1
                        dvdy(j,i)=-(-25*v_cold_450av(1,i)+48*v_cold_450av(2,i)-36*v_cold_450av(3,i)+16*v_cold_450av(4,i)-3*v_cold_450av(5,i))/(12*dy);
                    elseif j==2
                        dvdy(j,i)=-(-3*v_cold_450av(1,i)-10*v_cold_450av(2,i)+18*v_cold_450av(3,i)-6*v_cold_450av(4,i)+v_cold_450av(5,i))/(12*dy);
                    elseif j==ny_calc-1
                        dvdy(j,i)=-(3*v_cold_450av(ny_calc,i)+10*v_cold_450av(ny_calc-1,i)-18*v_cold_450av(ny_calc-2,i)+6*v_cold_450av(ny_calc-3,i)-v_cold_450av(ny_calc-4,i))/(12*dy);
                    elseif j==ny_calc
                        dvdy(j,i)=-(25*v_cold_450av(ny_calc,i)-48*v_cold_450av(ny_calc-1,i)+36*v_cold_450av(ny_calc-2,i)-16*v_cold_450av(ny_calc-3,i)+3*v_cold_450av(ny_calc-4,i))/(12*dy);
                    else
                        dvdy(j,i)=-(v_cold_450av(j-2,i)-8*v_cold_450av(j-1,i)+8*v_cold_450av(j+1,i)-v_cold_450av(j+2,i))/(12*dy);
                    end
                end
            end

% omega
           for j=1:ny_calc
               for i=1:nx
                   omega(j,i)=dvdx(j,i)-dudy(j,i);
               end
           end

           omega_cold_450=omega;

% Sij, strain
            for j=1:ny_calc
                for i=1:nx
                    Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
                    [V,D]=eig(Sij);
                    if D(1,1) > D(2,2)
                        strain_u(j,i)=V(1,1);
                        strain_v(j,i)=V(2,1);
                        eig11(j,i)=D(1,1);
                        eig22(j,i)=D(2,2);
                    elseif D(1,1) < D(2,2)
                        strain_u(j,i)=V(1,2);
                        strain_v(j,i)=V(2,2);
                        eig11(j,i)=D(2,2);
                        eig22(j,i)=D(1,1);
                    end
                end
            end
%
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            for j=1:floor(nx/nincrement)
                for i=1:floor(ny_calc/nincrement)
                    uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                    vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                end
            end

            ax=gca;
            IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
            load('MyColormap_for_w','mymap')
            colormap(ax,mymap)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[-4000 0 4000];
            c.TickLabels={'-4000','0','4000'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            hold on

            ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
            hold on
            ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
            xlim([-60 60])
            xlim([-60 60])
            ylim([ymin ymax])
            hold off

            saveas(gcf,strcat(savedirectory,strcat("450_cold_omega_strain",'.png')))
            close;
%
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            for j=1:floor(nx/nincrement)
                for i=1:floor(ny_calc/nincrement)
                    uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                    vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                end
            end

            ax=gca;
            IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
            colormap(ax,jet)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[0 1000 2000];
            c.TickLabels={'0','1000','2000'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            hold on

            ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
            hold on
            ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
            xlim([-60 60])
            ylim([ymin ymax])
            hold off

            saveas(gcf,strcat(savedirectory,strcat("450_cold_strain",'.png')))
            close;

% dissipation rate
            for j=1:ny_calc
                for i=1:nx
                    eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
                end
            end

            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            ax=gca;
            IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
            colormap(ax,jet)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[0 100 200];
            c.TickLabels={'0','100','200'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            xlim([-60 60])
            ylim([ymin ymax])

            saveas(gcf,strcat(savedirectory,strcat("450_cold_dissipationrate",'.png')))
            close;

% Kolmogorov Scale
            eps_av=0;
            for j=1:ny_calc
                for i=1:nx
                    eps_av=eps_av+eps(j,i)/(ny_calc*nx);
                end
            end

            eta_cold_450=((NYU^3)/eps_av)^0.25

%% cold, 500
% du/dx
            for j=1:ny_calc
                for i=1:nx
                    if i==1
                        dudx(j,i)=(-25*u_cold_500av(j,1)+48*u_cold_500av(j,2)-36*u_cold_500av(j,3)+16*u_cold_500av(j,4)-3*u_cold_500av(j,5))/(12*dx);
                    elseif i==2
                        dudx(j,i)=(-3*u_cold_500av(j,1)-10*u_cold_500av(j,2)+18*u_cold_500av(j,3)-6*u_cold_500av(j,4)+u_cold_500av(j,5))/(12*dx);
                    elseif i==nx-1
                        dudx(j,i)=(3*u_cold_500av(j,nx)+10*u_cold_500av(j,nx-1)-18*u_cold_500av(j,nx-2)+6*u_cold_500av(j,nx-3)-u_cold_500av(j,nx-4))/(12*dx);
                    elseif i==nx
                        dudx(j,i)=(25*u_cold_500av(j,nx)-48*u_cold_500av(j,nx-1)+36*u_cold_500av(j,nx-2)-16*u_cold_500av(j,nx-3)+3*u_cold_500av(j,nx-4))/(12*dx);
                    else
                        dudx(j,i)=(u_cold_500av(j,i-2)-8*u_cold_500av(j,i-1)+8*u_cold_500av(j,i+1)-u_cold_500av(j,i+2))/(12*dx);
                    end
                end
            end

% dv/dx
            for j=1:ny_calc
                for i=1:nx
                    if i==1
                        dvdx(j,i)=(-25*v_cold_500av(j,1)+48*v_cold_500av(j,2)-36*v_cold_500av(j,3)+16*v_cold_500av(j,4)-3*v_cold_500av(j,5))/(12*dx);
                    elseif i==2
                        dvdx(j,i)=(-3*v_cold_500av(j,1)-10*v_cold_500av(j,2)+18*v_cold_500av(j,3)-6*v_cold_500av(j,4)+v_cold_500av(j,5))/(12*dx);
                    elseif i==nx-1
                        dvdx(j,i)=(3*v_cold_500av(j,nx)+10*v_cold_500av(j,nx-1)-18*v_cold_500av(j,nx-2)+6*v_cold_500av(j,nx-3)-v_cold_500av(j,nx-4))/(12*dx);
                    elseif i==nx
                        dvdx(j,i)=(25*v_cold_500av(j,nx)-48*v_cold_500av(j,nx-1)+36*v_cold_500av(j,nx-2)-16*v_cold_500av(j,nx-3)+3*v_cold_500av(j,nx-4))/(12*dx);
                    else
                        dvdx(j,i)=(v_cold_500av(j,i-2)-8*v_cold_500av(j,i-1)+8*v_cold_500av(j,i+1)-v_cold_500av(j,i+2))/(12*dx);
                    end
                end
            end

% du/dy
            for i=1:nx
                for j=1:ny_calc
                    if j==1
                        dudy(j,i)=-(-25*u_cold_500av(1,i)+48*u_cold_500av(2,i)-36*u_cold_500av(3,i)+16*u_cold_500av(4,i)-3*u_cold_500av(5,i))/(12*dy);
                    elseif j==2
                        dudy(j,i)=-(-3*u_cold_500av(1,i)-10*u_cold_500av(2,i)+18*u_cold_500av(3,i)-6*u_cold_500av(4,i)+u_cold_500av(5,i))/(12*dy);
                    elseif j==ny_calc-1
                        dudy(j,i)=-(3*u_cold_500av(ny_calc,i)+10*u_cold_500av(ny_calc-1,i)-18*u_cold_500av(ny_calc-2,i)+6*u_cold_500av(ny_calc-3,i)-u_cold_500av(ny_calc-4,i))/(12*dy);
                    elseif j==ny_calc
                        dudy(j,i)=-(25*u_cold_500av(ny_calc,i)-48*u_cold_500av(ny_calc-1,i)+36*u_cold_500av(ny_calc-2,i)-16*u_cold_500av(ny_calc-3,i)+3*u_cold_500av(ny_calc-4,i))/(12*dy);
                    else
                        dudy(j,i)=-(u_cold_500av(j-2,i)-8*u_cold_500av(j-1,i)+8*u_cold_500av(j+1,i)-u_cold_500av(j+2,i))/(12*dy);
                    end
                end
            end

% dv/dy
            for i=1:nx
                for j=1:ny_calc
                    if j==1
                        dvdy(j,i)=-(-25*v_cold_500av(1,i)+48*v_cold_500av(2,i)-36*v_cold_500av(3,i)+16*v_cold_500av(4,i)-3*v_cold_500av(5,i))/(12*dy);
                    elseif j==2
                        dvdy(j,i)=-(-3*v_cold_500av(1,i)-10*v_cold_500av(2,i)+18*v_cold_500av(3,i)-6*v_cold_500av(4,i)+v_cold_500av(5,i))/(12*dy);
                    elseif j==ny_calc-1
                        dvdy(j,i)=-(3*v_cold_500av(ny_calc,i)+10*v_cold_500av(ny_calc-1,i)-18*v_cold_500av(ny_calc-2,i)+6*v_cold_500av(ny_calc-3,i)-v_cold_500av(ny_calc-4,i))/(12*dy);
                    elseif j==ny_calc
                        dvdy(j,i)=-(25*v_cold_500av(ny_calc,i)-48*v_cold_500av(ny_calc-1,i)+36*v_cold_500av(ny_calc-2,i)-16*v_cold_500av(ny_calc-3,i)+3*v_cold_500av(ny_calc-4,i))/(12*dy);
                    else
                        dvdy(j,i)=-(v_cold_500av(j-2,i)-8*v_cold_500av(j-1,i)+8*v_cold_500av(j+1,i)-v_cold_500av(j+2,i))/(12*dy);
                    end
                end
            end

% omega
           for j=1:ny_calc
               for i=1:nx
                   omega(j,i)=dvdx(j,i)-dudy(j,i);
               end
           end

           omega_cold_500=omega;

% Sij, strain
            for j=1:ny_calc
                for i=1:nx
                    Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
                    [V,D]=eig(Sij);
                    if D(1,1) > D(2,2)
                        strain_u(j,i)=V(1,1);
                        strain_v(j,i)=V(2,1);
                        eig11(j,i)=D(1,1);
                        eig22(j,i)=D(2,2);
                    elseif D(1,1) < D(2,2)
                        strain_u(j,i)=V(1,2);
                        strain_v(j,i)=V(2,2);
                        eig11(j,i)=D(2,2);
                        eig22(j,i)=D(1,1);
                    end
                end
            end
%
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            for j=1:floor(nx/nincrement)
                for i=1:floor(ny_calc/nincrement)
                    uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                    vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                end
            end

            ax=gca;
            IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
            load('MyColormap_for_w','mymap')
            colormap(ax,mymap)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[-4000 0 4000];
            c.TickLabels={'-4000','0','4000'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            hold on

            ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
            hold on
            ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
            xlim([-60 60])
            xlim([-60 60])
            ylim([ymin ymax])
            hold off

            saveas(gcf,strcat(savedirectory,strcat("500_cold_omega_strain",'.png')))
            close;
%
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            for j=1:floor(nx/nincrement)
                for i=1:floor(ny_calc/nincrement)
                    uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                    vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                end
            end

            ax=gca;
            IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
            colormap(ax,jet)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[0 1000 2000];
            c.TickLabels={'0','1000','2000'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            hold on

            ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
            hold on
            ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
            xlim([-60 60])
            ylim([ymin ymax])
            hold off

            saveas(gcf,strcat(savedirectory,strcat("500_cold_strain",'.png')))
            close;

% dissipation rate
            for j=1:ny_calc
                for i=1:nx
                    eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
                end
            end

            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            ax=gca;
            IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
            colormap(ax,jet)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[0 100 200];
            c.TickLabels={'0','100','200'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            xlim([-60 60])
            ylim([ymin ymax])

            saveas(gcf,strcat(savedirectory,strcat("500_cold_dissipationrate",'.png')))
            close;

% Kolmogorov Scale
            eps_av=0;
            for j=1:ny_calc
                for i=1:nx
                    eps_av=eps_av+eps(j,i)/(ny_calc*nx);
                end
            end

            eta_cold_500=((NYU^3)/eps_av)^0.25

 %% b, 400
% du/dx
            for j=1:ny_calc
                for i=1:nx
                    if i==1
                        dudx(j,i)=(-25*u_b_400av(j,1)+48*u_b_400av(j,2)-36*u_b_400av(j,3)+16*u_b_400av(j,4)-3*u_b_400av(j,5))/(12*dx);
                    elseif i==2
                        dudx(j,i)=(-3*u_b_400av(j,1)-10*u_b_400av(j,2)+18*u_b_400av(j,3)-6*u_b_400av(j,4)+u_b_400av(j,5))/(12*dx);
                    elseif i==nx-1
                        dudx(j,i)=(3*u_b_400av(j,nx)+10*u_b_400av(j,nx-1)-18*u_b_400av(j,nx-2)+6*u_b_400av(j,nx-3)-u_b_400av(j,nx-4))/(12*dx);
                    elseif i==nx
                        dudx(j,i)=(25*u_b_400av(j,nx)-48*u_b_400av(j,nx-1)+36*u_b_400av(j,nx-2)-16*u_b_400av(j,nx-3)+3*u_b_400av(j,nx-4))/(12*dx);
                    else
                        dudx(j,i)=(u_b_400av(j,i-2)-8*u_b_400av(j,i-1)+8*u_b_400av(j,i+1)-u_b_400av(j,i+2))/(12*dx);
                    end
                end
            end

% dv/dx
            for j=1:ny_calc
                for i=1:nx
                    if i==1
                        dvdx(j,i)=(-25*v_b_400av(j,1)+48*v_b_400av(j,2)-36*v_b_400av(j,3)+16*v_b_400av(j,4)-3*v_b_400av(j,5))/(12*dx);
                    elseif i==2
                        dvdx(j,i)=(-3*v_b_400av(j,1)-10*v_b_400av(j,2)+18*v_b_400av(j,3)-6*v_b_400av(j,4)+v_b_400av(j,5))/(12*dx);
                    elseif i==nx-1
                        dvdx(j,i)=(3*v_b_400av(j,nx)+10*v_b_400av(j,nx-1)-18*v_b_400av(j,nx-2)+6*v_b_400av(j,nx-3)-v_b_400av(j,nx-4))/(12*dx);
                    elseif i==nx
                        dvdx(j,i)=(25*v_b_400av(j,nx)-48*v_b_400av(j,nx-1)+36*v_b_400av(j,nx-2)-16*v_b_400av(j,nx-3)+3*v_b_400av(j,nx-4))/(12*dx);
                    else
                        dvdx(j,i)=(v_b_400av(j,i-2)-8*v_b_400av(j,i-1)+8*v_b_400av(j,i+1)-v_b_400av(j,i+2))/(12*dx);
                    end
                end
            end

% du/dy
            for i=1:nx
                for j=1:ny_calc
                    if j==1
                        dudy(j,i)=-(-25*u_b_400av(1,i)+48*u_b_400av(2,i)-36*u_b_400av(3,i)+16*u_b_400av(4,i)-3*u_b_400av(5,i))/(12*dy);
                    elseif j==2
                        dudy(j,i)=-(-3*u_b_400av(1,i)-10*u_b_400av(2,i)+18*u_b_400av(3,i)-6*u_b_400av(4,i)+u_b_400av(5,i))/(12*dy);
                    elseif j==ny_calc-1
                        dudy(j,i)=-(3*u_b_400av(ny_calc,i)+10*u_b_400av(ny_calc-1,i)-18*u_b_400av(ny_calc-2,i)+6*u_b_400av(ny_calc-3,i)-u_b_400av(ny_calc-4,i))/(12*dy);
                    elseif j==ny_calc
                        dudy(j,i)=-(25*u_b_400av(ny_calc,i)-48*u_b_400av(ny_calc-1,i)+36*u_b_400av(ny_calc-2,i)-16*u_b_400av(ny_calc-3,i)+3*u_b_400av(ny_calc-4,i))/(12*dy);
                    else
                        dudy(j,i)=-(u_b_400av(j-2,i)-8*u_b_400av(j-1,i)+8*u_b_400av(j+1,i)-u_b_400av(j+2,i))/(12*dy);
                    end
                end
            end

% dv/dy
            for i=1:nx
                for j=1:ny_calc
                    if j==1
                        dvdy(j,i)=-(-25*v_b_400av(1,i)+48*v_b_400av(2,i)-36*v_b_400av(3,i)+16*v_b_400av(4,i)-3*v_b_400av(5,i))/(12*dy);
                    elseif j==2
                        dvdy(j,i)=-(-3*v_b_400av(1,i)-10*v_b_400av(2,i)+18*v_b_400av(3,i)-6*v_b_400av(4,i)+v_b_400av(5,i))/(12*dy);
                    elseif j==ny_calc-1
                        dvdy(j,i)=-(3*v_b_400av(ny_calc,i)+10*v_b_400av(ny_calc-1,i)-18*v_b_400av(ny_calc-2,i)+6*v_b_400av(ny_calc-3,i)-v_b_400av(ny_calc-4,i))/(12*dy);
                    elseif j==ny_calc
                        dvdy(j,i)=-(25*v_b_400av(ny_calc,i)-48*v_b_400av(ny_calc-1,i)+36*v_b_400av(ny_calc-2,i)-16*v_b_400av(ny_calc-3,i)+3*v_b_400av(ny_calc-4,i))/(12*dy);
                    else
                        dvdy(j,i)=-(v_b_400av(j-2,i)-8*v_b_400av(j-1,i)+8*v_b_400av(j+1,i)-v_b_400av(j+2,i))/(12*dy);
                    end
                end
            end

% omega
           for j=1:ny_calc
               for i=1:nx
                   omega(j,i)=dvdx(j,i)-dudy(j,i);
               end
           end

           omega_b_400=omega;

% Sij, strain
            for j=1:ny_calc
                for i=1:nx
                    Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
                    [V,D]=eig(Sij);
                    if D(1,1) > D(2,2)
                        strain_u(j,i)=V(1,1);
                        strain_v(j,i)=V(2,1);
                        eig11(j,i)=D(1,1);
                        eig22(j,i)=D(2,2);
                    elseif D(1,1) < D(2,2)
                        strain_u(j,i)=V(1,2);
                        strain_v(j,i)=V(2,2);
                        eig11(j,i)=D(2,2);
                        eig22(j,i)=D(1,1);
                    end
                end
            end
%
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            for j=1:floor(nx/nincrement)
                for i=1:floor(ny_calc/nincrement)
                    uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                    vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                end
            end

            ax=gca;
            IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
            load('MyColormap_for_w','mymap')
            colormap(ax,mymap)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[-4000 0 4000];
            c.TickLabels={'-4000','0','4000'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            hold on

            ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
            hold on
            ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
            xlim([-60 60])
            xlim([-60 60])
            ylim([ymin ymax])
            hold off

            saveas(gcf,strcat(savedirectory,strcat("400_before_osc_mean_omega_strain",'.png')))
            close;
%
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            for j=1:floor(nx/nincrement)
                for i=1:floor(ny_calc/nincrement)
                    uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                    vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                end
            end

            ax=gca;
            IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
            colormap(ax,jet)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[0 1000 2000];
            c.TickLabels={'0','1000','2000'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            hold on

            ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
            hold on
            ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
            xlim([-60 60])
            ylim([ymin ymax])
            hold off

            saveas(gcf,strcat(savedirectory,strcat("400_before_osc_mean_strain",'.png')))
            close;

% dissipation rate
            for j=1:ny_calc
                for i=1:nx
                    eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
                end
            end

            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            ax=gca;
            IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
            colormap(ax,jet)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[0 100 200];
            c.TickLabels={'0','100','200'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            xlim([-60 60])
            ylim([ymin ymax])

            saveas(gcf,strcat(savedirectory,strcat("400_before_osc_mean_dissipationrate",'.png')))
            close;

% Kolmogorov Scale
            eps_av=0;
            for j=1:ny_calc
                for i=1:nx
                    eps_av=eps_av+eps(j,i)/(ny_calc*nx);
                end
            end

            eta_b_400=((NYU^3)/eps_av)^0.25

%% b, 450
% du/dx
            for j=1:ny_calc
                for i=1:nx
                    if i==1
                        dudx(j,i)=(-25*u_b_450av(j,1)+48*u_b_450av(j,2)-36*u_b_450av(j,3)+16*u_b_450av(j,4)-3*u_b_450av(j,5))/(12*dx);
                    elseif i==2
                        dudx(j,i)=(-3*u_b_450av(j,1)-10*u_b_450av(j,2)+18*u_b_450av(j,3)-6*u_b_450av(j,4)+u_b_450av(j,5))/(12*dx);
                    elseif i==nx-1
                        dudx(j,i)=(3*u_b_450av(j,nx)+10*u_b_450av(j,nx-1)-18*u_b_450av(j,nx-2)+6*u_b_450av(j,nx-3)-u_b_450av(j,nx-4))/(12*dx);
                    elseif i==nx
                        dudx(j,i)=(25*u_b_450av(j,nx)-48*u_b_450av(j,nx-1)+36*u_b_450av(j,nx-2)-16*u_b_450av(j,nx-3)+3*u_b_450av(j,nx-4))/(12*dx);
                    else
                        dudx(j,i)=(u_b_450av(j,i-2)-8*u_b_450av(j,i-1)+8*u_b_450av(j,i+1)-u_b_450av(j,i+2))/(12*dx);
                    end
                end
            end

% dv/dx
            for j=1:ny_calc
                for i=1:nx
                    if i==1
                        dvdx(j,i)=(-25*v_b_450av(j,1)+48*v_b_450av(j,2)-36*v_b_450av(j,3)+16*v_b_450av(j,4)-3*v_b_450av(j,5))/(12*dx);
                    elseif i==2
                        dvdx(j,i)=(-3*v_b_450av(j,1)-10*v_b_450av(j,2)+18*v_b_450av(j,3)-6*v_b_450av(j,4)+v_b_450av(j,5))/(12*dx);
                    elseif i==nx-1
                        dvdx(j,i)=(3*v_b_450av(j,nx)+10*v_b_450av(j,nx-1)-18*v_b_450av(j,nx-2)+6*v_b_450av(j,nx-3)-v_b_450av(j,nx-4))/(12*dx);
                    elseif i==nx
                        dvdx(j,i)=(25*v_b_450av(j,nx)-48*v_b_450av(j,nx-1)+36*v_b_450av(j,nx-2)-16*v_b_450av(j,nx-3)+3*v_b_450av(j,nx-4))/(12*dx);
                    else
                        dvdx(j,i)=(v_b_450av(j,i-2)-8*v_b_450av(j,i-1)+8*v_b_450av(j,i+1)-v_b_450av(j,i+2))/(12*dx);
                    end
                end
            end

% du/dy
            for i=1:nx
                for j=1:ny_calc
                    if j==1
                        dudy(j,i)=-(-25*u_b_450av(1,i)+48*u_b_450av(2,i)-36*u_b_450av(3,i)+16*u_b_450av(4,i)-3*u_b_450av(5,i))/(12*dy);
                    elseif j==2
                        dudy(j,i)=-(-3*u_b_450av(1,i)-10*u_b_450av(2,i)+18*u_b_450av(3,i)-6*u_b_450av(4,i)+u_b_450av(5,i))/(12*dy);
                    elseif j==ny_calc-1
                        dudy(j,i)=-(3*u_b_450av(ny_calc,i)+10*u_b_450av(ny_calc-1,i)-18*u_b_450av(ny_calc-2,i)+6*u_b_450av(ny_calc-3,i)-u_b_450av(ny_calc-4,i))/(12*dy);
                    elseif j==ny_calc
                        dudy(j,i)=-(25*u_b_450av(ny_calc,i)-48*u_b_450av(ny_calc-1,i)+36*u_b_450av(ny_calc-2,i)-16*u_b_450av(ny_calc-3,i)+3*u_b_450av(ny_calc-4,i))/(12*dy);
                    else
                        dudy(j,i)=-(u_b_450av(j-2,i)-8*u_b_450av(j-1,i)+8*u_b_450av(j+1,i)-u_b_450av(j+2,i))/(12*dy);
                    end
                end
            end

% dv/dy
            for i=1:nx
                for j=1:ny_calc
                    if j==1
                        dvdy(j,i)=-(-25*v_b_450av(1,i)+48*v_b_450av(2,i)-36*v_b_450av(3,i)+16*v_b_450av(4,i)-3*v_b_450av(5,i))/(12*dy);
                    elseif j==2
                        dvdy(j,i)=-(-3*v_b_450av(1,i)-10*v_b_450av(2,i)+18*v_b_450av(3,i)-6*v_b_450av(4,i)+v_b_450av(5,i))/(12*dy);
                    elseif j==ny_calc-1
                        dvdy(j,i)=-(3*v_b_450av(ny_calc,i)+10*v_b_450av(ny_calc-1,i)-18*v_b_450av(ny_calc-2,i)+6*v_b_450av(ny_calc-3,i)-v_b_450av(ny_calc-4,i))/(12*dy);
                    elseif j==ny_calc
                        dvdy(j,i)=-(25*v_b_450av(ny_calc,i)-48*v_b_450av(ny_calc-1,i)+36*v_b_450av(ny_calc-2,i)-16*v_b_450av(ny_calc-3,i)+3*v_b_450av(ny_calc-4,i))/(12*dy);
                    else
                        dvdy(j,i)=-(v_b_450av(j-2,i)-8*v_b_450av(j-1,i)+8*v_b_450av(j+1,i)-v_b_450av(j+2,i))/(12*dy);
                    end
                end
            end

% omega
           for j=1:ny_calc
               for i=1:nx
                   omega(j,i)=dvdx(j,i)-dudy(j,i);
               end
           end

           omega_b_450=omega;

% Sij, strain
            for j=1:ny_calc
                for i=1:nx
                    Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
                    [V,D]=eig(Sij);
                    if D(1,1) > D(2,2)
                        strain_u(j,i)=V(1,1);
                        strain_v(j,i)=V(2,1);
                        eig11(j,i)=D(1,1);
                        eig22(j,i)=D(2,2);
                    elseif D(1,1) < D(2,2)
                        strain_u(j,i)=V(1,2);
                        strain_v(j,i)=V(2,2);
                        eig11(j,i)=D(2,2);
                        eig22(j,i)=D(1,1);
                    end
                end
            end
%
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            for j=1:floor(nx/nincrement)
                for i=1:floor(ny_calc/nincrement)
                    uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                    vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                end
            end

            ax=gca;
            IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
            load('MyColormap_for_w','mymap')
            colormap(ax,mymap)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[-4000 0 4000];
            c.TickLabels={'-4000','0','4000'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            hold on

            ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
            hold on
            ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
            xlim([-60 60])
            xlim([-60 60])
            ylim([ymin ymax])
            hold off

            saveas(gcf,strcat(savedirectory,strcat("450_before_osc_mean_omega_strain",'.png')))
            close;
%
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            for j=1:floor(nx/nincrement)
                for i=1:floor(ny_calc/nincrement)
                    uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                    vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                end
            end

            ax=gca;
            IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
            colormap(ax,jet)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[0 1000 2000];
            c.TickLabels={'0','1000','2000'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            hold on

            ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
            hold on
            ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
            xlim([-60 60])
            ylim([ymin ymax])
            hold off

            saveas(gcf,strcat(savedirectory,strcat("450_before_osc_mean_strain",'.png')))
            close;

% dissipation rate
            for j=1:ny_calc
                for i=1:nx
                    eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
                end
            end

            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            ax=gca;
            IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
            colormap(ax,jet)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[0 100 200];
            c.TickLabels={'0','100','200'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            xlim([-60 60])
            ylim([ymin ymax])

            saveas(gcf,strcat(savedirectory,strcat("450_before_osc_mean_dissipationrate",'.png')))
            close;

% Kolmogorov Scale
            eps_av=0;
            for j=1:ny_calc
                for i=1:nx
                    eps_av=eps_av+eps(j,i)/(ny_calc*nx);
                end
            end

            eta_b_450=((NYU^3)/eps_av)^0.25

%% b, 500
% du/dx
            for j=1:ny_calc
                for i=1:nx
                    if i==1
                        dudx(j,i)=(-25*u_b_500av(j,1)+48*u_b_500av(j,2)-36*u_b_500av(j,3)+16*u_b_500av(j,4)-3*u_b_500av(j,5))/(12*dx);
                    elseif i==2
                        dudx(j,i)=(-3*u_b_500av(j,1)-10*u_b_500av(j,2)+18*u_b_500av(j,3)-6*u_b_500av(j,4)+u_b_500av(j,5))/(12*dx);
                    elseif i==nx-1
                        dudx(j,i)=(3*u_b_500av(j,nx)+10*u_b_500av(j,nx-1)-18*u_b_500av(j,nx-2)+6*u_b_500av(j,nx-3)-u_b_500av(j,nx-4))/(12*dx);
                    elseif i==nx
                        dudx(j,i)=(25*u_b_500av(j,nx)-48*u_b_500av(j,nx-1)+36*u_b_500av(j,nx-2)-16*u_b_500av(j,nx-3)+3*u_b_500av(j,nx-4))/(12*dx);
                    else
                        dudx(j,i)=(u_b_500av(j,i-2)-8*u_b_500av(j,i-1)+8*u_b_500av(j,i+1)-u_b_500av(j,i+2))/(12*dx);
                    end
                end
            end

% dv/dx
            for j=1:ny_calc
                for i=1:nx
                    if i==1
                        dvdx(j,i)=(-25*v_b_500av(j,1)+48*v_b_500av(j,2)-36*v_b_500av(j,3)+16*v_b_500av(j,4)-3*v_b_500av(j,5))/(12*dx);
                    elseif i==2
                        dvdx(j,i)=(-3*v_b_500av(j,1)-10*v_b_500av(j,2)+18*v_b_500av(j,3)-6*v_b_500av(j,4)+v_b_500av(j,5))/(12*dx);
                    elseif i==nx-1
                        dvdx(j,i)=(3*v_b_500av(j,nx)+10*v_b_500av(j,nx-1)-18*v_b_500av(j,nx-2)+6*v_b_500av(j,nx-3)-v_b_500av(j,nx-4))/(12*dx);
                    elseif i==nx
                        dvdx(j,i)=(25*v_b_500av(j,nx)-48*v_b_500av(j,nx-1)+36*v_b_500av(j,nx-2)-16*v_b_500av(j,nx-3)+3*v_b_500av(j,nx-4))/(12*dx);
                    else
                        dvdx(j,i)=(v_b_500av(j,i-2)-8*v_b_500av(j,i-1)+8*v_b_500av(j,i+1)-v_b_500av(j,i+2))/(12*dx);
                    end
                end
            end

% du/dy
            for i=1:nx
                for j=1:ny_calc
                    if j==1
                        dudy(j,i)=-(-25*u_b_500av(1,i)+48*u_b_500av(2,i)-36*u_b_500av(3,i)+16*u_b_500av(4,i)-3*u_b_500av(5,i))/(12*dy);
                    elseif j==2
                        dudy(j,i)=-(-3*u_b_500av(1,i)-10*u_b_500av(2,i)+18*u_b_500av(3,i)-6*u_b_500av(4,i)+u_b_500av(5,i))/(12*dy);
                    elseif j==ny_calc-1
                        dudy(j,i)=-(3*u_b_500av(ny_calc,i)+10*u_b_500av(ny_calc-1,i)-18*u_b_500av(ny_calc-2,i)+6*u_b_500av(ny_calc-3,i)-u_b_500av(ny_calc-4,i))/(12*dy);
                    elseif j==ny_calc
                        dudy(j,i)=-(25*u_b_500av(ny_calc,i)-48*u_b_500av(ny_calc-1,i)+36*u_b_500av(ny_calc-2,i)-16*u_b_500av(ny_calc-3,i)+3*u_b_500av(ny_calc-4,i))/(12*dy);
                    else
                        dudy(j,i)=-(u_b_500av(j-2,i)-8*u_b_500av(j-1,i)+8*u_b_500av(j+1,i)-u_b_500av(j+2,i))/(12*dy);
                    end
                end
            end

% dv/dy
            for i=1:nx
                for j=1:ny_calc
                    if j==1
                        dvdy(j,i)=-(-25*v_b_500av(1,i)+48*v_b_500av(2,i)-36*v_b_500av(3,i)+16*v_b_500av(4,i)-3*v_b_500av(5,i))/(12*dy);
                    elseif j==2
                        dvdy(j,i)=-(-3*v_b_500av(1,i)-10*v_b_500av(2,i)+18*v_b_500av(3,i)-6*v_b_500av(4,i)+v_b_500av(5,i))/(12*dy);
                    elseif j==ny_calc-1
                        dvdy(j,i)=-(3*v_b_500av(ny_calc,i)+10*v_b_500av(ny_calc-1,i)-18*v_b_500av(ny_calc-2,i)+6*v_b_500av(ny_calc-3,i)-v_b_500av(ny_calc-4,i))/(12*dy);
                    elseif j==ny_calc
                        dvdy(j,i)=-(25*v_b_500av(ny_calc,i)-48*v_b_500av(ny_calc-1,i)+36*v_b_500av(ny_calc-2,i)-16*v_b_500av(ny_calc-3,i)+3*v_b_500av(ny_calc-4,i))/(12*dy);
                    else
                        dvdy(j,i)=-(v_b_500av(j-2,i)-8*v_b_500av(j-1,i)+8*v_b_500av(j+1,i)-v_b_500av(j+2,i))/(12*dy);
                    end
                end
            end

% omega
           for j=1:ny_calc
               for i=1:nx
                   omega(j,i)=dvdx(j,i)-dudy(j,i);
               end
           end

           omega_b_500=omega;

% Sij, strain
            for j=1:ny_calc
                for i=1:nx
                    Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
                    [V,D]=eig(Sij);
                    if D(1,1) > D(2,2)
                        strain_u(j,i)=V(1,1);
                        strain_v(j,i)=V(2,1);
                        eig11(j,i)=D(1,1);
                        eig22(j,i)=D(2,2);
                    elseif D(1,1) < D(2,2)
                        strain_u(j,i)=V(1,2);
                        strain_v(j,i)=V(2,2);
                        eig11(j,i)=D(2,2);
                        eig22(j,i)=D(1,1);
                    end
                end
            end
%
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            for j=1:floor(nx/nincrement)
                for i=1:floor(ny_calc/nincrement)
                    uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                    vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                end
            end

            ax=gca;
            IMAGE = imagesc(wx,wy,omega(:,:),[-4000 4000]);
            load('MyColormap_for_w','mymap')
            colormap(ax,mymap)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[-4000 0 4000];
            c.TickLabels={'-4000','0','4000'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} \omega_{z} \rm[1/s]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            hold on

            ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
            hold on
            ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
            xlim([-60 60])
            xlim([-60 60])
            ylim([ymin ymax])
            hold off

            saveas(gcf,strcat(savedirectory,strcat("500_before_osc_mean_omega_strain",'.png')))
            close;
%
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            for j=1:floor(nx/nincrement)
                for i=1:floor(ny_calc/nincrement)
                    uplot(i,j)=strain_u(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                    vplot(i,j)=strain_v(nincrement*(i-1)+1,nincrement*(j-1)+1)*eig11(nincrement*(i-1)+1,nincrement*(j-1)+1);
                end
            end

            ax=gca;
            IMAGE = imagesc(wx,wy,eig11(:,:),[0 2000]);
            colormap(ax,jet)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[0 1000 2000];
            c.TickLabels={'0','1000','2000'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} S \rm[1/s]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            hold on

            ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[1/s]','max','true','k','0');
            hold on
            ncquiverref2(x,y,-uplot(:,:),-vplot(:,:),'[1/s]','max','true','k','0');
            xlim([-60 60])
            ylim([ymin ymax])
            hold off

            saveas(gcf,strcat(savedirectory,strcat("500_before_osc_mean_strain",'.png')))
            close;

% dissipation rate
            for j=1:ny_calc
                for i=1:nx
                    eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
                end
            end

            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            ax=gca;
            IMAGE = imagesc(wx,wy,eps(:,:),[0 200]);
            colormap(ax,jet)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[0 100 200];
            c.TickLabels={'0','100','200'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} \epsilon \rm[m^{2}/s^{3}]';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            xlim([-60 60])
            ylim([ymin ymax])

            saveas(gcf,strcat(savedirectory,strcat("500_before_osc_mean_dissipationrate",'.png')))
            close;

% Kolmogorov Scale
            eps_av=0;
            for j=1:ny_calc
                for i=1:nx
                    eps_av=eps_av+eps(j,i)/(ny_calc*nx);
                end
            end

            eta_b_500=((NYU^3)/eps_av)^0.25

%% DETERMINE BORDER between irz and orz
%400
            line(1:ny_calc)=10e7;  % do not change

            for j=1:ny_calc
                for i=60:87
                    if omega_b_400(j,i) <= -400
                        if i<line(j)
                            line(j)=i;
                        end
                    end
                end
                for i=1:(nx-1)/2
                    if i<=line(j)
                        zones1(j,i)=1;
                    elseif i>line(j)
                        zones1(j,i)=2;
                    end
                end
            end
            
            line(1:ny_calc)=1;  % do not change
            
            for j=1:ny_calc
                for i=1:28
                    k=131-i;
                    if omega_b_400(j,k) >= 400
                        if k>line(j)
                            line(j)=k;
                        end
                    end
                end
                for i=(nx-1)/2+1:nx
                    if i<=line(j)
                        zones1(j,i)=3;
                    elseif i>line(j)
                        zones1(j,i)=4;
                    end
                end
            end
            
%450
            line(1:ny_calc)=10e7;  % do not change

            for j=1:ny_calc
                for i=60:87
                    if omega_b_450(j,i) <= -400
                        if i<line(j)
                            line(j)=i;
                        end
                    end
                end
                for i=1:(nx-1)/2
                    if i<=line(j)
                        zones2(j,i)=1;
                    elseif i>line(j)
                        zones2(j,i)=2;
                    end
                end
            end
            
            line(1:ny_calc)=1;  % do not change
            
            for j=1:ny_calc
                for i=1:28
                    k=131-i;
                    if omega_b_450(j,k) >= 400
                        if k>line(j)
                            line(j)=k;
                        end
                    end
                end
                for i=(nx-1)/2+1:nx
                    if i<=line(j)
                        zones2(j,i)=3;
                    elseif i>line(j)
                        zones2(j,i)=4;
                    end
                end
            end
            
%500
            line(1:ny_calc)=10e7;  % do not change

            for j=1:ny_calc
                for i=60:87
                    if omega_b_500(j,i) <= -400
                        if i<line(j)
                            line(j)=i;
                        end
                    end
                end
                for i=1:(nx-1)/2
                    if i<=line(j)
                        zones3(j,i)=1;
                    elseif i>line(j)
                        zones3(j,i)=2;
                    end
                end
            end
            
            line(1:ny_calc)=1;  % do not change
            
            for j=1:ny_calc
                for i=1:28
                    k=131-i;
                    if omega_b_500(j,k) >= 400
                        if k>line(j)
                            line(j)=k;
                        end
                    end
                end
                for i=(nx-1)/2+1:nx
                    if i<=line(j)
                        zones3(j,i)=3;
                    elseif i>line(j)
                        zones3(j,i)=4;
                    end
                end
            end
            
            temp=((zones1+zones2+zones3)/3-fliplr((zones1+zones2+zones3)/3));
            
            for j=1:ny_calc
                for i=1:nx
                    if temp(j,i)<-1.4
                        zones(j,i)=1;
                    elseif (temp(j,i)<0) && (temp(j,i)>-1.4)
                        zones(j,i)=2;
                    elseif (temp(j,i)<1.4) && (temp(j,i)>=0)
                        zones(j,i)=3;
                    elseif temp(j,i)>1.4
                        zones(j,i)=4;
                    end
                end
            end
            
% MANUAL MODIFICATION

            zones(45,74)=1;
            zones(46,74)=1;
            zones(45,118)=4;
            zones(46,118)=4;
            zones(3,77)=2;
            zones(3,115)=3;
            
% dzn/dx
            for j=1:ny_calc
                for i=1:nx
                    if i==1
                        dzndx(j,i)=(-25*zones(j,1)+48*zones(j,2)-36*zones(j,3)+16*zones(j,4)-3*zones(j,5))/(12);
                    elseif i==2
                        dzndx(j,i)=(-3*zones(j,1)-10*zones(j,2)+18*zones(j,3)-6*zones(j,4)+zones(j,5))/(12);
                    elseif i==nx-1
                        dzndx(j,i)=(3*zones(j,nx)+10*zones(j,nx-1)-18*zones(j,nx-2)+6*zones(j,nx-3)-zones(j,nx-4))/(12);
                    elseif i==nx
                        dzndx(j,i)=(25*zones(j,nx)-48*zones(j,nx-1)+36*zones(j,nx-2)-16*zones(j,nx-3)+3*zones(j,nx-4))/(12);
                    else
                        dzndx(j,i)=(zones(j,i-2)-8*zones(j,i-1)+8*zones(j,i+1)-zones(j,i+2))/(12);
                    end
                end
            end
            
            for j=1:ny_calc
                for i=1:nx
                    if dzndx(j,i)>0.58
                        zones4(j,i)=0;
                    end
                end
            end
            
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            ax=gca;
            IMAGE = imagesc(wx,wy,zones,[1 4]);
            colormap(ax,parula)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[1 2 3 4];
            c.TickLabels={'1','2','3','4'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} ';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            xlim([-60 60])
            ylim([ymin ymax])
            
            saveas(gcf,strcat(savedirectory,strcat("zone",'.png')))
            close;
            
            fig=figure;
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];

            ax=gca;
            IMAGE = imagesc(wx,wy,zones4,[0 1]);
            colormap(ax,gray)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

            ytickformat('%.2f')
            yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
            set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

            c=colorbar;
            c.Ticks=[0 1];
            c.TickLabels={'0','1'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 25;
            c.Label.String = '\it \fontname{Times New Roman} ';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',25)
            xlim([-60 60])
            ylim([ymin ymax])
            
            saveas(gcf,strcat(savedirectory,strcat("zone_border",'.png')))
            close;
            
            fileID=fopen(filename_zones,'w');
            fwrite(fileID,rot90(zones),'double');
            fclose(fileID);