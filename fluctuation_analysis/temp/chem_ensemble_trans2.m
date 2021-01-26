    clear all
    close all

%% Parameters 1

      trans_start_time = 2.9297;
      trans_fin_time = 3.2257;
      trig_time = 3.495;

      filename = sprintf('D:/chem_output/20190823/chem_rmv/chem_10_rmv.dat');  %convert from, under the same directory
      presname = sprintf('C:/Users/atagi/Desktop/original/pressure/20190823/calc/PDown_hps20_lps300_20190823_10.dat'); %convert from, under the same directory
      filename_chemI_bps = 'C:/Users/atagi/Desktop/modified/chem_intensity/20190823/chem_Intensity_bps_20190823_10.dat';

%% Parameters 2

      nx= 1024;
      ny= 1024;
      nzall= 21839;
      Fs_chem= 10e3;
      Fs_spiv= 20e3;
      Fs_press= 20e3;
      pres_samp_time = 10;  % [sec]

%% Parameters 3

      hpsfreq = 20; % [Hz]
      lpsfreq = 300;   %  [Hz]

%% Matrix

      Sts_press = 1/Fs_press;    % [sec]
      Sts_chem = 1/Fs_chem;    % [sec]
      Sts_spiv = 1/Fs_spiv;    % [sec]
      Pixels=nx*ny;
      pres_datasize =Fs_press*pres_samp_time;
      chem_cam_start_time = trig_time - Sts_chem*nzall
      cam_start_time = trig_time - Sts_spiv*nzall
      taxis = Sts_press:Sts_press:pres_samp_time;
      chem_taxis = chem_cam_start_time:Sts_chem:chem_cam_start_time+Sts_chem*(nzall-1);
      before_transition_data_chem=floor(nzall -(trig_time - trans_start_time)/Sts_chem)%ok
      while_transition_data_chem=floor((trans_fin_time - trans_start_time)/Sts_chem)

      scrsz=get(groot,'ScreenSize');

%% CALCULATION 1

      fid1 = fopen(sprintf(presname),'r');
      K = fread(fid1,pres_datasize,'double');
      fclose(fid1);

      fid2 = fopen(sprintf(filename),'r');
      for idx=1:1:nzall
          I = fread(fid2,Pixels,'uint16');
          A(idx) = mean(mean(I));
      end
      fclose(fid2);

      HR1=0;
      for i=before_transition_data_chem:before_transition_data_chem+floor(while_transition_data_chem/10)
          HR1 = HR1 + A(i);
      end

      HR2=0;
      for i=before_transition_data_chem+floor(while_transition_data_chem/10):before_transition_data_chem+2*floor(while_transition_data_chem/10)
          HR2 = HR2 + A(i);
      end

      HR3=0;
      for i=before_transition_data_chem+2*floor(while_transition_data_chem/10):before_transition_data_chem+3*floor(while_transition_data_chem/10)
          HR3 = HR3 + A(i);
      end

      HR4=0;
      for i=before_transition_data_chem+3*floor(while_transition_data_chem/10):before_transition_data_chem+4*floor(while_transition_data_chem/10)
          HR4 = HR4 + A(i);
      end

      HR5=0;
      for i=before_transition_data_chem+4*floor(while_transition_data_chem/10):before_transition_data_chem+5*floor(while_transition_data_chem/10)
          HR5 = HR5 + A(i);
      end

      HR6=0;
      for i=before_transition_data_chem+5*floor(while_transition_data_chem/10):before_transition_data_chem+6*floor(while_transition_data_chem/10)
          HR6 = HR6 + A(i);
      end

      HR7=0;
      for i=before_transition_data_chem+6*floor(while_transition_data_chem/10):before_transition_data_chem+7*floor(while_transition_data_chem/10)
          HR7 = HR7 + A(i);
      end

      HR8=0;
      for i=before_transition_data_chem+7*floor(while_transition_data_chem/10):before_transition_data_chem+8*floor(while_transition_data_chem/10)
          HR8 = HR8 + A(i);
      end

      HR9=0;
      for i=before_transition_data_chem+8*floor(while_transition_data_chem/10):before_transition_data_chem+9*floor(while_transition_data_chem/10)
          HR9 = HR9 + A(i);
      end

      HR10=0;
      for i=before_transition_data_chem+9*floor(while_transition_data_chem/10):before_transition_data_chem+while_transition_data_chem
          HR10 = HR10 + A(i);
      end

      floor(HR1)
      floor(HR2)
      floor(HR3)
      floor(HR4)
      floor(HR5)
      floor(HR6)
      floor(HR7)
      floor(HR8)
      floor(HR9)
      floor(HR10)
      floor(HR1+HR2+HR3+HR4+HR5+HR6+HR7+HR8+HR9+HR10)

%% CALCULATION 2

      I_fft = fft(A);
      nI = length(I_fft);

      f = (0:nI-1)*(Fs_chem/nI);
      f = f';

      for i = 1:nI
         if (Fs_chem/2-abs(f(i)-Fs_chem/2) <= lpsfreq) && (Fs_chem/2-abs(f(i)-Fs_chem/2) >= hpsfreq)
             I_fft_bpsfil(i) = I_fft(i);
         elseif (Fs_chem/2-abs(f(i)-Fs_chem/2) > lpsfreq) || (Fs_chem/2-abs(f(i)-Fs_chem/2) < hpsfreq)
             I_fft_bpsfil(i) = 0;
         end
      end

      I_bpsfil = ifft(I_fft_bpsfil);

      fileID=fopen(filename_chemI_bps,'w');
      fwrite(fileID,I_bpsfil,'double');
      fclose(fileID);

%% MAKING FIGURE

        for idx=1:1:nzall
            B(idx) =  I_bpsfil(idx)- mean(I_bpsfil);
        end

        fig = figure;
        fig.Color='white';
        fig.Position=[50 50 960 735];

        pos1 = [0.12 0.20 0.80 0.20]; % left bottom width height
        subplot('Position',pos1)
        plot(chem_taxis,B,'k')

        ax = gca;
        xtickformat('%.2f')
        xticks([trans_start_time trans_start_time+0.1 trans_start_time+0.2 trans_start_time+0.3 trans_start_time+0.4 trans_start_time+0.5])
        set(gca,'xTickLabel', char('0.00','0.10','0.20','0.30','0.40','0.50'))
        ytickformat('%.3f')
        yticks([])
%         set(gca,'YTickLabel', char('','',''))

        xlim([trans_start_time trans_start_time+0.5]);
        ylim([-200 200]);

        ax.Box = 'on';
        ax.LineWidth = 2.0;
%         ax.XMinorTick = 'on';
%         ax.YMinorTick = 'on';

        xlabel('\it \fontname{Times New Roman} t \rm[sec]')
        ylabel('\it \fontname{Times New Roman} I''')
        set(gca,'FontName','Times New Roman','FontSize',30)
        hold on

        plot([trans_start_time trans_start_time],[-800 800],'m--','LineWidth',1.0)
        hold on

        plot([trans_fin_time trans_fin_time],[-800 800],'m--','LineWidth',1.0)
        hold off

        pos2 = [0.12 0.47 0.80 0.20];
        subplot('Position',pos2)
        plot(taxis,K,'k')

        ax = gca;
        xtickformat('%.2f')
        xticks([trans_start_time trans_start_time+0.1 trans_start_time+0.2 trans_start_time+0.3 trans_start_time+0.4 trans_start_time+0.5])
%         set(gca,'xTickLabel', char('0.00','0.10','0.20','0.30','0.40','0.50'))
        set(gca,'xTickLabel', char('','','','','',''))
        ytickformat('%.3f')
        yticks([])
%         set(gca,'YTickLabel', char('','',''))

        xlim([trans_start_time trans_start_time+0.5]);
%         ylim([-0.20 0.20]);

        ax.Box = 'on';
        ax.LineWidth = 2.0;
%         ax.XMinorTick = 'on';
%         ax.YMinorTick = 'on';

%         xlabel('\it \fontname{Times New Roman} t \rm[sec]')
        ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
        set(gca,'FontName','Times New Roman','FontSize',30)
        hold on

        plot([trans_start_time trans_start_time],[-0.40 0.40],'m--','LineWidth',1.0)
        hold on

        plot([trans_fin_time trans_fin_time],[-0.40 0.40],'m--','LineWidth',1.0)
        hold off
