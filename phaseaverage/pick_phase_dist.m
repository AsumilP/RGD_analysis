function [dudx, dudy] = pick_phase_dist(dir_i,fn_i,fn_av,locs,phase,cam_start_data,...
                        before_transition_data,before_transition_data_calc,calc_start_time,...
                        calc_data,Sts_press,Sts,nx,ny,cnt_st1,cnt_st2,cnt_st3,cnt_st4,cnt_st5,...
                        ,cnt_st6,cnt_st7,cnt_st8,cnt_st9,cnt_st10)

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

  for t=1:length(locs)
    if (locs(t)-cam_start_data >before_transition_data) && (locs(t)-cam_start_data <= before_transition_data+calc_data)

      fid = fopen(strcat(dir_i,fn_i),'r');
      skip_frames(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))+1,nx*ny,2,1);
      I=(fread(fid,nx*ny,'uint16'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      fclose(fid);

      nn1=nn1+1;
      meantemp1(:,:) = meantemp1(:,:) + image(:,:);

%save,figvis

    elseif (locs(t)-cam_start_data >before_transition_data+calc_data) && (locs(t)-cam_start_data <= before_transition_data+2*calc_data)

      fid = fopen(strcat(dir_i,fn_i),'r');
      skip_frames(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))+1,nx*ny,2,1);
      fseek(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))*nx*ny*2,'bof');
      I=(fread(fid,nx*ny,'uint16'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      fclose(fid);

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

      elseif (locs(t)-cam_start_data >before_transition_data+2*calc_data) && (locs(t)-cam_start_data <= before_transition_data+3*calc_data)

          fid = fopen(sprintf(file_image),'r');
          fseek(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))*nx*ny*2,'bof');
          I=(fread(fid,nx*ny,'uint16'));
          image=permute(reshape(I,[nx,ny]),[2 1]);
          fclose(fid);

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

      elseif (locs(t)-cam_start_data >before_transition_data+3*calc_data) && (locs(t)-cam_start_data <= before_transition_data+4*calc_data)

          fid = fopen(sprintf(file_image),'r');
          fseek(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))*nx*ny*2,'bof');
          I=(fread(fid,nx*ny,'uint16'));
          image=permute(reshape(I,[nx,ny]),[2 1]);
          fclose(fid);

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

      elseif (locs(t)-cam_start_data >before_transition_data+4*calc_data) && (locs(t)-cam_start_data <= before_transition_data+5*calc_data)

          fid = fopen(sprintf(file_image),'r');
          fseek(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))*nx*ny*2,'bof');
          I=(fread(fid,nx*ny,'uint16'));
          image=permute(reshape(I,[nx,ny]),[2 1]);
          fclose(fid);

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

      elseif (locs(t)-cam_start_data >before_transition_data+5*calc_data) && (locs(t)-cam_start_data <= before_transition_data+6*calc_data)

          fid = fopen(sprintf(file_image),'r');
          fseek(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))*nx*ny*2,'bof');
          I=(fread(fid,nx*ny,'uint16'));
          image=permute(reshape(I,[nx,ny]),[2 1]);
          fclose(fid);

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

      elseif (locs(t)-cam_start_data >before_transition_data+6*calc_data) && (locs(t)-cam_start_data <= before_transition_data+7*calc_data)

          fid = fopen(sprintf(file_image),'r');
          fseek(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))*nx*ny*2,'bof');
          I=(fread(fid,nx*ny,'uint16'));
          image=permute(reshape(I,[nx,ny]),[2 1]);
          fclose(fid);

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

      elseif (locs(t)-cam_start_data >before_transition_data+7*calc_data) && (locs(t)-cam_start_data <= before_transition_data+8*calc_data)

          fid = fopen(sprintf(file_image),'r');
          fseek(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))*nx*ny*2,'bof');
          I=(fread(fid,nx*ny,'uint16'));
          image=permute(reshape(I,[nx,ny]),[2 1]);
          fclose(fid);

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

      elseif (locs(t)-cam_start_data >before_transition_data+8*calc_data) && (locs(t)-cam_start_data <= before_transition_data+9*calc_data)

          fid = fopen(sprintf(file_image),'r');
          fseek(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))*nx*ny*2,'bof');
          I=(fread(fid,nx*ny,'uint16'));
          image=permute(reshape(I,[nx,ny]),[2 1]);
          fclose(fid);

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

      elseif (locs(t)-cam_start_data >before_transition_data+9*calc_data) && (locs(t)-cam_start_data <= before_transition_data+10*calc_data)

          fid = fopen(sprintf(file_image),'r');
          fseek(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))*nx*ny*2,'bof');
          I=(fread(fid,nx*ny,'uint16'));
          image=permute(reshape(I,[nx,ny]),[2 1]);
          fclose(fid);

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











end
