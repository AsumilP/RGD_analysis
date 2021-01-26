    clear all
    close all
    clc

%% PARAMETERS

     n400 = 6;
     n450 = 11;
     n500 = 6;
     datasize = 5000;
     osc_freq = 93.9929; % [Hz] averaged of 3 conditions

     scrsz=get(groot,'ScreenSize');
     taxis_pchip=1:1:datasize;
     

%% READ and AVERAGE

% 400
     lag_400av=0;
     for i=1:1:n400
        formatspec = 'v_osclr_400_%d_lag.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        lag_400 = fread(fid,datasize,'double');
        fclose(fid);

        lag_400av = lag_400av + lag_400/n400;
     end

% 450
     lag_450av=0;
     for i=1:1:n450
        formatspec = 'v_osclr_450_%d_lag.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        lag_450 = fread(fid,datasize,'double');
        fclose(fid);

        lag_450av = lag_450av + lag_450/n450;
     end

% 500
     lag_500av=0;
     for i=1:1:n500
        formatspec = 'v_osclr_500_%d_lag.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        lag_500 = fread(fid,datasize,'double');
        fclose(fid);

        lag_500av = lag_500av + lag_500/n500;
     end

%% MAKE FIGURE

      figure('Position', [50 50 960 735],'Color','white');
      plot(taxis_pchip, lag_400av,'vr','MarkerSize',7,'MarkerFaceColor','w','LineWidth',1,'MarkerIndices',1:50:length(lag_400av))
      hold on;

      ax = gca;
      ax.YColor = 'k';
      xticks([0 datasize*1/4 datasize*2/4 datasize*3/4 datasize])
      set(gca,'xTickLabel', char('0.0','T/4','T/2','3T/4','T'),'FontName','Times New Roman','FontSize',40)
      ytickformat('%.3f')
      yticks([-2000/osc_freq -1000/osc_freq 0 1000/osc_freq 2000/osc_freq])
      set(gca,'YTickLabel', char('-\pi/5','-\pi/10','0.00','\pi/10','\pi/5'))
      
      ax.Box = 'on';
      ax.LineWidth = 2.0;
      ax.XMinorTick = 'on';
      ax.YMinorTick = 'on';

      xlim([0 datasize]);
      ylim([-2000/osc_freq 2000/osc_freq]);

      xlabel('\it \fontname{Times New Roman} t \rm[s]')
      ylabel('\it \fontname{Times New Roman} \tau')
      set(gca,'FontName','Times New Roman','FontSize',40)
      hold on
      
      plot(taxis_pchip, lag_450av,'^b','MarkerSize',7,'MarkerFaceColor','w','LineWidth',1,'MarkerIndices',1:50:length(lag_450av))
      hold on;
      
      plot(taxis_pchip, lag_500av,'sk','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1,'MarkerIndices',1:50:length(lag_500av))
      hold on;
      
      legend('400 [L/min]','450 [L/min]','500 [L/min]','FontSize',23)
      
      hold off;
      pbaspect([sqrt(2) 1 1]);
