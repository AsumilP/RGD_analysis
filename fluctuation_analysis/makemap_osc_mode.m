    clear all
    close all
    clc

%% PARAMETERS

    interpolation = 2; % 1.spline, 2.hermite
    figex = '.png'; % fig, png

%% Read

    dir = sprintf('G:/Analysis/pressure/PS_mode_calc/');
    rfn = sprintf('PS_sensor_power.xlsx');
    
    sensor_pos = xlsread(append(dir,rfn),'A2:A136');
    spk_freq = xlsread(append(dir,rfn),'B2:B136');
    PS_power = xlsread(append(dir,rfn),'C2:C136');
    
%% Interpolation

    for j = 1:1:9
        PS_power61(j) = PS_power((j-1)*15+1);
        PS_power68(j) = PS_power((j-1)*15+2);
        PS_power70(j) = PS_power((j-1)*15+3);
        PS_power73(j) = PS_power((j-1)*15+4);
        PS_power80(j) = PS_power((j-1)*15+5);
        PS_power85(j) = PS_power((j-1)*15+6);
        PS_power143(j) = PS_power((j-1)*15+7);
        PS_power147(j) = PS_power((j-1)*15+8);
        PS_power149(j) = PS_power((j-1)*15+9);
        PS_power155(j) = PS_power((j-1)*15+10);
        PS_power171(j) = PS_power((j-1)*15+11);
        PS_power188(j) = PS_power((j-1)*15+12);
        PS_power194(j) = PS_power((j-1)*15+13);
        PS_power203(j) = PS_power((j-1)*15+14);
        PS_power232(j) = PS_power((j-1)*15+15);
        sensor_plot_pos(j) = sensor_pos((j-1)*15+1);
    end


%     der = (er_max-er_min)/(er_interp_num-1);
%     dfr = (fr_max-fr_min)/(fr_interp_num-1);
%     er_interp = er_min:der:er_max;
%     fr_interp = fr_min:dfr:fr_max;
%     
%     T_interp_temp = zeros(length(fr),length(er_interp));
%     T_interp_plot = zeros(length(fr_interp),length(er_interp));
%     
%     if interpolation == 1
%         for i = 1:1:length(fr)
%             T_interp_temp(i,:) = spline(er,T(i,:),er_interp);
%         end
%         for j = 1:1:length(er_interp)
%             T_interp_plot(:,j) = spline(fr,T_interp_temp(:,j),fr_interp);
%         end
%         
%     elseif interpolation == 2
%         for i = 1:1:length(fr)
%             T_interp_temp(i,:) = pchip(er,T(i,:),er_interp);
%         end
%         for j = 1:1:length(er_interp)
%             T_interp_plot(:,j) = pchip(fr,T_interp_temp(:,j),fr_interp);
%         end
%     end
% 
%% Plot, Figure
    
   figure('Position', [50 50 960 735],'Color','white');
   plot(sensor_plot_pos,PS_power61)

    ax = gca;
    xtickformat('%d')
    ytickformat('%.d')
    
    ax.XAxisLocation = 'bottom';
    ax.YDir='normal';
    ax.YAxisLocation = 'left';
    ax.XColor = 'black';
    ax.YColor = 'black';
    % ax.XScale = 'log';
    ax.YScale = 'log';

    ax.FontSize = 20;
    ax.FontName = 'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XLim = [0 1185];
    ax.YLim = [10 4000];
   
     xlabel('\rm \fontname{Times New Roman} Seneor position [mm]')
     ylabel('\it \fontname{Times New Roman} P \rm[kPa]')
     set(gca,'FontName','Times New Roman','FontSize',20)
     hold on
     pause;
     
     plot(sensor_plot_pos,PS_power68)
     hold on
     pause;
     plot(sensor_plot_pos,PS_power70)
     hold on
     pause;
     plot(sensor_plot_pos,PS_power73)
     hold on
     pause;
     plot(sensor_plot_pos,PS_power80)
     hold on
     pause;
     plot(sensor_plot_pos,PS_power85)
     hold on
     pause;
     plot(sensor_plot_pos,PS_power143)
     hold on
     pause;
     plot(sensor_plot_pos,PS_power147)
     hold on
     pause;
     plot(sensor_plot_pos,PS_power149)
     hold on
     pause;
     plot(sensor_plot_pos,PS_power155)
     hold on
     pause;
     plot(sensor_plot_pos,PS_power171)
     hold on
     pause;
     plot(sensor_plot_pos,PS_power188)
     hold on
     pause;
     plot(sensor_plot_pos,PS_power194)
     hold on
     pause;
     plot(sensor_plot_pos,PS_power203)
     hold on
     pause;
     plot(sensor_plot_pos,PS_power232)
     hold off

     pbaspect([sqrt(2) 1 1]);
%      saveas(gcf,strcat(dir,ofn,figex));