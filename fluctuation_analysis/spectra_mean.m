    clear all
    close all
    clc

%% PARAMETERS

    signal_type = 2; % 1. p_sequence, 2. p_cER, 3. speaker, 4. p_noinput
    up_or_dwn = 1; % 1. upperstream 2. downstream, when signal_type = 1 or 2 or 3

    fft_dbl_type = 2; % 1. ^v^v 2. ^vv^ 3. ^v
    hpsfreq = 20;
    lpsfreq = 3000;
    fft_mean_type = 1;
    fft_mean_tlength = 1; % [s]

    date = 20201120;
    num_start = 1;
    num_end = 1;
    flow_rate = 500; % [L/min], signal_type = 1,2
    eq_ratio = 0.76; % signal_type = 1,2
    lduct = 1185; % [mm], signal_type = 2,3
    speaker_voltage = 1; % [V], signal_type = 3
    speaker_duration = 15; % [s], signal_type = 3
%     speaker_lf = 0; %%% [Hz], signal_type = 3
%     speaker_hf = 350; %%% [Hz], signal_type = 3
    speaker_lf_start = 40; %%%
    speaker_lf_end = 300; %%%

    calc_start_time = 0; % [s], trans_start_time
    calc_fin_time = 15; % [s], trans_fin_time
    calc_data_length = 1; % [s] >= fft_mean_tlength, signal_type = 1

    figex = '.png'; % fig, png

%% PARAMETERS, fixed

    if (signal_type == 1) || (signal_type == 2) || (signal_type == 3) || (signal_type == 4)

      Fs = 20e3;
      Sts = 1/Fs; % [sec]
      %pres_samp_time = 10; % [sec] NEED TO BE CHANGED
      pres_samp_time = 15; % [sec] NEED TO BE CHANGED
      datasize = Fs*pres_samp_time;
      calc_start_point = floor(calc_start_time/Sts)
      calc_fin_point = floor(calc_fin_time/Sts)
      abs_calc_fft_av = zeros(Fs*fft_mean_tlength,1,1);
      abs_btrans_fft_av = zeros(Fs*fft_mean_tlength,1,1);
      abs_atrans_fft_av = zeros(Fs*fft_mean_tlength,1,1);
      nn = 0;

    elseif signal_type == 5

    end
        
%     for speaker_lf = speaker_lf_start:10:speaker_lf_end %%%
%       speaker_hf = speaker_lf + 15; %%%

      for num = num_start:1:num_end
          
%% READ
%
        if signal_type == 1
          if up_or_dwn == 1

            dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
            fnubps = sprintf('PUpper_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
            fnupsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%d_%02u.dat',flow_rate,eq_ratio,fft_mean_tlength,date,num);
            fnupsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%d_%02u.dat',flow_rate,eq_ratio,fft_mean_tlength,date,num);
            fnupsb_av = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%d_av.dat',flow_rate,eq_ratio,fft_mean_tlength,date);
            fnupsa_av = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%d_av.dat',flow_rate,eq_ratio,fft_mean_tlength,date);
            fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
            fni = append(dir,fnubps);
            fnpsb = append(dir,fnupsb);
            fnpsa = append(dir,fnupsa);
            fnpsb_av = append(dir,fnupsb_av);
            fnpsa_av = append(dir,fnupsa_av);
            fnaxis = append(dir,fnaxis);

          elseif up_or_dwn == 2

            dir = sprintf('H:/Analysis/pressure/%d/calc/',date);
            fndbps = sprintf('PDown_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
            fndpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%d_%02u.dat',flow_rate,eq_ratio,fft_mean_tlength,date,num);
            fndpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%d_%02u.dat',flow_rate,eq_ratio,fft_mean_tlength,date,num);
            fndpsb_av = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%d_av.dat',flow_rate,eq_ratio,fft_mean_tlength,date);
            fndpsa_av = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%d_av.dat',flow_rate,eq_ratio,fft_mean_tlength,date);
            fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
            fni = append(dir,fndbps);
            fnpsb = append(dir,fndpsb);
            fnpsa = append(dir,fndpsa);
            fnpsb_av = append(dir,fndpsb_av);
            fnpsa_av = append(dir,fndpsa_av);
            fnaxis = append(dir,fnaxis);

          end
%
        elseif signal_type == 2
          if up_or_dwn == 1

            dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
            fnubps = sprintf('PUpper_d%d_hps%d_lps%d_%d_%.2f_cER.dat',lduct,hpsfreq,lpsfreq,flow_rate,eq_ratio);
            fnups = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_%d_%02u_cER.dat',lduct,hpsfreq,lpsfreq,flow_rate,eq_ratio,fft_mean_tlength,date,num);
            fnups_av = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_%d_av_cER.dat',lduct,hpsfreq,lpsfreq,flow_rate,eq_ratio,fft_mean_tlength,date);
            fnaxis = sprintf('PS_faxis_pressure_tlen%g_cER.dat',fft_mean_tlength);
            fign = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_%d_%02u_cER',lduct,hpsfreq,lpsfreq,flow_rate,eq_ratio,fft_mean_tlength,date,num);
            fni = append(dir,fnubps);
            fnps = append(dir,fnups);
            fnps_av = append(dir,fnups_av);
            fnaxis = append(dir,fnaxis);

          elseif up_or_dwn == 2

            dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
            fndbps = sprintf('PDown_d%d_hps%d_lps%d_%d_%.2f_cER.dat',lduct,hpsfreq,lpsfreq,flow_rate,eq_ratio);
            fndps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_%d_%02u_cER.dat',lduct,hpsfreq,lpsfreq,flow_rate,eq_ratio,fft_mean_tlength,date,num);
            fndps_av = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_%d_av_cER.dat',lduct,hpsfreq,lpsfreq,flow_rate,eq_ratio,fft_mean_tlength,date);
            fnaxis = sprintf('PS_faxis_pressure_tlen%g_cER.dat',fft_mean_tlength);
            fign = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_%d_%02u_cER',lduct,hpsfreq,lpsfreq,flow_rate,eq_ratio,fft_mean_tlength,date,num);
            fni = append(dir,fndbps);
            fnps = append(dir,fndps);
            fnps_av = append(dir,fndps_av);
            fnaxis = append(dir,fnaxis);

          end
%
        elseif signal_type == 3
          if up_or_dwn == 1

            dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
%             dir = sprintf('G:/Analysis/pressure/PS_spk_calc');
            fnubps = sprintf('ppu_spk_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,hpsfreq,lpsfreq,num);
            fnups = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,fft_mean_tlength,num);
            fnups_av = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf_start,speaker_hf,speaker_voltage,speaker_duration,lduct,fft_mean_tlength);
            fnaxis = sprintf('p_spk_ps_f_%d-%dHz_%dV_%gs_d%d_tlen%g.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,fft_mean_tlength);
            fign = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,fft_mean_tlength,num);
            fni = append(dir,fnubps);
            fnps = append(dir,fnups);
            fnps_av = append(dir,fnups_av);
            fnaxis = append(dir,fnaxis);

          elseif up_or_dwn == 2

            dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
%             dir = sprintf('G:/Analysis/pressure/PS_spk_calc');
            fndbps = sprintf('ppd_spk_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,hpsfreq,lpsfreq,num);
            fndps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,fft_mean_tlength,num);
            fndps_av = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf_start,speaker_hf,speaker_voltage,speaker_duration,lduct,fft_mean_tlength);
            fnaxis = sprintf('p_spk_ps_f_%d-%dHz_%dV_%gs_d%d_tlen%g.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,fft_mean_tlength);
            fign = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,fft_mean_tlength,num);
            fni = append(dir,fndbps);
            fnps = append(dir,fndps);
            fnps_av = append(dir,fndps_av);
            fnaxis = append(dir,fnaxis);

          end
%
        elseif signal_type == 4
          if up_or_dwn == 1

            dir = sprintf('H:/Analysis/pressure/%d/calc/',date);
            fnubps = sprintf('ppu_spk_noinput_%02u.dat',num);
            fnups = sprintf('ppu_spk_ps_noinput_tlen%g_%02u.dat',fft_mean_tlength,num);
            fnups_av = sprintf('ppu_spk_ps_noinput_tlen%g_av.dat',fft_mean_tlength);
            fnaxis = sprintf('p_spk_ps_f_noinput_tlen%g.dat',fft_mean_tlength);
            fni = append(dir,fnubps);
            fnps = append(dir,fnups);
            fnps_av = append(dir,fnups_av);
            fnaxis = append(dir,fnaxis);

          elseif up_or_dwn == 2

            dir = sprintf('H:/Analysis/pressure/%d/calc/',date);
            fndbps = sprintf('ppd_spk_noinput_%02u.dat',num);
            fndps = sprintf('ppd_spk_ps_noinput_tlen%g_%02u.dat',fft_mean_tlength,num);
            fndps_av = sprintf('ppd_spk_ps_noinput_tlen%g_av.dat',fft_mean_tlength);
            fnaxis = sprintf('p_spk_ps_f_noinput_tlen%g.dat',fft_mean_tlength);
            fni = append(dir,fndbps);
            fnps = append(dir,fndps);
            fnps_av = append(dir,fndps_av);
            fnaxis = append(dir,fnaxis);

          end
%
        elseif signal_type == 5

        end
%
        fid = fopen(fni,'r');
        signal_bps = fread(fid,datasize,'double');
        fclose(fid);

%% CUT BY SECTIONS

        if (signal_type == 2) || (signal_type == 3) || (signal_type == 4) % single data-series

          for t = 1:floor((calc_fin_time-calc_start_time)*Fs)
            signal_calc(t,1) = signal_bps(calc_start_point+t);
          end

        else % double data-series

          for t = 1:calc_data_length*Fs
            signal_btrans(t,1) = signal_bps(calc_start_point-calc_data_length*Fs+t);
          end

          for t = 1:calc_data_length*Fs
            signal_atrans(t,1) = signal_bps(calc_fin_point+t);
          end

        end

%% PS CALCULATION and SAVE

        if (signal_type == 2) || (signal_type == 3) || (signal_type == 4)

          [abs_calc_fft,av_angle_fft,fps,div_nlength] = fft_meanspec(signal_calc,Fs,fft_mean_tlength,0,fft_dbl_type,fft_mean_type);

          fileID = fopen(fnps,'w');
          fwrite(fileID,abs_calc_fft,'double');
          fclose(fileID);
          
          nn = nn +1;
          abs_calc_fft_av = abs_calc_fft_av + abs_calc_fft;

        else

          [abs_btrans_fft,av_angle_fft,fps,div_nlength] = fft_meanspec(signal_btrans,Fs,fft_mean_tlength,0,fft_dbl_type,fft_mean_type);
          [abs_atrans_fft,av_angle_fft,fps,div_nlength] = fft_meanspec(signal_atrans,Fs,fft_mean_tlength,0,fft_dbl_type,fft_mean_type);

          fileID = fopen(fnpsb,'w');
          fwrite(fileID,abs_btrans_fft,'double');
          fclose(fileID);

          fileID = fopen(fnpsa,'w');
          fwrite(fileID,abs_atrans_fft,'double');
          fclose(fileID);
          
          nn = nn +1;
          abs_btrans_fft_av = abs_btrans_fft_av + abs_btrans_fft;
          abs_atrans_fft_av = abs_atrans_fft_av + abs_atrans_fft;

        end

        fileID = fopen(fnaxis,'w');
        fwrite(fileID,fps,'double');
        fclose(fileID);

        div_nlength

%% FIGURE

        figure('Position', [50 50 960 735],'Color','white');

        if (signal_type == 2) || (signal_type == 3) || (signal_type == 4)
          loglog(fps,abs_calc_fft,'-k','MarkerSize',10)
          hold on
        else
          loglog(fps,abs_btrans_fft,'-vk','MarkerSize',10)
          hold on
          loglog(fps,abs_atrans_fft,'-^k','MarkerSize',10)
        end

        ax = gca;
        xtickformat('%d')
        ytickformat('%d')

        ax.XAxisLocation = 'bottom';
        ax.YDir = 'normal';
        ax.YAxisLocation = 'left';
        ax.XColor = 'black';
        ax.YColor = 'black';
        ax.XLim = [hpsfreq 300];
        %ax.YLim = [10^-1 10^5];
        ax.FontSize = 20;
        ax.FontName = 'Times New Roman';
        ax.TitleFontSizeMultiplier = 2;
        ax.Box = 'on';
        ax.LineWidth = 2.0;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';

        xlabel('\it \fontname{Times New Roman}f \rm[Hz]');
        ylabel('\it \fontname{Times New Roman}P \rm[kPa,m/s,-]');
        hold off
        pbaspect([sqrt(2) 1 1]);
        saveas(gcf, strcat(dir,fign,figex));
        close;

      end
%     end %%%
    
%% SAVE & FIGURE, Averaged

    if (signal_type == 2) || (signal_type == 3) || (signal_type == 4)
        
        fileID = fopen(fnps_av,'w');
        fwrite(fileID,abs_calc_fft_av/nn,'double');
        fclose(fileID);
        
    else
        
        fileID = fopen(fnpsb_av,'w');
        fwrite(fileID,abs_btrans_fft_av/nn,'double');
        fclose(fileID);
        
        fileID = fopen(fnpsa_av,'w');
        fwrite(fileID,abs_atrans_fft_av/nn,'double');
        fclose(fileID);
        
    end

    figure('Position', [50 50 960 735],'Color','white');

    if (signal_type == 2) || (signal_type == 3) || (signal_type == 4)
      loglog(fps,abs_calc_fft_av/nn,'-k','MarkerSize',10)
      hold on
    else
      loglog(fps,abs_btrans_fft_av/nn,'-vk','MarkerSize',10)
      hold on
      loglog(fps,abs_atrans_fft_av/nn,'-^k','MarkerSize',10)
    end

    ax = gca;
    xtickformat('%d')
    ytickformat('%d')

    ax.XAxisLocation = 'bottom';
    ax.YDir = 'normal';
    ax.YAxisLocation = 'left';
    ax.XColor = 'black';
    ax.YColor = 'black';
    ax.XLim = [hpsfreq 300];
    %ax.YLim = [10^-1 10^5];
    ax.FontSize = 20;
    ax.FontName = 'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlabel('\it \fontname{Times New Roman}f \rm[Hz]');
    ylabel('\it \fontname{Times New Roman}P \rm[kPa,m/s,-]');
    hold off
    pbaspect([sqrt(2) 1 1]);
