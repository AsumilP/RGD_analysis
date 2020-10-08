    clear all
    close all
    clc

%% PARAMETERS

    flow_rate1 = 400; % [L/min]
    step1 = 'trans1';
    num_data1 = 6;
    
    flow_rate2 = 400; % [L/min]
    step2 = 'trans2';
    num_data2 = 6;
    
    flow_rate3 = 400; % [L/min]
    step3 = 'trans3';
    num_data3 = 6;
    
    dir = 'G:/dmd_averaged/';

%% READ



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
    loglog(faxis,psb_av1,'-vr','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av1))
    hold on
    if signal_type == 1
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
           loglog(faxis,psa_av2,'-<b','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:2:length(psa_av2))
           hold on
       end

     elseif data_species == 3

       loglog(faxis,psb_av2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av2))
       hold on
       if signal_type == 1
           loglog(faxis,psa_av2,'-<b','MarkerSize',8,'MarkerFaceColor','b','MarkerIndices',1:1:length(psa_av2))
           hold on
       end
       loglog(faxis,psb_av3,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(psb_av3))
       hold on
       if signal_type == 1
           loglog(faxis,psa_av3,'->k','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(psa_av3))
           hold on
       end

     end

     % legend('582mm','883mm','1185mm','FontSize',20,'Location','northwest')
     legend('400L/min, stable','400L/min, oscillation','450L/min, stable','450L/min, oscillation','500L/min, stable','500L/min, oscillation','FontSize',20,'Location','northwest')
     hold off
     pbaspect([sqrt(2) 1 1]);
