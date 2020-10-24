    clear all
    close all
    clc

%% PARAMETERS

    name_mode = 2; % 1. p_sequence, 2. p_cER, 3. specific Hz
    date = 20201015;
    recnum = 1;
    sw_num = 60; % [-], vane angle, only for name_mode = 2
    flow_rate = 290; % [L/min], only for name_mode = 2
    eq_ratio = 0.72; % [-], only for name_mode = 2
    duct_l = 582; % [mm], only for name_mode = 2
    specific_f = 100; % [Hz], only for name_mode = 3
    speaker_v = 1; % [V], only for name_mode = 3
    speaker_t = 15; % [s], only for name_mode = 3
    
    fs = 20e3; % Sampling Rate [Hz]
    samp_time = 15; % [sec]
    trigV = 8; % [V]
    Prof_Upper = 20/10; % [kPa/V]
    Prof_Down = 0.5; % [kPa/V]

    fft_dbl_type = 2; % 1. ^v^v 2. ^vv^ 3. ^v
    hpsfreq = 20; % [Hz]
    lpsfreq = 300; % [Hz]
    RMS_width = 0.2; % [sec]
    cam_frames = 21838;

    for num = 1:1:recnum

%% READ DATA

%       dir = sprintf('H:/Analysis/pressure/%d/calc/',date);
      dir = sprintf('C:/Users/yatagi/Desktop/sw%d_cER/%d/calc/',sw_num,date);
      
      if name_mode == 1
        rfn = sprintf('pressure_%d.xlsx',num);
      elseif name_mode == 2
        rfn = sprintf('pressure_d%d_%d_%.2f_cER.xlsx',duct_l,flow_rate,eq_ratio);
      elseif name_mode == 3
        rfn = sprintf('pressure_speaker_%dHz_%dV_%ds_%d.xlsx',specific_f,speaker_v,speaker_t,num);
      end
      trig = xlsread(append(dir,rfn), sprintf('A2:A%d',fs*samp_time+1));   
      upv = xlsread(append(dir,rfn), sprintf('B2:B%d',fs*samp_time+1));     
      dpv = xlsread(append(dir,rfn), sprintf('C2:C%d',fs*samp_time+1));
      spv = xlsread(append(dir,rfn), sprintf('D2:D%d',fs*samp_time+1));
%       trig = xlsread(append(dir,rfn), sprintf('C2:C%d',fs*samp_time+1));
%       upv = xlsread(append(dir,rfn), sprintf('B2:B%d',fs*samp_time+1));
%       dpv = xlsread(append(dir,rfn), sprintf('A2:A%d',fs*samp_time+1));

%% OUTPUT FILE

      fn_signal_axis = sprintf('signal_time_%dkHz_%dsec.dat',fs/1000,samp_time);
      fn_rms_axis = sprintf('rms_time_%dkHz_%dsec_width%.1fsec.dat',fs/1000,samp_time,RMS_width);
      if name_mode == 1
        fnubps = sprintf('PUpper_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
        fndbps = sprintf('PDown_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
        fnurms = sprintf('PUpper_primerms_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
        fndrms = sprintf('PDown_primerms_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
      elseif name_mode == 2
        fnubps = sprintf('PUpper_d%d_hps%d_lps%d_%d_%.2f_cER.dat',duct_l,hpsfreq,lpsfreq,flow_rate,eq_ratio);
        fndbps = sprintf('PDown_d%d_hps%d_lps%d_%d_%.2f_cER.dat',duct_l,hpsfreq,lpsfreq,flow_rate,eq_ratio);
        fnurms = sprintf('PUpper_d%d_primerms_hps%d_lps%d_%d_%.2f_cER.dat',duct_l,hpsfreq,lpsfreq,flow_rate,eq_ratio);
        fndrms = sprintf('PDown_d%d_primerms_hps%d_lps%d_%d_%.2f.dat',duct_l,hpsfreq,lpsfreq,flow_rate,eq_ratio);
      elseif name_mode == 3
        fnubps = sprintf('PUpper_speaker_hps%d_lps%d_%dHz_%dV_%ds_%d.dat',hpsfreq,lpsfreq,specific_f,speaker_v,speaker_t,num);
        fndbps = sprintf('PDown_speaker_hps%d_lps%d_%dHz_%dV_%ds_%d.dat',hpsfreq,lpsfreq,specific_f,speaker_v,speaker_t,num);
        fnurms = sprintf('PUpper_primerms_speaker_hps%d_lps%d_%dHz_%dV_%ds_%d.dat',hpsfreq,lpsfreq,specific_f,speaker_v,speaker_t,num);
        fndrms = sprintf('PDown_primerms_speaker_hps%d_lps%d_%dHz_%dV_%ds_%d.dat',hpsfreq,lpsfreq,specific_f,speaker_v,speaker_t,num);
      end
      fn_signal_axis = append(dir,fn_signal_axis);
      fn_rms_axis = append(dir,fn_rms_axis);
      fnubps = append(dir,fnubps);
      fndbps = append(dir,fndbps);
      fnurms = append(dir,fnurms);
      fndrms = append(dir,fndrms);

%% Matrix

      Sts = 1/fs; % [sec]
      ppd = Prof_Down*dpv; % [kPa]
      ppu = Prof_Upper*upv; % [kPa]
      taxis = Sts:Sts:samp_time;

      fileID = fopen(fn_signal_axis,'w');
      fwrite(fileID,taxis,'double');
      fclose(fileID);

%% FIND THE TRIGERERD TIME-STEP, Fts

      Fts = 10e7;  % do not change

      for t = 1:fs*samp_time
        if  trig(t) > trigV
          if t < Fts
            Fts = t;
          end
        end
      end

      trig_time = Fts*Sts  % [sec]
      cam_start_time = trig_time - cam_frames*Sts

%% BAND-PASS FILTER, CALCULATION & SAVE

      [ppu] = band_pass_filter(ppu, fs, lpsfreq, hpsfreq, fft_dbl_type);
      [ppd] = band_pass_filter(ppd, fs, lpsfreq, hpsfreq, fft_dbl_type);

      fileID = fopen(fnubps,'w');
      fwrite(fileID,ppu,'double');
      fclose(fileID);

      fileID = fopen(fndbps,'w');
      fwrite(fileID,ppd,'double');
      fclose(fileID);

%% primerms-time, SAVE

      taxis_rms = Sts + RMS_width/2:Sts:samp_time - RMS_width/2;

      fileID = fopen(fn_rms_axis,'w');
      fwrite(fileID,taxis_rms,'double');
      fclose(fileID);

%% PRMIE_RMS, CALCULATION & SAVE

      for k= 1:fs*samp_time - RMS_width/Sts
        for j = 1:RMS_width/Sts
          p_temp_upper(j) = ppu(k+j);
          p_temp_down(j) = ppd(k+j);
        end
        p_rms_upper(k) = rms(p_temp_upper-mean(p_temp_upper));
        p_rms_down(k) = rms(p_temp_down-mean(p_temp_down));
      end

      fileID=fopen(fnurms,'w');
      fwrite(fileID,p_rms_upper,'double');
      fclose(fileID);

      fileID = fopen(fndrms,'w');
      fwrite(fileID,p_rms_down,'double');
      fclose(fileID);

%% FIGURE

% BAND-PASS, P_DOWN
      figure('Position', [50 50 960 735],'Color','white');
      plot(taxis,ppd,'vk')

      ax = gca;
      xtickformat('%d')
      ytickformat('%.2f')

      ax.XColor = 'k';
      ax.YColor = 'k';
      ax.FontSize = 20;
      ax.FontName = 'Times New Roman';
      ax.TitleFontSizeMultiplier = 2;
      ax.Box = 'on';
      ax.LineWidth = 2.0;
      ax.XMinorTick = 'on';
      ax.YMinorTick = 'on';
      ax.XLim = [0 samp_time];
      ax.YLim = [-0.60 0.60];

      xlabel('\it \fontname{Times New Roman} t \rm[sec]')
      ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
      set(gca,'FontName','Times New Roman','FontSize',20)
      hold on

      plot(taxis,ppu,'^r')
      hold on

      plot([trig_time trig_time],[-0.60 0.60],'g','LineWidth',1.5)
      hold on

      plot([cam_start_time cam_start_time],[-0.60 0.60],'g','LineWidth',1.5)
      hold off
      pbaspect([sqrt(2) 1 1]);

% BAND-PASS, P_DOWN, PRIMERMS
      figure('Position', [50 50 960 735],'Color','white');
      plot(taxis_rms,p_rms_down,'vk')

      ax = gca;
      xtickformat('%d')
      ytickformat('%.2f')

      ax.XColor = 'k';
      ax.YColor = 'k';
      ax.FontSize = 20;
      ax.FontName = 'Times New Roman';
      ax.TitleFontSizeMultiplier = 2;
      ax.Box = 'on';
      ax.LineWidth = 2.0;
      ax.XMinorTick = 'on';
      ax.YMinorTick = 'on';
      ax.XLim = [0 samp_time];
      ax.YLim = [0 0.40];

      xlabel('\it \fontname{Times New Roman} t \rm[sec]')
      ylabel('\it \fontname{Times New Roman} p''_{rms} \rm[kPa]')
      set(gca,'FontName','Times New Roman','FontSize',20)
      hold on

      plot(taxis_rms,p_rms_upper,'^r')
      hold on

      plot([trig_time trig_time],[0 0.40],'g','LineWidth',1.5)
      hold on

      plot([cam_start_time cam_start_time],[0 0.40],'g','LineWidth',1.5)
      hold off
      pbaspect([sqrt(2) 1 1]);

      pause;
%       clear all
      close all
      clc

    end
