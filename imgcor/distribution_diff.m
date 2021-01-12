    clear all
    close all
    clc

%% Parameters

    nx = 95;
    ny = 124;
    nz = 21838;
%     date = '20201218';
    
    for cond = [1]

%         dir_in1 = strcat('G:/',date,'/raw_old/');
%         dir_in2 = strcat('G:/',date,'/raw/');
%         filename_in1 = sprintf('spiv_bl_%02u.mraw',cond);
%         filename_in2 = sprintf('spiv_bl_%02u.dat',cond);
        
        dir_in1 = strcat('C:/Users/yatagi/Desktop/');
        dir_in2 = strcat('C:/Users/yatagi/Desktop/');
        filename_in1 = sprintf('spiv_bl_%02u_vcut.dat',cond);
        filename_in2 = sprintf('spiv_bl_%02u_vcl.dat',cond);

%% Matrix

        Pixels = nx*ny;
  
%% Read & Calc.

        fid1 = fopen(append(dir_in1,filename_in1),'r');
        fid2 = fopen(append(dir_in2,filename_in2),'r');

        for m = 1:1:nz
%             I = fread(fid1,Pixels,'uint8');
%             bcout = fread(fid2,Pixels,'uint16');
            I = fread(fid1,Pixels,'double');
            bcout = fread(fid2,Pixels,'double');
            dif_max(m) = max(bcout - I);
        end
    
        fclose(fid1);
        fclose(fid2);
        
 %% Plot
 
        figure('Position', [50 50 960 735],'Color','white');
        plot(1:nz,dif_max,'-vk')

        ax = gca;
        xtickformat('%d')
        ytickformat('%.2f')

        ax.XColor = 'k';
        ax.YColor = 'k';
        ax.FontSize = 20;
        ax.FontName = 'Times New Roman';
        ax.TitleFontSizeMultiplier = 2;
        ax.Box = 'on';
        ax.LineWidth = 2.0;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.XLim = [1 nz];

        xlabel('\rm \fontname{Times New Roman} frames')
        ylabel('\rm \fontname{Times New Roman} diff')
        set(gca,'FontName','Times New Roman','FontSize',20)

        pbaspect([sqrt(2) 1 1]);

    end