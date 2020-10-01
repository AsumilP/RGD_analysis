     clear all
     close all
     clc

%% PARAMETERS

     fs_pres = 20e3; % Sampling Rate
     pres_samp_time = 15; % [sec]
     prof_upper = 20/10; % [kPa/V]
     prof_down = 0.5; % [kPa/V]

     fft_dbl_type = 1; % 1. ^v^v 2. ^vv^ 3. ^v
     hpsfreq = 20; % [Hz]
     lpsfreq = 300; % [Hz]
     fchange_hpsfreq = 0; % [Hz]
     fchange_lpsfreq = 2; % [Hz]
     fft_mean_type = 1;
     fft_mean_tlength = 1; % [s]

     date = 20200908;
     recnum = 31;
     input_sw = 1; % 0: noinput
     speaker_voltage = 1; % [V]
     speaker_duration = 7.5; % [s]
     speaker_lf = 0; % [Hz]
     speaker_hf = 350; % [Hz]
     lduct = 582; % [mm]
     figex = '.fig'; % fig, png
     fig_vis = 0;
     nnc = 0;

%%
     for num = 1:recnum

%% READ DATA

        dir = sprintf('H:/Analysis/pressure/%d/calc/',date);
        if input_sw == 1
            rfn = sprintf('pressure_speaker_%d-%dHz_%dV_%gs_d%d_%d.xlsx',speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
        elseif input_sw == 0
            rfn = sprintf('pressure_speaker_noinput_%d.xlsx',num);
        end
        upv = xlsread(append(dir,rfn), sprintf('B2:B%d',fs_pres*pres_samp_time+1));
        dpv = xlsread(append(dir,rfn), sprintf('C2:C%d',fs_pres*pres_samp_time+1));
        spv = xlsread(append(dir,rfn), sprintf('D2:D%d',fs_pres*pres_samp_time+1));

%% OUTPUT FILE

        if input_sw == 1

            fnpu = sprintf('ppu_spk_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
            fnpu = append(dir, fnpu);
            fnpups = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
            fnpups = append(dir, fnpups);
            fnpuang = sprintf('ppu_spk_ang_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
            fnpuang = append(dir, fnpuang);
            fnpd = sprintf('ppd_spk_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
            fnpd = append(dir, fnpd);
            fnpdps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
            fnpdps = append(dir, fnpdps);
            fnpdang = sprintf('ppd_spk_ang_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
            fnpdang = append(dir, fnpdang);
            fnspv = sprintf('spv_spk_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
            fnspv = append(dir, fnspv);
            fnspvps = sprintf('spv_spk_ps_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
            fnspvps = append(dir, fnspvps);
            fnspvang = sprintf('spv_spk_ang_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
            fnspvang = append(dir, fnspvang);
            fnfps = sprintf('p_spk_ps_f_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
            fnfps = append(dir, fnfps);
            fnspvf = sprintf('f_spk_ps_%d-%dHz_%dV_%gs_d%d_%02u.dat', hpsfreq, lpsfreq, speaker_voltage, speaker_duration, lduct, num);
            fnspvf = append(dir, fnspvf);

            if fig_vis == 1

              figp = sprintf('p_spk_%d-%dHz_%dV_%gs_d%d_%02u', hpsfreq, lpsfreq, speaker_voltage, speaker_duration, lduct, num);
              figv = sprintf('v_spk_%d-%dHz_%dV_%gs_d%d_%02u', hpsfreq, lpsfreq, speaker_voltage, speaker_duration, lduct, num);
              figf = sprintf('f_spk_%d-%dHz_%dV_%gs_d%d_%02u', hpsfreq, lpsfreq, speaker_voltage, speaker_duration, lduct, num);

            end

            figfp = sprintf('fp_spk_av_%d-%dHz_%dV_%gs_d%d', hpsfreq, lpsfreq, speaker_voltage, speaker_duration, lduct);
            figfps = sprintf('fps_spk1_av_%d-%dHz_%dV_%gs_d%d', hpsfreq, lpsfreq, speaker_voltage, speaker_duration, lduct);
            figfps_spk = sprintf('fps_spk2_av_%d-%dHz_%dV_%gs_d%d', hpsfreq, lpsfreq, speaker_voltage, speaker_duration, lduct);
            figfang = sprintf('fang_spk1_av_%d-%dHz_%dV_%gs_d%d', hpsfreq, lpsfreq, speaker_voltage, speaker_duration, lduct);
            figfang_spk = sprintf('fang_spk2_av_%d-%dHz_%dV_%gs_d%d', hpsfreq, lpsfreq, speaker_voltage, speaker_duration, lduct);

        elseif  input_sw == 0

            fnpu = sprintf('ppu_spk_noinput_%02u.dat',num);
            fnpu = append(dir, fnpu);
            fnpups = sprintf('ppu_spk_ps_noinput_%02u.dat',num);
            fnpups = append(dir, fnpups);
            fnpuang = sprintf('ppu_spk_ang_noinput_%02u.dat',num);
            fnpuang = append(dir, fnpuang);
            fnpd = sprintf('ppd_spk_noinput_%02u.dat',num);
            fnpd = append(dir, fnpd);
            fnpdps = sprintf('ppd_spk_ps_noinput_%02u.dat',num);
            fnpdps = append(dir, fnpdps);
            fnpdang = sprintf('ppd_spk_ang_noinput_%02u.dat',num);
            fnpdang = append(dir, fnpdang);
            fnspv = sprintf('spv_spk_noinput_%02u.dat',num);
            fnspv = append(dir, fnspv);
            fnspvps = sprintf('spv_spk_ps_noinput_%02u.dat',num);
            fnspvps = append(dir, fnspvps);
            fnspvang = sprintf('spv_spk_ang_noinput_%02u.dat',num);
            fnspvang = append(dir, fnspvang);
            fnfps = sprintf('p_spk_ps_f_noinput_%02u.dat',num);
            fnfps = append(dir, fnfps);
            fnspvf = sprintf('f_spk_ps_noinput_%02u.dat',num);
            fnspvf = append(dir, fnspvf);

            if fig_vis == 1

              figp = sprintf('p_spk_noinput_%02u',num);
              figv = sprintf('v_spk_noinput_%02u',num);
              figf = sprintf('f_spk_noinput_%02u',num);

            end

            figfp = sprintf('fp_spk_av_noinput');
            figfps = sprintf('fps_spk1_av_noinput');
            figfps_spk = sprintf('fps_spk2_av_noinput');
            figfang = sprintf('fang_spk1_av_noinput');
            figfang_spk = sprintf('fang_spk2_av_noinput');

        end

%% MATRIX

        ts_pres =1/fs_pres; %  [sec]
        pres_datasize = fs_pres*pres_samp_time;
        taxis_all = ts_pres:ts_pres:pres_datasize*ts_pres;
        ppu = upv*prof_upper;
        ppd = dpv*prof_down;
        nnc = nnc + 1;

%% BAND-PASS-FILTER

        [ppu] = band_pass_filter(ppu, fs_pres, lpsfreq, hpsfreq, fft_dbl_type);
        [ppd] = band_pass_filter(ppd, fs_pres, lpsfreq, hpsfreq, fft_dbl_type);
        [spv] = band_pass_filter(spv, fs_pres, speaker_hf, 0, fft_dbl_type); % f should be more than 1/speaker_duration.

        fileID=fopen(fnpu,'w');
        fwrite(fileID,ppu,'double');
        fclose(fileID);

        fileID=fopen(fnpd,'w');
        fwrite(fileID,ppd,'double');
        fclose(fileID);

        fileID=fopen(fnspv,'w');
        fwrite(fileID,spv,'double');
        fclose(fileID);

%% SPEAKER-FREQUENCY-CHANGE

        [fchange] = trace_frequency(spv, fs_pres, taxis_all, speaker_hf, speaker_lf, fchange_lpsfreq, fchange_hpsfreq, fft_dbl_type);

        fileID=fopen(fnspvf,'w');
        fwrite(fileID,fchange,'double');
        fclose(fileID);

%% POWER SPECTRA

        [abs_freq_ppu, av_ang_ppu, fps, div_nlength] = fft_meanspec(ppu, fs_pres, fft_mean_tlength, 0, fft_dbl_type, fft_mean_type);
        [abs_freq_ppd, av_ang_ppd, fps, div_nlength] = fft_meanspec(ppd, fs_pres, fft_mean_tlength, 0, fft_dbl_type, fft_mean_type);
        [abs_freq_spv, av_ang_spv, fps, div_nlength] = fft_meanspec(spv, fs_pres, fft_mean_tlength, 0, fft_dbl_type, fft_mean_type);

        fileID = fopen(fnpups,'w');
        fwrite(fileID,abs_freq_ppu,'double');
        fclose(fileID);

        fileID = fopen(fnpdps,'w');
        fwrite(fileID,abs_freq_ppd,'double');
        fclose(fileID);

        fileID = fopen(fnspvps,'w');
        fwrite(fileID,abs_freq_spv,'double');
        fclose(fileID);

        fileID = fopen(fnpuang,'w');
        fwrite(fileID,av_ang_ppu,'double');
        fclose(fileID);

        fileID = fopen(fnpdang,'w');
        fwrite(fileID,av_ang_ppd,'double');
        fclose(fileID);

        fileID = fopen(fnspvang,'w');
        fwrite(fileID,av_ang_spv,'double');
        fclose(fileID);

        fileID = fopen(fnfps,'w');
        fwrite(fileID,fps,'double');
        fclose(fileID);

%% FIGURE, PRESSURE FLUCTUATION

        if fig_vis == 1

          figure('Position', [50 50 960 735],'Color','white');
          plot(taxis_all,ppu,'-r')
          hold on
          plot(taxis_all,ppd,'-b')

          ax = gca;
          ax.Box = 'on';
          ax.LineWidth = 2.0;
          ax.XMinorTick = 'on';
          ax.YMinorTick = 'on';

          xtickformat('%.f')
          ytickformat('%.1f')

          xlim([0 pres_samp_time]);
          ylim([-0.4 0.4]);

          xlabel('\it \fontname{Times New Roman} t \rm[sec]')
          ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
          set(gca,'FontName','Times New Roman','FontSize',20)
          legend({'Upstream','Downstream'},'Location','northeast')
          hold off
          pbaspect([sqrt(2) 1 1]);
          saveas(gcf, strcat(dir, figp, figex));
          close;

        end

%% FIGURE, SPEAKER-INPUT-VOLTAGE

        if fig_vis == 1

          figure('Position', [50 50 960 735],'Color','white');
          plot(taxis_all,spv,'--k')

          ax = gca;
          ax.Box = 'on';
          ax.LineWidth = 2.0;
          ax.XMinorTick = 'on';
          ax.YMinorTick = 'on';

          xtickformat('%.f')
          ytickformat('%.1f')

          xlim([0 pres_samp_time]);
          ylim([-speaker_voltage-0.5 speaker_voltage+0.5]);

          xlabel('\it \fontname{Times New Roman} t \rm[sec]')
          ylabel('\rm \fontname{Times New Roman} Input \rm[V]')
          set(gca,'FontName','Times New Roman','FontSize',20)
          hold off
          pbaspect([sqrt(2) 1 1]);
          saveas(gcf, strcat(dir, figv, figex));
          close;

        end

%% FIGURE, SPEAKER-FREQUENCY-CHANGE

        if fig_vis == 1

          figure('Position', [50 50 960 735],'Color','white');
          plot(taxis_all,fchange,'-k')

          ax = gca;
          ax.Box = 'on';
          ax.LineWidth = 2.0;
          ax.XMinorTick = 'on';
          ax.YMinorTick = 'on';

          xtickformat('%.f')
          ytickformat('%.f')

          xlim([0 pres_samp_time]);
          ylim([speaker_lf speaker_hf+50]);

          xlabel('\it \fontname{Times New Roman} t \rm[sec]')
          ylabel('\it \fontname{Times New Roman} f \rm[Hz]')
          set(gca,'FontName','Times New Roman','FontSize',20)
          pbaspect([sqrt(2) 1 1]);
          saveas(gcf, strcat(dir, figf, figex));
          close;

        end

%% FIGURE, POWER SPECTRA

        if fig_vis == 1

          figure('Position', [50 50 960 735],'Color','white');
          % yyaxis left
          loglog(fps, abs_freq_ppu, '-^r')
          hold on
          loglog(fps, abs_freq_ppd, '-vb')

          ax = gca;
          ax.Box = 'on';
          ax.LineWidth = 2.0;
          ax.XMinorTick = 'on';
          ax.YMinorTick = 'on';

          xlim([hpsfreq lpsfreq]);
          ylim([5 300]);

          xlabel('\it \fontname{Times New Roman} f \rm[Hz]')
          ylabel('\it \fontname{Times New Roman} P \rm[kPa]')
          set(gca,'FontName','Times New Roman','FontSize',20)
          legend({'Upstream','Downstream'},'Location','southeast')
          hold on

          % yyaxis right
          % loglog(f, abs_freq_spv, 'k')
          %
          % ax = gca;
          % ax.Box = 'on';
          % ax.LineWidth = 2.0;
          % ax.XMinorTick = 'on';
          % ax.YMinorTick = 'on';
          %
          % xlim([hpsfreq lpsfreq]);
          %
          % xlabel('\it \fontname{Times New Roman} f \rm[Hz]')
          % ylabel('\it \fontname{Times New Roman} P \rm[V]')
          % set(gca,'FontName','Times New Roman','FontSize',20)
          hold off
          pbaspect([sqrt(2) 1 1]);
          close;

        end

%%
    end

%% AVERAGED DISTRIBUTION f-p'

    if input_sw == 1

      ppurms = zeros(lpsfreq - hpsfreq +1, nnc, 1);
      ppdrms = zeros(lpsfreq - hpsfreq +1, nnc, 1);
      nn = zeros(lpsfreq - hpsfreq +1, nnc, 1);
      f = hpsfreq:1:lpsfreq;
      f = f';

      for num = 1:recnum

        fnpu = sprintf('ppu_spk_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
        fnpu = append(dir, fnpu);
        fnpd = sprintf('ppd_spk_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
        fnpd = append(dir, fnpd);
        fnspvf = sprintf('f_spk_ps_%d-%dHz_%dV_%gs_d%d_%02u.dat', hpsfreq, lpsfreq, speaker_voltage, speaker_duration, lduct, num);
        fnspvf = append(dir, fnspvf);

        fid = fopen(fnpu,'r');
        ppu = fread(fid,pres_datasize,'double');
        fclose(fid);
        fid = fopen(fnpd,'r');
        ppd = fread(fid,pres_datasize,'double');
        fclose(fid);
        fid = fopen(fnspvf,'r');
        fchange = fread(fid,pres_datasize,'double');
        fclose(fid);

        for k = 1:pres_datasize
          for l = 1:1:lpsfreq - hpsfreq + 1
            if (fchange(k) >= l + hpsfreq - 1.5 ) && (fchange(k) < l + hpsfreq - 0.5 )
              nn(l, num) = nn(l, num) + 1;
              ppun(l,nn(l, num)) = ppu(k);
              ppdn(l,nn(l, num)) = ppd(k);
            end
          end
        end

        for l = 1:1:lpsfreq - hpsfreq +1
          ppurms(l, num) = rms(ppun(l,:)-mean(ppun(l,:)));
          ppdrms(l, num) = rms(ppdn(l,:)-mean(ppdn(l,:)));
        end

      end

      ppurms_av = mean(ppurms(:, :),2);
      ppdrms_av = mean(ppdrms(:, :),2);

    end

%% AVERAGED POWER SPECTRA

     ppups_av = zeros(div_nlength, 1, 1);
     ppuang_av = zeros(div_nlength, 1, 1);
     ppdps_av = zeros(div_nlength, 1, 1);
     ppdang_av = zeros(div_nlength, 1, 1);
     spvps_av = zeros(div_nlength, 1, 1);
     spvang_av = zeros(div_nlength, 1, 1);

     for num = 1:recnum

         if input_sw == 1

             fnpups = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
             fnpups = append(dir, fnpups);
             fnpdps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
             fnpdps = append(dir, fnpdps);
             fnspvps = sprintf('spv_spk_ps_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
             fnspvps = append(dir, fnspvps);

             fnpuang = sprintf('ppu_spk_ang_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
             fnpuang = append(dir, fnpuang);
             fnpdang = sprintf('ppd_spk_ang_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
             fnpdang = append(dir, fnpdang);
             fnspvang = sprintf('spv_spk_ang_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
             fnspvang = append(dir, fnspvang);

             fnfps = sprintf('p_spk_ps_f_%d-%dHz_%dV_%gs_d%d_%02u.dat', speaker_lf, speaker_hf, speaker_voltage, speaker_duration, lduct, num);
             fnfps = append(dir, fnfps);

         elseif input_sw == 0

             fnpups = sprintf('ppu_spk_ps_noinput_%02u.dat',num);
             fnpups = append(dir, fnpups);
             fnpdps = sprintf('ppd_spk_ps_noinput_%02u.dat',num);
             fnpdps = append(dir, fnpdps);
             fnspvps = sprintf('spv_spk_ps_noinput_%02u.dat',num);
             fnspvps = append(dir, fnspvps);

             fnpuang = sprintf('ppu_spk_ang_noinput_%02u.dat',num);
             fnpuang = append(dir, fnpuang);
             fnpdang = sprintf('ppd_spk_ang_noinput_%02u.dat',num);
             fnpdang = append(dir, fnpdang);
             fnspvang = sprintf('spv_spk_ang_noinput_%02u.dat',num);
             fnspvang = append(dir, fnspvang);

             fnfps = sprintf('p_spk_ps_f_noinput_%02u.dat',num);
             fnfps = append(dir, fnfps);

         end

         fid = fopen(fnpups,'r');
         ppups = fread(fid,div_nlength,'double');
         fclose(fid);
         fid = fopen(fnpdps,'r');
         ppdps = fread(fid,div_nlength,'double');
         fclose(fid);
         fid = fopen(fnspvps,'r');
         spvps = fread(fid,div_nlength,'double');
         fclose(fid);

         fid = fopen(fnpuang,'r');
         ppuang = fread(fid,div_nlength,'double');
         fclose(fid);
         fid = fopen(fnpdang,'r');
         ppdang = fread(fid,div_nlength,'double');
         fclose(fid);
         fid = fopen(fnspvang,'r');
         spvang = fread(fid,div_nlength,'double');
         fclose(fid);

         fid = fopen(fnfps,'r');
         fps = fread(fid,div_nlength,'double');
         fclose(fid);

         ppups_av = ppups_av + ppups/nnc;
         ppdps_av = ppdps_av + ppdps/nnc;
         spvps_av = spvps_av + spvps/nnc;

         ppuang_av = ppuang_av + ppuang/nnc;
         ppdang_av = ppdang_av + ppdang/nnc;
         spvang_av = spvang_av + spvang/nnc;

     end

%% FIGURE, AVERAGED DISTRIBUTION f-p'rms

        if input_sw == 1

            figure('Position', [50 50 960 735],'Color','white');
%             loglog(f,ppurms_av,'-^','MarkerSize',8,'MarkerFaceColor','w','Color','r')
            semilogx(f,ppurms_av,'-^','MarkerSize',8,'MarkerFaceColor','w','Color','r')
            hold on
%             loglog(f,ppdrms_av,'-v','MarkerSize',8,'MarkerFaceColor','w','Color','b')
            semilogx(f,ppdrms_av,'-v','MarkerSize',8,'MarkerFaceColor','w','Color','b')

            ax = gca;
            ax.Box = 'on';
            ax.LineWidth = 2.0;
            ax.XMinorTick = 'on';
            ax.YMinorTick = 'on';

            xtickformat('%.f')
            ytickformat('%.2f')

            xlim([hpsfreq lpsfreq]);
            ylim([0.001 0.2]);

            xlabel('\it \fontname{Times New Roman} f \rm[Hz]')
            ylabel('\it \fontname{Times New Roman} p''_{rms} \rm[kPa]')
            set(gca,'FontName','Times New Roman','FontSize',20)
            legend({'Upstream','Downstream'},'Location','northeast')
            hold off
            pbaspect([sqrt(2) 1 1]);
            saveas(gcf, strcat(dir, figfp, figex));
%             close;

        end

%% FIGURE, AVERAGED POWER SPECTRA, pressure

        figure('Position', [50 50 960 735],'Color','white');
        loglog(fps,ppups_av,'-^','MarkerSize',8,'MarkerFaceColor','w','Color','r')
        hold on
        loglog(fps,ppdps_av,'-v','MarkerSize',8,'MarkerFaceColor','w','Color','b')

        ax = gca;
        ax.Box = 'on';
        ax.LineWidth = 2.0;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';

        xtickformat('%d')
        ytickformat('%d')

        xlim([hpsfreq lpsfreq]);
        ylim([5 300]);

        xlabel('\it \fontname{Times New Roman} f \rm[Hz]')
        ylabel('\it \fontname{Times New Roman} P \rm[kPa]')
        set(gca,'FontName','Times New Roman','FontSize',20)
        legend({'Upstream','Downstream'},'Location','southeast')
        hold off
        pbaspect([sqrt(2) 1 1]);
        saveas(gcf, strcat(dir, figfps, figex));
%         close;

%% FIGURE, AVERAGED POWER SPECTRA, speaker_input

        figure('Position', [50 50 960 735],'Color','white');
        loglog(fps,spvps_av,'-','MarkerSize',8,'MarkerFaceColor','w','Color','k')

        ax = gca;
        ax.Box = 'on';
        ax.LineWidth = 2.0;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';

        xtickformat('%d')
        ytickformat('%d')

        xlim([hpsfreq lpsfreq]);
        % ylim([5 300]);

        xlabel('\it \fontname{Times New Roman} f \rm[Hz]')
        ylabel('\it \fontname{Times New Roman} V \rm[V]')
        set(gca,'FontName','Times New Roman','FontSize',20)
        legend({'Input voltage'},'Location','southeast')
        hold off
        pbaspect([sqrt(2) 1 1]);
        saveas(gcf, strcat(dir, figfps_spk, figex));
%         close;

%% FIGURE, AVERAGED PHASE RESPONSE, pressure

        figure('Position', [50 50 960 735],'Color','white');
%         loglog(fps,ppuang_av,'-^','MarkerSize',8,'MarkerFaceColor','w','Color','r')
        semilogx(fps,ppuang_av,'-^','MarkerSize',8,'MarkerFaceColor','w','Color','r')
        hold on
%         loglog(fps,ppdang_av,'-v','MarkerSize',8,'MarkerFaceColor','w','Color','b')
        semilogx(fps,ppdang_av,'-v','MarkerSize',8,'MarkerFaceColor','w','Color','b')

        ax = gca;
        ax.Box = 'on';
        ax.LineWidth = 2.0;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';

        xtickformat('%d')
        ytickformat('%.2f')

        xlim([hpsfreq lpsfreq]);
        % ylim([-20 120]);

        xlabel('\it \fontname{Times New Roman} f \rm[Hz]')
        ylabel('\it \fontname{Times New Roman} radians /\pi')
        set(gca,'FontName','Times New Roman','FontSize',20)
        legend({'Upstream','Downstream'},'Location','southeast')
        hold off
        pbaspect([sqrt(2) 1 1]);
        saveas(gcf, strcat(dir, figfang, figex));
%         close;

%% FIGURE, AVERAGED PHASE RESPONSE, speaker_input

        figure('Position', [50 50 960 735],'Color','white');
%         loglog(fps,spvang_av,'-','MarkerSize',8,'MarkerFaceColor','w','Color','k')
        semilogx(fps,spvang_av,'-','MarkerSize',8,'MarkerFaceColor','w','Color','k')

        ax = gca;
        ax.Box = 'on';
        ax.LineWidth = 2.0;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';

        xtickformat('%d')
        ytickformat('%.2f')

        xlim([hpsfreq lpsfreq]);
        % ylim([5 300]);

        xlabel('\it \fontname{Times New Roman} f \rm[Hz]')
        ylabel('\it \fontname{Times New Roman} radians /\pi')
        set(gca,'FontName','Times New Roman','FontSize',20)
        legend({'Input voltage'},'Location','southeast')
        hold off
        pbaspect([sqrt(2) 1 1]);
        saveas(gcf, strcat(dir, figfang_spk, figex));
%         close;
