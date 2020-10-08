clear
close all
clc

%% PARAMETERS
  dt=50*10^(-6); %[s]
  increment=25;
  id=2; %1: norm, 2: norm (considering damp)
  date='20190821'; %1
  cond=1;
  div='03_13';
  serach_freq=95.17;

%% FILENAMES & READ
  ifilename_fg='f_and_g.txt';
  ifilename_norm='norm.txt';

  filepath=strcat('G:/Analysis/piv_output/cold_dmd/',date,'/%02u/averaging/',div,'/mode/');
  ifilename=sprintf(strcat(filepath,ifilename_fg),cond);
  fileID=fopen(ifilename,'r');
  fg=fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:)=fg';
  ifilename=sprintf(strcat(filepath,ifilename_norm),cond);
  fileID=fopen(ifilename,'r');
  norm(:,:)=fscanf(fileID,'%f');
  fclose(fileID);

  T=dt*length(norm(:,:))*increment; %data time [s]

%% SEARCH MODE NUMEBER
  for i=1:1:length(norm)
      if abs(fg_v(i,1)-serach_freq) < 0.01
          mode_number=i
      end
  end

%% SORT
  tmp_fg_r=0;
  tmp_fg_i=0;
  tmp_norm=0;

  for i=1:1:length(norm)
      for j=i+1:1:length(norm)
          if fg_v(i,1)>fg_v(j,1)
              tmp_fg_r=fg_v(i,1);
              fg_v(i,1)=fg_v(j,1);
              fg_v(j,1)=tmp_fg_r;

              tmp_fg_i=fg_v(i,2);
              fg_v(i,2)=fg_v(j,2);
              fg_v(j,2)=tmp_fg_i;

              tmp_norm=norm(i,1);
              norm(i,1)=norm(j,1);
              norm(j,1)=tmp_norm;
          end
      end
  end

%% IF=1
  if id == 1
%% MAKE A FIGURE
    scrsz = get(groot,'ScreenSize');
%       figure('Position', [1 scrsz(2) scrsz(3)*1/2*0.8 scrsz(4)/2]);
    figure('Position', [50 50 960 735],'Color','white');
    loglog(fg_v(:,1),norm(:,1),'-v','MarkerSize',5,'MarkerFaceColor','w','Color','k')

    ax = gca;
    xtickformat('%.2f')
    xticks([20 30 40 50 60 70 80 90 100 200])
    set(gca,'xTickLabel', char('20','','40','','60','','80','','100','200'))
    ytickformat('%.3f')
    yticks([0.00000001 0.000001 0.0001 0.01 1 100 10000])
    set(gca,'YTickLabel', char('10^{-8}','10^{-6}','10^{-4}','10^{-2}','10^{0}','10^{2}','10^{4}'))

    ax.XAxisLocation = 'bottom';
    ax.YDir='normal';
    ax.YAxisLocation = 'left';
    ax.XColor = 'black';
    ax.YColor = 'black';
    ax.XScale = 'log';
    ax.YScale = 'log';
    ax.XLim = [20 300];
    ax.YLim = [10^0 10^4];
    ax.FontSize = 30;
    ax.FontName =  'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlabel('\it{ f}_j \rm{[Hz]}')
    ylabel('||\it{\bf{v}}_j||')
    pbaspect([sqrt(2) 1 1]);

    figname=strcat('fg_norm_',date,'_%02u_',div,'.png');
    figname_out=sprintf(strcat(filepath,figname),cond,cond);
    saveas(gca,figname_out)
  end

%% IF=2
  if id == 2  %norm (considering damp)
    norm_d=norm.* abs(exp((fg_v(:,2,1)+sqrt(-1)*2*pi*fg_v(:,1,1))*T));
    ii=0;
    norm_dm=0;
    fg_m=0;

    for j=1:length(norm)
      if fg_v(j,1)>=0
        ii = ii + 1;
        norm_dm(ii)=norm_d(j);
        fg_m(ii) = fg_v(j,1);
      end
    end
    norm_dm = norm_dm';
    fg_m = fg_m';

%% MAKE FIGURES
    scrsz = get(groot,'ScreenSize');
%    figure('Position', [1 scrsz(2) scrsz(3)*1/2*0.8 scrsz(4)/2]);
    figure('Position', [50 50 960 735],'Color','white');
%    loglog(fg_m,norm_dm,'-v','MarkerSize',5,'MarkerFaceColor','w','Color','k') %??¿½?¿½t??¿½?¿½B??¿½?¿½??¿½?¿½??¿½?¿½^??¿½?¿½È‚ï¿½
    loglog(fg_m,norm_dm,'-v','MarkerSize',5,'MarkerFaceColor','w','Color','k') %??¿½?¿½t??¿½?¿½B??¿½?¿½??¿½?¿½??¿½?¿½^??¿½?¿½??¿½?¿½??¿½?¿½??¿½?¿½

    ax = gca;
    xtickformat('%.2f')
    xticks([20 30 40 50 60 70 80 90 100 200])
    set(gca,'xTickLabel', char('20','','40','','60','','80','','100','200'))
    ytickformat('%.3f')
    yticks([0.00000001 0.000001 0.0001 0.01 1 100 10000])
    set(gca,'YTickLabel', char('10^{-8}','10^{-6}','10^{-4}','10^{-2}','10^{0}','10^{2}','10^{4}'))

    ax.XAxisLocation = 'bottom';
    ax.YDir='normal';
    ax.YAxisLocation = 'left';
    ax.XColor = 'black';
    ax.YColor = 'black';
    ax.XScale = 'log';
    ax.YScale = 'log';
    ax.XLim = [20 300];
    ax.YLim = [10^-1 10^2];
    ax.FontSize = 30;
    ax.FontName =  'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlabel('\it{ f}_j \rm{[Hz]}')
    ylabel('|\it{\lambda}_{j}^{m}| ||\it{\bf{v}}_j||')
    pbaspect([sqrt(2) 1 1]);

    figname=strcat('fg_norm_d_',date,'_%02u_',div,'.png');
    figname_out=sprintf(strcat(filepath,figname),cond,cond);
    saveas(gca,figname_out)

  end