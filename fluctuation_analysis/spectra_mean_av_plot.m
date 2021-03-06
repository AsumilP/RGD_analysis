    clear all
    close all
    clc

%% PARAMETERS
    data_species = 2; % 1, 2, 3, 4, 5, 6
    signal_type = 2; % 1. p_sequence, 2. p_cER, 3. speaker_chirp, 4. specific_f, 5. air, 6. BG
    noise_sub = 0; %1. Yes, 0: No
    up_or_dwn = 2; % 1. upperstream 2. downstream, when signal_type = 1,2,3,4,5

%%
    ndata_noise = 10;
    noise_date = 20200828;
    fs_noise = 20e3;
    fft_mean_tlength_noise = 1; % [s]

%     dir_noise = sprintf('H:/Analysis/pressure/%d/calc/',noise_date);
    dir_noise = sprintf('G:/Analysis/pressure/PS_air_BG_calc/');
    div_nlength_noise = fs_noise*fft_mean_tlength_noise;

%%
%     spk_freq= [61 68 70 73 80 85 143 147 149 155 171 188 194 203 232];
%     spk_PS= [895.3 1325 1476 1650 1720 1508 239.2 376 386.2 451.1 554.8 188 168.1 119.7 39.13]; % PS_mode at 450mm

%%
    if data_species == 1

      ndata1 = 10;
      flow_rate1 = 0; % [L/min]
      eq_ratio1 = 0.00;
      hpsfreq1 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq1 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration1 = 7.5; % [s], signal_type = 3,4
      specific_f1 = 0; % [s], signal_type = 4
      part1 = 1; % signal_type = 4
      lduct1 = 582; % [mm], signal_type = 3,4

      date = 20200908;
      fft_mean_tlength = 1; % [s]
      speaker_voltage = 1; % [V], signal_type = 3,4
      speaker_lf = 0; % [Hz], signal_type = 3
      speaker_hf = 350; % [Hz], signal_type = 3
      fs = 20e3;
      div_nlength = fs*fft_mean_tlength;

%       dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
      dir = sprintf('G:/Analysis/pressure/PS_air_BG_calc/');
      % dir = sprintf('E:/chem_output/chem_intensity/%d/',date);
      % dir = sprintf('E:/piv_output/v_oscillation/');

%%
    elseif data_species == 2

      ndata1 = 1;
      flow_rate1 = 500; % [L/min]
      eq_ratio1 = 0.74;
      hpsfreq1 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq1 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration1 = 7.5; % [s], signal_type = 3,4
      specific_f1 = 0; % [s], signal_type = 4
      part1 = 1; % signal_type = 4
      lduct1 = 582; % [mm], signal_type = 3,4

      ndata2 = 1;
      flow_rate2 = 500; % [L/min]
      eq_ratio2 = 0.80;
      hpsfreq2 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq2 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration2 = 7.5; % [s], signal_type = 3,4
      specific_f2 = 0; % [s], signal_type = 4
      part2 = 1; % signal_type = 4
      lduct2 = 582; % [mm], signal_type = 3,4

      date = 20201029;
      fft_mean_tlength = 1; % [s]
      speaker_voltage = 1; % [V], signal_type = 3,4
      speaker_lf = 0; % [Hz], signal_type = 3
      speaker_hf = 350; % [Hz], signal_type = 3
      fs = 20e3;
      div_nlength = fs*fft_mean_tlength;

      dir = sprintf('I:/Analysis/pressure/%d/calc/',date);
      % dir = sprintf('E:/chem_output/chem_intensity/%d/',date);
      % dir = sprintf('E:/piv_output/v_oscillation/');

%%
    elseif data_species == 3

      ndata1 = 31;
      flow_rate1 = 0; % [L/min]
      eq_ratio1 = 0;
      hpsfreq1 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq1 = 300; % [Hz], signal_type = 1,2,3,4
      speaker_duration1 = 7.5; % [s], signal_type = 3,4
      specific_f1 = 0; % [s], signal_type = 4
      part1 = 1; % signal_type = 4
      lduct1 = 582; % [mm], signal_type = 3,4

      ndata2 = 30;
      flow_rate2 = 0; % [L/min]
      eq_ratio2 = 0;
      hpsfreq2 = 0; % [Hz], signal_type = 1,2,3,4
      lpsfreq2 = 0; % [Hz], signal_type = 1,2,3,4
      speaker_duration2 = 7.5; % [s], signal_type = 3,4
      specific_f2 = 0; % [s], signal_type = 4
      part2 = 1; % signal_type = 4
      lduct2 = 883; % [mm], signal_type = 3,4

      ndata3 = 30;
      flow_rate3 = 0; % [L/min]
      eq_ratio3 = 0;
      hpsfreq3 = 0; % [Hz], signal_type = 1,2,3,4
      lpsfreq3 = 0; % [Hz], signal_type = 1,2,3,4
      speaker_duration3 = 7.5; % [s], signal_type = 3,4
      specific_f3 = 0; % [s], signal_type = 4
      part3 = 1; % signal_type = 4
      lduct3 = 1185; % [mm], signal_type = 3,4

      date = 20201029;
      fft_mean_tlength = 1; % [s]
      speaker_voltage = 1; % [V], signal_type = 3,4
      speaker_lf = 0; % [Hz], signal_type = 3
      speaker_hf = 350; % [Hz], signal_type = 3
      fs = 20e3;
      div_nlength = fs*fft_mean_tlength;

      % dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
      % dir = sprintf('G:/Analysis/pressure/PS_trans_calc/');
      dir = sprintf('G:/Analysis/pressure/PS_chirp_calc/');
      % dir = sprintf('E:/chem_output/chem_intensity/%d/',date);
      % dir = sprintf('E:/piv_output/v_oscillation/');

%%
    elseif data_species == 4

      ndata1 = 1;
      flow_rate1 = 500; % [L/min]
      eq_ratio1 = 0.74;
      hpsfreq1 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq1 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration1 = 15; % [s], signal_type = 3,4
      specific_f1 = 0; % [s], signal_type = 4
      part1 = 1; % signal_type = 4
      lduct1 = 582; % [mm], signal_type = 3,4

      ndata2 = 1;
      flow_rate2 = 500; % [L/min]
      eq_ratio2 = 0.76;
      hpsfreq2 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq2 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration2 = 15; % [s], signal_type = 3,4
      specific_f2 = 0; % [s], signal_type = 4
      part2 = 1; % signal_type = 4
      lduct2 = 582; % [mm], signal_type = 3,4

      ndata3 = 1;
      flow_rate3 = 500; % [L/min]
      eq_ratio3 = 0.78;
      hpsfreq3 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq3 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration3 = 15; % [s], signal_type = 3,4
      specific_f3 = 0; % [s], signal_type = 4
      part3 = 1; % signal_type = 4
      lduct3 = 582; % [mm], signal_type = 3,4

      ndata4 = 1;
      flow_rate4 = 500; % [L/min]
      eq_ratio4 = 0.80;
      hpsfreq4 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq4 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration4 = 15; % [s], signal_type = 3,4
      specific_f4 = 0; % [s], signal_type = 4
      part4 = 1; % signal_type = 4
      lduct4 = 582; % [mm], signal_type = 3,4

      date = 20201029;
      fft_mean_tlength = 1; % [s]
      speaker_voltage = 1; % [V], signal_type = 3,4
      speaker_lf = 0; % [Hz], signal_type = 3
      speaker_hf = 350; % [Hz], signal_type = 3
      fs = 20e3;
      div_nlength = fs*fft_mean_tlength;

      dir = sprintf('I:/Analysis/pressure/%d/calc/',date);
      % dir = sprintf('G:/Analysis/pressure/PS_trans_calc/');
      % dir = sprintf('G:/Analysis/pressure/PS_chirp_calc/');
      % dir = sprintf('E:/chem_output/chem_intensity/%d/',date);
      % dir = sprintf('E:/piv_output/v_oscillation/');

%%
    elseif data_species == 5

      part_all = 9;

      ndata1 = 5;
      flow_rate1 = 400; % [L/min]
      eq_ratio1 = 0.68;
      hpsfreq1 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq1 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration1 = 15; % [s], signal_type = 3,4
      specific_f1 = 61; % [s], signal_type = 4
      part1 = part_all; % signal_type = 4
      lduct1 = 1185; % [mm], signal_type = 3,4

      ndata2 = 5;
      flow_rate2 = 450; % [L/min]
      eq_ratio2 = 0.68;
      hpsfreq2 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq2 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration2 = 15; % [s], signal_type = 3,4
      specific_f2 = 68; % [s], signal_type = 4
      part2 = part_all; % signal_type = 4
      lduct2 = 1185; % [mm], signal_type = 3,4

      ndata3 = 5;
      flow_rate3 = 500; % [L/min]
      eq_ratio3 = 0.68;
      hpsfreq3 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq3 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration3 = 15; % [s], signal_type = 3,4
      specific_f3 = 70; % [s], signal_type = 4
      part3 = part_all; % signal_type = 4
      lduct3 = 1185; % [mm], signal_type = 3,4

      ndata4 = 5;
      flow_rate4 = 500; % [L/min]
      eq_ratio4 = 0.68;
      hpsfreq4 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq4 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration4 = 15; % [s], signal_type = 3,4
      specific_f4 = 73; % [s], signal_type = 4
      part4 = part_all; % signal_type = 4
      lduct4 = 1185; % [mm], signal_type = 3,4

      ndata5 = 5;
      flow_rate5 = 500; % [L/min]
      eq_ratio5 = 0.68;
      hpsfreq5 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq5 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration5 = 15; % [s], signal_type = 3,4
      specific_f5 = 80; % [s], signal_type = 4
      part5 = part_all; % signal_type = 4
      lduct5 = 1185; % [mm], signal_type = 3,4

      date = 20200908;
      fft_mean_tlength = 1; % [s]
      speaker_voltage = 1; % [V], signal_type = 3,4
      speaker_lf = 40; % [Hz], signal_type = 3
      speaker_hf = 315; % [Hz], signal_type = 3
      fs = 20e3;
      div_nlength = fs*fft_mean_tlength;

      % dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
      % dir = sprintf('G:/Analysis/pressure/PS_trans_calc/');
      % dir = sprintf('G:/Analysis/pressure/PS_cER_calc/sw60/');
      dir = sprintf('G:/Analysis/pressure/PS_mode_calc/');
      % dir = sprintf('E:/chem_output/chem_intensity/%d/',date);
      % dir = sprintf('E:/piv_output/v_oscillation/');

%%
    elseif data_species == 6

      ndata1 = 5;
      flow_rate1 = 250; % [L/min]
      eq_ratio1 = 0.70;
      hpsfreq1 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq1 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration1 = 7.5; % [s], signal_type = 3,4
      specific_f1 = 61; % [Hz], signal_type = 4
      part1 = 1; % signal_type = 4
      lduct1 = 582; % [mm], signal_type = 2, 3, 4

      ndata2 = 5;
      flow_rate2 = 300; % [L/min]
      eq_ratio2 = 0.72;
      hpsfreq2 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq2 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration2 = 7.5; % [s], signal_type = 3,4
      specific_f2 = 68; % [Hz], signal_type = 4
      part2 = 1; % signal_type = 4
      lduct2 = 582; % [mm], signal_type = 2, 3, 4

      ndata3 = 5;
      flow_rate3 = 350; % [L/min]
      eq_ratio3 = 0.74;
      hpsfreq3 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq3 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration3 = 7.5; % [s], signal_type = 3,4
      specific_f3 = 70; % [Hz], signal_type = 4
      part3 = 1; % signal_type = 4
      lduct3 = 582; % [mm], signal_type = 3

      ndata4 = 8;
      flow_rate4 = 400; % [L/min]
      eq_ratio4 = 0.76;
      hpsfreq4 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq4 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration4 = 7.5; % [s], signal_type = 3,4
      specific_f4 = 0; % [s], signal_type = 4
      part4 = 1; % signal_type = 4
      lduct4 = 582; % [mm], signal_type = 3

      ndata5 = 9;
      flow_rate5 = 450; % [L/min]
      eq_ratio5 = 0.78;
      hpsfreq5 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq5 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration5 = 7.5; % [s], signal_type = 3,4
      specific_f5 = 0; % [s], signal_type = 4
      part5 = 1; % signal_type = 4
      lduct5 = 582; % [mm], signal_type = 3

      ndata6 = 5;
      flow_rate6 = 500; % [L/min]
      eq_ratio6 = 0.80;
      hpsfreq6 = 20; % [Hz], signal_type = 1,2,3,4
      lpsfreq6 = 3000; % [Hz], signal_type = 1,2,3,4
      speaker_duration6 = 7.5; % [s], signal_type = 3,4
      specific_f6 = 0; % [s], signal_type = 4
      part6 = 1; % signal_type = 4
      lduct6 = 582; % [mm], signal_type = 3

      date = 20200908;
      fft_mean_tlength = 1; % [s]
      speaker_voltage = 1; % [V], signal_type = 3,4
      speaker_lf = 0; % [Hz], signal_type = 3
      speaker_hf = 350; % [Hz], signal_type = 3
      fs = 20e3;
      div_nlength = fs*fft_mean_tlength;

      % dir = sprintf('H:/Analysis/pressure/%d/calc/',date);
      % dir = sprintf('H:/Analysis/pressure/PS_trans_calc/');
      % dir = sprintf('G:/Analysis/pressure/PS_cER_calc/sw60/');
      dir = sprintf('G:/Analysis/pressure/PS_air_BG_calc/');
      % dir = sprintf('E:/chem_output/chem_intensity/%d/',date);
      % dir = sprintf('E:/piv_output/v_oscillation/');

%%
    end

%% Matrix
    psnoise_av = zeros();
    psb_av1 = 0;
    psb_av2 = 0;
    psb_av3 = 0;
    psb_av4 = 0;
    psb_av5 = 0;
    psb_av6 = 0;
    psa_av1 = 0;
    psa_av2 = 0;
    psa_av3 = 0;
    psa_av4 = 0;
    psa_av5 = 0;
    psa_av6 = 0;

%% READ and AVERAGE
%%
    if noise_sub == 1
        for i = 1:1:ndata_noise
            if  signal_type == 6
                if up_or_dwn == 1
                    fnps_n = sprintf('ppu_spk_ps_noinput_tlen%g_%02u.dat',fft_mean_tlength_noise,i);
                elseif up_or_dwn == 2
                    fnps_n = sprintf('ppd_spk_ps_noinput_tlen%g_%02u.dat',fft_mean_tlength_noise,i);
                end
            end

            fid = fopen(append(dir_noise,fnps_n),'r');
            psnoise = fread(fid,div_nlength_noise,'double');
            fclose(fid);

            psnoise_av = psnoise_av + psnoise/ndata_noise;
        end
    end
%%
    if data_species == 1

      if signal_type == 1
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
              psa_av1 = psa_av1 + psa/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
              psa_av1 = psa_av1 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 2
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct1,hpsfreq1,lpsfreq1,flow_rate1,eq_ratio1,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct1,hpsfreq1,lpsfreq1,flow_rate1,eq_ratio1,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g_cER.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 3
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          fnaxis = sprintf('p_spk_ps_f_%d-%dHz_%dV_%gs_d%d_tlen%g.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 4
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part1,hpsfreq1,lpsfreq1,specific_f1,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part1,hpsfreq1,lpsfreq1,specific_f1,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          fnaxis = sprintf('p%d/PS_faxis_pressure_tlen%g.dat',part1,fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 5
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct1,flow_rate1,hpsfreq1,lpsfreq1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct1,flow_rate1,hpsfreq1,lpsfreq1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);
          
      elseif signal_type == 6
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_BG_hps%d_lps%d_tlen%g_%02u.dat',lduct1,hpsfreq1,lpsfreq1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_BG_hps%d_lps%d_tlen%g_%02u.dat',lduct1,hpsfreq1,lpsfreq1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      end
%%
    elseif data_species == 2

      if signal_type == 1
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
              psa_av1 = psa_av1 + psa/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
              psa_av1 = psa_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
              psa_av2 = psa_av2 + psa/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
              psa_av2 = psa_av2 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 2
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct1,hpsfreq1,lpsfreq1,flow_rate1,eq_ratio1,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct1,hpsfreq1,lpsfreq1,flow_rate1,eq_ratio1,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct2,hpsfreq2,lpsfreq2,flow_rate2,eq_ratio2,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct2,hpsfreq2,lpsfreq2,flow_rate2,eq_ratio2,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g_cER.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 3
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          fnaxis = sprintf('p_spk_ps_f_%d-%dHz_%dV_%gs_d%d_tlen%g.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 4
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part1,hpsfreq1,lpsfreq1,specific_f1,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part1,hpsfreq1,lpsfreq1,specific_f1,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part2,hpsfreq2,lpsfreq2,specific_f2,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part2,hpsfreq2,lpsfreq2,specific_f2,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          fnaxis = sprintf('p%d/PS_faxis_pressure_tlen%g.dat',part1,fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 5
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct1,flow_rate1,hpsfreq1,lpsfreq1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct1,flow_rate1,hpsfreq1,lpsfreq1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct2,flow_rate2,hpsfreq2,lpsfreq2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct2,flow_rate2,hpsfreq2,lpsfreq2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      end
%%
    elseif data_species == 3

      if signal_type == 1
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
              psa_av1 = psa_av1 + psa/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
              psa_av1 = psa_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
              psa_av2 = psa_av2 + psa/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
              psa_av2 = psa_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
              psa_av3 = psa_av3 + psa/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
              psa_av3 = psa_av3 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 2
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct1,hpsfreq1,lpsfreq1,flow_rate1,eq_ratio1,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct1,hpsfreq1,lpsfreq1,flow_rate1,eq_ratio1,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct2,hpsfreq2,lpsfreq2,flow_rate2,eq_ratio2,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct2,hpsfreq2,lpsfreq2,flow_rate2,eq_ratio2,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct3,hpsfreq3,lpsfreq3,flow_rate3,eq_ratio3,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct3,hpsfreq3,lpsfreq3,flow_rate3,eq_ratio3,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g_cER.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 3
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
%                   fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
%                   fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
%                   fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
%                   fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
%                   fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
%                   fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          fnaxis = sprintf('p_spk_ps_f_%d-%dHz_%dV_%gs_d%d_tlen%g.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 4
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part1,hpsfreq1,lpsfreq1,specific_f1,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part1,hpsfreq1,lpsfreq1,specific_f1,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part2,hpsfreq2,lpsfreq2,specific_f2,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part2,hpsfreq2,lpsfreq2,specific_f2,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part3,hpsfreq3,lpsfreq3,specific_f3,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part3,hpsfreq3,lpsfreq3,specific_f3,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          fnaxis = sprintf('p%d/PS_faxis_pressure_tlen%g.dat',part1,fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 5
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct1,flow_rate1,hpsfreq1,lpsfreq1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct1,flow_rate1,hpsfreq1,lpsfreq1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct2,flow_rate2,hpsfreq2,lpsfreq2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct2,flow_rate2,hpsfreq2,lpsfreq2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct3,flow_rate3,hpsfreq3,lpsfreq3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct3,flow_rate3,hpsfreq3,lpsfreq3,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end
          
          fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      end
%%
    elseif data_species == 4

      if signal_type == 1
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
              psa_av1 = psa_av1 + psa/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
              psa_av1 = psa_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
              psa_av2 = psa_av2 + psa/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
              psa_av2 = psa_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
              psa_av3 = psa_av3 + psa/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
              psa_av3 = psa_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate4,eq_ratio4,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate4,eq_ratio4,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate4,eq_ratio4,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate4,eq_ratio4,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
              psa_av4 = psa_av4 + psa/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
              psa_av4 = psa_av4 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 2
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct1,hpsfreq1,lpsfreq1,flow_rate1,eq_ratio1,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct1,hpsfreq1,lpsfreq1,flow_rate1,eq_ratio1,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct2,hpsfreq2,lpsfreq2,flow_rate2,eq_ratio2,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct2,hpsfreq2,lpsfreq2,flow_rate2,eq_ratio2,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct3,hpsfreq3,lpsfreq3,flow_rate3,eq_ratio3,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct3,hpsfreq3,lpsfreq3,flow_rate3,eq_ratio3,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct4,hpsfreq4,lpsfreq4,flow_rate4,eq_ratio4,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct4,hpsfreq4,lpsfreq4,flow_rate4,eq_ratio4,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g_cER.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 3
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
%                   fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
%                   fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
%                   fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
%                   fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
%                   fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
%                   fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration4,lduct4,fft_mean_tlength,i);
%                   fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration4,lduct4,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration4,lduct4,fft_mean_tlength,i);
%                   fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration4,lduct4,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
          end

          fnaxis = sprintf('p_spk_ps_f_%d-%dHz_%dV_%gs_d%d_tlen%g.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 4
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part1,hpsfreq1,lpsfreq1,specific_f1,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part1,hpsfreq1,lpsfreq1,specific_f1,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part2,hpsfreq2,lpsfreq2,specific_f2,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part2,hpsfreq2,lpsfreq2,specific_f2,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part3,hpsfreq3,lpsfreq3,specific_f3,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part3,hpsfreq3,lpsfreq3,specific_f3,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part4,hpsfreq4,lpsfreq4,specific_f4,speaker_voltage,speaker_duration4,lduct4,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part4,hpsfreq4,lpsfreq4,specific_f4,speaker_voltage,speaker_duration4,lduct4,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
          end

          fnaxis = sprintf('p%d/PS_faxis_pressure_tlen%g.dat',part1,fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 5
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct1,flow_rate1,hpsfreq1,lpsfreq1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct1,flow_rate1,hpsfreq1,lpsfreq1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct2,flow_rate2,hpsfreq2,lpsfreq2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct2,flow_rate2,hpsfreq2,lpsfreq2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct3,flow_rate3,hpsfreq3,lpsfreq3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct3,flow_rate3,hpsfreq3,lpsfreq3,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct4,flow_rate4,hpsfreq4,lpsfreq4,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct4,flow_rate4,hpsfreq4,lpsfreq4,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      end
%%
    elseif data_species == 5

      if signal_type == 1
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
              psa_av1 = psa_av1 + psa/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
              psa_av1 = psa_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
              psa_av2 = psa_av2 + psa/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
              psa_av2 = psa_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
              psa_av3 = psa_av3 + psa/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
              psa_av3 = psa_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate4,eq_ratio4,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate4,eq_ratio4,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate4,eq_ratio4,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate4,eq_ratio4,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
              psa_av4 = psa_av4 + psa/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
              psa_av4 = psa_av4 - psnoise_av;
          end

          for i = 1:1:ndata5
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate5,eq_ratio5,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate5,eq_ratio5,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate5,eq_ratio5,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate5,eq_ratio5,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av5 = psb_av5 + psb/ndata5;
              psa_av5 = psa_av5 + psa/ndata5;
          end

          if noise_sub == 1
              psb_av5 = psb_av5 - psnoise_av;
              psa_av5 = psa_av5 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 2
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct1,hpsfreq1,lpsfreq1,flow_rate1,eq_ratio1,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct1,hpsfreq1,lpsfreq1,flow_rate1,eq_ratio1,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct2,hpsfreq2,lpsfreq2,flow_rate2,eq_ratio2,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct2,hpsfreq2,lpsfreq2,flow_rate2,eq_ratio2,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct3,hpsfreq3,lpsfreq3,flow_rate3,eq_ratio3,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct3,hpsfreq3,lpsfreq3,flow_rate3,eq_ratio3,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct4,hpsfreq4,lpsfreq4,flow_rate4,eq_ratio4,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct4,hpsfreq4,lpsfreq4,flow_rate4,eq_ratio4,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
          end

          for i = 1:1:ndata5
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct5,hpsfreq5,lpsfreq5,flow_rate5,eq_ratio5,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct5,hpsfreq5,lpsfreq5,flow_rate5,eq_ratio5,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av5 = psb_av5 + psb/ndata5;
          end

          if noise_sub == 1
              psb_av5 = psb_av5 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g_cER.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 3
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration4,lduct4,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration4,lduct4,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
          end

          for i = 1:1:ndata5
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration5,lduct5,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration5,lduct5,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av5 = psb_av5 + psb/ndata5;
          end

          if noise_sub == 1
              psb_av5 = psb_av5 - psnoise_av;
          end

          fnaxis = sprintf('p_spk_ps_f_%d-%dHz_%dV_%gs_d%d_tlen%g.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 4
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part1,hpsfreq1,lpsfreq1,specific_f1,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part1,hpsfreq1,lpsfreq1,specific_f1,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part2,hpsfreq2,lpsfreq2,specific_f2,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part2,hpsfreq2,lpsfreq2,specific_f2,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part3,hpsfreq3,lpsfreq3,specific_f3,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part3,hpsfreq3,lpsfreq3,specific_f3,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part4,hpsfreq4,lpsfreq4,specific_f4,speaker_voltage,speaker_duration4,lduct4,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part4,hpsfreq4,lpsfreq4,specific_f4,speaker_voltage,speaker_duration4,lduct4,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
          end

          for i = 1:1:ndata5
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part5,hpsfreq5,lpsfreq5,specific_f5,speaker_voltage,speaker_duration5,lduct5,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part5,hpsfreq5,lpsfreq5,specific_f5,speaker_voltage,speaker_duration5,lduct5,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av5 = psb_av5 + psb/ndata5;
          end

          if noise_sub == 1
              psb_av5 = psb_av5 - psnoise_av;
          end

          fnaxis = sprintf('p%d/PS_faxis_pressure_tlen%g.dat',part1,fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      elseif signal_type == 5
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct1,flow_rate1,hpsfreq1,lpsfreq1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct1,flow_rate1,hpsfreq1,lpsfreq1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct2,flow_rate2,hpsfreq2,lpsfreq2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct2,flow_rate2,hpsfreq2,lpsfreq2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct3,flow_rate3,hpsfreq3,lpsfreq3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct3,flow_rate3,hpsfreq3,lpsfreq3,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct4,flow_rate4,hpsfreq4,lpsfreq4,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct4,flow_rate4,hpsfreq4,lpsfreq4,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
          end

          for i = 1:1:ndata5
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct5,flow_rate5,hpsfreq5,lpsfreq5,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct5,flow_rate5,hpsfreq5,lpsfreq5,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av5 = psb_av5 + psb/ndata5;
          end

          if noise_sub == 1
              psb_av5 = psb_av5 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      end
%%
    elseif data_species == 6

      if signal_type == 1
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
              psa_av1 = psa_av1 + psa/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
              psa_av1 = psa_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
              psa_av2 = psa_av2 + psa/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
              psa_av2 = psa_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
              psa_av3 = psa_av3 + psa/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
              psa_av3 = psa_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate4,eq_ratio4,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate4,eq_ratio4,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate4,eq_ratio4,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate4,eq_ratio4,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
              psa_av4 = psa_av4 + psa/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
              psa_av4 = psa_av4 - psnoise_av;
          end

          for i = 1:1:ndata5
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate5,eq_ratio5,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate5,eq_ratio5,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate5,eq_ratio5,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate5,eq_ratio5,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av5 = psb_av5 + psb/ndata5;
              psa_av5 = psa_av5 + psa/ndata5;
          end

          if noise_sub == 1
              psb_av5 = psb_av5 - psnoise_av;
              psa_av5 = psa_av5 - psnoise_av;
          end

          for i = 1:1:ndata6
              if up_or_dwn == 1
                  fnpsb = sprintf('PUpper_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate6,eq_ratio6,fft_mean_tlength,i);
                  fnpsa = sprintf('PUpper_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate6,eq_ratio6,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnpsb = sprintf('PDown_PS_b_%d_%.2f_tlen%g_%02u.dat',flow_rate6,eq_ratio6,fft_mean_tlength,i);
                  fnpsa = sprintf('PDown_PS_a_%d_%.2f_tlen%g_%02u.dat',flow_rate6,eq_ratio6,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnpsb),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              fid = fopen(append(dir,fnpsa),'r');
              psa = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av6 = psb_av6 + psb/ndata6;
              psa_av6 = psa_av6 + psa/ndata6;
          end

          if noise_sub == 1
              psb_av6 = psb_av6 - psnoise_av;
              psa_av6 = psa_av6 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);
%%
      elseif signal_type == 2
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct1,hpsfreq1,lpsfreq1,flow_rate1,eq_ratio1,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct1,hpsfreq1,lpsfreq1,flow_rate1,eq_ratio1,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct2,hpsfreq2,lpsfreq2,flow_rate2,eq_ratio2,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct2,hpsfreq2,lpsfreq2,flow_rate2,eq_ratio2,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct3,hpsfreq3,lpsfreq3,flow_rate3,eq_ratio3,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct3,hpsfreq3,lpsfreq3,flow_rate3,eq_ratio3,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct4,hpsfreq4,lpsfreq4,flow_rate4,eq_ratio4,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct4,hpsfreq4,lpsfreq4,flow_rate4,eq_ratio4,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
          end

          for i = 1:1:ndata5
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct5,hpsfreq5,lpsfreq5,flow_rate5,eq_ratio5,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct5,hpsfreq5,lpsfreq5,flow_rate5,eq_ratio5,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av5 = psb_av5 + psb/ndata5;
          end

          if noise_sub == 1
              psb_av5 = psb_av5 - psnoise_av;
          end

          for i = 1:1:ndata6
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct6,hpsfreq6,lpsfreq6,flow_rate6,eq_ratio6,fft_mean_tlength);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_hps%d_lps%d_%d_%.2f_tlen%g_cER.dat',lduct6,hpsfreq6,lpsfreq6,flow_rate6,eq_ratio6,fft_mean_tlength);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av6 = psb_av6 + psb/ndata6;
          end

          if noise_sub == 1
              psb_av6 = psb_av6 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g_cER.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);
%%
      elseif signal_type == 3
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration4,lduct4,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration4,lduct4,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
          end

          for i = 1:1:ndata5
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration5,lduct5,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration5,lduct5,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av5 = psb_av5 + psb/ndata5;
          end

          if noise_sub == 1
              psb_av5 = psb_av5 - psnoise_av;
          end

          for i = 1:1:ndata6
              if up_or_dwn == 1
                  fnps = sprintf('ppu_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration6,lduct6,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('ppd_spk_ps_%d-%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration6,lduct6,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av6 = psb_av6 + psb/ndata6;
          end

          if noise_sub == 1
              psb_av6 = psb_av6 - psnoise_av;
          end

          fnaxis = sprintf('p_spk_ps_f_%d-%dHz_%dV_%gs_d%d_tlen%g.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);
%%
      elseif signal_type == 4
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part1,hpsfreq1,lpsfreq1,specific_f1,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part1,hpsfreq1,lpsfreq1,specific_f1,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part2,hpsfreq2,lpsfreq2,specific_f2,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part2,hpsfreq2,lpsfreq2,specific_f2,speaker_voltage,speaker_duration2,lduct2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part3,hpsfreq3,lpsfreq3,specific_f3,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part3,hpsfreq3,lpsfreq3,specific_f3,speaker_voltage,speaker_duration3,lduct3,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part4,hpsfreq4,lpsfreq4,specific_f4,speaker_voltage,speaker_duration4,lduct4,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part4,hpsfreq4,lpsfreq4,specific_f4,speaker_voltage,speaker_duration4,lduct4,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
          end

          for i = 1:1:ndata5
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part5,hpsfreq5,lpsfreq5,specific_f5,speaker_voltage,speaker_duration5,lduct5,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part5,hpsfreq5,lpsfreq5,specific_f5,speaker_voltage,speaker_duration5,lduct5,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av5 = psb_av5 + psb/ndata5;
          end

          if noise_sub == 1
              psb_av5 = psb_av5 - psnoise_av;
          end

          for i = 1:1:ndata6
              if up_or_dwn == 1
                  fnps = sprintf('p%d/PUpper_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part6,hpsfreq6,lpsfreq6,specific_f6,speaker_voltage,speaker_duration6,lduct6,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('p%d/PDown_speaker_PS_hps%d_lps%d_%dHz_%dV_%gs_d%d_tlen%g_%02u.dat',part6,hpsfreq6,lpsfreq6,specific_f6,speaker_voltage,speaker_duration6,lduct6,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av6 = psb_av6 + psb/ndata6;
          end

          if noise_sub == 1
              psb_av6 = psb_av6 - psnoise_av;
          end

          fnaxis = sprintf('p%d/PS_faxis_pressure_tlen%g.dat',part1,fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);
%%
      elseif signal_type == 5
          for i = 1:1:ndata1
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct1,flow_rate1,hpsfreq1,lpsfreq1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct1,flow_rate1,hpsfreq1,lpsfreq1,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av1 = psb_av1 + psb/ndata1;
          end

          if noise_sub == 1
              psb_av1 = psb_av1 - psnoise_av;
          end

          for i = 1:1:ndata2
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct2,flow_rate2,hpsfreq2,lpsfreq2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct2,flow_rate2,hpsfreq2,lpsfreq2,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av2 = psb_av2 + psb/ndata2;
          end

          if noise_sub == 1
              psb_av2 = psb_av2 - psnoise_av;
          end

          for i = 1:1:ndata3
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct3,flow_rate3,hpsfreq3,lpsfreq3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct3,flow_rate3,hpsfreq3,lpsfreq3,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av3 = psb_av3 + psb/ndata3;
          end

          if noise_sub == 1
              psb_av3 = psb_av3 - psnoise_av;
          end

          for i = 1:1:ndata4
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct4,flow_rate4,hpsfreq4,lpsfreq4,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct4,flow_rate4,hpsfreq4,lpsfreq4,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av4 = psb_av4 + psb/ndata4;
          end

          if noise_sub == 1
              psb_av4 = psb_av4 - psnoise_av;
          end

          for i = 1:1:ndata5
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct5,flow_rate5,hpsfreq5,lpsfreq5,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct5,flow_rate5,hpsfreq5,lpsfreq5,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av5 = psb_av5 + psb/ndata5;
          end

          if noise_sub == 1
              psb_av5 = psb_av5 - psnoise_av;
          end

          for i = 1:1:ndata6
              if up_or_dwn == 1
                  fnps = sprintf('PUpper_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct6,flow_rate6,hpsfreq6,lpsfreq6,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_d%d_air%dL_hps%d_lps%d_tlen%g_%02u.dat',lduct6,flow_rate6,hpsfreq6,lpsfreq6,fft_mean_tlength,i);
              end

              fid = fopen(append(dir,fnps),'r');
              psb = fread(fid,div_nlength,'double');
              fclose(fid);

              psb_av6 = psb_av6 + psb/ndata6;
          end

          if noise_sub == 1
              psb_av6 = psb_av6 - psnoise_av;
          end

          fnaxis = sprintf('PS_faxis_pressure_tlen%g.dat',fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);

      end
%%
    end

%% FIGURE
    figure('Position', [50 50 960 735],'Color','white');
%     loglog(faxis,psb_av1,'-vr','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av1))
    loglog(faxis,psb_av1,'-vr','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av1))
    hold on
    if signal_type == 1
%         loglog(faxis,psa_av1,'-^r','MarkerSize',8,'MarkerFaceColor','r','MarkerIndices',1:5:length(psa_av1))
        loglog(faxis,psa_av1,'-^r','MarkerSize',8,'MarkerFaceColor','r','MarkerIndices',1:1:length(psa_av1))
    end

    ax = gca;
    xtickformat('%d')
%     xticks([20 30 40 50 60 70 80 90 100 200])
%     set(gca,'xTickLabel', char('20','','40','','60','','80','','100','200'))
    ytickformat('%d')
%     yticks([0.00000001 0.000001 0.0001 0.01 1 100 10000])
%     set(gca,'YTickLabel', char('10^{-8}','10^{-6}','10^{-4}','10^{-2}','10^{0}','10^{2}','10^{4}'))

     ax.XAxisLocation = 'bottom';
     ax.YDir='normal';
     ax.YAxisLocation = 'left';
     ax.XColor = 'black';
     ax.YColor = 'black';
     % ax.XScale = 'log';
     % ax.YScale = 'log';
%      ax.XLim = [hpsfreq1 lpsfreq1];
     ax.XLim = [hpsfreq1 300];
     ax.YLim = [0.1 10000];
     ax.FontSize = 20;
     ax.FontName = 'Times New Roman';
     ax.TitleFontSizeMultiplier = 2;
     ax.Box = 'on';
     ax.LineWidth = 2.0;
     ax.XMinorTick = 'on';
     ax.YMinorTick = 'on';

     xlabel('\it \fontname{Times New Roman}f \rm[Hz]');
     ylabel('\it \fontname{Times New Roman}P \rm[kPa]');
     hold on

     if data_species == 2

%        loglog(faxis,psb_av2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av2))
%        loglog(faxis,psb_av2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av2))
       loglog(faxis,psb_av2,'-sk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av2))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av2,'-<b','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:5:length(psa_av2))
           loglog(faxis,psa_av2,'-<b','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:1:length(psa_av2))
           hold on
       end

     elseif data_species == 3

%        loglog(faxis,psb_av2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av2))
       loglog(faxis,psb_av2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av2))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av2,'-<b','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:5:length(psa_av2))
           loglog(faxis,psa_av2,'-<b','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:1:length(psa_av2))
           hold on
       end
%        loglog(faxis,psb_av3,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av3))
       loglog(faxis,psb_av3,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av3))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av3,'->k','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:5:length(psa_av3))
           loglog(faxis,psa_av3,'->k','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(psa_av3))
           hold on
       end

     elseif data_species == 4

%        loglog(faxis,psb_av2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av2))
       loglog(faxis,psb_av2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av2))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av2,'-<b','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:5:length(psa_av2))
           loglog(faxis,psa_av2,'-<b','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:1:length(psa_av2))
           hold on
       end
%        loglog(faxis,psb_av3,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av3))
       loglog(faxis,psb_av3,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av3))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av3,'->k','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:5:length(psa_av3))
           loglog(faxis,psa_av3,'->k','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(psa_av3))
           hold on
       end
%        loglog(faxis,psb_av4,'-pg','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av4))
       loglog(faxis,psb_av4,'-pg','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av4))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av4,'-hg','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:5:length(psa_av4))
           loglog(faxis,psa_av4,'-hg','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(psa_av4))
           hold on
       end

     elseif data_species == 5

%        loglog(faxis,psb_av2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av2))
       loglog(faxis,psb_av2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av2))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av2,'-<b','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:5:length(psa_av2))
           loglog(faxis,psa_av2,'-<b','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:1:length(psa_av2))
           hold on
       end
%        loglog(faxis,psb_av3,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av3))
       loglog(faxis,psb_av3,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av3))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av3,'->k','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:5:length(psa_av3))
           loglog(faxis,psa_av3,'->k','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(psa_av3))
           hold on
       end
%        loglog(faxis,psb_av4,'-pg','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av4))
       loglog(faxis,psb_av4,'-pg','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av4))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av4,'-hg','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:5:length(psa_av4))
           loglog(faxis,psa_av4,'-hg','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(psa_av4))
           hold on
       end
%        loglog(faxis,psb_av5,'-xc','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av5))
       loglog(faxis,psb_av5,'-xc','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av5))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av5,'-+c','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:5:length(psa_av5))
           loglog(faxis,psa_av5,'-+c','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(psa_av5))
           hold on
       end

     elseif data_species == 6

%        loglog(faxis,psb_av2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av2))
       loglog(faxis,psb_av2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av2))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av2,'-<b','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:5:length(psa_av2))
           loglog(faxis,psa_av2,'-<b','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:1:length(psa_av2))
           hold on
       end
%        loglog(faxis,psb_av3,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av3))
       loglog(faxis,psb_av3,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av3))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av3,'->k','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:5:length(psa_av3))
           loglog(faxis,psa_av3,'->k','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(psa_av3))
           hold on
       end
%        loglog(faxis,psb_av4,'-pg','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av4))
       loglog(faxis,psb_av4,'-pg','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av4))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av4,'-hg','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:5:length(psa_av4))
           loglog(faxis,psa_av4,'-hg','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(psa_av4))
           hold on
       end
%        loglog(faxis,psb_av5,'-xc','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av5))
       loglog(faxis,psb_av5,'-xc','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av5))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av5,'-+c','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:5:length(psa_av5))
           loglog(faxis,psa_av5,'-+c','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(psa_av5))
           hold on
       end
%        loglog(faxis,psb_av6,'-om','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:5:length(psb_av6))
       loglog(faxis,psb_av6,'-om','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av6))
       hold on
       if signal_type == 1
%            loglog(faxis,psa_av6,'-*m','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:5:length(psa_av6))
           loglog(faxis,psa_av6,'-*m','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(psa_av6))
           hold on
       end

     end

%      legend('Downstream, 450mm','FontSize',20,'Location','northwest')
%      legend('Upperstream, 450mm','FontSize',20,'Location','northwest')
%      legend('582mm','883mm','1185mm','FontSize',20,'Location','northwest')
     % legend('582mm','883mm','1185mm','0mm','FontSize',20,'Location','northwest')
%      legend('61Hz','68Hz','70Hz','73Hz','80Hz','FontSize',20,'Location','northwest')
%      legend('85Hz','143Hz','147Hz','149Hz','155Hz','FontSize',20,'Location','northwest')
%      legend('171Hz','188Hz','194Hz','203Hz','232Hz','FontSize',20,'Location','northwest')
%      legend('400L/min, stable','400L/min, oscillation','450L/min, stable','450L/min, oscillation','500L/min, stable','500L/min, oscillation','FontSize',20,'Location','northwest')
%      legend('250L/min','300L/min','350L/min','400L/min','450L/min','500L/min','FontSize',20,'Location','northwest')
     % legend('250L/min, 0.70','250L/min, 0.72','250L/min, 0.74','250L/min, 0.76','250L/min, 0.78','250L/min, 0.80','FontSize',15,'Location','northeast')
     % legend('350L/min, 0.70','350L/min, 0.72','350L/min, 0.74','350L/min, 0.76','350L/min, 0.78','350L/min, 0.80','FontSize',15,'Location','northeast')
     % legend('450L/min, 0.70','450L/min, 0.72','450L/min, 0.74','450L/min, 0.76','450L/min, 0.78','450L/min, 0.80','FontSize',15,'Location','northeast')
     % legend('500L/min, 0.70','500L/min, 0.72','500L/min, 0.74','500L/min, 0.76','500L/min, 0.78','500L/min, 0.80','FontSize',15,'Location','northeast')
     legend('500L/min, 0.74','500L/min, 0.80','FontSize',15,'Location','northwest')
     hold on
%      plot(spk_freq(1:6),spk_PS(1:6)/30,'-dk','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(spk_PS))
%      hold on
%      plot(spk_freq(7:14),spk_PS(7:14)/30,'-dk','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(spk_PS))
     hold off
     pbaspect([sqrt(2) 1 1]);
