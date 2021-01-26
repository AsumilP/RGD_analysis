    clear all
    close all

%% Parameters 1
    
      trans_start_time = 2.7729;
      trans_fin_time = 3.1957;
      trig_time = 3.5188;

      filename = 'chem_Intensity_bps_20190301_06.dat';  %convert from, under the same directory
      presname = 'PDown_hps20_lps300_20190301_06.dat'; %convert from, under the same directory
      
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

%% CALCULATION 1

      fid1 = fopen(sprintf(presname),'r');
      K = fread(fid1,pres_datasize,'double');
      fclose(fid1);
      
      fid2 = fopen(sprintf(filename),'r');
        I_bpsfil = fread(fid2,nzall,'double');
        fclose(fid2);
 
%% MAKING FIGURE

        for idx=1:1:nzall
            B(idx) =  I_bpsfil(idx)- mean(I_bpsfil);
        end

        fig = figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

        pos1 = [0.12 0.20 0.80 0.20]; % left bottom width height
        subplot('Position',pos1)
        plot(chem_taxis,B,'k')
        
        ax = gca;
        xtickformat('%.2f')
%         xticks([trans_start_time trans_start_time+0.02 trans_start_time+0.04 trans_start_time+0.06 trans_start_time+0.08 trans_start_time+0.1])
%         set(gca,'xTickLabel', char('0.00','0.02','0.04','0.06','0.08','0.10'))
%         xticks([trans_start_time+0.2 trans_start_time+0.22 trans_start_time+0.24 trans_start_time+0.26 trans_start_time+0.28 trans_start_time+0.3])
%         set(gca,'xTickLabel', char('0.20','0.22','0.24','0.26','0.28','0.30'))
%         xticks([trans_start_time+0.3 trans_start_time+0.32 trans_start_time+0.34 trans_start_time+0.36 trans_start_time+0.38 trans_start_time+0.4])
%         set(gca,'xTickLabel', char('0.30','0.32','0.34','0.36','0.38','0.40'))
        xticks([trans_start_time+0.38 trans_start_time+0.40 trans_start_time+0.42 trans_start_time+0.44 trans_start_time+0.46 trans_start_time+0.48])
        set(gca,'xTickLabel', char('0.38','0.40','0.42','0.44','0.46','0.48'))
        ytickformat('%.3f')
        yticks([-300 0 300])
        set(gca,'YTickLabel', char('-300','0','300'))
%         yticks([-150 0 150])
%         set(gca,'YTickLabel', char('-150','0','150'))

%         xlim([trans_start_time trans_start_time+0.1]);
%         xlim([trans_start_time+0.24 trans_start_time+0.3]);
%         xlim([trans_start_time+0.34 trans_start_time+0.4]);
        xlim([trans_start_time+0.38 trans_start_time+0.44]);
        ylim([-300 300]);
%         ylim([-150 150]);

        xlabel('\it \fontname{Times New Roman} t \rm[sec]')
        ylabel('\it \fontname{Times New Roman} I''')
        set(gca,'FontName','Times New Roman','FontSize',30)
        hold on

        plot([trans_start_time trans_start_time],[-800 800],'m--','LineWidth',2.0)
        hold on

        plot([trans_fin_time trans_fin_time],[-800 800],'m--','LineWidth',2.0)
        hold off
         
        pos2 = [0.12 0.47 0.80 0.20];
        subplot('Position',pos2)
        plot(taxis,K,'k')

        ax = gca;
        xtickformat('%.2f')
%         xticks([trans_start_time trans_start_time+0.02 trans_start_time+0.04 trans_start_time+0.06 trans_start_time+0.08 trans_start_time+0.1])
%         set(gca,'xTickLabel', char('0.00','0.02','0.04','0.06','0.08','0.10'))
%         set(gca,'xTickLabel', char('','','','','',''))
%         xticks([trans_start_time+0.2 trans_start_time+0.22 trans_start_time+0.24 trans_start_time+0.26 trans_start_time+0.28 trans_start_time+0.3])
%         set(gca,'xTickLabel', char('0.20','0.22','0.24','0.26','0.28','0.30'))
        set(gca,'xTickLabel', char('','','','','',''))
%         xticks([trans_start_time+0.3 trans_start_time+0.32 trans_start_time+0.34 trans_start_time+0.36 trans_start_time+0.38 trans_start_time+0.4])
%         set(gca,'xTickLabel', char('0.30','0.32','0.34','0.36','0.38','0.40'))
        xticks([trans_start_time+0.38 trans_start_time+0.40 trans_start_time+0.42 trans_start_time+0.44 trans_start_time+0.46 trans_start_time+0.48])
%         set(gca,'xTickLabel', char('0.38','0.40','0.42','0.44','0.46','0.48'))
%         set(gca,'xTickLabel', char('','','','','',''))
        ytickformat('%.3f')
        yticks([-0.25 0 0.25])
        set(gca,'YTickLabel', char('-0.25','0.00','0.25'))
%         yticks([-0.10 0 0.10])
%         set(gca,'YTickLabel', char('-0.10','0.00','0.10'))
        
%         xlim([trans_start_time trans_start_time+0.1]);
%         xlim([trans_start_time+0.24 trans_start_time+0.3]);
%         xlim([trans_start_time+0.34 trans_start_time+0.4]);
        xlim([trans_start_time+0.38 trans_start_time+0.44]);
        ylim([-0.25 0.25]);
%         ylim([-0.10 0.10]);

%         xlabel('\it \fontname{Times New Roman} t \rm[sec]')
        ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
        set(gca,'FontName','Times New Roman','FontSize',30)
        hold on

        plot([trans_start_time trans_start_time],[-0.40 0.40],'m--','LineWidth',2.0)
        hold on

        plot([trans_fin_time trans_fin_time],[-0.40 0.40],'m--','LineWidth',2.0)
        hold off
   