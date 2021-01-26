    clc
    clear all
    close all

%% Parameters 

    savedirectory='C:/Users/atagi/Desktop/modified/circulation_calc/';

%% Reading

    circ400_zn1_av=xlsread('omega_circulation_trans.xlsx','average','C27:L27');
    circ400_zn2_av=xlsread('omega_circulation_trans.xlsx','average','C28:L28');
    circ400_zn3_av=xlsread('omega_circulation_trans.xlsx','average','C29:L29');
    circ400_zn4_av=xlsread('omega_circulation_trans.xlsx','average','C30:L30');
    circ450_zn1_av=xlsread('omega_circulation_trans.xlsx','average','C81:L81');
    circ450_zn2_av=xlsread('omega_circulation_trans.xlsx','average','C82:L82');
    circ450_zn3_av=xlsread('omega_circulation_trans.xlsx','average','C83:L83');
    circ450_zn4_av=xlsread('omega_circulation_trans.xlsx','average','C84:L84');
    circ500_zn1_av=xlsread('omega_circulation_trans.xlsx','average','C111:L111');
    circ500_zn2_av=xlsread('omega_circulation_trans.xlsx','average','C112:L112');
    circ500_zn3_av=xlsread('omega_circulation_trans.xlsx','average','C113:L113');
    circ500_zn4_av=xlsread('omega_circulation_trans.xlsx','average','C114:L114');
    
    circ400_zn1_rms=xlsread('omega_circulation_trans.xlsx','rms','C27:L27');
    circ400_zn2_rms=xlsread('omega_circulation_trans.xlsx','rms','C28:L28');
    circ400_zn3_rms=xlsread('omega_circulation_trans.xlsx','rms','C29:L29');
    circ400_zn4_rms=xlsread('omega_circulation_trans.xlsx','rms','C30:L30');
    circ450_zn1_rms=xlsread('omega_circulation_trans.xlsx','rms','C81:L81');
    circ450_zn2_rms=xlsread('omega_circulation_trans.xlsx','rms','C82:L82');
    circ450_zn3_rms=xlsread('omega_circulation_trans.xlsx','rms','C83:L83');
    circ450_zn4_rms=xlsread('omega_circulation_trans.xlsx','rms','C84:L84');
    circ500_zn1_rms=xlsread('omega_circulation_trans.xlsx','rms','C111:L111');
    circ500_zn2_rms=xlsread('omega_circulation_trans.xlsx','rms','C112:L112');
    circ500_zn3_rms=xlsread('omega_circulation_trans.xlsx','rms','C113:L113');
    circ500_zn4_rms=xlsread('omega_circulation_trans.xlsx','rms','C114:L114');
    
    circ400_zn1std=xlsread('omega_circulation_trans.xlsx','deviation','C27:L27');
    circ400_zn2std=xlsread('omega_circulation_trans.xlsx','deviation','C28:L28');
    circ400_zn3std=xlsread('omega_circulation_trans.xlsx','deviation','C29:L29');
    circ400_zn4std=xlsread('omega_circulation_trans.xlsx','deviation','C30:L30');
    circ450_zn1std=xlsread('omega_circulation_trans.xlsx','deviation','C81:L81');
    circ450_zn2std=xlsread('omega_circulation_trans.xlsx','deviation','C82:L82');
    circ450_zn3std=xlsread('omega_circulation_trans.xlsx','deviation','C83:L83');
    circ450_zn4std=xlsread('omega_circulation_trans.xlsx','deviation','C84:L84');
    circ500_zn1std=xlsread('omega_circulation_trans.xlsx','deviation','C111:L111');
    circ500_zn2std=xlsread('omega_circulation_trans.xlsx','deviation','C112:L112');
    circ500_zn3std=xlsread('omega_circulation_trans.xlsx','deviation','C113:L113');
    circ500_zn4std=xlsread('omega_circulation_trans.xlsx','deviation','C114:L114');
    
%%  MAKING FIGURE

    axis=1:10;
    
  % outer recirculation zone, average
    figure('Position', [50 50 960 735],'Color','white');
    plot(axis, (abs(circ400_zn1_av)+abs(circ400_zn4_av))/2,'-vk','MarkerSize',15,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    ax = gca;
    ax.YColor = 'k';
    xticks([0.5 3.125 5.5 7.875 10.5])
    set(gca,'xTickLabel', char('0.0','T/4','T/2','3T/4','T'),'FontName','Times New Roman','FontSize',40)
    ytickformat('%.3f')
    yticks([2000 3000 4000 5000])
    set(gca,'YTickLabel', char('2.0','3.0','4.0','5.0'))
      
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlim([0.5 10.5]);
    ylim([2000 5000]);

    xlabel('\it \fontname{Times New Roman} t \rm[s]')
    ylabel('\it \fontname{Times New Roman} |\Gamma_{ORZ,ave}| \rm[Å~10^3 m^{2}/s]')
    set(gca,'FontName','Times New Roman','FontSize',30)
    hold on
    
    plot(axis,(abs(circ450_zn1_av)+abs(circ450_zn4_av))/2,'-^k','MarkerSize',15,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis,(abs(circ500_zn1_av)+abs(circ500_zn4_av))/2,'-sk','MarkerSize',15,'MarkerFaceColor','w','LineWidth',1)
    legend('400 [L/min]','450 [L/min]','500 [L/min]','FontSize',23,'Location','northeast')
    hold off

    pbaspect([sqrt(2) 1 1]); 
    
    saveas(gcf,strcat(savedirectory,'orz_circulation_average_trans.png'))
    close;
    
  % inner recirculation zone, average
    figure('Position', [50 50 960 735],'Color','white');
    plot(axis, (abs(circ400_zn2_av)+abs(circ400_zn3_av))/2,'-vk','MarkerSize',15,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    ax = gca;
    ax.YColor = 'k';
    xticks([0.5 3.125 5.5 7.875 10.5])
    set(gca,'xTickLabel', char('0.0','T/4','T/2','3T/4','T'),'FontName','Times New Roman','FontSize',40)
    ytickformat('%.3f')
    yticks([2000 3000 4000 5000])
    set(gca,'YTickLabel', char('2.0','3.0','4.0','5.0'))
      
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlim([0.5 10.5]);
    ylim([2000 5000]);

    xlabel('\it \fontname{Times New Roman} t \rm[s]')
    ylabel('\it \fontname{Times New Roman} |\Gamma_{IRZ,ave}| \rm[Å~10^3 m^{2}/s]')
    set(gca,'FontName','Times New Roman','FontSize',30)
    hold on
    
    plot(axis,(abs(circ450_zn2_av)+abs(circ450_zn3_av))/2,'-^k','MarkerSize',15,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis,(abs(circ500_zn2_av)+abs(circ500_zn3_av))/2,'-sk','MarkerSize',15,'MarkerFaceColor','w','LineWidth',1)
    legend('400 [L/min]','450 [L/min]','500 [L/min]','FontSize',23,'Location','northeast')
    hold off

    pbaspect([sqrt(2) 1 1]); 
    
    saveas(gcf,strcat(savedirectory,'irz_circulation_average_trans.png'))
    close;
    
  % inner & outer recirculation zone, fluctuation
    figure('Position', [50 50 960 735],'Color','white');
    plot(axis, (abs(circ400_zn1_rms./circ400_zn1_av)+abs(circ400_zn4_rms./circ400_zn4_av))/2,'--vk','MarkerSize',15,'MarkerFaceColor','k','LineWidth',1)
    hold on
    
    ax = gca;
    ax.YColor = 'k';
    xticks([0.5 3.125 5.5 7.875 10.5])
    set(gca,'xTickLabel', char('0.0','T/4','T/2','3T/4','T'),'FontName','Times New Roman','FontSize',40)
    ytickformat('%.3f')
    yticks([1 1.02 1.04 1.06])
    set(gca,'YTickLabel', char('1.00','1.02','1.04','1.06'))
      
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlim([0.5 10.5]);
    ylim([1 1.06]);

    xlabel('\it \fontname{Times New Roman} t \rm[s]')
    ylabel('\it \fontname{Times New Roman} |\Gamma_{rms}/\Gamma_{ave}| \rm')
    set(gca,'FontName','Times New Roman','FontSize',30)
    hold on
    
    plot(axis,(abs(circ450_zn1_rms./circ450_zn1_av)+abs(circ450_zn4_rms./circ450_zn4_av))/2,'--^k','MarkerSize',15,'MarkerFaceColor','k','LineWidth',1)
    hold on
    
    plot(axis,(abs(circ500_zn1_rms./circ500_zn1_av)+abs(circ500_zn4_rms./circ500_zn4_av))/2,'--sk','MarkerSize',15,'MarkerFaceColor','k','LineWidth',1)
    hold on
    
    plot(axis, (abs(circ400_zn2_rms./circ400_zn2_av)+abs(circ400_zn3_rms./circ400_zn3_av))/2,'--vk','MarkerSize',15,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis,(abs(circ450_zn2_rms./circ450_zn2_av)+abs(circ450_zn3_rms./circ450_zn3_av))/2,'--^k','MarkerSize',15,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis,(abs(circ500_zn2_rms./circ500_zn2_av)+abs(circ500_zn3_rms./circ500_zn3_av))/2,'--sk','MarkerSize',15,'MarkerFaceColor','w','LineWidth',1)
    legend('ORZ, 400 [L/min]','ORZ, 450 [L/min]','ORZ, 500 [L/min]','IRZ, 400 [L/min]','IRZ, 450 [L/min]','IRZ, 500 [L/min]','FontSize',23,'Location','northwest')
    hold off

    pbaspect([sqrt(2) 1 1]);
    saveas(gcf,strcat(savedirectory,'rz_fluctuation_trans.png'))
    close;