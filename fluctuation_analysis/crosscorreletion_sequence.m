    clear all
    close all
    clc

    calc_type = 3; % 1. chemiluminescence & pressure, 2. PIV & pressure, 3. pressure & pressure
    name_mode = 4; % 1. sequence, 2. cER, 3. speaker_specific_f, 4.speaker_chirp, for calc_type = 3
    read_sw = 0; % 1;visualize, slow
    gif_sw = 0; % 1;visualize, slow
    pres_pos = 0; % 0;downstream, 1:upperstream

%% Parameters, change

    calc_start_time = 1; % trans_start_time [s]
    calc_fin_time = 14; % trans_fin_time [s]
    calc_width = 1; % [sec]
    trig_time = 0.1; % [s]
    flow_rate = 0; % [L/min]
    eq_ratio = 0;
    date = 20200908;
    num = 5;
    hpsfreq = 20;
    lpsfreq = 300;

%% Parameters, fixed

    Fs_press = 20e3;
    pres_samp_time = 15;  % [sec]
    specific_f = 100; % [Hz], only for name_mode = 3
    speaker_v = 1; % [V], only for name_mode = 3, 4
    speaker_t = 7.5; % [s], only for name_mode = 3, 4
    speaker_lf = 0; % [Hz] for name_mode = 4
    speaker_hf = 350; % [Hz] for name_mode = 4
    lduct = 582; % [mm] for name_mode = 4
    datasize_pchip = 5000;
    Sts_press = 1/Fs_press; % [sec]
    pres_datasize = Fs_press*pres_samp_time;
    taxis = Sts_press:Sts_press:pres_samp_time;

    calcstartpoint_press = floor(calc_start_time/Sts_press)
    calcfinpoint_press = floor(calc_fin_time/Sts_press)
    T_duration = calc_fin_time-calc_start_time

    sectionsize_press = calc_width/Sts_press;

    if (calc_type == 1) || (calc_type == 2)

      nzall_chem = 21839;
      nzall_spiv = 21838;
      Fs_chem = 10e3;
      Fs_spiv = 20e3;
      Sts_chem = 1/Fs_chem; % [sec]
      Sts_spiv = 1/Fs_spiv; % [sec]

      cam_start_time = trig_time - Sts_spiv*nzall_chem
      chem_cam_start_time = trig_time - Sts_chem*nzall_chem

    end

    if calc_type == 1

      dir_pres = sprintf('H:/Analysis/pressure/%d/calc/',date);
      dir_chem = sprintf('E:/chem_output/chem_intensity/%d/',date);
      dir_out = sprintf('E:/chem_output/chempress_lag/%d/',date);
      if pres_pos == 0
        fnp = sprintf('PDown_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
      elseif pres_pos == 1
        fnp = sprintf('PUpper_hps%d_lps%d_%d_%02u.dat',hpsfreq,lpsfreq,date,num);
      end
      fnc = sprintf('chem_Intensity_bps_%d_%d.dat',date,num);
      fnlag = sprintf('chem_pres_lag_%d_%.2f_%d_%02u.dat',flow_rate,eq_ratio,date,num);
      fnaxi = sprintf('chem_pres_lagtaxis.dat');
      fngif = sprintf('pprime_Iprime_%d_%.2f_%d_%02u.gif',flow_rate,eq_ratio,date,num);

      fnp = append(dir_pres,fnp);
      fnc = append(dir_chem,fnc);
      fnlag = append(dir_out,fnlag);
      fnaxi = append(dir_out,fnaxi);
      fngif = append(dir_out,fngif);

      calcstartpoint_chem = floor((calc_start_time-chem_cam_start_time)/Sts_chem)
      calcfinpoint_chem = floor((calc_fin_time-chem_cam_start_time)/Sts_chem)
      sectionsize_chem = calc_width/Sts_chem;
      axis_temp = Sts_chem:Sts_chem:Sts_chem*sectionsize_chem;
      chem_taxis = chem_cam_start_time:Sts_chem:chem_cam_start_time+Sts_chem*(nzall_chem-1);
      Sts_pchip = (calcfinpoint_chem-calcstartpoint_chem)*Sts_chem/datasize_pchip;
      taxislag = 0:Sts_chem:(calcfinpoint_chem-calcstartpoint_chem)*Sts_chem;
      taxis_pchip = 0:Sts_pchip:(calcfinpoint_chem-calcstartpoint_chem)*Sts_chem;

    elseif calc_type == 2

      dir_pres = sprintf('H:/Analysis/pressure/%d/calc/',date);
      dir_velo = sprintf('E:/piv_output/v_oscillation/');
      dir_out = sprintf('E:/piv_output/v_press_lag/');
      if pres_pos == 0
        fnp = sprintf('PDown_hps%d_lps%d_%d_%d.dat',hpsfreq,lpsfreq,date,num);
      elseif pres_pos == 1
        fnp = sprintf('PUpper_hps%d_lps%d_%d_%d.dat',hpsfreq,lpsfreq,date,num);
      end
      fnvl = sprintf('v_oscillation_l_%d_%02u.dat',date,num);
      fnvr = sprintf('v_oscillation_r_%d_%02u.dat',date,num);
      fnlag = sprintf('velo_pres_lag_%d_%.2f_%d_%02u.dat',flow_rate,eq_ratio,date,num);
      fnaxi = sprintf('velo_pres_lagtaxis.dat');
      fngif = sprintf('pprime_vprime_%d_%.2f_%d_%02u.gif',flow_rate,eq_ratio,date,num);

      fnp = append(dir_pres,fnp);
      fnvl = append(dir_velo,fnvl);
      fnvr = append(dir_velo,fnvr);
      fnlag = append(dir_out,fnlag);
      fnaxi = append(dir_out,fnaxi);
      fngif = append(dir_out,fngif);

      calcstartpoint_spiv = floor((calc_start_time-cam_start_time)/Sts_spiv)
      calcfinpoint_spiv = floor((calc_fin_time-cam_start_time)/Sts_spiv)
      sectionsize_spiv = calc_width/Sts_spiv;
      axis_temp = Sts_spiv:Sts_spiv:Sts_spiv*sectionsize_spiv;
      spiv_taxis = cam_start_time:Sts_spiv:cam_start_time+Sts_spiv*(nzall_spiv-1);
      Sts_pchip = (calcfinpoint_spiv-calcstartpoint_spiv)*Sts_spiv/datasize_pchip;
      taxislag = 0:Sts_spiv:(calcfinpoint_spiv-calcstartpoint_spiv)*Sts_spiv;
      taxis_pchip = 0:Sts_pchip:(calcfinpoint_spiv-calcstartpoint_spiv)*Sts_spiv;

    elseif calc_type == 3

      dir_pres = sprintf('H:/Analysis/pressure/%d/calc/',date);
      dir_out = sprintf('H:/Analysis/pressure/%d/calc/',date);
      if pres_pos == 0
        if name_mode == 1
          fnp = sprintf('PDown_hps%d_lps%d_%d_%d.dat',hpsfreq,lpsfreq,date,num);
          fnp2 = sprintf('PUpper_hps%d_lps%d_%d_%d.dat',hpsfreq,lpsfreq,date,num);
          fnlag = sprintf('presd_presu_lag_%d_%.2f_%d_%02u.dat',flow_rate,eq_ratio,date,num);
          fnaxi = sprintf('pres_pres_lagtaxis.dat');
          fngif = sprintf('pprimed_pprimeu_%d_%.2f_%d_%02u.gif',flow_rate,eq_ratio,date,num);
        elseif name_mode == 2
          fnp = sprintf('PDown_hps%d_lps%d_%d_%.2f_cER.dat',hpsfreq,lpsfreq,flow_rate,eq_ratio);
          fnp2 = sprintf('PUpper_hps%d_lps%d_%d_%.2f_cER.dat',hpsfreq,lpsfreq,flow_rate,eq_ratio);
          fnlag = sprintf('presd_presu_cER_lag_%d_%.2f_%d_%02u.dat',flow_rate,eq_ratio,date,num);
          fnaxi = sprintf('pres_pres_lagtaxis.dat');
          fngif = sprintf('pprimed_pprimeu_cER_%d_%.2f_%d_%02u.gif',flow_rate,eq_ratio,date,num);
        elseif name_mode == 3
          fnp = sprintf('PDown_speaker_hps%d_lps%d_%dHz_%dV_%ds_%02u.dat',hpsfreq,lpsfreq,specific_f,speaker_v,speaker_t,num);
          fnp2 = sprintf('PUpper_speaker_hps%d_lps%d_%dHz_%dV_%ds_%02u.dat',hpsfreq,lpsfreq,specific_f,speaker_v,speaker_t,num);
          fnlag = sprintf('presd_presu_speaker_lag_%dHz_%dV_%ds_%02u.dat',specific_f,speaker_v,speaker_t,num);
          fnaxi = sprintf('pres_pres_speaker_%dHz_lagtaxis.dat',specific_f);
          fngif = sprintf('pprimed_pprimeu_speaker_%dHz_%dV_%ds_%02u.gif',specific_f,speaker_v,speaker_t,num);
        elseif name_mode == 4
          fnp = sprintf('ppd_spk_%d-%dHz_%dV_%gs_d%d_%02u.dat',speaker_lf,speaker_hf,speaker_v,speaker_t,lduct,num);
          fnp2 = sprintf('ppu_spk_%d-%dHz_%dV_%gs_d%d_%02u.dat',speaker_lf,speaker_hf,speaker_v,speaker_t,lduct,num);
%           fnp2 = sprintf('spv_spk_%d-%dHz_%dV_%gs_d%d_%02u.dat',speaker_lf,speaker_hf,speaker_v,speaker_t,lduct,num);
          fnlag = sprintf('ppd_ppu_spk_lag_%d-%dHz_%dV_%gs_d%d_%02u.dat',speaker_lf,speaker_hf,speaker_v,speaker_t,lduct,num);
%           fnlag = sprintf('ppd_spv_spk_lag_%d-%dHz_%dV_%gs_d%d_%02u.dat',speaker_lf,speaker_hf,speaker_v,speaker_t,lduct,num);
          fnaxi = sprintf('pres_pres_speaker_chirp_lagtaxis.dat');
          fngif = sprintf('pprimed_pprimeu_speaker_chirp_%d-%dHz_%dV_%gs_d%d_%02u.gif',speaker_lf,speaker_hf,speaker_v,speaker_t,lduct,num);
%           fngif = sprintf('pprimed_spv_speaker_chirp_%d-%dHz_%dV_%gs_d%d_%02u.gif',speaker_lf,speaker_hf,speaker_v,speaker_t,lduct,num);
        end
      elseif pres_pos == 1
        if name_mode == 1
          fnp2 = sprintf('PDown_hps%d_lps%d_%d_%d.dat',hpsfreq,lpsfreq,date,num);
          fnp = sprintf('PUpper_hps%d_lps%d_%d_%d.dat',hpsfreq,lpsfreq,date,num);
          fnlag = sprintf('presu_presd_lag_%d_%.2f_%d_%02u.dat',flow_rate,eq_ratio,date,num);
          fnaxi = sprintf('pres_pres_lagtaxis.dat');
          fngif = sprintf('pprimeu_pprimed_%d_%.2f_%d_%02u.gif',flow_rate,eq_ratio,date,num);
        elseif name_mode == 2
          fnp2 = sprintf('PDown_hps%d_lps%d_%d_%.2f_cER.dat',hpsfreq,lpsfreq,flow_rate,eq_ratio);
          fnp = sprintf('PUpper_hps%d_lps%d_%d_%.2f_cER.dat',hpsfreq,lpsfreq,flow_rate,eq_ratio);
          fnlag = sprintf('presu_presd_cER_lag_%d_%.2f_%d_%02u.dat',flow_rate,eq_ratio,date,num);
          fnaxi = sprintf('pres_pres_lagtaxis.dat');
          fngif = sprintf('pprimeu_pprimed_cER_%d_%.2f_%d_%02u.gif',flow_rate,eq_ratio,date,num);
        elseif name_mode == 3
          fnp2 = sprintf('PDown_speaker_hps%d_lps%d_%dHz_%dV_%ds_%d.dat',hpsfreq,lpsfreq,specific_f,speaker_v,speaker_t,num);
          fnp = sprintf('PUpper_speaker_hps%d_lps%d_%dHz_%dV_%ds_%d.dat',hpsfreq,lpsfreq,specific_f,speaker_v,speaker_t,num);
          fnlag = sprintf('presu_presd_speaker_lag_%dHz_%dV_%ds_%02u.dat',specific_f,speaker_v,speaker_t,num);
          fnaxi = sprintf('pres_pres_speaker_%dHz_lagtaxis.dat',specific_f);
          fngif = sprintf('pprimeu_pprimed_speaker_%dHz_%dV_%ds_%02u.gif',specific_f,speaker_v,speaker_t,num);
        elseif name_mode == 4
          fnp2 = sprintf('ppd_spk_%d-%dHz_%dV_%gs_d%d_%02u.dat',speaker_lf,speaker_hf,speaker_v,speaker_t,lduct,num);
%           fnp2 = sprintf('spv_spk_%d-%dHz_%dV_%gs_d%d_%02u.dat',speaker_lf,speaker_hf,speaker_v,speaker_t,lduct,num);
          fnp = sprintf('ppu_spk_%d-%dHz_%dV_%gs_d%d_%02u.dat',speaker_lf,speaker_hf,speaker_v,speaker_t,lduct,num);
          fnlag = sprintf('ppu_ppd_spk_lag_%d-%dHz_%dV_%gs_d%d_%02u.dat',speaker_lf,speaker_hf,speaker_v,speaker_t,lduct,num);
%           fnlag = sprintf('ppu_spv_spk_lag_%d-%dHz_%dV_%gs_d%d_%02u.dat',speaker_lf,speaker_hf,speaker_v,speaker_t,lduct,num);
          fnaxi = sprintf('pres_pres_speaker_chirp_lagtaxis.dat');
          fngif = sprintf('pprimeu_pprimed_speaker_chirp_%d-%dHz_%dV_%gs_d%d_%02u.gif',speaker_lf,speaker_hf,speaker_v,speaker_t,lduct,num);
%           fngif = sprintf('pprimeu_spv_speaker_chirp_%d-%dHz_%dV_%gs_d%d_%02u.gif',speaker_lf,speaker_hf,speaker_v,speaker_t,lduct,num);
        end
      end

      fnp = append(dir_pres,fnp);
      fnp2 = append(dir_pres,fnp2);
      fnlag = append(dir_out,fnlag);
      fnaxi = append(dir_out,fnaxi);
      fngif = append(dir_out,fngif);

      axis_temp = Sts_press:Sts_press:Sts_press*sectionsize_press;
      Sts_pchip = (calcfinpoint_press-calcstartpoint_press)*Sts_press/datasize_pchip;
      taxislag = 0:Sts_press:(calcfinpoint_press-calcstartpoint_press)*Sts_press;
      taxis_pchip = 0:Sts_pchip:(calcfinpoint_press-calcstartpoint_press)*Sts_press;

    end

%% Read and Calc.

    fid1 = fopen(fnp,'r');
    P1 = fread(fid1,pres_datasize,'double');
    fclose(fid1);

    if calc_type == 1

      fid2 = fopen(fnc,'r');
      I = fread(fid2,nzall_chem,'double');
      fclose(fid2);

      if read_sw == 1

        figure;
        plot(taxis,P1)
        figure;
        plot(chem_taxis,I)

      end

      for k = 1:1:calcfinpoint_chem-calcstartpoint_chem+1
        for j = 1:1:sectionsize_chem

          s1_temp(j) = I(calcstartpoint_chem-(sectionsize_chem/2)+k-1+j-1);
          s2_temp(j) = P1(calcstartpoint_press-(sectionsize_press/2)+2*(k-1+j-1));

        end

        if gif_sw == 1

          fig = figure;
          pos1 = [0.12 0.20 0.80 0.20]; % left bottom width height
          subplot('Position',pos1)
          plot(axis_temp,s1_temp)
          ylim([-300 300]);
          xtickformat('%.2f')
          ytickformat('%d')
          ylabel('\it \fontname{Times New Roman} I''')
          hold on
          pos2 = [0.12 0.47 0.80 0.20];
          subplot('Position',pos2)
          plot(axis_temp,s2_temp,'k')
          ylim([-0.5 0.5]);
          xticks([])
          ytickformat('%.1f')
          ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
          hold off
          frame = getframe(fig);
          im{k} = frame2im(frame);
          % pause;
          close;

        end

        [C,lag] = xcorr(s1_temp,s2_temp);
        [M,Int] = max(C);
        t(k) = lag(Int);

        clear s1_temp
        clear s2_temp

      end

      if gif_sw == 1
        for k = 1:1:calcfinpoint_chem-calcstartpoint_chem+1
          [A,map] = rgb2ind(im{k},256);
          if k == 1
            imwrite(A,map,fngif,'gif','LoopCount',Inf,'DelayTime',0.01);
          else
            imwrite(A,map,fngif,'gif','WriteMode','append','DelayTime',0.01);
          end
        end
      end

    elseif calc_type == 2

      fid2 = fopen(fnvl,'r');
      VL = fread(fid2,nzall_spiv,'double');
      fclose(fid2);

      fid2 = fopen(fnvr,'r');
      VR = fread(fid2,nzall_spiv,'double');
      fclose(fid2);

      if read_sw == 1

        figure;
        plot(taxis,P1)
        figure;
        plot(spiv_taxis,VL)
        hold on
        plot(spiv_taxis,VR)
        legend
        hold off

      end

      for k = 1:1:calcfinpoint_spiv-calcstartpoint_spiv+1
        for j = 1:1:sectionsize_spiv
          %% aniti-phase --> +pi
          s1_temp(j) = -(VL(calcstartpoint_spiv-(sectionsize_spiv/2)+k-1+j-1)+VR(calcstartpoint_spiv-(sectionsize_spiv/2)+k-1+j-1))/2;
          % s1_temp(j) = (VL(calcstartpoint_spiv-(sectionsize_spiv/2)+k-1+j-1)+VR(calcstartpoint_spiv-(sectionsize_spiv/2)+k-1+j-1))/2;
          % s1_temp(j) = VL(calcstartpoint_spiv-(sectionsize_spiv/2)+k-1+j-1);
          % s1_temp(j) = VR(calcstartpoint_spiv-(sectionsize_spiv/2)+k-1+j-1);
          s2_temp(j) = P1(calcstartpoint_press-(sectionsize_press/2)+k-1+j-1);
        end

        if gif_sw == 1

          if k == calcfinpoint_spiv-calcstartpoint_spiv-50  % a specific time you want. if there aren't any, Comment-out.

            fig = figure;
            pos1 = [0.12 0.20 0.80 0.20]; % left bottom width height
            subplot('Position',pos1)
            plot(axis_temp,s1_temp)
            ylim([-10 10]);
            xtickformat('%d')
            ytickformat('%d')
            ylabel('\it \fontname{Times New Roman} v''')
            hold on
            pos2 = [0.12 0.47 0.80 0.20];
            subplot('Position',pos2)
            plot(axis_temp,s2_temp,'k')
            ylim([-0.5 0.5]);
            xticks([])
            ytickformat('%.1f')
            ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
            hold off
            frame = getframe(fig);
            im{k} = frame2im(frame);
            % pause;
            close;

          end  % a specific time you want. if there aren't any, Comment-out.

        end

        [C,lag] = xcorr(s1_temp,s2_temp);
        [M,Int] = max(C);
        t(k) = lag(Int);

        clear s1_temp
        clear s2_temp

      end

      if gif_sw == 1
        for k = 1:1:calcfinpoint_spiv-calcstartpoint_spiv+1
          [A,map] = rgb2ind(im{k},256);
          if k == 1
            imwrite(A,map,fngif,'gif','LoopCount',Inf,'DelayTime',0.01);
          else
            imwrite(A,map,fngif,'gif','WriteMode','append','DelayTime',0.01);
          end
        end
      end

    elseif calc_type == 3

      fid2 = fopen(fnp2,'r');
      P2 = fread(fid2,pres_datasize,'double');
      fclose(fid2);

      if read_sw == 1

        figure;
        plot(taxis,P1)
        figure;
        plot(taxis,P2)

      end

      for k = 1:1:calcfinpoint_press-calcstartpoint_press+1
        for j = 1:1:sectionsize_press

          s1_temp(j) = P2(calcstartpoint_press-(sectionsize_press/2)+k-1+j-1);
          s2_temp(j) = P1(calcstartpoint_press-(sectionsize_press/2)+k-1+j-1);

        end

        if gif_sw == 1

          fig = figure;
          pos1 = [0.12 0.20 0.80 0.20]; % left bottom width height
          subplot('Position',pos1)
          plot(axis_temp,s1_temp)
          ylim([-0.5 0.5]);
%           ylim([-1 1]);
          xtickformat('%.2f')
          ytickformat('%.1f')
          ylabel('\it \fontname{Times New Roman} p''')
          hold on
          pos2 = [0.12 0.47 0.80 0.20];
          subplot('Position',pos2)
          plot(axis_temp,s2_temp,'k')
          ylim([-0.5 0.5]);
          xticks([])
          ytickformat('%.1f')
          ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
          hold off
          frame = getframe(fig);
          im{k} = frame2im(frame);
          pause;
          close;

        end

        [C,lag] = xcorr(s1_temp,s2_temp);
        [M,Int] = max(C);
        t(k) = lag(Int);

        clear s1_temp
        clear s2_temp

      end

      if gif_sw == 1
        for k = 1:1:calcfinpoint_press-calcstartpoint_press+1
          [A,map] = rgb2ind(im{k},256);
          if k == 1
            imwrite(A,map,fngif,'gif','LoopCount',Inf,'DelayTime',0.01);
          else
            imwrite(A,map,fngif,'gif','WriteMode','append','DelayTime',0.01);
          end
        end
      end

    end

    plag = pchip(taxislag,t,taxis_pchip);

    fileID = fopen(fnlag,'w');
    fwrite(fileID,plag,'double');
    fclose(fileID);

    fileID = fopen(fnaxi,'w');
    fwrite(fileID,taxis_pchip,'double');
    fclose(fileID);

%% Figure

    fig = figure;
    fig.Color='white';
    fig.Position=[50 50 960 735];

    plot(taxis_pchip, plag,'ok','MarkerSize',5,'LineWidth',1)
    hold on;

    plot(taxislag, t,'-r','MarkerSize',5,'LineWidth',1)

    ax = gca;
    ax.YColor = 'k';
    xticks([0 Sts_pchip*datasize_pchip*1/4 Sts_pchip*datasize_pchip*2/4 Sts_pchip*datasize_pchip*3/4 Sts_pchip*datasize_pchip])
    set(gca,'xTickLabel', char('0.0','T/4','T/2','3T/4','T'),'FontName','Times New Roman','FontSize',25)
    ytickformat('%d')

    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlabel('\it \fontname{Times New Roman} t \rm[s]')
    ylabel('\it \fontname{Times New Roman} displacement \rm[-]')
    set(gca,'FontName','Times New Roman','FontSize',25)
    hold off;
    pbaspect([sqrt(2) 1 1]);
