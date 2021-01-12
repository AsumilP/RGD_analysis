    clear all
    close all
    clc

%% PARAMETERS

    signal_type = 3; % 1. p_sequence_trans, 2. p_cER, 3. specific_f, 4. air, 5. BG , 6. cold_specific
    up_or_dwn = 2; % 1. upperstream, 2. downstream, when signal_type = 1 or 2 or 3

    hpsfreq = 20;
    lpsfreq = 3000;
    RMS_width = 0.2; % [sec]

    date = 20201203;
    num_start = 1;
    num_end = 5; % = num_start for signal_type = 1
    flow_rate = 350; % [L/min], signal_type = 2,4
    eq_ratio = 0.80; % signal_type = 2
    duct_l = 1185; % [mm], signal_type = 2,3,4,5
    speaker_v = 1; % [V], signal_type = 3
    speaker_t = 15; % [s], signal_type = 3
    part = 8; % signal_type = 3

    calc_start_time = 0.10005; % [s], trans_start_time
    calc_fin_time = 14.9; % [s], trans_fin_time
    calc_data_length = 1; % [s] >= fft_mean_tlength, signal_type = 1

    for specific_f = [61 68 70 73 80 85 143 147 149 155 171 188 194 203 232] %%% signal_type = 3

%% PARAMETERS, fixed

        if (signal_type == 1) || (signal_type == 2) || (signal_type == 3) || (signal_type == 4) || (signal_type == 5) ...
            || (signal_type == 6)

            Fs = 20e3;
            Sts = 1/Fs; % [sec]
%             pres_samp_time = 10; % [sec] NEED TO BE CHANGED
            pres_samp_time = 15; % [sec] NEED TO BE CHANGED
            datasize = Fs*pres_samp_time - RMS_width/Sts;
            taxis_rms = Sts + RMS_width/2:Sts:pres_samp_time - RMS_width/2;
            calc_start_point = floor((calc_start_time - Sts - RMS_width/2)/Sts) + 1;
            calc_fin_point = floor((calc_fin_time - Sts - RMS_width/2)/Sts) + 1;
            abs_calc_rms_av = 0;
            abs_btrans_rms_av = 0;
            abs_atrans_rms_av = 0;
            nn = 0;

        elseif signal_type == 7

        end

            for num = num_start:1:num_end

%% READ
%
                if signal_type == 1
                    if up_or_dwn == 1

                        dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
                        fnurms = sprintf('PUpper_primerms_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
                        fni = append(dir,fnurms);

                    elseif up_or_dwn == 2

                        dir = sprintf('H:/Analysis/pressure/%d/calc/',date);
                        fndrms = sprintf('PDown_primerms_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
                        fni = append(dir,fndrms);

                    end
%
                elseif signal_type == 2
                    if up_or_dwn == 1

                        dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
                        fnurms = sprintf('PUpper_d%d_primerms_hps%d_lps%d_%d_%.2f_cER.dat',duct_l,hpsfreq,lpsfreq,flow_rate,eq_ratio);
                        fni = append(dir,fnurms);

                    elseif up_or_dwn == 2

                        dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
                        fndrms = sprintf('PDown_d%d_primerms_hps%d_lps%d_%d_%.2f_cER.dat',duct_l,hpsfreq,lpsfreq,flow_rate,eq_ratio);
                        fni = append(dir,fndrms);

                    end
%
                elseif signal_type == 3
                    if up_or_dwn == 1

                        dir = sprintf('G:/Analysis/pressure/%d/calc/p%d/',date,part);
                        fnurms = sprintf('PUpper_primerms_speaker_hps%d_lps%d_%dHz_%dV_%ds_d%d_%d.dat',hpsfreq,lpsfreq,specific_f,speaker_v,speaker_t,duct_l,num);
                        fni = append(dir,fnurms);

                    elseif up_or_dwn == 2

                        dir = sprintf('G:/Analysis/pressure/%d/calc/p%d/',date,part);
                        fndrms = sprintf('PDown_primerms_speaker_hps%d_lps%d_%dHz_%dV_%ds_d%d_%d.dat',hpsfreq,lpsfreq,specific_f,speaker_v,speaker_t,duct_l,num);
                        fni = append(dir,fndrms);

                    end
%
                elseif signal_type == 4
                    if up_or_dwn == 1

                        dir = sprintf('H:/Analysis/pressure/%d/calc/',date);
                        fnurms = sprintf('PUpper_primerms_d%d_air%dL_hps%d_lps%d_%d.dat',duct_l,flow_rate,hpsfreq,lpsfreq,num);
                        fni = append(dir,fnurms);

                    elseif up_or_dwn == 2

                        dir = sprintf('H:/Analysis/pressure/%d/calc/',date);
                        fndrms = sprintf('PDown_primerms_d%d_air%dL_hps%d_lps%d_%d.dat',duct_l,flow_rate,hpsfreq,lpsfreq,num);
                        fni = append(dir,fndrms);

                    end
%
                elseif signal_type == 5
                    if up_or_dwn == 1

                        dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
                        fnurms = sprintf('PUpper_primerms_d%d_BG_hps%d_lps%d_%d.dat',duct_l,hpsfreq,lpsfreq,num);
                        fni = append(dir,fnurms);

                    elseif up_or_dwn == 2

                        dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
                        fndrms = sprintf('PDown_primerms_d%d_BG_hps%d_lps%d_%d.dat',duct_l,hpsfreq,lpsfreq,num);
                        fni = append(dir,fndrms);

                    end
%
                elseif signal_type == 6
                    if up_or_dwn == 1

                        % dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
                        % fnubps = sprintf('PUpper_d%d_BG_hps%d_lps%d_%d.dat',duct_l,hpsfreq,lpsfreq,num);
                        % fni = append(dir,fnubps);

                    elseif up_or_dwn == 2

                        % dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
                        % fndbps = sprintf('PDown_d%d_BG_hps%d_lps%d_%d.dat',duct_l,hpsfreq,lpsfreq,num);
                        % fni = append(dir,fndbps);

                    end

                elseif signal_type == 7

                end

                fid = fopen(fni,'r');
                signal_rms = fread(fid,datasize,'double');
                fclose(fid);

%% CUT BY SECTIONS

                if (signal_type == 2) || (signal_type == 3) || (signal_type == 4) || (signal_type == 5) || (signal_type == 6) ...
                    || (signal_type == 7) % single data-series

                    for t = calc_start_point:1:calc_fin_point
                        signal_calc(t - calc_start_point + 1,1) = signal_rms(t);
                    end

                elseif signal_type == 1

                    for t = 1:calc_data_length*Fs
                        signal_btrans(t,1) = signal_rms(calc_start_point-calc_data_length*Fs+t);
                    end

                    for t = 1:calc_data_length*Fs
                        signal_atrans(t,1) = signal_rms(calc_fin_point+t);
                    end

                end

%% PS CALCULATION and SAVE

                if (signal_type == 2) || (signal_type == 3) || (signal_type == 4) || (signal_type == 5) || (signal_type == 6) ...
                    || (signal_type == 7)

                    rms_mean_temp = mean(signal_calc);

                    nn = nn + 1;
                    abs_calc_rms_av = abs_calc_rms_av + rms_mean_temp;

%                     sprintf('calc_start_time and calc_start_point : %.5f, %d',calc_start_time,calc_start_point)
%                     sprintf('calc_fin_time and calc_fin_point : %.5f, %d',calc_fin_time,calc_fin_point)
%                     sprintf('rms_mean_temp : %.8f',rms_mean_temp)

                elseif signal_type == 1

                    rms_mean_b_temp = mean(signal_btrans);
                    rms_mean_a_temp = mean(signal_atrans);

                    nn = nn + 1;
                    abs_btrans_rms_av = abs_btrans_rms_av + rms_mean_b_temp;
                    abs_atrans_rms_av = abs_atrans_rms_av + rms_mean_a_temp;

%                     sprintf('calc_start_time and calc_start_point : %.5f, %d',calc_start_time,calc_start_point)
%                     sprintf('calc_fin_time and calc_fin_point : %.5f, %d',calc_fin_time,calc_fin_point)
%                     sprintf('rms_mean_b_temp : %.8f',rms_mean_b_temp)
%                     sprintf('rms_mean_a_temp : %.8f',rms_mean_a_temp)

                end

%% FIGURE

                figure('Position', [50 50 960 735],'Color','white');

                plot(taxis_rms,signal_rms,'-k','MarkerSize',10)
                hold on

                ax = gca;
                xtickformat('%d')
                ytickformat('%.3f')

                ax.XAxisLocation = 'bottom';
                ax.YDir = 'normal';
                ax.YAxisLocation = 'left';
                ax.XColor = 'black';
                ax.YColor = 'black';
                ax.XLim = [0 pres_samp_time];
%                 ax.YLim = [10^-1 10^5];
                ax.FontSize = 20;
                ax.FontName = 'Times New Roman';
                ax.TitleFontSizeMultiplier = 2;
                ax.Box = 'on';
                ax.LineWidth = 2.0;
                ax.XMinorTick = 'on';
                ax.YMinorTick = 'on';

                xlabel('\it \fontname{Times New Roman}t \rm[s]');
                ylabel('\it \fontname{Times New Roman}p''_{rms} \rm[kPa]');
                hold off
                pbaspect([sqrt(2) 1 1]);

            end

            pause;
            fni

            if (signal_type == 2) || (signal_type == 3) || (signal_type == 4) || (signal_type == 5) || (signal_type == 6) ...
                || (signal_type == 7)

              sprintf('abs_calc_rms_av/nn : %.8f',abs_calc_rms_av/nn)

            elseif signal_type == 1

              sprintf('abs_btrans_rms_av/nn : %.8f',abs_btrans_rms_av/nn)
              sprintf('abs_atrans_rms_av/nn : %.8f',abs_atrans_rms_av/nn)

            end

            close all
    end %%%
