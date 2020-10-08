    clear all
    close all
    clc

%% PARAMETERS

    flow_rate1 = 500; % [L/min]
    step1 = 'trans1';
    
    flow_rate2 = 500; % [L/min]
    step2 = 'trans2';
    
    flow_rate3 = 500; % [L/min]
    step3 = 'trans3';
    
    dir = 'G:/dmd_averaged/';
    velo = 'v';

%% READ

    fg_m_fil_in1 = sprintf(strcat(dir,'fg_m_real_fil_%02u_',step1,'_',velo,'.dat'),flow_rate1);
    norm_dm_fil_in1 = sprintf(strcat(dir,'norm_dm_fil_%02u_',step1,'_',velo,'.dat'),flow_rate1);
    fg_m_fil_in2 = sprintf(strcat(dir,'fg_m_real_fil_%02u_',step2,'_',velo,'.dat'),flow_rate2);
    norm_dm_fil_in2 = sprintf(strcat(dir,'norm_dm_fil_%02u_',step2,'_',velo,'.dat'),flow_rate2);
    fg_m_fil_in3 = sprintf(strcat(dir,'fg_m_real_fil_%02u_',step3,'_',velo,'.dat'),flow_rate3);
    norm_dm_fil_in3 = sprintf(strcat(dir,'norm_dm_fil_%02u_',step3,'_',velo,'.dat'),flow_rate3);
    
    fileID = fopen(fg_m_fil_in1,'r');
    fg1 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(fg_m_fil_in2,'r');
    fg2 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(fg_m_fil_in3,'r');
    fg3 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(norm_dm_fil_in1,'r');
    norm1 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(norm_dm_fil_in2,'r');
    norm2 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(norm_dm_fil_in3,'r');
    norm3 = fread(fileID,[1 inf],'double');
    fclose(fileID);

%% FIGURE

    figure('Position', [50 50 960 735],'Color','white');
    loglog(fg1,norm1,'-^k','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(norm1))

    ax = gca;
    xtickformat('%d')
%     xticks([20 30 40 50 60 70 80 90 100 200])
%     set(gca,'xTickLabel', char('20','','40','','60','','80','','100','200'))
    ytickformat('%d')
%     yticks([0.00000001 0.000001 0.0001 0.01 1 100 10000])
%     set(gca,'YTickLabel', char('10^{-8}','10^{-6}','10^{-4}','10^{-2}','10^{0}','10^{2}','10^{4}'))

     ax.XAxisLocation = 'bottom';
     ax.YDir='normal';
     ax.YAxisLocation = 'left';
     ax.XColor = 'black';
     ax.YColor = 'black';
     % ax.XScale = 'log';
     % ax.YScale = 'log';
     ax.XLim = [20 300];
     ax.YLim = [4 100];
     ax.FontSize = 20;
     ax.FontName = 'Times New Roman';
     ax.TitleFontSizeMultiplier = 2;
     ax.Box = 'on';
     ax.LineWidth = 2.0;
     ax.XMinorTick = 'on';
     ax.YMinorTick = 'on';

     xlabel('\it{ f}_j \rm{[Hz]}')
     ylabel('|\it{\lambda}_{j}^{m}| ||\it{\bf{v}}_j||')
     hold on
     
     loglog(fg2,norm2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(norm2))
     hold on
     
     loglog(fg3,norm3,'-vr','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(norm3))
     
%      legend('400L/min, stable','400L/min, oscillation','450L/min, stable','450L/min, oscillation','500L/min, stable','500L/min, oscillation','FontSize',20,'Location','northwest')
     hold off
     pbaspect([sqrt(2) 1 1]);
