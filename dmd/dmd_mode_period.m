clear
clc
close all

%% Parameters 1

    dt = 50*10^(-6); %[s]
    increment = 6;
    id = 2; %1: norm, 2: norm (considering damp)
    date = '20190819'; %1
    cond = 5;
    step = 'trans3';
    div = 'u3_3';
    serach_freq = 206;

    div_theta = 10;
    col_min = -1;
    col_max = 1;
%     vis='gray';

%% Parameters 2

    nx = 191;
    ny = 98;
    vec_spc_x = 8;
    vec_spc_y = 8;
    img_res_x = 80*10^(-3);
    img_res_y = 75*10^(-3);
    X = img_res_x*vec_spc_x;
    Y = img_res_y*vec_spc_y;
    xmin = -(0.5*(nx-1))*X+X;
    xmax = 0.5*(nx-1)*X+X;
    ymin = Y*19; % ATTENTION, CUT
    ymax = Y*116; % ATTENTION, CUT
    wx(1,1) = xmin;
    wx(2,1) = xmax;
    wy(1,1) = ymin;
    wy(2,1) = ymax;

%% READ FILES

    ifilename_fg = 'f_and_g.txt';
    ifilename_norm = 'norm.txt';

    filepath = strcat('G:/Analysis/piv_output/dmd/',date,'/%02u/averaging/',step,'/',div,'/mode/');
    ifilename = sprintf(strcat(filepath,ifilename_fg),cond);
    fileID = fopen(ifilename,'r');
    fg = fscanf(fileID,'%f',[2 Inf]);
    fclose(fileID);
    fg_v(:,:) = fg';

    ifilename = sprintf(strcat(filepath,ifilename_norm),cond);
    fileID = fopen(ifilename,'r');
    norm(:,:) = fscanf(fileID,'%f');
    fclose(fileID);

    T = dt*length(norm(:,:))*increment %data time [s]

%% SEARCH MODE NUMEBER

    mn = 0;

    for i = 1:1:length(norm)
      if abs(fg_v(i,1)-serach_freq) < floor(1/(2*T))
        mn = mn + 1;
        mode_number(mn) = i
      end
    end

%% SORT

    tmp_fg_r = 0;
    tmp_fg_i = 0;
    tmp_norm = 0;

    for i = 1:1:length(norm)
      for j = i+1:1:length(norm)
          if fg_v(i,1) > fg_v(j,1)
              tmp_fg_r = fg_v(i,1);
              fg_v(i,1) = fg_v(j,1);
              fg_v(j,1) = tmp_fg_r;

              tmp_fg_i = fg_v(i,2);
              fg_v(i,2) = fg_v(j,2);
              fg_v(j,2) = tmp_fg_i;

              tmp_norm = norm(i,1);
              norm(i,1) = norm(j,1);
              norm(j,1) = tmp_norm;
          end
      end
    end

%% IF=1

    if id == 1

%% MAKE A FIGURE

      figure('Position', [50 50 960 735],'Color','white');
      loglog(fg_v(:,1),norm(:,1),'-v','MarkerSize',5,'MarkerFaceColor','w','Color','k')

      ax = gca;
      xtickformat('%d')
      ytickformat('%d')

      ax.XAxisLocation = 'bottom';
      ax.YDir = 'normal';
      ax.YAxisLocation = 'left';
      ax.XColor = 'black';
      ax.YColor = 'black';
      % ax.XScale = 'log';
      % ax.YScale = 'log';
      ax.XLim = [20 300];
      ax.YLim = [4 100];
      ax.FontSize = 20;
      ax.FontName =  'Times New Roman';
      ax.TitleFontSizeMultiplier = 2;
      ax.Box = 'on';
      ax.LineWidth = 2.0;
      ax.XMinorTick = 'on';
      ax.YMinorTick = 'on';

      xlabel('\it{ f}_j \rm{[Hz]}')
      ylabel('||\it{\bf{v}}_j||')
      pbaspect([sqrt(2) 1 1]);

      figname = strcat('fg_norm_',date,'_%02u_',div,'.png');
      % figname_out = sprintf(strcat(filepath,figname),cond,cond);
      % saveas(gca,figname_out)

    end

%% IF=2

    if id == 2  %norm (considering damp)

      norm_d = norm.* abs(exp((fg_v(:,2,1)+sqrt(-1)*2*pi*fg_v(:,1,1))*T));
      ii = 0;
      norm_dm = 0;
      fg_m = 0;

      for j = 1:length(norm)
        if fg_v(j,1) >= 0
          ii = ii + 1;
          norm_dm(ii) = norm_d(j);
          fg_m(ii) = fg_v(j,1);
        end
      end
      norm_dm = norm_dm';
      fg_m = fg_m';

%% MAKE FIGURES

      figure('Position', [50 50 960 735],'Color','white');
      loglog(fg_m,norm_dm,'-v','MarkerSize',5,'MarkerFaceColor','w','Color','k')

      ax = gca;
      xtickformat('%d')
      ytickformat('%d')

      ax.XAxisLocation = 'bottom';
      ax.YDir = 'normal';
      ax.YAxisLocation = 'left';
      ax.XColor = 'black';
      ax.YColor = 'black';
      % ax.XScale = 'log';
      % ax.YScale = 'log';
      ax.XLim = [20 300];
      ax.YLim = [4 100];
      ax.FontSize = 20;
      ax.FontName =  'Times New Roman';
      ax.TitleFontSizeMultiplier = 2;
      ax.Box = 'on';
      ax.LineWidth = 2.0;
      ax.XMinorTick = 'on';
      ax.YMinorTick = 'on';

      xlabel('\it{ f}_j \rm{[Hz]}')
      ylabel('|\it{\lambda}_{j}^{m}| ||\it{\bf{v}}_j||')
      pbaspect([sqrt(2) 1 1]);

      figname = strcat('fg_norm_d_',date,'_%02u_',div,'.png');
      % figname_out = sprintf(strcat(filepath,figname),cond,cond);
      % saveas(gca,figname_out)

    end

%% READ to plot

    for i = 1:mn

      i2 = cond;
      m = mode_number(mn);
      I = 0;

      filename1 = 'real_mode_%04u.dat';
      filename1 = sprintf(strcat(filepath,filename1),i2,m);
      fileID1 = fopen(filename1,'r');
      IR = reshape(fread(fileID1,nx*ny,'double'),[nx,ny]).';
      fclose(fileID1);
      filename2 = 'imag_mode_%04u.dat';
      filename2 = sprintf(strcat(filepath,filename2),i2,m);
      fileID2 = fopen(filename2,'r');
      II = reshape(fread(fileID2,nx*ny,'double'),[nx,ny]).';
      fclose(fileID2);
      ifilename3 = 'f_and_g.txt';
      ifilename3 = sprintf(strcat(filepath,ifilename3),i2);
      fileID3 = fopen(ifilename3,'r');
      fg = fscanf(fileID3,'%f',[2 Inf]);
      fclose(fileID3);
      fg = fg';
      freq = fg(m,1);

%% CALCULATE DMD MODE (time series)

      for j = 1:div_theta

        t = (j-1)/(div_theta*freq);
        theta = 2*pi*freq*t;
        I = IR + 1i*II;
        A = I*exp(1i*theta);
        B = real(A);
        % C = imcrop(B,[137 150 750 770]);

%% MAKE FIGURE
        fig = figure;
        fig.Color = 'white';
        fig.Position = [1 1 850*(1+sqrt(5))/2 650];
        IMAGE = imagesc(wx,wy,B(:,:),[col_min col_max]);
        % IMAGE = imagesc(C,[col_min col_max]);
        ax = gca;
        load('MyColormap_for_w','mymap')
        colormap(ax,mymap)
        % colormap(ax,vis)

        % xtickformat('%.2f')
        xticks([-60 -40 -20 0 20 40 60])
        set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
        % ytickformat('%.2f')
        yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
        set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

        c = colorbar;
        % c.Ticks=[-10 -5 0 5 10]; % Chem
        % c.TickLabels={'-10','-5','0','5','10'};
        c.TickLabelInterpreter='latex';
        c.Label.FontSize = 20;
        c.Label.String = '\it \fontname{Times New Roman} Re(\Psi)';
        c.Location = 'eastoutside';
        c.AxisLocation='out';

        xlabel('\it \fontname{Times New Roman} x \rm[mm]')
        ylabel('\it \fontname{Times New Roman} y \rm[mm]')
        set(gca,'XMinorTick','on','YMinorTick','on','FontName','Times New Roman','FontSize',20,'LineWidth',2.0,'Color','k')

        xlim([-60 60])
        ylim([ymin ymax])
        
        pbaspect([2 1 1]);

        frame = getframe(fig);
        im{j} = frame2im(frame);
        ff = round(freq);
        filename_out = 'real_mode_%dHz_%1uo%1u_%04u.png';
        filename_out = sprintf(strcat(filepath,filename_out),i2,ff,j,div_theta,m);
        print(gcf,'-dpng','-r300',filename_out) %dpi300
        saveas(gca,filename_out)

      end
      close all

      gifname= 'real_mode_%dHz_div%1u_%04u.gif';
      gifname = sprintf(strcat(filepath,gifname),i2,ff,div_theta,m);

      for idx=1:1:div_theta
        [A,map]= rgb2ind(im{idx},256);
        if idx == 1
          imwrite(A,map,gifname,'gif','LoopCount',Inf,'DelayTime',0.1);
        else
          imwrite(A,map,gifname,'gif','WriteMode','append','DelayTime',0.1);
        end
      end
      
    end
