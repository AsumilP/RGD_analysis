    clear all
    close all
    clc

    data_species = 1; % 1, 2, 3
    laglimp = 10; % to pi/laglimp
    laglimm = -10; % from pi/laglimm

%% PARAMETERS

    if data_species == 1

      ndata1 = 6;
      osc_freq1 = 93.9929; % [Hz]
      data_freq1 = 20; % [kHz]
      flow_rate1 = 400; % [L/min]
      eq_ratio1 = 0.68;

      dir1 = sprintf('E:/pressure/%d/calc/',date);
      % dir1 = sprintf('E:/chem_output/chem_intensity/%d/',date);
      % dir1 = sprintf('E:/piv_output/v_oscillation/');

      datasize = 5000;

    elseif data_species == 2

      ndata1 = 6;
      osc_freq1 = 93.9929; % [Hz]
      data_freq1 = 20; % [kHz]
      flow_rate1 = 400; % [L/min]
      eq_ratio1 = 0.68;

      dir1 = sprintf('E:/pressure/%d/calc/',date);
      % dir1 = sprintf('E:/chem_output/chem_intensity/%d/',date);
      % dir1 = sprintf('E:/piv_output/v_oscillation/');

      ndata2 = 6;
      osc_freq2 = 93.9929; % [Hz]
      data_freq2 = 20; % [kHz]
      flow_rate2 = 400; % [L/min]
      eq_ratio2 = 0.68;

      dir2 = sprintf('E:/pressure/%d/calc/',date);
      % dir2 = sprintf('E:/chem_output/chem_intensity/%d/',date);
      % dir2 = sprintf('E:/piv_output/v_oscillation/');

      datasize = 5000;

    elseif data_species == 3

      ndata1 = 6;
      osc_freq1 = 93.9929; % [Hz]
      data_freq1 = 20; % [kHz]
      flow_rate1 = 400; % [L/min]
      eq_ratio1 = 0.68;

      dir1 = sprintf('E:/pressure/%d/calc/',date);
      % dir1 = sprintf('E:/chem_output/chem_intensity/%d/',date);
      % dir1 = sprintf('E:/piv_output/v_oscillation/');

      ndata2 = 6;
      osc_freq2 = 93.9929; % [Hz]
      data_freq2 = 20; % [kHz]
      flow_rate2 = 400; % [L/min]
      eq_ratio2 = 0.68;

      % dir2 = sprintf('E:/pressure/%d/calc/',date);
      dir2 = sprintf('E:/chem_output/chem_intensity/%d/',date);
      % dir2 = sprintf('E:/piv_output/v_oscillation/');

      ndata3 = 6;
      osc_freq3 = 93.9929; % [Hz]
      data_freq3 = 20; % [kHz]
      flow_rate3 = 400; % [L/min]
      eq_ratio3 = 0.68;

      % dir3 = sprintf('E:/pressure/%d/calc/',date);
      % dir3 = sprintf('E:/chem_output/chem_intensity/%d/',date);
      dir3 = sprintf('E:/piv_output/v_oscillation/');

      datasize = 5000;

    end

%% Matrix

    taxis_pchip = 1:1:datasize;
    lag_av1 = 0;
    lag_av2 = 0;
    lag_av3 = 0;

%% Read and Calc.

    if data_species == 1

      for i = 1:1:ndata1
        fn = sprintf('%d_%.2f_%02u_lag.dat',flow_rate1,eq_ratio1,i);
        fid = fopen(append(dir1,fn),'r');
        lag = fread(fid,datasize,'double');
        fclose(fid);

        lag_av1 = lag_av1 + 2*pi*lag*osc_freq1/(ndata1*data_freq1*1000);
      end

    elseif data_species == 2

      for i = 1:1:ndata1
        fn = sprintf('%d_%.2f_%02u_lag.dat',flow_rate1,eq_ratio1,i);
        fid = fopen(append(dir1,fn),'r');
        lag = fread(fid,datasize,'double');
        fclose(fid);

        lag_av1 = lag_av1 + 2*pi*lag*osc_freq1/(ndata1*data_freq1*1000);
      end

      for i = 1:1:ndata2
        fn = sprintf('%d_%.2f_%02u_lag.dat',flow_rate2,eq_ratio2,i);
        fid = fopen(append(dir2,fn),'r');
        lag = fread(fid,datasize,'double');
        fclose(fid);

        lag_av2 = lag_av2 + 2*pi*lag*osc_freq2/(ndata2*data_freq2*1000);
      end

    elseif data_species == 3

      for i = 1:1:ndata1
        fn = sprintf('%d_%.2f_%02u_lag.dat',flow_rate1,eq_ratio1,i);
        fid = fopen(append(dir1,fn),'r');
        lag = fread(fid,datasize,'double');
        fclose(fid);

        lag_av1 = lag_av1 + 2*pi*lag*osc_freq1/(ndata1*data_freq1*1000);
      end

      for i = 1:1:ndata2
        fn = sprintf('%d_%.2f_%02u_lag.dat',flow_rate2,eq_ratio2,i);
        fid = fopen(append(dir2,fn),'r');
        lag = fread(fid,datasize,'double');
        fclose(fid);

        lag_av2 = lag_av2 + 2*pi*lag*osc_freq2/(ndata2*data_freq2*1000);
      end

      for i = 1:1:ndata3
        fn = sprintf('%d_%.2f_%02u_lag.dat',flow_rate3,eq_ratio3,i);
        fid = fopen(append(dir3,fn),'r');
        lag = fread(fid,datasize,'double');
        fclose(fid);

        lag_av3 = lag_av3 + 2*pi*lag*osc_freq3/(ndata3*data_freq3*1000);
      end

    end

%% FIGURE

    figure('Position', [50 50 960 735],'Color','white');
    plot(taxis_pchip,lag_av1,'vr','MarkerSize',7,'MarkerFaceColor','w','LineWidth',1,'MarkerIndices',1:50:length(lag_av1))
    hold on

    ax = gca;
    xticks([0 datasize*1/4 datasize*2/4 datasize*3/4 datasize])
    set(gca,'xTickLabel',char('0.0','T/4','T/2','3T/4','T'),'FontName','Times New Roman','FontSize',40)
    yticks([-pi -9*pi/10 -8*pi/10 -7*pi/10 -6*pi/10 -5*pi/10 -4*pi/10 -3*pi/10 -2*pi/10 -pi/10 0 ...
             pi/10 2*pi/10 3*pi/10 4*pi/10 5*pi/10 6*pi/10 7*pi/10 8*pi/10 9*pi/10 pi])
    set(gca,'YTickLabel',char('-\pi','-9\pi/10','-8\pi/10','-7\pi/10','-6\pi/10','-5\pi/10','-4\pi/10','-3\pi/10',...
                              '-2\pi/10','-\pi/10','0','\pi/10','2\pi/10','3\pi/10','4\pi/10','5\pi/10','6\pi/10',...
                              '7\pi/10','8\pi/10','9\pi/10','\pi'))
    ax.XColor = 'k';
    ax.YColor = 'k';
    ax.FontSize = 25;
    ax.FontName = 'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XLim = [0 datasize];
    ax.YLim = [pi/laglimm pi/laglimp];

    xlabel('\it \fontname{Times New Roman} t \rm[s]')
    ylabel('\it \fontname{Times New Roman} \tau')
    set(gca,'FontName','Times New Roman','FontSize',40)
    hold on

    if data_species == 2

      plot(taxis_pchip,lag_av2,'^b','MarkerSize',7,'MarkerFaceColor','w','LineWidth',1,'MarkerIndices',1:50:length(lag_450av))
      hold on

    elseif data_species == 3

      plot(taxis_pchip,lag_av2,'^b','MarkerSize',7,'MarkerFaceColor','w','LineWidth',1,'MarkerIndices',1:50:length(lag_450av))
      hold on

      plot(taxis_pchip,lag_av3,'sk','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1,'MarkerIndices',1:50:length(lag_500av))
      hold on

      end
    end

    legend('FontSize',23)
    hold off
    pbaspect([sqrt(2) 1 1]);
