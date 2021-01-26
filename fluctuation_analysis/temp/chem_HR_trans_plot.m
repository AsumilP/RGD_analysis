    clear all
    close all
    clc

%% Parameters

    HR_400_10 = xlsread('chem_HR_trans.xlsx','proportional','B9:K9');
    HR_450_10 = xlsread('chem_HR_trans.xlsx','proportional','B30:K30');
    HR_500_10 = xlsread('chem_HR_trans.xlsx','proportional','B44:K44');

%% FIGURE

    axis=1:10;
    figure('Position', [50 50 960 735],'Color','white');
    plot(axis, HR_400_10,'-vr','MarkerSize',15,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    ax = gca;
    ax.YColor = 'k';
    xticks([0.5 3.125 5.5 7.875 10.5])
    set(gca,'xTickLabel', char('0.0','T/4','T/2','3T/4','T'),'FontName','Times New Roman','FontSize',40)
    ytickformat('%.3f')
    yticks([0.08 0.10 0.12])
    set(gca,'YTickLabel', char('8.0','10','12'))
      
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlim([0.5 10.5]);
    ylim([0.08 0.12]);

    xlabel('\it \fontname{Times New Roman} t \rm[s]')
    ylabel('\it \fontname{Times New Roman} \rm[%]')
    set(gca,'FontName','Times New Roman','FontSize',40)
    hold on
    
    plot(axis, HR_450_10,'-^b','MarkerSize',15,'MarkerFaceColor','w','LineWidth',1)
    hold on
    
    plot(axis, HR_500_10,'-sk','MarkerSize',15,'MarkerFaceColor','w','LineWidth',1)
    legend('400 [L/min]','450 [L/min]','500 [L/min]','FontSize',23)
    hold off 
     
    pbaspect([sqrt(2) 1 1]); 
   