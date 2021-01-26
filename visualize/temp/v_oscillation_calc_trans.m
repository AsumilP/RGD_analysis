    clc
    clear all
    close all

%% Parameters 1

    date=20190816;
    hpsfreq = 20; % [Hz]
    lpsfreq = 300;   %  [Hz]
    
    for num = 1:1:4

        file_v=sprintf('E:/piv_output/velofield/%d/spiv_fbsc_%02u_vcl.dat',date,num);
        file_v_osc_l=sprintf('C:/Users/atagi/Desktop/modified/v_oscillation/v_oscillation_l_%d_%02u.dat',date,num);
        file_v_osc_r=sprintf('C:/Users/atagi/Desktop/modified/v_oscillation/v_oscillation_r_%d_%02u.dat',date,num);

%% Parameters 2

     nx = 191;
     ny = 121;
     nzall = 21838;
     Fs = 20e3;    % Sampling Rate

%% Matrix

     Pixels=nx*ny;
     velo=zeros(nx,ny);
     N=[nx ny];
     taxis=1/Fs:1/Fs:nzall/Fs;

%% Reading

     fid1 = fopen(sprintf(file_v),'r');

     for i=1:nzall
          I=(fread(fid1,Pixels,'double'));
          velo=reshape(I,N);
          velo=permute(reshape(velo,N),[2 1]);
%           vleft(i,:)=velo(101,70:82);
%           vright(i,:)=velo(101,108:120);
%           vleft(i,:)=velo(101,75:87); % cold
%           vright(i,:)=velo(101,101:113); % cold
     end

     vleftmean=mean(vleft,2);
     vrightmean=mean(vright,2);
     
%% BAND-PASS FILTER, CALCULATION & SAVE
     
     vleftmean_fft = fft(vleftmean);
     vrightmean_fft = fft(vrightmean);
     nleftmean = length(vleftmean_fft);
     nrightmean = length(vrightmean_fft);

     f = (0:nleftmean-1)*(Fs/nleftmean);
     f = f';

     for i = 1:nleftmean
         if (Fs/2-abs(f(i)-Fs/2) <= lpsfreq) && (Fs/2-abs(f(i)-Fs/2) >= hpsfreq)
            vleftmean_fft_bpsfil(i) = vleftmean_fft(i);
         elseif (Fs/2-abs(f(i)-Fs/2) > lpsfreq) || (Fs/2-abs(f(i)-Fs/2) < hpsfreq)
            vleftmean_fft_bpsfil(i) = 0;
         end
     end

     vleftmean_bpsfil = ifft(vleftmean_fft_bpsfil);

     fileID=fopen(file_v_osc_l,'w');
     fwrite(fileID,vleftmean_bpsfil,'double');
     fclose(fileID);

     for i = 1:nrightmean
         if (Fs/2-abs(f(i)-Fs/2) <= lpsfreq) && (Fs/2-abs(f(i)-Fs/2) >= hpsfreq)
             vrightmean_fft_bpsfil(i) = vrightmean_fft(i);
         elseif (Fs/2-abs(f(i)-Fs/2) > lpsfreq) || (Fs/2-abs(f(i)-Fs/2) < hpsfreq)
             vrightmean_fft_bpsfil(i) = 0;
         end
     end

     vrightmean_bpsfil = ifft(vrightmean_fft_bpsfil);

     fileID=fopen(file_v_osc_r,'w');
     fwrite(fileID,vrightmean_bpsfil,'double');
     fclose(fileID);
     
%%  BAND-PASS FILTER, MAKING FIGURE

  % POWER SPECTRUM, vleftmean_fft
     figure('Position', [50 50 960 735],'Color','white');
     loglog(f,abs(vleftmean_fft),'k')

     ax = gca;
     xtickformat('%.2f')
     xticks([1 10 100 1000 10000])
     set(gca,'xTickLabel', char('10^{0}','10^{1}','10^{2}','10^{3}','10^{4}'))
     ytickformat('%.3f')
%      yticks([0.01 1 100 10000])
%      set(gca,'YTickLabel', char('10^{-2}','10^{0}','10^{2}','10^{4}'))

     xlim([0 Fs/2]);
%      ylim([0.01 10000]);

     ax.Box = 'on';
     ax.LineWidth = 2.0;
     ax.XMinorTick = 'on';
     ax.YMinorTick = 'on';

     xlabel('\it \fontname{Times New Roman} f \rm[Hz]')
     ylabel('\it \fontname{Times New Roman} P \rm[m/s]')
     set(gca,'FontName','Times New Roman','FontSize',30)
     hold on

     loglog(f,abs(vleftmean_fft_bpsfil),'r')
     hold off

     
  % POWER SPECTRUM, vrightmean_fft_bpsfil
     figure('Position', [50 50 960 735],'Color','white');
     loglog(f,abs(vrightmean_fft),'k')

     ax = gca;
     xtickformat('%.2f')
     xticks([1 10 100 1000 10000])
     set(gca,'xTickLabel', char('10^{0}','10^{1}','10^{2}','10^{3}','10^{4}'))
     ytickformat('%.3f')
%      yticks([0.01 1 100 10000])
%      set(gca,'YTickLabel', char('10^{-2}','10^{0}','10^{2}','10^{4}'))

     xlim([0 Fs/2]);
%      ylim([0.01 10000]);

     ax.Box = 'on';
     ax.LineWidth = 2.0;
     ax.XMinorTick = 'on';
     ax.YMinorTick = 'on';

     xlabel('\it \fontname{Times New Roman} f \rm[Hz]')
     ylabel('\it \fontname{Times New Roman} P \rm[m/s]')
     set(gca,'FontName','Times New Roman','FontSize',30)
     hold on

     loglog(f,abs(vrightmean_fft_bpsfil),'r')
     hold off

     
  % BAND-PASS, vleftmean
     figure('Position', [50 50 960 735],'Color','white');
     plot(taxis,vleftmean,'k')

     ax = gca;
     xtickformat('%.2f')
%      xticks([0 2 4 6 8 10])
%      set(gca,'xTickLabel', char('0','2','4','6','8','10'))
     ytickformat('%.3f')
%      yticks([-0.40 -0.20 0 0.20 0.40])
%      set(gca,'YTickLabel', char('-0.40','-0.20','0.00','0.20','0.40'))

     xlim([1/Fs nzall/Fs]);
%      ylim([-0.40 0.40]);
     
     ax.Box = 'on';
     ax.LineWidth = 2.0;
     ax.XMinorTick = 'on';
     ax.YMinorTick = 'on';

     xlabel('\it \fontname{Times New Roman} t')
     ylabel('\it \fontname{Times New Roman} v'' \rm[m/s]')
     set(gca,'FontName','Times New Roman','FontSize',30)
     hold on

     plot(taxis,vleftmean_bpsfil,'r')
     hold off


  % BAND-PASS, P_UPPER
     figure('Position', [50 50 960 735],'Color','white');
     plot(taxis,vrightmean,'k')

     ax = gca;
     xtickformat('%.2f')
%      xticks([0 2 4 6 8 10])
%      set(gca,'xTickLabel', char('0','2','4','6','8','10'))
     ytickformat('%.3f')
%      yticks([-0.40 -0.20 0 0.20 0.40])
%      set(gca,'YTickLabel', char('-0.40','-0.20','0.00','0.20','0.40'))

     xlim([1/Fs nzall/Fs]);
%      ylim([-0.40 0.40]);
     
     ax.Box = 'on';
     ax.LineWidth = 2.0;
     ax.XMinorTick = 'on';
     ax.YMinorTick = 'on';

     xlabel('\it \fontname{Times New Roman} t')
     ylabel('\it \fontname{Times New Roman} v'' \rm[m/s]')
     set(gca,'FontName','Times New Roman','FontSize',30)
     hold on

     plot(taxis,vrightmean_bpsfil,'r')
     hold off
     
     pause;
     
    end
