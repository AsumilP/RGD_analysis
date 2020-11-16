     clear all
     close all
     clc

%% PARAMETERS

        fs_pres = 20e3; % Sampling Rate
        pres_samp_time = 15; % [sec]

        fft_dbl_type = 2; % 1. ^v^v 2. ^vv^ 3. ^v
        hpsfreq = 20; % [Hz]
        lpsfreq = 350; % [Hz]
        fchange_hpsfreq = 0; % [Hz]
        fchange_lpsfreq = 7; % [Hz]
        fft_mean_type = 1;
        fft_mean_tlength = 2; % [s]

        speaker_voltage = 1; % [V]
        speaker_duration = 15; % [s]
        speaker_lf = 0.01; % [Hz]
        speaker_hf = 350; % [Hz]

%% Theoritical waves

        k = (speaker_hf-speaker_lf)/speaker_duration;
    
        for t = 1:speaker_duration*fs_pres
            phi(t) = 0 + 2*pi*(speaker_lf*t/fs_pres + k/2*t*t/fs_pres/fs_pres);
%             phi(t) = 2*pi*speaker_lf*(k^(t/fs_pres)-1)/log(k);
        end
    
        spv = sin(phi).';

%% MATRIX

        ts_pres = 1/fs_pres; %  [sec]
        pres_datasize = fs_pres*pres_samp_time;
        taxis_all = ts_pres:ts_pres:speaker_duration;

%% BAND-PASS-FILTER

%         [spv] = band_pass_filter(spv, fs_pres, speaker_hf, 0, fft_dbl_type); % f should be more than 1/speaker_duration.

%% SPEAKER-FREQUENCY-CHANGE

        [fchange] = trace_frequency(spv, fs_pres, taxis_all, speaker_hf, speaker_lf, fchange_lpsfreq, fchange_hpsfreq, fft_dbl_type);

%% POWER SPECTRA

        [abs_freq_spv, av_ang_spv, fps, div_nlength] = fft_meanspec(spv, fs_pres, fft_mean_tlength, 0, fft_dbl_type, fft_mean_type);

%% FIGURE, SPEAKER-INPUT-VOLTAGE

          figure('Position', [50 50 960 735],'Color','white');
          plot(taxis_all,spv,'-k')

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

%% FIGURE, SPEAKER-FREQUENCY-CHANGE

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

%% FIGURE, AVERAGED POWER SPECTRA, speaker_input

        figure('Position', [50 50 960 735],'Color','white');
        loglog(fps,abs_freq_spv,'-','MarkerSize',8,'MarkerFaceColor','w','Color','k')

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

%% FIGURE, AVERAGED PHASE RESPONSE, speaker_input
% 
%         figure('Position', [50 50 960 735],'Color','white');
%         loglog(fps,av_ang_spv,'-','MarkerSize',8,'MarkerFaceColor','w','Color','k')
% %         semilogx(fps,av_ang_spv,'-','MarkerSize',8,'MarkerFaceColor','w','Color','k')
% 
%         ax = gca;
%         ax.Box = 'on';
%         ax.LineWidth = 2.0;
%         ax.XMinorTick = 'on';
%         ax.YMinorTick = 'on';
% 
%         xtickformat('%d')
%         ytickformat('%.2f')
% 
%         xlim([hpsfreq lpsfreq]);
%         % ylim([5 300]);
% 
%         xlabel('\it \fontname{Times New Roman} f \rm[Hz]')
%         ylabel('\it \fontname{Times New Roman} radians /\pi')
%         set(gca,'FontName','Times New Roman','FontSize',20)
%         legend({'Input voltage'},'Location','southeast')
%         hold off
%         pbaspect([sqrt(2) 1 1]);
