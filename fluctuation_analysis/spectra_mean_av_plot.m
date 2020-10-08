    clear all
    close all
    clc

%% PARAMETERS
    data_species = 3; % 1, 2, 3
    signal_type = 3; % 1. p_sequence, 2. p_cER, 3. speaker
    noise_sub = 0; %1. Yes, 0: No
    up_or_dwn = 1; % 1. upperstream 2. downstream, when signal_type = 1 or 2 or 3

%%
    ndata_noise = 5;
    noise_date = 20200828;
    fs_noise = 20e3;
    fft_mean_tlength_noise = 1; % [s]
    
    dir_noise = sprintf('H:/Analysis/pressure/%d/calc/',noise_date);
    div_nlength_noise = fs_noise*fft_mean_tlength_noise;
    
%%
    if data_species == 1

      ndata1 = 30;
      flow_rate1 = 0; % [L/min]
      eq_ratio1 = 0.00;
      speaker_duration1 = 7.5; % [s], signal_type = 3
      lduct1 = 1185; % [mm], signal_type = 3

      date = 20200908;
      fft_mean_tlength = 1; % [s]
      speaker_voltage = 1; % [V], signal_type = 3
      speaker_lf = 0; % [Hz], signal_type = 3
      speaker_hf = 350; % [Hz], signal_type = 3
      fs = 20e3;
      div_nlength = fs*fft_mean_tlength;
      
      dir = sprintf('H:/Analysis/pressure/%d/calc/',date);
      % dir = sprintf('E:/chem_output/chem_intensity/%d/',date);
      % dir = sprintf('E:/piv_output/v_oscillation/');
      
%%
    elseif data_species == 2

      ndata1 = 30;
      flow_rate1 = 0; % [L/min]
      eq_ratio1 = 0.00;
      speaker_duration1 = 7.5; % [s], signal_type = 3
      lduct1 = 1185; % [mm], signal_type = 3

      ndata2 = 30;
      flow_rate2 = 0; % [L/min]
      eq_ratio2 = 0.00;
      speaker_duration2 = 7.5; % [s], signal_type = 3
      lduct2 = 1185; % [mm], signal_type = 3

      date = 20200908;
      fft_mean_tlength = 1; % [s]
      speaker_voltage = 1; % [V], signal_type = 3
      speaker_lf = 0; % [Hz], signal_type = 3
      speaker_hf = 350; % [Hz], signal_type = 3
      fs = 20e3;
      div_nlength = fs*fft_mean_tlength;

      dir = sprintf('H:/Analysis/pressure/%d/calc/',date);
      % dir = sprintf('E:/chem_output/chem_intensity/%d/',date);
      % dir = sprintf('E:/piv_output/v_oscillation/');
      
%%
    elseif data_species == 3

      ndata1 = 31;
      flow_rate1 = 0; % [L/min]
      eq_ratio1 = 0.00;
      speaker_duration1 = 7.5; % [s], signal_type = 3
      lduct1 = 582; % [mm], signal_type = 3

      ndata2 = 30;
      flow_rate2 = 0; % [L/min]
      eq_ratio2 = 0.00;
      speaker_duration2 = 7.5; % [s], signal_type = 3
      lduct2 = 883; % [mm], signal_type = 3

      ndata3 = 30;
      flow_rate3 = 0; % [L/min]
      eq_ratio3 = 0.00;
      speaker_duration3 = 7.5; % [s], signal_type = 3
      lduct3 = 1185; % [mm], signal_type = 3

      date = 20200908;
      fft_mean_tlength = 5; % [s]
      speaker_voltage = 1; % [V], signal_type = 3
      speaker_lf = 0; % [Hz], signal_type = 3
      speaker_hf = 350; % [Hz], signal_type = 3
      fs = 20e3;
      div_nlength = fs*fft_mean_tlength;

      dir = sprintf('H:/Analysis/pressure/%d/calc/',date);
      % dir = sprintf('E:/chem_output/chem_intensity/%d/',date);
      % dir = sprintf('E:/piv_output/v_oscillation/');
      
%%
    end

%% Matrix
    psnoise_av = zeros();
    psb_av1 = 0;
    psb_av2 = 0;
    psb_av3 = 0;
    psa_av1 = 0;
    psa_av2 = 0;
    psa_av3 = 0;

%% READ and AVERAGE
%%
    if noise_sub == 1
        for i = 1:1:ndata_noise
            if (signal_type == 1) || (signal_type == 2) || (signal_type == 3)
                if up_or_dwn == 1
                    fnps_n = sprintf('ppu_spk_ps_noinput_tlen%g_%02u.dat',fft_mean_tlength_noise,i);
                elseif up_or_dwn == 2
                    fnps_n = sprintf('ppd_spk_ps_noinput_tlen%g_%02u.dat',fft_mean_tlength_noise,i);
                end
            elseif signal_type == 4
                
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
                  fnps = sprintf('PUpper_PS_%d_%.2f_tlen%g_%d_%02u_cER.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_%d_%.2f_tlen%g_%d_%02u_cER.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
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
                  fnps = sprintf('PUpper_PS_%d_%.2f_tlen%g_%d_%02u_cER.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_%d_%.2f_tlen%g_%d_%02u_cER.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
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
                  fnps = sprintf('PUpper_PS_%d_%.2f_tlen%g_%d_%02u_cER.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_%d_%.2f_tlen%g_%d_%02u_cER.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
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
                  fnps = sprintf('PUpper_PS_%d_%.2f_tlen%g_%d_%02u_cER.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_%d_%.2f_tlen%g_%d_%02u_cER.dat',flow_rate1,eq_ratio1,fft_mean_tlength,i);
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
                  fnps = sprintf('PUpper_PS_%d_%.2f_tlen%g_%d_%02u_cER.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_%d_%.2f_tlen%g_%d_%02u_cER.dat',flow_rate2,eq_ratio2,fft_mean_tlength,i);
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
                  fnps = sprintf('PUpper_PS_%d_%.2f_tlen%g_%d_%02u_cER.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
              elseif up_or_dwn == 2
                  fnps = sprintf('PDown_PS_%d_%.2f_tlen%g_%d_%02u_cER.dat',flow_rate3,eq_ratio3,fft_mean_tlength,i);
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
          
          fnaxis = sprintf('p_spk_ps_f_%d-%dHz_%dV_%gs_d%d_tlen%g.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration1,lduct1,fft_mean_tlength);
          fid = fopen(append(dir,fnaxis),'r');
          faxis = fread(fid,div_nlength,'double');
          fclose(fid);
          
      elseif signal_type == 4
          
          
      end

    end

%% FIGURE

    figure('Position', [50 50 960 735],'Color','white');
    loglog(faxis,psb_av1,'-vr','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:2:length(psb_av1))
    hold on
    if signal_type == 1
        loglog(faxis,psa_av1,'-^r','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:2:length(psa_av1))
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
     ax.XLim = [20 300];
     ax.YLim = [1 10000];
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

       loglog(faxis,psb_av2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:2:length(psb_av2))
       hold on
       if signal_type == 1
           loglog(faxis,psa_av2,'-<b','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:2:length(psa_av2))
           hold on
       end

     elseif data_species == 3

       loglog(faxis,psb_av2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:2:length(psb_av2))
       hold on
       if signal_type == 1
           loglog(faxis,psa_av2,'-<b','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:2:length(psa_av2))
           hold on
       end
       loglog(faxis,psb_av3,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:2:length(psb_av3))
       hold on
       if signal_type == 1
           loglog(faxis,psa_av3,'->k','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:2:length(psa_av3))
           hold on
       end

     end

     legend('582mm','883mm','1185mm','FontSize',20,'Location','northwest')
     hold off
     pbaspect([sqrt(2) 1 1]);
