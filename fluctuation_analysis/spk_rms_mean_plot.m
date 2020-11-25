    clear all
    close all
    clc

%% PARAMETERS

    up_or_dwn = 1; % 1. upperstream 2. downstream
    hpsfreq = 20; % [Hz]
    lpsfreq = 315; % [Hz]
    speaker_lf_start = 40; % [Hz]
    speaker_lf_end = 300; % [Hz]
    speaker_voltage = 1; % [V]
    speaker_duration = 15; % [s]
    
    lduct1 = 0; % [mm]
    lduct2 = 582; % [mm]
    lduct3 = 883; % [mm]
    lduct4 = 1185; % [mm]
    
%%

    dir = sprintf('G:/Analysis/pressure/PS_spk_calc/');
    prms_connected1 = zeros(lpsfreq-hpsfreq+1,1,1);
    prms_connected2 = zeros(lpsfreq-hpsfreq+1,1,1);
    prms_connected3 = zeros(lpsfreq-hpsfreq+1,1,1);
    prms_connected4 = zeros(lpsfreq-hpsfreq+1,1,1);

    for speaker_lf = speaker_lf_start:10:speaker_lf_end
        
        speaker_hf = speaker_lf + 15;
        
        if up_or_dwn == 1
            fnprms1_1 = sprintf('ppu_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct1,hpsfreq,lpsfreq);
            fnprms2_1 = sprintf('ppu_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct2,hpsfreq,lpsfreq);
            fnprms3_1 = sprintf('ppu_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct3,hpsfreq,lpsfreq);
            fnprms4_1 = sprintf('ppu_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct4,hpsfreq,lpsfreq);
            fnprms1_2 = sprintf('ppu_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf+10,speaker_hf+10,speaker_voltage,speaker_duration,lduct1,hpsfreq,lpsfreq);
            fnprms2_2 = sprintf('ppu_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf+10,speaker_hf+10,speaker_voltage,speaker_duration,lduct2,hpsfreq,lpsfreq);
            fnprms3_2 = sprintf('ppu_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf+10,speaker_hf+10,speaker_voltage,speaker_duration,lduct3,hpsfreq,lpsfreq);
            fnprms4_2 = sprintf('ppu_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf+10,speaker_hf+10,speaker_voltage,speaker_duration,lduct4,hpsfreq,lpsfreq);
        elseif up_or_dwn == 2
            fnprms1_1 = sprintf('ppd_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct1,hpsfreq,lpsfreq);
            fnprms2_1 = sprintf('ppd_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct2,hpsfreq,lpsfreq);
            fnprms3_1 = sprintf('ppd_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct3,hpsfreq,lpsfreq);
            fnprms4_1 = sprintf('ppd_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct4,hpsfreq,lpsfreq);
            fnprms1_2 = sprintf('ppd_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf+10,speaker_hf+10,speaker_voltage,speaker_duration,lduct1,hpsfreq,lpsfreq);
            fnprms2_2 = sprintf('ppd_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf+10,speaker_hf+10,speaker_voltage,speaker_duration,lduct2,hpsfreq,lpsfreq);
            fnprms3_2 = sprintf('ppd_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf+10,speaker_hf+10,speaker_voltage,speaker_duration,lduct3,hpsfreq,lpsfreq);
            fnprms4_2 = sprintf('ppd_spk_rms_%d-%dHz_%dV_%ds_d%d_hps%d-lps%d_av.dat',speaker_lf+10,speaker_hf+10,speaker_voltage,speaker_duration,lduct4,hpsfreq,lpsfreq);
        end
        
        if speaker_lf == speaker_lf_start
            
            fid = fopen(append(dir,fnprms1_1),'r');
            prms1_1 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms2_1),'r');
            prms2_1 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms3_1),'r');
            prms3_1 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms4_1),'r');
            prms4_1 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            
            fid = fopen(append(dir,fnprms1_2),'r');
            prms1_2 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms2_2),'r');
            prms2_2 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms3_2),'r');
            prms3_2 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms4_2),'r');
            prms4_2 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            
            for i = 2:1:11
                prms_connected1(i) = prms1_1(i);
                prms_connected2(i) = prms2_1(i);
                prms_connected3(i) = prms3_1(i);
                prms_connected4(i) = prms4_1(i);
            end
            for i = 12:1:15
                prms_connected1(i) = (prms1_1(i)+prms1_2(i-10))/2;
                prms_connected2(i) = (prms2_1(i)+prms2_2(i-10))/2;
                prms_connected3(i) = (prms3_1(i)+prms3_2(i-10))/2;
                prms_connected4(i) = (prms4_1(i)+prms4_2(i-10))/2;
            end

        elseif speaker_lf ==  speaker_lf_end
            
            fid = fopen(append(dir,fnprms1_1),'r');
            prms1_1 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms2_1),'r');
            prms2_1 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms3_1),'r');
            prms3_1 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms4_1),'r');
            prms4_1 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            
            for i = 1:1:10
                prms_connected1(speaker_lf_end+4+i) = prms1_1(i+5);
                prms_connected2(speaker_lf_end+4+i) = prms2_1(i+5);
                prms_connected3(speaker_lf_end+4+i) = prms3_1(i+5);
                prms_connected4(speaker_lf_end+4+i) = prms4_1(i+5);
            end
            
        else
            
            fid = fopen(append(dir,fnprms1_1),'r');
            prms1_1 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms2_1),'r');
            prms2_1 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms3_1),'r');
            prms3_1 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms4_1),'r');
            prms4_1 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            
            fid = fopen(append(dir,fnprms1_2),'r');
            prms1_2 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms2_2),'r');
            prms2_2 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms3_2),'r');
            prms3_2 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            fid = fopen(append(dir,fnprms4_2),'r');
            prms4_2 = fread(fid,lpsfreq-hpsfreq+1,'double');
            fclose(fid);
            
            for i = 1:1:6
                prms_connected1(speaker_lf-speaker_lf_start+5+i) = prms1_1(5+i);
                prms_connected2(speaker_lf-speaker_lf_start+5+i) = prms2_1(5+i);
                prms_connected3(speaker_lf-speaker_lf_start+5+i) = prms3_1(5+i);
                prms_connected4(speaker_lf-speaker_lf_start+5+i) = prms4_1(5+i);
            end
            
            for i = 1:1:4
                prms_connected1(speaker_lf-speaker_lf_start+11+i) = (prms1_1(11+i)+prms1_2(1+i))/2;
                prms_connected2(speaker_lf-speaker_lf_start+11+i) = (prms2_1(11+i)+prms2_2(1+i))/2;
                prms_connected3(speaker_lf-speaker_lf_start+11+i) = (prms3_1(11+i)+prms3_2(1+i))/2;
                prms_connected4(speaker_lf-speaker_lf_start+11+i) = (prms4_1(11+i)+prms4_2(1+i))/2;
            end
                
        end
    end
    
%% FIGURE

    f = hpsfreq:1:lpsfreq;
    f = f';
    
    figure('Position', [50 50 960 735],'Color','white');
    loglog(f,prms_connected1,'-vr','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(prms_connected1))

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
%      ax.YLim = [1 10000];
     ax.FontSize = 20;
     ax.FontName = 'Times New Roman';
     ax.TitleFontSizeMultiplier = 2;

    xtickformat('%.f')
    ytickformat('%.2f')

     xlabel('\it \fontname{Times New Roman} f \rm[Hz]')
     ylabel('\it \fontname{Times New Roman} p''_{rms} \rm[kPa]')
     hold on
     
     loglog(f,prms_connected2,'-sb','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(prms_connected2))
     hold on
     
     loglog(f,prms_connected3,'-dk','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(prms_connected3))
     hold on
     
     loglog(f,prms_connected4,'-xm','MarkerSize',8,'MarkerFaceColor','w','MarkerIndices',1:1:length(prms_connected4))
     legend('0mm','582mm','883mm','1185mm','FontSize',20,'Location','northwest')
     hold off
     pbaspect([sqrt(2) 1 1]);
