clear
clc
close all

%% Parameters 1
    date = '20190821'; %date
    con_num = 1;%condition number
    div_file = 1;
    m = 57; %mode number
    div_theta = 10;
    col_min = -10;
    col_max = 10;
%     vis='gray';

%% Parameters 2
    nx = 191;
    ny = 98;
    vec_spc_x = 8;
    vec_spc_y = 8;
    img_res_x = 80*10^(-3);
    img_res_y = 75*10^(-3);
    X=img_res_x*vec_spc_x;
    Y=img_res_y*vec_spc_y;
    xmin=-(0.5*(nx-1))*X+X;
    xmax=0.5*(nx-1)*X+X;
    ymin=Y*19; % ATTENTION, CUT
    ymax=Y*116; % ATTENTION, CUT
    wx(1,1)=xmin;
    wx(2,1)=xmax;
    wy(1,1)=ymin;
    wy(2,1)=ymax;

%% READ FILES
    for i = con_num
        i2 = i;
        I = 0;
        if div_file==1
          filepath = strcat('G:/Analysis/piv_output/cold_dmd/',date,'/%02u/averaging/01_13/mode/');
        elseif div_file==2
          filepath = strcat('G:/Analysis/piv_output/cold_dmd/',date,'/%02u/averaging/02_13/mode/');
        elseif div_file==3
          filepath = strcat('G:/Analysis/piv_output/cold_dmd/',date,'/%02u/averaging/03_13/mode/');
        elseif div_file==4
          filepath = strcat('G:/Analysis/piv_output/cold_dmd/',date,'/%02u/averaging/04_13/mode/');
        elseif div_file==5
          filepath = strcat('G:/Analysis/piv_output/cold_dmd/',date,'/%02u/averaging/05_13/mode/');
        elseif div_file==6
          filepath = strcat('G:/Analysis/piv_output/cold_dmd/',date,'/%02u/averaging/06_13/mode/');
        elseif div_file==7
          filepath = strcat('G:/Analysis/piv_output/cold_dmd/',date,'/%02u/averaging/07_13/mode/');
        elseif div_file==8
          filepath = strcat('G:/Analysis/piv_output/cold_dmd/',date,'/%02u/averaging/08_13/mode/');
        elseif div_file==9
          filepath = strcat('G:/Analysis/piv_output/cold_dmd/',date,'/%02u/averaging/09_13/mode/');
        elseif div_file==10
          filepath = strcat('G:/Analysis/piv_output/cold_dmd/',date,'/%02u/averaging/10_13/mode/');
        elseif div_file==11
          filepath = strcat('G:/Analysis/piv_output/cold_dmd/',date,'/%02u/averaging/11_13/mode/');
        elseif div_file==12
          filepath = strcat('G:/Analysis/piv_output/cold_dmd/',date,'/%02u/averaging/12_13/mode/');
        elseif div_file==13
          filepath = strcat('G:/Analysis/piv_output/cold_dmd/',date,'/%02u/averaging/13_13/mode/');
        end

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
%          C = imcrop(B,[137 150 750 770]);

%% MAKE FIGURE
          fig=figure;
          fig.Color='white';
          fig.Position=[1 1 800*(1+sqrt(5))/2 800];
          IMAGE = imagesc(wx,wy,B(:,:),[col_min col_max]);
%          IMAGE = imagesc(C,[col_min col_max]);
          ax=gca;
          load('MyColormap_for_w','mymap')
          colormap(ax,mymap)
%          colormap(ax,vis)

          xtickformat('%.2f')
          xticks([-60 -40 -20 0 20 40 60])
          set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
          ytickformat('%.2f')
          yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
          set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

          c=colorbar;
          c.Ticks=[-10 -5 0 5 10]; % Chem
          c.TickLabels={'-10','-5','0','5','10'};
          c.TickLabelInterpreter='latex';
          c.Label.FontSize = 25;
          c.Label.String = '\it \fontname{Times New Roman} Re(\Psi)';
          c.Location = 'eastoutside';
          c.AxisLocation='out';

          xlabel('\it \fontname{Times New Roman} x \rm[mm]')
          ylabel('\it \fontname{Times New Roman} y \rm[mm]')
          set(gca,'XMinorTick','off','YMinorTick','off','FontName','Times New Roman','FontSize',25,'LineWidth',2.0,'Color','k')

          xlim([-60 60])
          ylim([ymin ymax])

          frame = getframe(fig);
          im{j}=frame2im(frame);
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
