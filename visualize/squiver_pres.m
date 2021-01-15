function squiver_pres(u,v,w,nx,ny,nx_start,nx_end,ny_start,ny_end,nincrement,...
                      dx,dy,wmin,wmax,quivermode,idx,skip_frame,...
                      nz,pres_samp_time,Fs_spiv,Fs_press,p,first_frame,...
                      trans_start_time,trans_fin_time,trig_time)

  pos1 = [0.10 0.37 0.83 0.60]; % left bottom width height
  pos2 = [0.135 0.12 0.70 0.12]; % left bottom width height
  N = [nx ny];
  % wx = zeros(2,1);
  % wy = zeros(2,1);
  nx_calc = nx_end - nx_start + 1;
  ny_calc = ny_end - ny_start + 1;
  xmin_all = - (0.5 * (nx-1)) * dx - 0.5 * dx;
  xmax_all = 0.5 * (nx-1) * dx + 0.5 * dx;
  xmin = xmin_all + (nx_start-1) * dx;
  xmax = xmax_all - (nx - nx_end) * dx;
%   ymin_all = dy;
%   ymax_all = dy * ny;
  ymin = (ny-ny_end+1) * dy;
  ymax = (ny-ny_start+1) * dy;
  l_nx = dx * nx_calc;
  l_ny = dy * ny_calc;

  tall = 1/Fs_press:1/Fs_press:pres_samp_time;
  cam_start_time = trig_time - (1/Fs_spiv) * nz
  spiv_vis_start_time = cam_start_time + (first_frame -1) * (1/Fs_spiv);
  for i = 1:floor(nx_calc/nincrement)
    x(i,:) = xmin + dx * nincrement * (i-1);
  end
  for i = 1:floor(ny_calc/nincrement)
    y(i,:) = ymin + dy * nincrement * (i-1);
  end
  wx(1,1) = xmin;
  wx(2,1) = xmax;
  wy(1,1) = ymin;
  wy(2,1) = ymax;

  %% Prepare for quiver
  u = permute(reshape(u,N),[2 1]);
  v = permute(reshape(v,N),[2 1]);
  w = permute(reshape(w,N),[2 1]);
  u_vis = u(ny_start:ny_end,nx_start:nx_end);
  v_vis = v(ny_start:ny_end,nx_start:nx_end);
  w_vis = w(ny_start:ny_end,nx_start:nx_end);

  for j=1:floor(nx_calc/nincrement)
      for i=1:floor(ny_calc/nincrement)
         uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
         vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
      end
  end

  %% Quiver plot
  h1 = subplot('Position',pos1);
  ax=gca;
  IMAGE = imagesc(wx,wy,w_vis(:,:),[wmin wmax]);
  load('MyColormap_for_w','mymap')
  colormap(ax,mymap)
  pbaspect([l_nx/l_ny 1 1]);
  xtickformat('%.f')
  % xticks([-60 -40 -20 0 20 40 60])
  % set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
  ytickformat('%.f')
  yticks([ymin+(ymax-70) ymin+(ymax-60) ymin+(ymax-50) ymin+(ymax-40) ...
          ymin+(ymax-30) ymin+(ymax-20) ymin+(ymax-10) ymin+ymax])
  set(gca,'YTickLabel', char('70','60','50','40','30','20','10','0'))
  c=colorbar;
  % c.Ticks=[-10 -5.0 0 5.0 10];
  % c.TickLabels={'-10','-5.0','0.0','5.0','10'};
  c.TickLabelInterpreter='latex';
  c.Label.FontSize = 25;
  c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
  c.Location = 'eastoutside';
  c.AxisLocation='out';
  xlabel('\it \fontname{Times New Roman} x \rm[mm]')
  ylabel('\it \fontname{Times New Roman} y \rm[mm]')
  set(gca,'FontName','Times New Roman','FontSize',25)
  hold on

  if quivermode == 1
    ncquiverref(x,y,uplot(:,:),vplot(:,:),'[m/s]','median','true','k','0');
  elseif quivermode == 2
    quiver(x,y,uplot(:,:),vplot(:,:),0,'Color',[0.2,0.2,0.2]);
  end
  % xlim([xmin xmax])
  xlim([-60 60])
  ylim([ymin ymax])
  hold off

  %% Pressure plot
  subplot('Position',pos2)
  plot(tall,p,'k')
  ax = gca;
  % ytickformat('%.2f')
  xticks([trans_start_time-0.2 trans_start_time trans_start_time+0.2 trans_start_time+0.4 trans_start_time+0.6])
  set(gca,'xTickLabel', char('-0.2','0.0','0.2','0.4','0.6'))
  % ytickformat('%.3f')
  yticks([-0.50 0 0.50])
  set(gca,'YTickLabel', char('-0.50','0.00','0.50'))
  xlim([trans_start_time-0.2 trans_start_time+0.6]);
  ylim([-0.50 0.50]);
  xlabel('\it \fontname{Times New Roman} t \rm[sec]')
  ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
  set(gca,'FontName','Times New Roman','FontSize',25)
  hold on

  plot([trans_start_time trans_start_time],[-0.50 0.50],'m--','LineWidth',2.0)
  hold on

  plot([trans_fin_time trans_fin_time],[-0.50 0.50],'m--','LineWidth',2.0)
  hold on

  plot([spiv_vis_start_time+(1/Fs_spiv)*(idx-1)*(skip_frame+1) spiv_vis_start_time+(1/Fs_spiv)*(idx-1)*(skip_frame+1)],[-0.50 0.50],'b-','LineWidth',2.0)
  hold off
end
