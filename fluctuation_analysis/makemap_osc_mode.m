    clear all
    close all
    clc

%% PARAMETERS

    figex = '.fig'; % fig, png

%% Read

    dir = sprintf('G:/Analysis/pressure/PS_mode_calc/');
    rfn = sprintf('PS_sensor_power.xlsx');
    ofn1 = sprintf('PS_mode_plot_61-85');
    ofn2 = sprintf('PS_mode_plot_143-232');
    ofn3 = sprintf('ppr_mode_plot_61-85');
    ofn4 = sprintf('ppr_mode_plot_143-232');
    
    sensor_pos = xlsread(append(dir,rfn),'A2:A136');
    spk_freq = xlsread(append(dir,rfn),'B2:B136');
    PS_power = xlsread(append(dir,rfn),'C2:C136');
    ppr = xlsread(append(dir,rfn),'D2:D136');
    
%% Interpolation

    for j = 1:1:9
        PS_power61(j) = PS_power((j-1)*15+1)/30;
        PS_power68(j) = PS_power((j-1)*15+2)/30;
        PS_power70(j) = PS_power((j-1)*15+3)/30;
        PS_power73(j) = PS_power((j-1)*15+4)/30;
        PS_power80(j) = PS_power((j-1)*15+5)/30;
        PS_power85(j) = PS_power((j-1)*15+6)/30;
        PS_power143(j) = PS_power((j-1)*15+7)/30;
        PS_power147(j) = PS_power((j-1)*15+8)/30;
        PS_power149(j) = PS_power((j-1)*15+9)/30;
        PS_power155(j) = PS_power((j-1)*15+10)/30;
        PS_power171(j) = PS_power((j-1)*15+11)/30;
        PS_power188(j) = PS_power((j-1)*15+12)/30;
        PS_power194(j) = PS_power((j-1)*15+13)/30;
        PS_power203(j) = PS_power((j-1)*15+14)/30;
        PS_power232(j) = PS_power((j-1)*15+15)/30;
        
        ppr61(j) = ppr((j-1)*15+1)/2;
        ppr68(j) = ppr((j-1)*15+2)/2;
        ppr70(j) = ppr((j-1)*15+3)/2;
        ppr73(j) = ppr((j-1)*15+4)/2;
        ppr80(j) = ppr((j-1)*15+5)/2;
        ppr85(j) = ppr((j-1)*15+6)/2;
        ppr143(j) = ppr((j-1)*15+7)/2;
        ppr147(j) = ppr((j-1)*15+8)/2;
        ppr149(j) = ppr((j-1)*15+9)/2;
        ppr155(j) = ppr((j-1)*15+10)/2;
        ppr171(j) = ppr((j-1)*15+11)/2;
        ppr188(j) = ppr((j-1)*15+12)/2;
        ppr194(j) = ppr((j-1)*15+13)/2;
        ppr203(j) = ppr((j-1)*15+14)/2;
        ppr232(j) = ppr((j-1)*15+15)/2;
        
        sensor_plot_pos(j) = sensor_pos((j-1)*15+1);
    end
 
%% Plot, Figure1
    
   figure('Position', [50 50 960 735],'Color','white');
   plot(sensor_plot_pos,PS_power61,'-vr','MarkerSize',8,'MarkerFaceColor','r','MarkerIndices',1:1:length(PS_power61))

    ax = gca;
    xtickformat('%d')
    ytickformat('%d')
    
    ax.XAxisLocation = 'bottom';
    ax.YDir='normal';
    ax.YAxisLocation = 'left';
    ax.XColor = 'black';
    ax.YColor = 'black';
%     ax.XScale = 'log';
%     ax.YScale = 'log';

    ax.FontSize = 20;
    ax.FontName = 'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XLim = [0 1185];
    ax.YLim = [1 160];
   
     xlabel('\rm \fontname{Times New Roman} Sensor height [mm]')
     ylabel('\it \fontname{Times New Roman} P \rm[kPa]')
     set(gca,'FontName','Times New Roman','FontSize',20)
     hold on
     
     plot(sensor_plot_pos,PS_power68,'-sb','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:1:length(PS_power68))
     hold on
     plot(sensor_plot_pos,PS_power70,'-dk','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(PS_power70))
     hold on
     plot(sensor_plot_pos,PS_power73,'-pg','MarkerSize',8,'MarkerFaceColor','g','MarkerIndices',1:1:length(PS_power73))
     hold on
     plot(sensor_plot_pos,PS_power80,'-xc','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(PS_power80))
     hold on
     plot(sensor_plot_pos,PS_power85,'-om','MarkerSize',8,'MarkerFaceColor','m','MarkerIndices',1:1:length(PS_power85))
     legend('61Hz','68Hz','70Hz','73Hz','80Hz','85Hz','FontSize',20,'Location','northwest')
     hold off
     
     pbaspect([sqrt(2) 1 1]);
     saveas(gcf,strcat(dir,ofn1,figex));

%% Plot, Figure2
    
   figure('Position', [50 50 960 735],'Color','white');
   plot(sensor_plot_pos,PS_power143,'-vr','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(PS_power143))

    ax = gca;
    xtickformat('%d')
    ytickformat('%d')
    
    ax.XAxisLocation = 'bottom';
    ax.YDir='normal';
    ax.YAxisLocation = 'left';
    ax.XColor = 'black';
    ax.YColor = 'black';
    % ax.XScale = 'log';
%     ax.YScale = 'log';

    ax.FontSize = 20;
    ax.FontName = 'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XLim = [0 1185];
    ax.YLim = [1 160];
   
     xlabel('\rm \fontname{Times New Roman} Sensor height [mm]')
     ylabel('\it \fontname{Times New Roman} P \rm[kPa]')
     set(gca,'FontName','Times New Roman','FontSize',20)
     hold on
     
     plot(sensor_plot_pos,PS_power147,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(PS_power147))
     hold on
     plot(sensor_plot_pos,PS_power149,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(PS_power149))
     hold on
     plot(sensor_plot_pos,PS_power155,'-pg','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(PS_power155))
     hold on
     plot(sensor_plot_pos,PS_power171,'-xc','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(PS_power171))
     hold on
     plot(sensor_plot_pos,PS_power188,'-vr','MarkerSize',8,'MarkerFaceColor','r','MarkerIndices',1:1:length(PS_power188))
     hold on
     plot(sensor_plot_pos,PS_power194,'-sb','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:1:length(PS_power194))
     hold on
     plot(sensor_plot_pos,PS_power203,'-dk','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(PS_power203))
     hold on
     plot(sensor_plot_pos,PS_power232,'-pg','MarkerSize',8,'MarkerFaceColor','g','MarkerIndices',1:1:length(PS_power232))
     legend('143Hz','147Hz','149Hz','155Hz','171Hz','188Hz','194Hz','203Hz','232Hz','FontSize',20,'Location','northwest')
     hold off

     pbaspect([sqrt(2) 1 1]);
     saveas(gcf,strcat(dir,ofn2,figex));
     
%% Plot, Figure3
    
   figure('Position', [50 50 960 735],'Color','white');
   plot(sensor_plot_pos,ppr61,'-vr','MarkerSize',8,'MarkerFaceColor','r','MarkerIndices',1:1:length(ppr61))

    ax = gca;
    xtickformat('%d')
    ytickformat('%.2f')
    
    ax.XAxisLocation = 'bottom';
    ax.YDir='normal';
    ax.YAxisLocation = 'left';
    ax.XColor = 'black';
    ax.YColor = 'black';
%     ax.XScale = 'log';
%     ax.YScale = 'log';

    ax.FontSize = 20;
    ax.FontName = 'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XLim = [0 1185];
    ax.YLim = [0 0.15];
   
     xlabel('\rm \fontname{Times New Roman} Sensor height [mm]')
     ylabel('\it \fontname{Times New Roman} p''_{rms} \rm[kPa]')
     set(gca,'FontName','Times New Roman','FontSize',20)
     hold on
     
     plot(sensor_plot_pos,ppr68,'-sb','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:1:length(ppr68))
     hold on
     plot(sensor_plot_pos,ppr70,'-dk','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(ppr70))
     hold on
     plot(sensor_plot_pos,ppr73,'-pg','MarkerSize',8,'MarkerFaceColor','g','MarkerIndices',1:1:length(ppr73))
     hold on
     plot(sensor_plot_pos,ppr80,'-xc','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(ppr80))
     hold on
     plot(sensor_plot_pos,ppr85,'-om','MarkerSize',8,'MarkerFaceColor','m','MarkerIndices',1:1:length(ppr85))
     legend('61Hz','68Hz','70Hz','73Hz','80Hz','85Hz','FontSize',20,'Location','northwest')
     hold off
     
     pbaspect([sqrt(2) 1 1]);
     saveas(gcf,strcat(dir,ofn3,figex));

%% Plot, Figure4
    
   figure('Position', [50 50 960 735],'Color','white');
   plot(sensor_plot_pos,ppr143,'-vr','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(ppr143))

    ax = gca;
    xtickformat('%d')
    ytickformat('%.2f')
    
    ax.XAxisLocation = 'bottom';
    ax.YDir='normal';
    ax.YAxisLocation = 'left';
    ax.XColor = 'black';
    ax.YColor = 'black';
    % ax.XScale = 'log';
%     ax.YScale = 'log';

    ax.FontSize = 20;
    ax.FontName = 'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XLim = [0 1185];
    ax.YLim = [0 0.15];
   
     xlabel('\rm \fontname{Times New Roman} Sensor height [mm]')
     ylabel('\it \fontname{Times New Roman} p''_{rms} \rm[kPa]')
     set(gca,'FontName','Times New Roman','FontSize',20)
     hold on
     
     plot(sensor_plot_pos,ppr147,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(ppr147))
     hold on
     plot(sensor_plot_pos,ppr149,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(ppr149))
     hold on
     plot(sensor_plot_pos,ppr155,'-pg','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(ppr155))
     hold on
     plot(sensor_plot_pos,ppr171,'-xc','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(ppr171))
     hold on
     plot(sensor_plot_pos,ppr188,'-vr','MarkerSize',8,'MarkerFaceColor','r','MarkerIndices',1:1:length(ppr188))
     hold on
     plot(sensor_plot_pos,ppr194,'-sb','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:1:length(ppr194))
     hold on
     plot(sensor_plot_pos,ppr203,'-dk','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(ppr203))
     hold on
     plot(sensor_plot_pos,ppr232,'-pg','MarkerSize',8,'MarkerFaceColor','g','MarkerIndices',1:1:length(ppr232))
     legend('143Hz','147Hz','149Hz','155Hz','171Hz','188Hz','194Hz','203Hz','232Hz','FontSize',20,'Location','northwest')
     hold off

     pbaspect([sqrt(2) 1 1]);
     saveas(gcf,strcat(dir,ofn4,figex));