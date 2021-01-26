    clc
    clear all
    close all

%% Parameters 1

%     trans_start_time=1.0638;
%     trans_fin_time=1.3517;
%     trig_time=1.6553;
    trans_start_time=3.4235;
    trans_fin_time=trans_start_time+1.09195;
    trig_time=trans_start_time;
    flow_rate=500;
    equivalence_ratio=0.76;%%%
    specific_f=146;%%%
    duct_l=582;
    hpsfreq=20;
    lpsfreq=300;
    date=20201223;
    num=5;
    col_max=2000; %Chem
%     col_max=1000; %PLIF
    vis='gray';

    file_image=sprintf('D:/Analysis/chem_output/chem_rmv/%d/chem_%02u_cor.dat',date,num);
%     file_image=sprintf('D:/plif_output/%d/plif_med/plif_%02u_med.dat',date,num);
%     presname=sprintf('E:/pressure/%d/calc/PDown_hps20_lps300_%d_%02u.dat',date,date,num);
    presname = sprintf('I:/Analysis/pressure/%d/calc/PDown_%d_%.2f_piv_%dHz_d%d_hps%d_lps%d.dat',date,flow_rate,equivalence_ratio,specific_f,duct_l,hpsfreq,lpsfreq);

    file_max=sprintf('D:/Analysis/chem_output/chem_phasemean/phasemean_max_%d_%d_%02u.dat',flow_rate,date,num);
    file_infdown=sprintf('D:/Analysis/chem_output/chem_phasemean/phasemean_infdown_%d_%d_%02u.dat',flow_rate,date,num);
    file_min=sprintf('D:/Analysis/chem_output/chem_phasemean/phasemean_min_%d_%d_%02u.dat',flow_rate,date,num);
    file_infup=sprintf('D:/Analysis/chem_output/chem_phasemean/phasemean_infup_%d_%d_%02u.dat',flow_rate,date,num);
%     file_max=sprintf('D:/plif_output/%d/plif_med/phasemean/phasemean_max_%d_%d_%02u.dat',date,flow_rate,date,num);
%     file_infdown=sprintf('D:/plif_output/%d/plif_med/phasemean/phasemean_infdown_%d_%d_%02u.dat',date,flow_rate,date,num);
%     file_min=sprintf('D:/plif_output/%d/plif_med/phasemean/phasemean_min_%d_%d_%02u.dat',date,flow_rate,date,num);
%     file_infup=sprintf('D:/plif_output/%d/plif_med/phasemean/phasemean_infup_%d_%d_%02u.dat',date,flow_rate,date,num);

    savedirectory=sprintf('D:/Analysis/chem_output/chem_phasemean/figure/%d_%02u/',date,num); %pictures
%     savedirectory=sprintf('D:/plif_output/%d/plif_med/phasemean/figure/%02u/',date,num); %pictures

%% Parameters 2

    nx=1024;
    ny=1024;
    nzall=21839;
    Fs=10e3;
    Fs_press=20e3;
    Fs_spiv=20e3;
    pres_samp_time=15;  % [sec]
    div=10;
    origin_x = 500; % [px]
    origin_y = 792; % [px]
    origin_height = 20; %[mm]
    img_res_x = 150*10^(-3); % [mm/px]
    img_res_y = 150*10^(-3); % [mm/px]

%% Matrix

    Sts=1/Fs;    % [sec]
    Sts_spiv=1/Fs_spiv;     % [sec]
    Sts_press=1/Fs_press;    % [sec]
    Pixels=nx*ny;
    origin_height_px=origin_height/img_res_y; %[px]
    pres_datasize=Fs_press*pres_samp_time;
    taxis=Sts_press:Sts_press:pres_samp_time;
%     cam_start_time = trig_time - Sts_spiv*nzall%ok
%     cam_start_time_chem = trig_time - Sts*nzall%ok
%     cam_start_data=floor(trig_time/Sts_press)-nzall%ok
%     cam_start_data_chem=floor(trig_time/Sts_press)-nzall*Sts/Sts_press%ok
%     before_transition_data=floor(nzall -(trig_time - trans_start_time)/Sts_press)%ok
%     before_transition_data_chem=floor(nzall -(trig_time - trans_start_time)/Sts)%ok
%     while_transition_data_chem=floor((trans_fin_time - trans_start_time)/Sts)
%     calc_data=floor((trans_fin_time - trans_start_time)/(div*Sts_press))
    cam_start_time = trig_time
    cam_start_time_chem = trig_time
    cam_start_data = floor(trig_time/Sts_press)
    cam_start_data_chem=floor(trig_time/Sts_press)
    before_transition_data = floor((trans_start_time - trig_time)/Sts_spiv)
    before_transition_data_chem=floor((trans_start_time - trig_time)/Sts)
    while_transition_data = floor((trans_fin_time - trans_start_time)/Sts_spiv)
    while_transition_data_chem=floor((trans_fin_time - trans_start_time)/Sts)
    calc_data = floor((trans_fin_time - trans_start_time)/(div*Sts_spiv))
    image=zeros(nx,ny);
    N=[nx ny];
    xmin=-origin_x*img_res_x; %[mm]
    ymax=origin_height+origin_y*img_res_y; %[mm]
    wx=zeros(2,1);
    wy=zeros(2,1);

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

     origin_height_px+origin_y
     2*origin_x

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

%% Calculation, PHASE MEAN, min

      meantemp1=zeros(ny,nx);
      meantemp2=zeros(ny,nx);
      meantemp3=zeros(ny,nx);
      meantemp4=zeros(ny,nx);
      meantemp5=zeros(ny,nx);
      meantemp6=zeros(ny,nx);
      meantemp7=zeros(ny,nx);
      meantemp8=zeros(ny,nx);
      meantemp9=zeros(ny,nx);
      meantemp10=zeros(ny,nx);
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

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmin(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn1=nn1+1;
              meantemp1(:,:) = meantemp1(:,:) + image(:,:);

              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_min_0-0.1T_",num2str(nn1),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+2*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmin(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn2=nn2+1;
              meantemp2(:,:) = meantemp2(:,:) + image(:,:);

              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_min_0.1T-0.2T_",num2str(nn2),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+3*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmin(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn3=nn3+1;
              meantemp3(:,:) = meantemp3(:,:) + image(:,:);

              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]); % Chem
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_min_0.2T-0.3T_",num2str(nn3),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+4*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmin(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn4=nn4+1;
              meantemp4(:,:) = meantemp4(:,:) + image(:,:);

              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_min_0.3T-0.4T_",num2str(nn4),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+5*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmin(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn5=nn5+1;
              meantemp5(:,:) = meantemp5(:,:) + image(:,:);

              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_min_0.4T-0.5T_",num2str(nn5),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+6*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmin(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn6=nn6+1;
              meantemp6(:,:) = meantemp6(:,:) + image(:,:);

              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_min_0.5T-0.6T_",num2str(nn6),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+7*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmin(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn7=nn7+1;
              meantemp7(:,:) = meantemp7(:,:) + image(:,:);

              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_min_0.6T-0.7T_",num2str(nn7),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+8*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmin(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn8=nn8+1;
              meantemp8(:,:) = meantemp8(:,:) + image(:,:);

              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_min_0.7T-0.8T_",num2str(nn8),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+9*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmin(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn9=nn9+1;
              meantemp9(:,:) = meantemp9(:,:) + image(:,:);

              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_min_0.8T-0.9T_",num2str(nn9),'.png')))
              close;

          elseif (locs_presmin(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+10*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmin(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn10=nn10+1;
              meantemp10(:,:) = meantemp10(:,:) + image(:,:);

              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_min_0.9T-T_",num2str(nn10),'.png')))
              close;

          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      min1st=meantemp1/nn1;
      min2nd=meantemp2/nn2;
      min3rd=meantemp3/nn3;
      min4th=meantemp4/nn4;
      min5th=meantemp5/nn5;
      min6th=meantemp6/nn6;
      min7th=meantemp7/nn7;
      min8th=meantemp8/nn8;
      min9th=meantemp9/nn9;
      min10th=meantemp10/nn10;

      save=cat(3,min1st,min2nd,min3rd,min4th,min5th,min6th,min7th,min8th,min9th,min10th);

      fileID=fopen(file_min,'w');
      fwrite(fileID,save,'double');
      fclose(fileID);

%% Calculation, PHASE MEAN, max

      meantemp1=zeros(ny,nx);
      meantemp2=zeros(ny,nx);
      meantemp3=zeros(ny,nx);
      meantemp4=zeros(ny,nx);
      meantemp5=zeros(ny,nx);
      meantemp6=zeros(ny,nx);
      meantemp7=zeros(ny,nx);
      meantemp8=zeros(ny,nx);
      meantemp9=zeros(ny,nx);
      meantemp10=zeros(ny,nx);
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

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn1=nn1+1;
              meantemp1(:,:) = meantemp1(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_max_0-0.1T_",num2str(nn1),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+2*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn2=nn2+1;
              meantemp2(:,:) = meantemp2(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_max_0.1T-0.2T_",num2str(nn2),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+3*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn3=nn3+1;
              meantemp3(:,:) = meantemp3(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_max_0.2T-0.3T_",num2str(nn3),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+4*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn4=nn4+1;
              meantemp4(:,:) = meantemp4(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_max_0.3T-0.4T_",num2str(nn4),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+5*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn5=nn5+1;
              meantemp5(:,:) = meantemp5(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_max_0.4T-0.5T_",num2str(nn5),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+6*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn6=nn6+1;
              meantemp6(:,:) = meantemp6(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_max_0.5T-0.6T_",num2str(nn6),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+7*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn7=nn7+1;
              meantemp7(:,:) = meantemp7(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_max_0.6T-0.7T_",num2str(nn7),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+8*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn8=nn8+1;
              meantemp8(:,:) = meantemp8(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_max_0.7T-0.8T_",num2str(nn8),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+9*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn9=nn9+1;
              meantemp9(:,:) = meantemp9(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_max_0.8T-0.9T_",num2str(nn9),'.png')))
              close;

          elseif (locs_presmax(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+10*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn10=nn10+1;
              meantemp10(:,:) = meantemp10(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_max_0.9T-T_",num2str(nn10),'.png')))
              close;

          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      max1st=meantemp1/nn1;
      max2nd=meantemp2/nn2;
      max3rd=meantemp3/nn3;
      max4th=meantemp4/nn4;
      max5th=meantemp5/nn5;
      max6th=meantemp6/nn6;
      max7th=meantemp7/nn7;
      max8th=meantemp8/nn8;
      max9th=meantemp9/nn9;
      max10th=meantemp10/nn10;

      save=cat(3,max1st,max2nd,max3rd,max4th,max5th,max6th,max7th,max8th,max9th,max10th);

      fileID=fopen(file_max,'w');
      fwrite(fileID,save,'double');
      fclose(fileID);

%% Calculation, PHASE MEAN, inflectdown

      meantemp1=zeros(ny,nx);
      meantemp2=zeros(ny,nx);
      meantemp3=zeros(ny,nx);
      meantemp4=zeros(ny,nx);
      meantemp5=zeros(ny,nx);
      meantemp6=zeros(ny,nx);
      meantemp7=zeros(ny,nx);
      meantemp8=zeros(ny,nx);
      meantemp9=zeros(ny,nx);
      meantemp10=zeros(ny,nx);
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

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn1=nn1+1;
              meantemp1(:,:) = meantemp1(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infdown_0-0.1T_",num2str(nn1),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+2*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn2=nn2+1;
              meantemp2(:,:) = meantemp2(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infdown_0.1T-0.2T_",num2str(nn2),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+3*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn3=nn3+1;
              meantemp3(:,:) = meantemp3(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infdown_0.2T-0.3T_",num2str(nn3),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+4*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn4=nn4+1;
              meantemp4(:,:) = meantemp4(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infdown_0.3T-0.4T_",num2str(nn4),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+5*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn5=nn5+1;
              meantemp5(:,:) = meantemp5(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infdown_0.4T-0.5T_",num2str(nn5),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+6*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn6=nn6+1;
              meantemp6(:,:) = meantemp6(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infdown_0.5T-0.6T_",num2str(nn6),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+7*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn7=nn7+1;
              meantemp7(:,:) = meantemp7(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infdown_0.6T-0.7T_",num2str(nn7),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+8*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn8=nn8+1;
              meantemp8(:,:) = meantemp8(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infdown_0.7T-0.8T_",num2str(nn8),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+9*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn9=nn9+1;
              meantemp9(:,:) = meantemp9(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infdown_0.8T-0.9T_",num2str(nn9),'.png')))
              close;

          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+10*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn10=nn10+1;
              meantemp10(:,:) = meantemp10(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infdown_0.9T-T_",num2str(nn10),'.png')))
              close;

          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      infdown1st=meantemp1/nn1;
      infdown2nd=meantemp2/nn2;
      infdown3rd=meantemp3/nn3;
      infdown4th=meantemp4/nn4;
      infdown5th=meantemp5/nn5;
      infdown6th=meantemp6/nn6;
      infdown7th=meantemp7/nn7;
      infdown8th=meantemp8/nn8;
      infdown9th=meantemp9/nn9;
      infdown10th=meantemp10/nn10;

      save=cat(3,infdown1st,infdown2nd,infdown3rd,infdown4th,infdown5th,infdown6th,infdown7th,infdown8th,infdown9th,infdown10th);

      fileID=fopen(file_infdown,'w');
      fwrite(fileID,save,'double');
      fclose(fileID);

%% Calculation, PHASE MEAN, inflectup

      meantemp1=zeros(ny,nx);
      meantemp2=zeros(ny,nx);
      meantemp3=zeros(ny,nx);
      meantemp4=zeros(ny,nx);
      meantemp5=zeros(ny,nx);
      meantemp6=zeros(ny,nx);
      meantemp7=zeros(ny,nx);
      meantemp8=zeros(ny,nx);
      meantemp9=zeros(ny,nx);
      meantemp10=zeros(ny,nx);
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

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn1=nn1+1;
              meantemp1(:,:) = meantemp1(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infup_0-0.1T_",num2str(nn1),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+2*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn2=nn2+1;
              meantemp2(:,:) = meantemp2(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infup_0.1T-0.2T_",num2str(nn2),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+3*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn3=nn3+1;
              meantemp3(:,:) = meantemp3(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infup_0.2T-0.3T_",num2str(nn3),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+4*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn4=nn4+1;
              meantemp4(:,:) = meantemp4(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infup_0.3T-0.4T_",num2str(nn4),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+5*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn5=nn5+1;
              meantemp5(:,:) = meantemp5(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infup_0.4T-0.5T_",num2str(nn5),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+6*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn6=nn6+1;
              meantemp6(:,:) = meantemp6(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infup_0.5T-0.6T_",num2str(nn6),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+7*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn7=nn7+1;
              meantemp7(:,:) = meantemp7(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infup_0.6T-0.7T_",num2str(nn7),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+8*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn8=nn8+1;
              meantemp8(:,:) = meantemp8(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infup_0.7T-0.8T_",num2str(nn8),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+9*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn9=nn9+1;
              meantemp9(:,:) = meantemp9(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infup_0.8T-0.9T_",num2str(nn9),'.png')))
              close;

          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+10*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-trans_start_time)/Sts))*Pixels*2,'bof');
              I=(fread(fid1,Pixels,'uint16'));
              image=permute(reshape(I,N),[2 1]);
              fclose(fid1);

              nn10=nn10+1;
              meantemp10(:,:) = meantemp10(:,:) + image(:,:);
              
              fig = figure;
              fig.Position=[1 1 800 800];
              fig.Color='white';

              pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
              subplot('Position',pos1)
              IMAGE = imagesc(wx,wy,image(1:origin_height_px+origin_y,1:2*origin_x),[0 col_max]);
              ax=gca;
              colormap(ax,vis)
              xtickformat('%.2f')
              xticks([-60 -40 -20 0 20 40 60])
              set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
              ytickformat('%.2f')
              yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
              set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

              c=colorbar;
              c.Ticks=[0 500 1000 1500 2000];
              c.TickLabels={'0','500','1000','1500','2000'}; 
              c.TickLabelInterpreter='latex';
              c.Label.FontSize = 15;
              c.Label.String = '\it \fontname{Times New Roman}';
              c.Location = 'eastoutside';
              c.AxisLocation='out';

              xlabel('\it \fontname{Times New Roman} x \rm[mm]')
              ylabel('\it \fontname{Times New Roman} y \rm[mm]')
              set(gca,'FontName','Times New Roman','FontSize',15)
              hold on

              xlim([-60 60])
              ylim([ymin ymax])
              hold off

              saveas(gcf,strcat(savedirectory,strcat("phase_infup_0.9T-T_",num2str(nn10),'.png')))
              close;

          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      infup1st=meantemp1/nn1;
      infup2nd=meantemp2/nn2;
      infup3rd=meantemp3/nn3;
      infup4th=meantemp4/nn4;
      infup5th=meantemp5/nn5;
      infup6th=meantemp6/nn6;
      infup7th=meantemp7/nn7;
      infup8th=meantemp8/nn8;
      infup9th=meantemp9/nn9;
      infup10th=meantemp10/nn10;

      save=cat(3,infup1st,infup2nd,infup3rd,infup4th,infup5th,infup6th,infup7th,infup8th,infup9th,infup10th);

      fileID=fopen(file_infup,'w');
      fwrite(fileID,save,'double');
      fclose(fileID);
