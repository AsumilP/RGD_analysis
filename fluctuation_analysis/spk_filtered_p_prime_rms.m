     clear all
     close all
     clc

%% PARAMETERS

     fs_pres = 20e3; % Sampling Rate
     pres_samp_time = 15; % [sec]
     prof_upper = 20/10; % [kPa/V]
     prof_down = 0.5; % [kPa/V]

     fft_dbl_type = 1; % 1. ^v^v 2. ^vv^ 3. ^v
     hpsfreq = 20; % [Hz]
     lpsfreq = 3000; % [Hz],, should be less than speaker_hf
     fchange_hpsfreq = 0; % [Hz]
     fchange_lpsfreq = 2; % [Hz]

     date = 20201118;
     recnum = 10;
     input_sw = 1; % 0: noinput
     speaker_voltage = 1; % [V]
     speaker_duration = 15; % [s]
%      speaker_lf = 50; %%% [Hz]
%      speaker_hf = 65; %%% [Hz]
     lduct = 1185; % [mm]
     figex = '.png'; % fig, png
     fig_vis = 1;
     nnc = 0;
     
     for speaker_lf = 40:10:450 %%%
         
         speaker_hf = speaker_lf + 15; %%%

%%
        for num = 1:recnum

%% READ DATA

            dir = sprintf('G:/Analysis/pressure/%d/calc/',date);
            if input_sw == 1
                rfn = sprintf('pressure_speaker_%d-%dHz_%dV_%gs_d%d_%d.xlsx',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,num);
            elseif input_sw == 0
                rfn = sprintf('pressure_speaker_noinput_%d.xlsx',num);
            end
            upv = xlsread(append(dir,rfn),sprintf('B2:B%d',fs_pres*pres_samp_time+1));
            dpv = xlsread(append(dir,rfn),sprintf('C2:C%d',fs_pres*pres_samp_time+1));
            spv = xlsread(append(dir,rfn),sprintf('D2:D%d',fs_pres*pres_samp_time+1));

%% OUTPUT FILE

            if input_sw == 1

                fnpu = sprintf('ppu_spk_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,hpsfreq,lpsfreq,num);
                fnpu = append(dir,fnpu);
                fnpd = sprintf('ppd_spk_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,hpsfreq,lpsfreq,num);
                fnpd = append(dir,fnpd);
                fnspv = sprintf('spv_spk_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,hpsfreq,lpsfreq,num);
                fnspv = append(dir,fnspv);
                fnspvfc = sprintf('fchange_spk_%d-%dHz_%dV_%gs_d%d_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,num);
                fnspvfc = append(dir,fnspvfc);
                fnppurms_av = sprintf('ppu_spk_rms_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,hpsfreq,lpsfreq);
                fnppurms_av = append(dir,fnppurms_av);
                fnppdrms_av = sprintf('ppd_spk_rms_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_av.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,hpsfreq,lpsfreq);
                fnppdrms_av = append(dir,fnppdrms_av);

                if fig_vis == 1

                    figp = sprintf('p_spk_%d-%dHz_hps%d-lps%d_%dV_%gs_d%d_%02u',speaker_lf,speaker_hf,hpsfreq,lpsfreq,speaker_voltage,speaker_duration,lduct,num);
                    figv = sprintf('v_spk_%d-%dHz_hps%d-lps%d_%dV_%gs_d%d_%02u',speaker_lf,speaker_hf,hpsfreq,lpsfreq,speaker_voltage,speaker_duration,lduct,num);
                    figf = sprintf('f_spk_%d-%dHz_hps%d-lps%d_%dV_%gs_d%d_%02u',speaker_lf,speaker_hf,hpsfreq,lpsfreq,speaker_voltage,speaker_duration,lduct,num);

                end

                figfp = sprintf('p_spk_av_%d-%dHz_hps%d-lps%dHz_%dV_%gs_d%d',speaker_lf,speaker_hf,hpsfreq,lpsfreq,speaker_voltage,speaker_duration,lduct);

            elseif  input_sw == 0

                fnpu = sprintf('ppu_spk_noinput_hps%d-lps%d_%02u.dat',hpsfreq,lpsfreq,num);
                fnpu = append(dir,fnpu);
                fnpd = sprintf('ppd_spk_noinput_hps%d-lps%d_%02u.dat',hpsfreq,lpsfreq,num);
                fnpd = append(dir,fnpd);
                fnspv = sprintf('spv_spk_noinput_hps%d-lps%d_%02u.dat',hpsfreq,lpsfreq,num);
                fnspv = append(dir,fnspv);

                if fig_vis == 1

                    figp = sprintf('p_spk_noinput_hps%d-lps%d_%02u',hpsfreq,lpsfreq,num);
                    figv = sprintf('v_spk_noinput_hps%d-lps%d_%02u',hpsfreq,lpsfreq,num);
                    figf = sprintf('f_spk_noinput_hps%d-lps%d_%02u',hpsfreq,lpsfreq,num);

                end

                figfp = sprintf('p_spk_av_noinput_hps%d-lps%d',hpsfreq,lpsfreq);

            end

%% MATRIX

            ts_pres = 1/fs_pres; %  [sec]
            pres_datasize = fs_pres*pres_samp_time;
            taxis_all = ts_pres:ts_pres:pres_datasize*ts_pres;
            ppu = upv*prof_upper;
            ppd = dpv*prof_down;
            nnc = nnc + 1;

%% BAND-PASS-FILTER

            [ppu] = band_pass_filter(ppu,fs_pres,lpsfreq,hpsfreq,fft_dbl_type);
            [ppd] = band_pass_filter(ppd,fs_pres,lpsfreq,hpsfreq,fft_dbl_type);
%             [spv] = band_pass_filter(spv,fs_pres,speaker_hf,floor(1/speaker_duration),fft_dbl_type); % f should be more than 1/speaker_duration.

            fileID = fopen(fnpu,'w');
            fwrite(fileID,ppu,'double');
            fclose(fileID);

            fileID = fopen(fnpd,'w');
            fwrite(fileID,ppd,'double');
            fclose(fileID);

            fileID = fopen(fnspv,'w');
            fwrite(fileID,spv,'double');
            fclose(fileID);

%% SPEAKER-FREQUENCY-CHANGE

            if input_sw == 1

                [fchange] = trace_frequency(spv,fs_pres,taxis_all,speaker_hf,speaker_lf,fchange_lpsfreq,fchange_hpsfreq,fft_dbl_type);

                fileID = fopen(fnspvfc,'w');
                fwrite(fileID,fchange,'double');
                fclose(fileID);

            end

%% FIGURE, PRESSURE FLUCTUATION

            if fig_vis == 1

                figure('Position',[50 50 960 735],'Color','white');
                plot(taxis_all,ppu,'-r')
                hold on
                plot(taxis_all,ppd,'-b')

                ax = gca;
                ax.Box = 'on';
                ax.LineWidth = 2.0;
                ax.XMinorTick = 'on';
                ax.YMinorTick = 'on';

                xtickformat('%.f')
                ytickformat('%.1f')

                xlim([0 pres_samp_time]);
                ylim([-0.4 0.4]);

                xlabel('\it \fontname{Times New Roman} t \rm[sec]')
                ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
                set(gca,'FontName','Times New Roman','FontSize',20)
                legend({'Upstream','Downstream'},'Location','northeast')
                hold off
                pbaspect([sqrt(2) 1 1]);
                saveas(gcf,strcat(dir,figp,figex));
                close;

            end

%% FIGURE, SPEAKER-INPUT-VOLTAGE

            if fig_vis == 1

                figure('Position',[50 50 960 735],'Color','white');
                plot(taxis_all,spv,'--k')

                ax = gca;
                ax.Box = 'on';
                ax.LineWidth = 2.0;
                ax.XMinorTick = 'on';
                ax.YMinorTick = 'on';

                xtickformat('%.f')
                ytickformat('%.1f')

                xlim([0 pres_samp_time]);
                ylim([-speaker_voltage-0.5 speaker_voltage+0.5]);

                xlabel('\it \fontname{Times New Roman} t \rm[sec]')
                ylabel('\rm \fontname{Times New Roman} Input \rm[V]')
                set(gca,'FontName','Times New Roman','FontSize',20)
                hold off
                pbaspect([sqrt(2) 1 1]);
                saveas(gcf,strcat(dir,figv,figex));
                close;

            end

%% FIGURE, SPEAKER-FREQUENCY-CHANGE

            if input_sw == 1
                if fig_vis == 1

                    figure('Position',[50 50 960 735],'Color','white');
                    plot(taxis_all,fchange,'-k')

                    ax = gca;
                    ax.Box = 'on';
                    ax.LineWidth = 2.0;
                    ax.XMinorTick = 'on';
                    ax.YMinorTick = 'on';

                    xtickformat('%.f')
                    ytickformat('%.f')

                    xlim([0 pres_samp_time]);
                    ylim([speaker_lf speaker_hf+50]);

                    xlabel('\it \fontname{Times New Roman} t \rm[sec]')
                    ylabel('\it \fontname{Times New Roman} f \rm[Hz]')
                    set(gca,'FontName','Times New Roman','FontSize',20)
                    pbaspect([sqrt(2) 1 1]);
                    saveas(gcf,strcat(dir,figf,figex));
                    close;

                end
            end

        end

%% AVERAGED DISTRIBUTION f-p'

        if input_sw == 1
         
            ppurms = zeros(lpsfreq - hpsfreq +1,nnc,1);
            ppdrms = zeros(lpsfreq - hpsfreq +1,nnc,1);
            nn = zeros(lpsfreq - hpsfreq +1,nnc,1);
            f = hpsfreq:1:lpsfreq;
            f = f';

            for num = 1:recnum

                fnpu = sprintf('ppu_spk_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,hpsfreq,lpsfreq,num);
                fnpu = append(dir,fnpu);
                fnpd = sprintf('ppd_spk_%d-%dHz_%dV_%gs_d%d_hps%d-lps%d_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,hpsfreq,lpsfreq,num);
                fnpd = append(dir,fnpd);
                fnspvfc = sprintf('fchange_spk_%d-%dHz_%dV_%gs_d%d_%02u.dat',speaker_lf,speaker_hf,speaker_voltage,speaker_duration,lduct,num);
                fnspvfc = append(dir,fnspvfc);

                fid = fopen(fnpu,'r');
                ppu = fread(fid,pres_datasize,'double');
                fclose(fid);
                fid = fopen(fnpd,'r');
                ppd = fread(fid,pres_datasize,'double');
                fclose(fid);
                fid = fopen(fnspvfc,'r');
                fchange = fread(fid,pres_datasize,'double');
                fclose(fid);

                for k = 1:pres_datasize                
                    for l = 1:1:lpsfreq - hpsfreq + 1
                        if (fchange(k) >= l + hpsfreq - 1.5 ) && (fchange(k) < l + hpsfreq - 0.5 )   
                            nn(l,num,1) = nn(l,num,1) + 1;
                            ppun(l,nn(l, num,1)) = ppu(k);
                            ppdn(l,nn(l, num,1)) = ppd(k);
                        end
                    end
                end

                for l = 1:1:size(ppun,1)
                    ppurms(l, num) = rms(ppun(l,:)-mean(ppun(l,:)));
                    ppdrms(l, num) = rms(ppdn(l,:)-mean(ppdn(l,:)));
                end
         
                ppun = 0;
                ppdn = 0;

            end
       
            ppurms_av = mean(ppurms(:, :),2);
            ppdrms_av = mean(ppdrms(:, :),2);
       
            fileID = fopen(fnppurms_av,'w');
            fwrite(fileID,ppurms_av,'double');
            fclose(fileID);
       
            fileID = fopen(fnppdrms_av,'w');
            fwrite(fileID,ppdrms_av,'double');
            fclose(fileID);

        end
     
        clear ppun
        clear ppdn

%% FIGURE, AVERAGED DISTRIBUTION f-p'rms

        if input_sw == 1

            figure('Position', [50 50 960 735],'Color','white');
            loglog(f,ppurms_av,'-^','MarkerSize',8,'MarkerFaceColor','w','Color','r')
%             semilogx(f,ppurms_av,'-^','MarkerSize',8,'MarkerFaceColor','w','Color','r')
            hold on
            loglog(f,ppdrms_av,'-v','MarkerSize',8,'MarkerFaceColor','w','Color','b')
%             semilogx(f,ppdrms_av,'-v','MarkerSize',8,'MarkerFaceColor','w','Color','b')

            ax = gca;
            ax.Box = 'on';
            ax.LineWidth = 2.0;
            ax.XMinorTick = 'on';
            ax.YMinorTick = 'on';

            xtickformat('%.f')
            ytickformat('%.2f')

            xlim([hpsfreq lpsfreq]);
            ylim([0.001 0.2]);

            xlabel('\it \fontname{Times New Roman} f \rm[Hz]')
            ylabel('\it \fontname{Times New Roman} p''_{rms} \rm[kPa]')
            set(gca,'FontName','Times New Roman','FontSize',20)
            legend({'Upstream','Downstream'},'Location','northeast')
            hold off
            pbaspect([sqrt(2) 1 1]);
            saveas(gcf, strcat(dir, figfp, figex));
            close;

        end
     
    end %%%
