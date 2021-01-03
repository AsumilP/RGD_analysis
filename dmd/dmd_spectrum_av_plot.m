    clear all
    close all
    clc

%% PARAMETERS

    flow_rate1 = 400; % [L/min]
    step1 = 'trans1';
    
    flow_rate2 = 400; % [L/min]
    step2 = 'trans2';
    
    flow_rate3 = 400; % [L/min]
    step3 = 'trans3';
    
    flow_rate4 = 400; % [L/min]
    step4 = 'trans4';
    
    flow_rate5 = 400; % [L/min]
    step5 = 'trans5';
    
    flow_rate6 = 400; % [L/min]
    step6 = 'trans6';
    
%     dir = 'G:/Analysis/piv_output/dmd/dmd_averaged/';
    dir = 'D:/Analysis/chem_output/chem_dmd/dmd_averaged/';
%     type = 'u';
    type = 'chem';

%% READ

    fg_m_fil_in1 = sprintf(strcat(dir,'fg_m_real_fil_%02u_',step1,'_',type,'.dat'),flow_rate1);
    norm_dm_fil_in1 = sprintf(strcat(dir,'norm_dm_fil_%02u_',step1,'_',type,'.dat'),flow_rate1);
    fg_m_fil_in2 = sprintf(strcat(dir,'fg_m_real_fil_%02u_',step2,'_',type,'.dat'),flow_rate2);
    norm_dm_fil_in2 = sprintf(strcat(dir,'norm_dm_fil_%02u_',step2,'_',type,'.dat'),flow_rate2);
    fg_m_fil_in3 = sprintf(strcat(dir,'fg_m_real_fil_%02u_',step3,'_',type,'.dat'),flow_rate3);
    norm_dm_fil_in3 = sprintf(strcat(dir,'norm_dm_fil_%02u_',step3,'_',type,'.dat'),flow_rate3);
    fg_m_fil_in4 = sprintf(strcat(dir,'fg_m_real_fil_%02u_',step4,'_',type,'.dat'),flow_rate4);
    norm_dm_fil_in4 = sprintf(strcat(dir,'norm_dm_fil_%02u_',step4,'_',type,'.dat'),flow_rate4);
    fg_m_fil_in5 = sprintf(strcat(dir,'fg_m_real_fil_%02u_',step5,'_',type,'.dat'),flow_rate5);
    norm_dm_fil_in5 = sprintf(strcat(dir,'norm_dm_fil_%02u_',step5,'_',type,'.dat'),flow_rate5);
    fg_m_fil_in6 = sprintf(strcat(dir,'fg_m_real_fil_%02u_',step6,'_',type,'.dat'),flow_rate6);
    norm_dm_fil_in6 = sprintf(strcat(dir,'norm_dm_fil_%02u_',step6,'_',type,'.dat'),flow_rate6);
%
    fileID = fopen(fg_m_fil_in1,'r');
    fg1 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(fg_m_fil_in2,'r');
    fg2 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(fg_m_fil_in3,'r');
    fg3 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(fg_m_fil_in4,'r');
    fg4 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(fg_m_fil_in5,'r');
    fg5 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(fg_m_fil_in6,'r');
    fg6 = fread(fileID,[1 inf],'double');
    fclose(fileID);
%
    fileID = fopen(norm_dm_fil_in1,'r');
    norm1 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(norm_dm_fil_in2,'r');
    norm2 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(norm_dm_fil_in3,'r');
    norm3 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(norm_dm_fil_in4,'r');
    norm4 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(norm_dm_fil_in5,'r');
    norm5 = fread(fileID,[1 inf],'double');
    fclose(fileID);
    
    fileID = fopen(norm_dm_fil_in6,'r');
    norm6 = fread(fileID,[1 inf],'double');
    fclose(fileID);

%% FIGURE

    figure('Position', [50 50 960 735],'Color','white');
    loglog(fg6,norm6,'-vr','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(norm1))

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
%      ax.YLim = [4 200];
     ax.YLim = [10^3 2*10^5];
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
     
     loglog(fg5,norm5,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(norm2))
     hold on
     
     loglog(fg4,norm4,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(norm3))
     hold on
     
     loglog(fg3,norm3,'-og','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(norm4))
     hold on
     
     loglog(fg2,norm2,'-pc','MarkerSize',8,'MarkerFaceColor','c','MarkerIndices',1:1:length(norm5))
     hold on
     
     loglog(fg1,norm1,'-xm','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(norm6))

     legend('t = 0.00 - 0.25s, 500L/min','t = -0.05 - 0.20s, 500L/min','t = -0.10 - 0.15s, 500L/min','t = -0.15 - 0.10s, 500L/min','t = -0.20 - 0.05s, 500L/min','t = -0.25 - 0.00s, 500L/min','FontSize',16,'Location','northwest')
     hold off
     pbaspect([sqrt(2) 1 1]);
