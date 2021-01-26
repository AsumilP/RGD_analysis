    clear all
    close all
    clc

%% Parameters

    eta_cold_400=xlsread('eta.xlsx','phaseaverage','B2:B2');
    eta_cold_450=xlsread('eta.xlsx','phaseaverage','B3:B3');
    eta_cold_500=xlsread('eta.xlsx','phaseaverage','B4:B4');
    eta_b_400=xlsread('eta.xlsx','phaseaverage','B7:B7');
    eta_b_450=xlsread('eta.xlsx','phaseaverage','B8:B8');
    eta_b_500=xlsread('eta.xlsx','phaseaverage','B9:B9');
    
    eta_max_400=xlsread('eta.xlsx','phaseaverage','B12:K12');
    eta_max_450=xlsread('eta.xlsx','phaseaverage','B16:K16');
    eta_max_500=xlsread('eta.xlsx','phaseaverage','B20:K20');
    eta_infdown_400=xlsread('eta.xlsx','phaseaverage','B13:K13');
    eta_infdown_450=xlsread('eta.xlsx','phaseaverage','B17:K17');
    eta_infdown_500=xlsread('eta.xlsx','phaseaverage','B21:K21');
    eta_min_400=xlsread('eta.xlsx','phaseaverage','B14:K14');
    eta_min_450=xlsread('eta.xlsx','phaseaverage','B18:K18');
    eta_min_500=xlsread('eta.xlsx','phaseaverage','B22:K22');
    eta_infup_400=xlsread('eta.xlsx','phaseaverage','B15:K15');
    eta_infup_450=xlsread('eta.xlsx','phaseaverage','B19:K19');
    eta_infup_500=xlsread('eta.xlsx','phaseaverage','B23:K23');
    
    eta_400_trans=xlsread('eta.xlsx','sectionalaverage','B9:K9');
    eta_450_trans=xlsread('eta.xlsx','sectionalaverage','B25:K25');
    eta_500_trans=xlsread('eta.xlsx','sectionalaverage','B35:K35');

%% FIGURE

    axis=1:10;
    figure('Position', [50 50 960 735],'Color','white');
    plot(axis, eta_max_400,'-xr','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    ax = gca;
    ax.YColor = 'k';
    xticks([0.5 3.125 5.5 7.875 10.5])
    set(gca,'xTickLabel', char('0.0','T/4','T/2','3T/4','T'),'FontName','Times New Roman','FontSize',40)
    ytickformat('%.3f')
    yticks([0.10 0.11 0.12 0.13 0.14 0.15])
    set(gca,'YTickLabel', char('0.10','0.11','0.12','0.13','0.14','0.15'))
      
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlim([0.5 10.5]);
    ylim([0.10 0.15]);

    xlabel('\it \fontname{Times New Roman} t \rm[s]')
    ylabel('\it \fontname{Times New Roman} \eta \rm[mm]')
    set(gca,'FontName','Times New Roman','FontSize',40)
    hold on
    
    plot(axis, eta_max_450,'-xb','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis, eta_max_500,'-xk','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis, eta_infdown_400,'-vr','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis, eta_infdown_450,'-vb','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis, eta_infdown_500,'-vk','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis, eta_min_400,'-or','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis, eta_min_450,'-ob','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis, eta_min_500,'-ok','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis, eta_infup_400,'-^r','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis, eta_infup_450,'-^b','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis, eta_infup_500,'-^k','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
%     legend('\it max \rm 400 [L/min]','\it max \rm 450 [L/min]','\it max \rm 500 [L/min]','\it max \rm 400 [L/min]','\it max \rm 450 [L/min]','\it max \rm 500 [L/min]','\it max \rm 400 [L/min]','\it max \rm 450 [L/min]','\it max \rm 500 [L/min]','\it max \rm 400 [L/min]','\it max \rm 450 [L/min]','\it max \rm 500 [L/min]','FontSize',15)
    hold off 
     
    pbaspect([sqrt(2) 1 1]);

%%

    figure('Position', [50 50 960 735],'Color','white');
    plot(axis, eta_400_trans*1000,'-vr','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    ax = gca;
    ax.YColor = 'k';
    xticks([0.5 3.125 5.5 7.875 10.5])
    set(gca,'xTickLabel', char('0.0','T/4','T/2','3T/4','T'),'FontName','Times New Roman','FontSize',40)
    ytickformat('%.3f')
    yticks([0.10 0.30 0.50 0.70])
    set(gca,'YTickLabel', char('0.10','0.30','0.50','0.70'))
      
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlim([0.5 10.5]);
    ylim([0.10 0.70]);

    xlabel('\it \fontname{Times New Roman} t \rm[s]')
    ylabel('\it \fontname{Times New Roman} \eta \rm[mm]')
    set(gca,'FontName','Times New Roman','FontSize',40)
    hold on
    
    plot(axis, eta_450_trans*1000,'-^b','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis, eta_500_trans*1000,'-sk','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot([0 11], [eta_cold_400 eta_cold_400],'--r','LineWidth',1.5)
    hold on
    
    plot([0 11], [eta_cold_450 eta_cold_450],'--b','LineWidth',1.5)
    hold on
    
    plot([0 11], [eta_cold_500 eta_cold_500],'--k','LineWidth',1.5)
    hold on
    
    plot([0 11], [eta_b_400 eta_b_400],'r','LineWidth',1.5)
    hold on
    
    plot([0 11], [eta_b_450 eta_b_450],'b','LineWidth',1.5)
    hold on
    
    plot([0 11], [eta_b_500 eta_b_500],'k','LineWidth',1.5)
    hold on

    legend('\rm 400 [L/min]','\rm 450 [L/min]','\rm 500 [L/min]','FontSize',25)
    hold off 
     
    pbaspect([sqrt(2) 1 1]);
   