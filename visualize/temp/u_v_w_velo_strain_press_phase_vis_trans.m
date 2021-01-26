    clc
    clear all
    close all

%% Parameters 1

    trans_start_time = 1.6838;
    trans_fin_time = 1.9594;
    trig_time = 2.3053;
    date=20190821;
    num=4;
    nincrement=3;

    file_u=sprintf('E:/piv_output/velofield/%d/spiv_fbsc_%02u_ucl.dat',date,num);
    file_v=sprintf('E:/piv_output/velofield/%d/spiv_fbsc_%02u_vcl.dat',date,num);
    file_w=sprintf('E:/piv_output/velofield/%d/spiv_fbsc_%02u_wcl.dat',date,num);
    file_eig11=sprintf('E:/piv_output/strain_eig/%d/spiv_strain_eig11_%d_%02u.dat',date,date,num);
    presname = sprintf('E:/pressure/%d/calc/PDown_hps20_lps300_%d_%02u.dat',date,date,num);

    savedirectory=sprintf('E:/piv_output/velo_phase_trans/%d/%02u/',date,num); %pictures

%% Parameters 2

    nx = 191;
    ny = 121;
    ny_calc = 98; % ATTENTION, CUT
    nzall = 21838;
    Fs_spiv= 20e3;
    Fs_press= 20e3;
    pres_samp_time = 10;  % [sec]
    div =10;
    vec_spc_x = 8;
    vec_spc_y = 8;
    img_res_x = 80*10^(-3);
    img_res_y = 75*10^(-3);
    col_max=5000;

%% Matrix

    Sts_spiv = 1/Fs_spiv;    % [sec]
    Sts_press = 1/Fs_press;    % [sec]
    Pixels=nx*ny;
    pres_datasize =Fs_press*pres_samp_time;
    taxis = Sts_press:Sts_press:pres_samp_time;
    cam_start_time = trig_time - Sts_spiv*nzall
    cam_start_data = floor(trig_time/Sts_press)-nzall
    before_transition_data = floor(nzall -(trig_time - trans_start_time)/Sts_spiv)
    while_transition_data = floor((trans_fin_time - trans_start_time)/Sts_spiv)
    calc_data = floor((trans_fin_time - trans_start_time)/(div*Sts_spiv))
    N=[nx ny];
    X=img_res_x*vec_spc_x;
    Y=img_res_y*vec_spc_y;
    xmin=-(0.5*(nx-1))*X+X;
    xmax=0.5*(nx-1)*X+X;
    ymin=Y*19; % ATTENTION, CUT
    ymax=Y*116; % ATTENTION, CUT
    wx=zeros(2,1);
    wy=zeros(2,1);

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

%% Search phases

      fid4 = fopen(sprintf(presname),'r');
      p_fil = fread(fid4,pres_datasize,'double');
      fclose(fid4);

      [pks_pres,locs_presmax] = findpeaks(p_fil);
      TF_pres = islocalmin(p_fil);

      nn=0;

      for t=1:pres_datasize
          if TF_pres(t)==1
              nn=nn+1;
              locs_prestemp(nn)=t;
          end
      end

      locs_presmin=reshape(locs_prestemp,[nn,1]);

      if length(locs_presmin) <= length(locs_presmax)
        if (locs_presmax(1) < locs_presmin(1))
            for t=1:length(locs_presmin)-1
              inflect1(t)=ceil((locs_presmin(t)+locs_presmax(t))/2);
            end
            for t=1:length(locs_presmin)-1
              inflect2(t)=ceil((locs_presmax(t+1)+locs_presmin(t))/2);
            end
        else
            for t=1:length(locs_presmin)-1
              inflect2(t)=ceil((locs_presmax(t)+locs_presmin(t))/2);
            end
            for t=1:length(locs_presmin)-1
              inflect1(t)=ceil((locs_presmin(t+1)+locs_presmax(t))/2);
            end
        end
        locs_inflectdown=reshape(inflect1,[length(locs_presmin)-1,1]);
        locs_inflectup=reshape(inflect2,[length(locs_presmin)-1,1]);

      else
        if (locs_presmax(1) < locs_presmin(1))
            for t=1:length(locs_presmax)-1
              inflect1(t)=ceil((locs_presmin(t)+locs_presmax(t))/2);
            end
            for t=1:length(locs_presmax)-1
              inflect2(t)=ceil((locs_presmax(t+1)+locs_presmin(t))/2);
            end
        else
            for t=1:length(locs_presmax)-1
              inflect2(t)=ceil((locs_presmax(t)+locs_presmin(t))/2);
            end
            for t=1:length(locs_presmax)-1
              inflect1(t)=ceil((locs_presmin(t+1)+locs_presmax(t))/2);
            end
        end
        locs_inflectdown=reshape(inflect1,[length(locs_presmax)-1,1]);
        locs_inflectup=reshape(inflect2,[length(locs_presmax)-1,1]);
      end

%% check phases

      fig = figure;
      fig.Color='white';
      fig.Position=[50 50 960 735];

      plot(taxis,p_fil,'k')
      ax = gca;
      ax.YColor = 'k';

      xtickformat('%.2f')
      xticks([trans_start_time-0.4 trans_start_time-0.2 trans_start_time trans_start_time+0.2 trans_start_time+0.4 trans_start_time+0.6 trans_start_time+0.8 trans_start_time+1.0])
      set(gca,'xTickLabel', char('-0.4','-0.2','0.0','0.2','0.4','0.6','0.8','10'))
      ytickformat('%.3f')
      yticks([-0.40 -0.20 0 0.20 0.40])
      set(gca,'YTickLabel', char('-0.40','-0.20','0.00','0.20','0.40'))

      xlim([trans_start_time-0.4 trans_fin_time+0.4]);
      ylim([-0.40 0.40]);

      ax.Box = 'on';
      ax.LineWidth = 2.0;
      ax.XMinorTick = 'on';
      ax.YMinorTick = 'on';

      xlabel('\it \fontname{Times New Roman} t \rm[sec]')
      ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
      set(gca,'FontName','Times New Roman','FontSize',20)
      hold on

      plot([trans_start_time trans_start_time],[-0.50 0.50],'m--','LineWidth',1.5)
      hold on

      plot([trans_fin_time trans_fin_time],[-0.50 0.50],'m--','LineWidth',1.5)
      hold on

      plot(taxis(locs_presmax),pks_pres,'xr')
      hold on

      plot(taxis(locs_presmin),p_fil(locs_presmin),'ob')
      hold on

      plot(taxis(locs_inflectdown),p_fil(locs_inflectdown),'vg')
      hold on

      plot(taxis(locs_inflectup),p_fil(locs_inflectup),'^c')
      hold off
      pbaspect([sqrt(2) 1 1]);

%% Calculation, PHASE_MIN

      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_presmin)
          if (locs_presmin(t)-cam_start_data >before_transition_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn1=nn1+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_min_0-0.1T_",num2str(nn1),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 1000 2000 3000];
%               c.TickLabels={'0','1000','2000','3000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_min_0-0.1T_",num2str(nn1),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+2*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn2=nn2+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_min_0.1T-0.2T_",num2str(nn2),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 1000 2000 3000];
%               c.TickLabels={'0','1000','2000','3000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_min_0.1T-0.2T_",num2str(nn2),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+3*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn3=nn3+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_min_0.2T-0.3T_",num2str(nn3),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 1000 2000 3000];
%               c.TickLabels={'0','1000','2000','3000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_min_0.2T-0.3T_",num2str(nn3),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+4*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn4=nn4+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_min_0.3T-0.4T_",num2str(nn4),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 1000 2000 3000];
%               c.TickLabels={'0','1000','2000','3000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_min_0.3T-0.4T_",num2str(nn4),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+5*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn5=nn5+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_min_0.4T-0.5T_",num2str(nn5),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 1000 2000 3000];
%               c.TickLabels={'0','1000','2000','3000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_min_0.4T-0.5T_",num2str(nn5),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+6*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn6=nn6+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_min_0.5T-0.6T_",num2str(nn6),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 1000 2000 3000];
%               c.TickLabels={'0','1000','2000','3000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_min_0.5T-0.6T_",num2str(nn6),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+7*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn7=nn7+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_min_0.6T-0.7T_",num2str(nn7),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 1000 2000 3000];
%               c.TickLabels={'0','1000','2000','3000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_min_0.6T-0.7T_",num2str(nn7),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+8*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn8=nn8+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_min_0.7T-0.8T_",num2str(nn8),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 1000 2000 3000];
%               c.TickLabels={'0','1000','2000','3000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_min_0.7T-0.8T_",num2str(nn8),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+9*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn9=nn9+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_min_0.8T-0.9T_",num2str(nn9),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 1000 2000 3000];
%               c.TickLabels={'0','1000','2000','3000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_min_0.8T-0.9T_",num2str(nn9),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+10*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmin(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn10=nn10+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_min_0.9T-T_",num2str(nn10),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 1000 2000 3000];
%               c.TickLabels={'0','1000','2000','3000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_min_0.9T-T_",num2str(nn10),'.png')))
              close;

          end
      end

%% Calculation, PHASE, max

      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_presmax)
          if (locs_presmax(t)-cam_start_data >before_transition_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn1=nn1+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_max_0-0.1T_",num2str(nn1),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 1000 2000 3000];
%               c.TickLabels={'0','1000','2000','3000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_max_0-0.1T_",num2str(nn1),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+2*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn2=nn2+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_max_0.1T-0.2T_",num2str(nn2),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_max_0.1T-0.2T_",num2str(nn2),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+3*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn3=nn3+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_max_0.2T-0.3T_",num2str(nn3),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_max_0.2T-0.3T_",num2str(nn3),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+4*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn4=nn4+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_max_0.3T-0.4T_",num2str(nn4),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_max_0.3T-0.4T_",num2str(nn4),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+5*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn5=nn5+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_max_0.4T-0.5T_",num2str(nn5),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_max_0.4T-0.5T_",num2str(nn5),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+6*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn6=nn6+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_max_0.5T-0.6T_",num2str(nn6),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_max_0.5T-0.6T_",num2str(nn6),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+7*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn7=nn7+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_max_0.6T-0.7T_",num2str(nn7),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_max_0.6T-0.7T_",num2str(nn7),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+8*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn8=nn8+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_max_0.7T-0.8T_",num2str(nn8),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_max_0.7T-0.8T_",num2str(nn8),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+9*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn9=nn9+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_max_0.8T-0.9T_",num2str(nn9),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_max_0.8T-0.9T_",num2str(nn9),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+10*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_presmax(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn10=nn10+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_max_0.9T-T_",num2str(nn10),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_max_0.9T-T_",num2str(nn10),'.png')))
              close;

          end
      end

%% Calculation, PHASE, inflectdown

      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_inflectdown)
          if (locs_inflectdown(t)-cam_start_data >before_transition_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn1=nn1+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectdown_0-0.1T_",num2str(nn1),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectdown_0-0.1T_",num2str(nn1),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+2*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn2=nn2+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectdown_0.1T-0.2T_",num2str(nn2),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectdown_0.1T-0.2T_",num2str(nn2),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+3*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn3=nn3+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectdown_0.2T-0.3T_",num2str(nn3),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectdown_0.2T-0.3T_",num2str(nn3),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+4*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn4=nn4+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectdown_0.3T-0.4T_",num2str(nn4),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectdown_0.3T-0.4T_",num2str(nn4),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+5*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn5=nn5+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectdown_0.4T-0.5T_",num2str(nn5),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectdown_0.4T-0.5T_",num2str(nn5),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+6*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn6=nn6+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectdown_0.5T-0.6T_",num2str(nn6),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectdown_0.5T-0.6T_",num2str(nn6),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+7*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn7=nn7+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectdown_0.6T-0.7T_",num2str(nn7),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectdown_0.6T-0.7T_",num2str(nn7),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+8*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn8=nn8+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectdown_0.7T-0.8T_",num2str(nn8),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectdown_0.7T-0.8T_",num2str(nn8),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+9*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn9=nn9+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectdown_0.8T-0.9T_",num2str(nn9),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectdown_0.8T-0.9T_",num2str(nn9),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+10*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectdown(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn10=nn10+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectdown_0.9T-T_",num2str(nn10),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectdown_0.9T-T_",num2str(nn10),'.png')))
              close;

          end
      end

%% Calculation, PHASE, inflectup

      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_inflectup)
          if (locs_inflectup(t)-cam_start_data >before_transition_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn1=nn1+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectup_0-0.1T_",num2str(nn1),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectup_0-0.1T_",num2str(nn1),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+2*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn2=nn2+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectup_0.1T-0.2T_",num2str(nn2),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectup_0.1T-0.2T_",num2str(nn2),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+3*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn3=nn3+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectup_0.2T-0.3T_",num2str(nn3),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectup_0.2T-0.3T_",num2str(nn3),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+4*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn4=nn4+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectup_0.3T-0.4T_",num2str(nn4),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectup_0.3T-0.4T_",num2str(nn4),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+5*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn5=nn5+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectup_0.4T-0.5T_",num2str(nn5),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectup_0.4T-0.5T_",num2str(nn5),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+6*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn6=nn6+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectup_0.5T-0.6T_",num2str(nn6),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectup_0.5T-0.6T_",num2str(nn6),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+7*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn7=nn7+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectup_0.6T-0.7T_",num2str(nn7),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectup_0.6T-0.7T_",num2str(nn7),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+8*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn8=nn8+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectup_0.7T-0.8T_",num2str(nn8),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectup_0.7T-0.8T_",num2str(nn8),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+9*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn9=nn9+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectup_0.8T-0.9T_",num2str(nn9),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectup_0.8T-0.9T_",num2str(nn9),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+10*calc_data)

              fid1 = fopen(sprintf(file_u),'r');
              fseek(fid1,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid1,Pixels,'double'));
              u=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              fid2 = fopen(sprintf(file_v),'r');
              fseek(fid2,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid2,Pixels,'double'));
              v=permute(reshape(I,N),[2 1]);
              fclose(fid2);

              fid3 = fopen(sprintf(file_w),'r');
              fseek(fid3,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid3,Pixels,'double'));
              w=permute(reshape(I,N),[2 1]);
              fclose(fid3);

              fid4 = fopen(sprintf(file_eig11),'r');
              fseek(fid4,(locs_inflectup(t)-cam_start_data-1)*Pixels*8,'bof');
              I=(fread(fid4,Pixels,'double'));
              eig11=reshape(I,[ny nx]);
              fclose(fid4);

              u_vis=u(4:101,:);
              v_vis=v(4:101,:);
              w_vis=w(4:101,:);
              eig11_vis=abs(eig11(4:101,:));

              nn10=nn10+1;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              for j=1:floor(nx/nincrement)
                  for i=1:floor(ny_calc/nincrement)
                     uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                     vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
                  end
              end

              ax=gca;
              IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
              load('MyColormap_for_w','mymap')
              colormap(ax,mymap)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
              c.Ticks=[-10 -5 0 5 10];
              c.TickLabels={'-10','-5.0','0.0','5.0','10'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              ax = gca;
              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("velo_phase_inflectup_0.9T-T_",num2str(nn10),'.png')))
              close;

              fig=figure;
              fig.Color='white';
              fig.Position=[1 1 800*(1+sqrt(5))/2 800];

              ax=gca;
              IMAGE = imagesc(wx,wy,eig11_vis,[0 col_max]);
              colormap(ax,jet)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

              ytickformat('%.2f')
              yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
              set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

              c=colorbar;
%               c.Ticks=[0 500 1000 1500 2000];
%               c.TickLabels={'0','500','1000','1500','2000'};
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 25;
              c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',25)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("strain_phase_inflectup_0.9T-T_",num2str(nn10),'.png')))
              close;

          end
      end
