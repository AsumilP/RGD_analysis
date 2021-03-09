function phase_vis(taxis,p_fil,calc_start_time,calc_fin_time,locs_presmax,pks_pres,locs_inflectdown,locs_presmin,locs_inflectup)

  fig = figure;
  fig.Color='white';
  fig.Position=[50 50 960 735];

  plot(taxis,p_fil,'k')
  ax = gca;
  ax.YColor = 'k';

  xtickformat('%.2f')
  xticks([calc_start_time-0.4 calc_start_time-0.2 calc_start_time calc_start_time+0.2 calc_start_time+0.4 calc_start_time+0.6 calc_start_time+0.8 calc_start_time+1.0])
  set(gca,'xTickLabel', char('-0.4','-0.2','0.0','0.2','0.4','0.6','0.8','1.0'))
  ytickformat('%.3f')
  yticks([-0.40 -0.20 0 0.20 0.40])
  set(gca,'YTickLabel', char('-0.40','-0.20','0.00','0.20','0.40'))

  xlim([calc_start_time-0.4 calc_fin_time+0.4]);
  ylim([-0.40 0.40]);

  ax.Box = 'on';
  ax.LineWidth = 2.0;
  ax.XMinorTick = 'on';
  ax.YMinorTick = 'on';

  xlabel('\it \fontname{Times New Roman} t \rm[sec]')
  ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
  set(gca,'FontName','Times New Roman','FontSize',20)
  hold on

  plot([calc_start_time calc_start_time],[-0.50 0.50],'m--','LineWidth',1.5)
  hold on

  plot([calc_fin_time calc_fin_time],[-0.50 0.50],'m--','LineWidth',1.5)
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

end
