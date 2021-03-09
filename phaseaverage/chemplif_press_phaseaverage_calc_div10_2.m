    clc
    clear all
    close all

%% Parameters 1

    type=1; % 1.trans, 2.all
    flow_rate=500;
    equivalence_ratio=0.80;%%%
    specific_f=189;%%%
    duct_l=582;
    hpsfreq=20;
    lpsfreq=300;
    date=20201223;
    num=7;
    col_max=2000; %Chem
%     col_max=800; %PLIF
    vis='gray';

    %CHEM.
    dir_i=sprintf('D:/Analysis/chem_output/chem_rmv/%d/',date);
    if type == 1
      dir_o=sprintf('D:/Analysis/chem_output/chem_phasemean/trans/');
      dir_f=sprintf('D:/Analysis/chem_output/chem_phasemean/trans/figure/%d_%02u/',date,num);
    elseif type == 2
      dir_o=sprintf('D:/Analysis/chem_output/chem_phasemean/mode/');
      dir_f=sprintf('D:/Analysis/chem_output/chem_phasemean/mode/figure/%d_%02u/',date,num);
    end

    %PLIF
    % dir_i=sprintf('H:/Analysis/plif_output/plif_med/%d/',date);
    % if type == 1
    %   dir_o=sprintf('H:/Analysis/plif_output/plif_phasemean/trans/');
    %   dir_f=sprintf('H:/Analysis/plif_output/plif_phasemean/trans/figure/%d_%02u/',date,num);
    % elseif type == 2
    %   dir_o=sprintf('H:/Analysis/plif_output/plif_phasemean/mode/');
    %   dir_f=sprintf('H:/Analysis/plif_output/plif_phasemean/mode/figure/%d_%02u/',date,num);
    % end

    dir_p=sprintf('I:/Analysis/pressure/%d/calc/',date);

%% Parameters 2

    calc_start_time=1.0638; % mode=1, trans_start_time
    calc_fin_time=1.3517; % mode=1, trans_fin_time
    trig_time=1.6553; % mode=1
    % calc_start_time=3.0647; % mode=2
    % calc_fin_time=calc_start_time+1.09195; % mode=2
    % trig_time=calc_start_time; % mode=2

    nx=1024;
    ny=1024;
    nzall=21839;
    Fs=10e3;
    Fs_press=20e3;
    Fs_spiv=20e3;
    pres_samp_time=15; % [sec]
    div=10;
    origin_x=500; % [px]
    origin_y=792; % [px]
    origin_height=20; %[mm]
    img_res_x=150*10^(-3); % [mm/px]
    img_res_y=150*10^(-3); % [mm/px]

%% Matrix

    Sts=1/Fs; % [sec]
    Sts_spiv=1/Fs_spiv; % [sec]
    Sts_press=1/Fs_press; % [sec]
    origin_height_px=origin_height/img_res_y; % [px]
    pres_datasize=Fs_press*pres_samp_time;
    taxis=Sts_press:Sts_press:pres_samp_time;
    if type == 1
      cam_start_time = trig_time - Sts_spiv*nzall
      cam_start_time_chem = trig_time - Sts*nzall
      cam_start_data=floor(trig_time/Sts_press)-nzall
      cam_start_data_chem=floor(trig_time/Sts_press)-nzall*Sts/Sts_press
      before_transition_data=floor(nzall -(trig_time - calc_start_time)/Sts_press)
      before_transition_data_chem=floor(nzall -(trig_time - calc_start_time)/Sts)
      while_transition_data_chem=floor((calc_fin_time - calc_start_time)/Sts)
      calc_data=floor((calc_fin_time - calc_start_time)/(div*Sts_press))
      % fn_i=sprintf('chem_%02u_cor.dat',num);
      fn_i=sprintf('chem_%02u_rmv.dat',num);
      % fn_i=sprintf('plif_%02u_med.dat',num);
      fn_p=sprintf('PDown_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
      fn_max=sprintf('phasemean_max_%d_%d_%02u.dat',flow_rate,date,num);
      fn_infdown=sprintf('phasemean_infdown_%d_%d_%02u.dat',flow_rate,date,num);
      fn_min=sprintf('phasemean_min_%d_%d_%02u.dat',flow_rate,date,num);
      fn_infup=sprintf('phasemean_infup_%d_%d_%02u.dat',flow_rate,date,num);
    elseif type == 2
      cam_start_time = trig_time
      cam_start_time_chem = trig_time
      cam_start_data = floor(trig_time/Sts_press)
      cam_start_data_chem=floor(trig_time/Sts_press)
      before_transition_data = floor((calc_start_time - trig_time)/Sts_spiv)
      before_transition_data_chem=floor((calc_start_time - trig_time)/Sts)
      while_transition_data = floor((calc_fin_time - calc_start_time)/Sts_spiv)
      while_transition_data_chem=floor((calc_fin_time - calc_start_time)/Sts)
      calc_data = floor((calc_fin_time - calc_start_time)/(div*Sts_spiv))
      % fn_i=sprintf('chem_%02u_cor.dat',num);
      % fn_i=sprintf('chem_%02u_rmv.dat',num);
      % fn_i=sprintf('plif_%02u_med.dat',num);
      % fn_p=sprintf('PDown_%d_%.2f_piv_%dHz_d%d_hps%d_lps%d.dat',flow_rate,equivalence_ratio,specific_f,duct_l,hpsfreq,lpsfreq);
      % fn_max=sprintf('phasemean_max_%d_%d_%02u.dat',flow_rate,date,num);
      % fn_infdown=sprintf('phasemean_infdown_%d_%d_%02u.dat',flow_rate,date,num);
      % fn_min=sprintf('phasemean_min_%d_%d_%02u.dat',flow_rate,date,num);
      % fn_infup=sprintf('phasemean_infup_%d_%d_%02u.dat',flow_rate,date,num);
    end

%% Search phases

    [p_fil,locs_presmax,pks_pres,locs_inflectdown,locs_presmin,locs_inflectup] = serach_phase(dir_p,fn_p,pres_datasize)

%% check phases

    phase_vis(taxis,p_fil,calc_start_time,calc_fin_time,locs_presmax,pks_pres,locs_inflectdown,locs_presmin,locs_inflectup)

%% Calculation, PHASE MEAN, min




          elseif (locs_presmin(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+10*calc_data)

              fid1 = fopen(sprintf(file_image),'r');
              fseek(fid1,(before_transition_data_chem+floor((locs_presmin(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_presmax(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectdown(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
              fseek(fid1,(before_transition_data_chem+floor((locs_inflectup(t)*Sts_press-calc_start_time)/Sts))*Pixels*2,'bof');
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
