function chem_vis(I,nx,ny,origin_x,origin_y,origin_height,dx,dy,...
                              visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)

  % pos1 = [0.10 0.37 0.83 0.60]; % left bottom width height
  % pos2 = [0.135 0.12 0.70 0.12]; % left bottom width height
  origin_height_px=origin_height/dy; %[px]
  xmin=-origin_x*dx; %[mm]
  ymax=origin_height+origin_y*dy; %[mm]
  wx=zeros(2,1);
  wy=zeros(2,1);
  N = [nx ny];
  
  for i=1:2*origin_x+1
      x(i,:)= xmin+dx*(i-1);
  end
  for i=1:origin_y+origin_height_px+1
      y(i,:)=ymax-dy*(i-1);
  end

  y=sort(y);
  xmax=max(x);
  ymin=min(y);
  wx(1,1)=xmin;
  wx(2,1)=xmax;
  wy(1,1)=ymin;
  wy(2,1)=ymax;

  l_nx = visx_end-visx_start;
  l_ny = visy_end-visy_start;

  %% Prepare for chem dis.
  I = permute(reshape(I,N),[2 1]);
  I_vis= I(1:origin_height_px+origin_y,1:2*origin_x);

  %% Streamline plot
  % h1 = subplot('Position',pos1);
  ax=gca;
  IMAGE = imagesc(wx,wy,I_vis(:,:),[col_min col_max]);
  % load('MyColormap_for_w','mymap')
  % colormap(ax,mymap)
  colormap(ax,vis)
  
  xtickformat('%.f')
  xticks([-60 -40 -20 0 20 40 60])
  set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
  ytickformat('%.f')
  yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
  set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))
  yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
  set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

  c=colorbar;
%   c.Ticks=[0 5 10 15 20];
%   c.TickLabels={'0.0','5.0','10','15','20'};
  c.TickLabelInterpreter='latex';
  c.Label.FontSize = 25;
  c.Label.String = '\it \fontname{Times New Roman}';
  c.Location = 'eastoutside';
  c.AxisLocation='out';
  xlabel('\it \fontname{Times New Roman} x \rm[mm]')
  ylabel('\it \fontname{Times New Roman} y \rm[mm]')
  set(gca,'FontName','Times New Roman','FontSize',25)

  xlim([visx_start visx_end])
  ylim([ymax-visy_end ymax-visy_start])
  pbaspect([l_nx/l_ny 1 1]);

end
