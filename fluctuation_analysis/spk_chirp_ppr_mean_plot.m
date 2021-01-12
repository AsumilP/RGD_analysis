    clear all
    close all
    clc

%% PARAMETERS

    up_or_dwn = 2; % 1. upperstream 2. downstream
    hpsfreq = 20; % [Hz]
    lpsfreq = 315; % [Hz]
    speaker_lf = 0; % [Hz]
    speaker_hf = 350; % [Hz]
    speaker_voltage = 1; % [V]
    speaker_duration = 7.5; % [s]
    
    lduct1 = 0; % [mm]
    lduct2 = 582; % [mm]
    lduct3 = 883; % [mm]
    lduct4 = 1185; % [mm]
    
%%

    dir = sprintf('G:/Analysis/pressure/PS_chirp_calc/');
        
    if up_or_dwn == 1
        fnprms1 = sprintf('ppu_spk_rms_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct1,hpsfreq,lpsfreq);
        fnprms2 = sprintf('ppu_spk_rms_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct2,hpsfreq,lpsfreq);
        fnprms3 = sprintf('ppu_spk_rms_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct3,hpsfreq,lpsfreq);
        fnprms4 = sprintf('ppu_spk_rms_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct4,hpsfreq,lpsfreq);
        
        fid = fopen(append(dir,fnprms1),'r');
        prms1 = fread(fid,lpsfreq-hpsfreq+1,'double');
        fclose(fid);
        fid = fopen(append(dir,fnprms2),'r');
        prms2 = fread(fid,lpsfreq-hpsfreq+1,'double');
        fclose(fid);
        fid = fopen(append(dir,fnprms3),'r');
        prms3 = fread(fid,lpsfreq-hpsfreq+1,'double');
        fclose(fid);
        fid = fopen(append(dir,fnprms4),'r');
        prms4 = fread(fid,lpsfreq-hpsfreq+1,'double');
        fclose(fid);
        
    elseif up_or_dwn == 2
%         fnprms1_1 = sprintf('ppd_spk_rms_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct1,hpsfreq,lpsfreq);
        fnprms2 = sprintf('ppd_spk_rms_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct2,hpsfreq,lpsfreq);
        fnprms3 = sprintf('ppd_spk_rms_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct3,hpsfreq,lpsfreq);
        fnprms4 = sprintf('ppd_spk_rms_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct4,hpsfreq,lpsfreq);
        
%         fid = fopen(append(dir,fnprms1),'r');
%         prms1 = fread(fid,lpsfreq-hpsfreq+1,'double');
%         fclose(fid);
        fid = fopen(append(dir,fnprms2),'r');
        prms2 = fread(fid,lpsfreq-hpsfreq+1,'double');
        fclose(fid);
        fid = fopen(append(dir,fnprms3),'r');
        prms3 = fread(fid,lpsfreq-hpsfreq+1,'double');
        fclose(fid);
        fid = fopen(append(dir,fnprms4),'r');
        prms4 = fread(fid,lpsfreq-hpsfreq+1,'double');
        fclose(fid);
        
        spk_freq= [61 68 70 73 80 85 143 147 149 155 171 188 194 203 232];
        spk_ppr= [0.06373398 0.09396354 0.10461654 0.11693276 0.12185269 0.106892 0.01841225 0.02754303 0.02820332 0.03273419 0.03991479 0.01516465 0.01395479 0.0111846 0.00783599]; % PS_mode at 450mm
        
    end
    
%% FIGURE

    f = hpsfreq:1:lpsfreq;
    f = f';
    
    figure('Position', [50 50 960 735],'Color','white');
    loglog(f,prms2,'-vr','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(prms2))

    ax = gca;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
     ax.XAxisLocation = 'bottom';
     ax.YDir='normal';
     ax.YAxisLocation = 'left';
     ax.XColor = 'black';
     ax.YColor = 'black';
     % ax.XScale = 'log';
     % ax.YScale = 'log';
     ax.XLim = [20 300];
     ax.YLim = [0.0001 1];
     ax.FontSize = 20;
     ax.FontName = 'Times New Roman';
     ax.TitleFontSizeMultiplier = 2;

    xtickformat('%.f')
%     ytickformat('%.2f')

     xlabel('\it \fontname{Times New Roman} f \rm[Hz]')
     ylabel('\it \fontname{Times New Roman} p''_{rms} \rm[kPa]')
     hold on
     
     loglog(f,prms3,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(prms3))
     hold on
     
     loglog(f,prms4,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(prms4))
     hold on
     
     if up_or_dwn == 1
        loglog(f,prms1,'-pg','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(prms1))
        hold on
     end
    
     if up_or_dwn == 1
         legend('582mm','883mm','1185mm','0mm','FontSize',20,'Location','northwest')
     elseif up_or_dwn == 2
         legend('582mm','883mm','1185mm','FontSize',20,'Location','northwest')
         hold on
         plot(spk_freq(1:6),spk_ppr(1:6)/2,'-dk','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(spk_ppr))
         hold on
         plot(spk_freq(7:14),spk_ppr(7:14)/2,'-dk','MarkerSize',8,'MarkerFaceColor','k','MarkerIndices',1:1:length(spk_ppr))
     end
     
     hold off
     pbaspect([sqrt(2) 1 1]);
