    clear all
    close all
    clc

%% PARAMETERS

    date = 20200828;
    num = 7;
    name_mode = 2; % 1. p_sequence, 2. p_cER
    up_or_dwn = 2; % 1. upstream, 2. downstream
    vis_lim = 0; % 0. no lim, 1. lim by transition-time
    trig_time = 3.4950; % [sec]
    cam_start_time = 2.4032; % [sec]

    Fs = 20e3; % Sampling Rate
    samp_time = 15; % [sec]

    hpsfreq = 10; % [Hz]
    lpsfreq = 300; % [Hz]
    RMS_width = 0.2; %  [sec]
    decide_trans_percent = 0.1; % 10%
    mean_samp_time = 2; % [sec]

    b_fluc_range = 1; %[sec]
    b_entirefluc_start = 0.1; % [sec] >0
    a_fluc_range = 2; %[sec]
    a_entirefluc_start = 3.5; % [sec] >0

%% MATRIX

    Sts = 1/Fs; % [sec]
    p_datasize = Fs*samp_time;
    r_datasize = Fs*samp_time-RMS_width/Sts;
    taxis_mean = (Sts+mean_samp_time)/2:Sts:(2*r_datasize*Sts+Sts-mean_samp_time)/2

%% READ DATA

    dir = sprintf('H:/Analysis/pressure/%d/calc/',date);
    fn_signal_axis = sprintf('signal_time_%dkHz_%dsec.dat',fs/1000,samp_time);
    fn_rms_axis = sprintf('rms_time_%dkHz_%dsec_width%.1fsec.dat',fs/1000,samp_time,RMS_width);
    if name_mode == 1
      if up_or_dwn == 1
        fnbps = sprintf('PUpper_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
        fnrms = sprintf('PUpper_primerms_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
      elseif up_or_dwn == 2
        fnbps = sprintf('PDown_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
        fnrms = sprintf('PDown_primerms_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
      end
    elseif name_mode == 2
      if up_or_dwn == 1
        fnbps = sprintf('PUpper_hps%d_lps%d_%d_%.2f_cER.dat',hpsfreq,lpsfreq,flow_rate,eq_ratio);
        fnrms = sprintf('PUpper_primerms_hps%d_lps%d_%d_%.2f_cER.dat',hpsfreq,lpsfreq,flow_rate,eq_ratio);
      elseif up_or_dwn == 2
        fnbps = sprintf('PDown_hps%d_lps%d_%d_%.2f_cER.dat',hpsfreq,lpsfreq,flow_rate,eq_ratio);
        fnrms = sprintf('PDown_primerms_hps%d_lps%d_%d_%.2f.dat',hpsfreq,lpsfreq,flow_rate,eq_ratio);
      end
    end
    fn_signal_axis = append(dir,fn_signal_axis);
    fn_rms_axis = append(dir,fn_rms_axis);
    fnbps = append(dir,fnbps);
    fnrms = append(dir,fnrms);

    fid = fopen(fn_signal_axis,'r');
    taxis_p = fread(fid,p_datasize,'double');
    fclose(fid);

    fid = fopen(fn_rms_axis,'r');
    taxis_r = fread(fid,r_datasize,'double');
    fclose(fid);

    fid = fopen(fnbps,'r');
    pp = fread(fid,p_datasize,'double');
    fclose(fid);

    fid = fopen(fnrms,'r');
    pp_rms = fread(fid,r_datasize,'double');
    fclose(fid);

%%  CONFIRMATION THE CHANGES

    for k = 1:r_datasize - mean_samp_time/Sts + 1
      for j = k:k + mean_samp_time/Sts - 1
        rms_temp(j) = pp_rms;
      end
      fluc_mean(k) = mean(rms_temp);
    end

    figure('Position', [50 50 960 735],'Color','white');
    plot(taxis_mean, fluc_mean, '-k', 'LineWidth',1.5)

    ax = gca;
    xtickformat('%d')
    ytickformat('%.2f')
    ax.XAxisLocation = 'bottom';
    ax.YDir = 'normal';
    ax.YAxisLocation = 'left';
    ax.XColor = 'black';
    ax.YColor = 'black';
    ax.XLim = [(Sts+mean_samp_time)/2 (2*r_datasize*Sts+Sts-mean_samp_time)/2];
    % ax.YLim = [0 0.4]
    ax.FontSize = 25;
    ax.FontName =  'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlabel('\it \fontname{Times New Roman} t \rm[s]')
    ylabel('\it \fontname{Times New Roman} p''_{rms} \rm[kPa]')
    set(gca,'FontName','Times New Roman','FontSize',25)
    pbaspect([sqrt(2) 1 1]);
    pause;

%%  FIND TRANSITION TIME

    detect_time_end = floor(cam_start_time) + 2;  % [sec] > from_detect
    from_detect_fluc_start = floor(cam_start_time);  % [sec]  >0
    from_detect_fluc_end = floor(cam_start_time);  % [sec]  >0

    for i = 1:b_fluc_range/Sts
        rms_temp(i) = pp_rms(b_entirefluc_start/Sts+i);
    end

    b_fluc_mean = mean(rms_temp)
    clear rms_temp;

    for i = 1:a_fluc_range/Sts
        rms_temp(i) = pp_rms(a_entirefluc_start/Sts+i);
    end

    a_fluc_mean = mean(rms_temp)

    trans_start_rms = b_fluc_mean+(a_fluc_mean-b_fluc_mean)*decide_trans_percent;
    trans_time_tmp = 10e7;  % do not change

    for  t = from_detect_fluc_start/Sts:detect_time_end/Sts
        if  pp_rms(t) > trans_start_rms
            if t < trans_time_tmp
                trans_time_tmp = t;
            end
        end
    end

    trans_start_time = trans_time_tmp*Sts + RMS_width/2  % [usec]

    trans_fin_rms = a_fluc_mean-(a_fluc_mean-b_fluc_mean)*decide_trans_percent;
    trans_time_tmp = 10e7;  % do not change

    for  t =  from_detect_fluc_end/Sts:detect_time_end/Sts
        if  pp_rms(t) > trans_fin_rms
            if t < trans_time_tmp
                trans_time_tmp = t;
            end
        end
    end

    trans_fin_time = trans_time_tmp*Sts + RMS_width/2  % [usec]

%% FIGURE, rms

    figure('Position', [50 50 960 735],'Color','white');
    plot(taxis_r,pp_rms,'k')

    ax = gca;
    xtickformat('%d')
    ytickformat('%.2f')

    if vis_lim == 1
      xticks([trans_start_time-1 trans_start_time-0.5 trans_start_time trans_start_time+0.5 trans_start_time+1 trans_start_time+1.5 trans_start_time+2])
      set(gca,'xTickLabel', char('-1.0','-0.5','0.0','0.5','1.0','1.5','2.0'))
      ax.Xlim([trans_start_time-1.0 trans_start_time+1.0]);
      ax.Ylim([0 0.60]);
    end

    ax.FontSize = 25;
    ax.FontName =  'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlabel('\it \fontname{Times New Roman} t \rm[sec]')
    ylabel('\it \fontname{Times New Roman} p''_{rms} \rm[kPa]')
    set(gca,'FontName','Times New Roman','FontSize',25)
    hold on

    plot([0 samp_time],[a_fluc_mean a_fluc_mean],'r','LineWidth',1.0)
    hold on

    plot([0 samp_time],[b_fluc_mean b_fluc_mean],'b','LineWidth',1.0)
    hold on

    plot([trans_start_time trans_start_time],[0 0.60],'m--','LineWidth',1.0)
    hold on

    plot([trans_fin_time trans_fin_time],[0 0.60],'m--','LineWidth',1.0)
    hold on

    plot([trig_time trig_time],[0 0.60],'g','LineWidth',1.0)
    hold on

    plot([cam_start_time cam_start_time],[0 0.60],'g','LineWidth',1.0)
    hold off
    pbaspect([sqrt(2) 1 1]);

%% FIGURE, pp

    figure('Position', [50 50 960 735],'Color','white');
    plot(taxis_p,pp,'k')

    ax = gca;
    xtickformat('%d')
    ytickformat('%.2f')

    if vis_lim == 1
      xticks([trans_start_time-1 trans_start_time-0.5 trans_start_time trans_start_time+0.5 trans_start_time+1 trans_start_time+1.5 trans_start_time+2])
      set(gca,'xTickLabel', char('-1.0','-0.5','0.0','0.5','1.0','1.5','2.0'))
      ax.Xlim([trans_start_time-1.0 trans_start_time+1.0]);
      ax.Ylim([-0.60 0.60]);
    end

    ax.FontSize = 25;
    ax.FontName =  'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlabel('\it \fontname{Times New Roman} t \rm[sec]')
    ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
    set(gca,'FontName','Times New Roman','FontSize',25)
    hold on

    plot([trans_start_time trans_start_time],[-0.60 0.60],'m--','LineWidth',1.0)
    hold on

    plot([trans_fin_time trans_fin_time],[-0.60 0.60],'m--','LineWidth',1.0)
    hold on

    plot([trig_time trig_time],[-0.60 0.60],'g','LineWidth',1.0)
    hold on

    plot([cam_start_time cam_start_time],[-0.60 0.60],'g','LineWidth',1.0)
    hold off
    pbaspect([sqrt(2) 1 1]);
