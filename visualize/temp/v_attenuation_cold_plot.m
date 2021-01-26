    clear all
    close all
    clc

%% PARAMETERS 1

     n400 = 1;
     n450 = 3;
     n500 = 3;
     
%% PARAMETERS 2

     ny = 121;
     d = 7.5; % [mm]
     vec_spc_y = 8;
     img_res_y = 75*10^(-3);
     Y=img_res_y*vec_spc_y;
     ymin=Y;
     ymax=ny*Y;
     
     for i=1:ny
        y(i,:)=(ymax-Y*(i-1))/d;
     end

     y=sort(y);
     scrsz=get(groot,'ScreenSize');

%% READ and AVERAGE

% 400, l
     vatten_l_400av=0;
     for i=1:1:n400
        formatspec = '400_cold_%d_vatten_l.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        vatten_l_400 = fread(fid,ny,'double');
        fclose(fid);

        vatten_l_400av = vatten_l_400av + vatten_l_400/n400;
     end

% 400, r
     vatten_r_400av=0;
     for i=1:1:n400
        formatspec = '400_cold_%d_vatten_r.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        vatten_r_400 = fread(fid,ny,'double');
        fclose(fid);

        vatten_r_400av = vatten_r_400av + vatten_r_400/n400;
     end

% 450, l
     vatten_l_450av=0;
     for i=1:1:n450
        formatspec = '450_cold_%d_vatten_l.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        vatten_l_450 = fread(fid,ny,'double');
        fclose(fid);

        vatten_l_450av = vatten_l_450av + vatten_l_450/n450;
     end

% 450, r
     vatten_r_450av=0;
     for i=1:1:n450
        formatspec = '450_cold_%d_vatten_r.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        vatten_r_450 = fread(fid,ny,'double');
        fclose(fid);

        vatten_r_450av = vatten_r_450av + vatten_r_450/n450;
     end

% 500, l
     vatten_l_500av=0;
     for i=1:1:n500
        formatspec = '500_cold_%d_vatten_l.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        vatten_l_500 = fread(fid,ny,'double');
        fclose(fid);

        vatten_l_500av = vatten_l_500av + vatten_l_500/n500;
     end

% 500, r
     vatten_r_500av=0;
     for i=1:1:n500
        formatspec = '500_cold_%d_vatten_r.dat';
        fid = fopen(sprintf(formatspec,i),'r');
        vatten_r_500 = fread(fid,ny,'double');
        fclose(fid);

        vatten_r_500av = vatten_r_500av + vatten_r_500/n500;
     end

%% MAKE FIGURE

    figure('Position', [50 50 960 735],'Color','white');
    l_plot_400 = loglog(y,vatten_l_400av,'-v','MarkerSize',8,'Color','r','MarkerFaceColor','w');
    
    ax = gca;
    xtickformat('%.2f')
    xticks([0 1 2 3 4 5 6 7 8 9 10 50 100 150])
    set(gca,'xTickLabel', char('0','1','2','','4','','6','','8','','10','50','100','150'))
    ytickformat('%.3f')
    yticks([0 0.02 0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.5])
    set(gca,'YTickLabel', char('0.00','0.02','0.05','0.10','0.20','0.30','0.40','','0.60','','0.80','','1.00','1.50'))

    ax.XAxisLocation = 'bottom';
    ax.YDir='normal';
    ax.YAxisLocation = 'left';
    ax.XColor = 'black';
    ax.YColor = 'black';
    ax.XScale = 'log';
    ax.YScale = 'log';
    ax.XLim = [1 10];
    ax.YLim = [0.4 1.0];
    ax.FontSize = 30;
    ax.FontName =  'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlabel('\it \fontname{Times New Roman}y/d');
    ylabel('\it \fontname{Times New Roman}v/U_{0}');
    hold on

    r_plot_400 = loglog(y,vatten_r_400av,'-v','MarkerSize',8,'Color','r','MarkerFaceColor','r');
    hold on
    
    l_plot_450 = loglog(y,vatten_l_450av,'-^','MarkerSize',8,'Color','b','MarkerFaceColor','w');
    hold on
    
    r_plot_450 = loglog(y,vatten_r_450av,'-^','MarkerSize',8,'Color','b','MarkerFaceColor','b');
    hold on
    
    l_plot_500 = loglog(y,vatten_l_500av,'-s','MarkerSize',8,'Color','k','MarkerFaceColor','w');
    hold on
    
    r_plot_500 = loglog(y,vatten_r_450av,'-s','MarkerSize',8,'Color','k','MarkerFaceColor','k');
    hold on
        
    loglog(y,4*(y.^-1),'--','MarkerSize',20,'LineWidth',3,'Color','k') 
    
    legend([l_plot_400 r_plot_400 l_plot_450 r_plot_450 l_plot_500 r_plot_500], {'400 left','400 right','450 left','450 right','500 left','500 right'},'FontSize',30,'Location','southwest')
    hold off
    
    pbaspect([sqrt(2) 1 1]);

%% MAKE FIGURE lr averaged

    figure('Position', [50 50 960 735],'Color','white');
    plot_400 = loglog(y,(vatten_l_400av+vatten_r_400av)/2,'-v','MarkerSize',8,'Color','r','MarkerFaceColor','w');
    
    ax = gca;
    xtickformat('%.2f')
    xticks([0 1 2 3 4 5 6 7 8 9 10 50 100 150])
    set(gca,'xTickLabel', char('0','1','2','','4','','6','','8','','10','50','100','150'))
    ytickformat('%.3f')
    yticks([0 0.02 0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.5])
    set(gca,'YTickLabel', char('0.00','0.02','0.05','0.10','0.20','0.30','0.40','','0.60','','0.80','','1.00','1.50'))

    ax.XAxisLocation = 'bottom';
    ax.YDir='normal';
    ax.YAxisLocation = 'left';
    ax.XColor = 'black';
    ax.YColor = 'black';
    ax.XScale = 'log';
    ax.YScale = 'log';
    ax.XLim = [1 10];
    ax.YLim = [0.4 1.0];
    ax.FontSize = 30;
    ax.FontName =  'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlabel('\it \fontname{Times New Roman}y/d');
    ylabel('\it \fontname{Times New Roman}v/U_{0}');
    hold on

    plot_450 = loglog(y,(vatten_l_450av+vatten_r_450av)/2,'-^','MarkerSize',8,'Color','b','MarkerFaceColor','w');
    hold on
    
    plot_500 = loglog(y,(vatten_l_500av+vatten_r_500av)/2,'-s','MarkerSize',8,'Color','k','MarkerFaceColor','w');
    hold on
        
    loglog(y,4*(y.^-1),'--','MarkerSize',20,'LineWidth',3,'Color','k') 
    
    legend([plot_400 plot_450 plot_500], {'400 [L/min]','450 [L/min]','500 [L/min]'},'FontSize',30,'Location','southwest')
    hold off
    
    pbaspect([sqrt(2) 1 1]);