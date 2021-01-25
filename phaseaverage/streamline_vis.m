function streamline_vis(u,v,w,nx,ny,nx_start,nx_end,ny_start,ny_end,...
                        dx,dy,spmin,spmax)

  % pos1 = [0.10 0.37 0.83 0.60]; % left bottom width height
  % pos2 = [0.135 0.12 0.70 0.12]; % left bottom width height
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

  for i = 1:nx_calc
    x(i,:) = xmin + dx  * (i-1);
  end
  for i = 1:ny_calc
    y(i,:) = ymin + dy * (i-1);
  end

  [sx,sy]=meshgrid(x,y);

  wx(1,1) = xmin;
  wx(2,1) = xmax;
  wy(1,1) = ymin;
  wy(2,1) = ymax;

  %% Prepare for streamlines on dis. of its strength
  u = permute(reshape(u,N),[2 1]);
  v = permute(reshape(v,N),[2 1]);
  w = permute(reshape(w,N),[2 1]);
  u_vis = u(ny_start:ny_end,nx_start:nx_end);
  v_vis = v(ny_start:ny_end,nx_start:nx_end);
  w_vis = w(ny_start:ny_end,nx_start:nx_end);
  speed = sqrt(u.^2+v.^2+w.^2);

  %% Streamline plot
  % h1 = subplot('Position',pos1);
  ax=gca;
  IMAGE = imagesc(wx,wy,speed(:,:),[spmin spmax]);
  % load('MyColormap_for_w','mymap')
  % colormap(ax,mymap)
  colormap(ax,jet)
  pbaspect([l_nx/l_ny 1 1]);
  xtickformat('%.f')
  xticks([-60 -40 -20 0 20 40 60])
  set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
  ytickformat('%.f')
  yticks([ymax-58.6 ymax-48.6 ymax-38.6 ymax-28.6 ...
          ymax-18.6 ymax-8.6 ymax])
  set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
  c=colorbar;
  c.Ticks=[0 5 10 15 20];
  c.TickLabels={'0.0','5.0','10','15','20'};
  c.TickLabelInterpreter='latex';
  c.Label.FontSize = 25;
  c.Label.String = '\it \fontname{Times New Roman} \rm[m/s]';
  c.Location = 'eastoutside';
  c.AxisLocation='out';
  xlabel('\it \fontname{Times New Roman} x \rm[mm]')
  ylabel('\it \fontname{Times New Roman} y \rm[mm]')
  set(gca,'FontName','Times New Roman','FontSize',25)
  hold on

  hlines=streamslice(sx,sy,u,v,3,'arrows');
  set(hlines,'Color','w','LineWidth',3)

  % xlim([xmin xmax])
  xlim([-60 60])
  ylim([ymin ymax])
  hold off

end
