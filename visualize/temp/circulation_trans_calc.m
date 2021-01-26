    clc
    clear all
    close all

%% Parameters 1

    trans_start_time=2.9297;
    trans_fin_time=3.2257;
    trig_time=3.495;
    date=20190823;
    num=10;

    file_circ_zn1=sprintf('E:/piv_output/omega_circulation/%d/spiv_%02u_circ_zone1.dat',date,num);
    file_circ_zn2=sprintf('E:/piv_output/omega_circulation/%d/spiv_%02u_circ_zone2.dat',date,num);
    file_circ_zn3=sprintf('E:/piv_output/omega_circulation/%d/spiv_%02u_circ_zone3.dat',date,num);
    file_circ_zn4=sprintf('E:/piv_output/omega_circulation/%d/spiv_%02u_circ_zone4.dat',date,num);
    
    savedirectory='C:/Users/atagi/Desktop/modified/circulation_calc/';

%% Parameters 2

     nzall = 21838;
     Fs_spiv= 20e3;
     Fs_press= 20e3;
     pres_samp_time = 10;  % [sec]
     div=10;
     mean_value=zeros(4,10);
     rms_value=zeros(4,10);
     std_value=zeros(4,10);
     hpsfreq = 20; % [Hz]
     lpsfreq = 300;   %  [Hz]

%% Matrix

     Sts_press = 1/Fs_press;    % [sec]
     Sts_spiv = 1/Fs_spiv;    % [sec]
     cam_start_time = trig_time - Sts_spiv*21839
     taxis=Sts_press:Sts_press:pres_samp_time;
     spiv_taxis = cam_start_time:Sts_spiv:cam_start_time+Sts_spiv*(nzall-1);
     before_transition_data = floor(nzall -(trig_time - trans_start_time)/Sts_spiv)
     while_transition_data = floor((trans_fin_time - trans_start_time)/Sts_spiv)
     calc_data = floor((trans_fin_time - trans_start_time)/(div*Sts_spiv))

%% Reading

     fid1=fopen(file_circ_zn1,'r');
     circ_zn1=(fread(fid1,nzall,'double'));
     fclose(fid1);   
     
     fid2=fopen(file_circ_zn2,'r');
     circ_zn2=(fread(fid2,nzall,'double'));
     fclose(fid2);  
     
     fid3=fopen(file_circ_zn3,'r');
     circ_zn3=(fread(fid3,nzall,'double'));
     fclose(fid3);  
     
     fid4 = fopen(file_circ_zn4,'r');
     circ_zn4=(fread(fid4,nzall,'double'));
     fclose(fid4);
     
 %% BAND-PASS
 
     circ_zn1_fft = fft(circ_zn1);
     circ_zn2_fft = fft(circ_zn2);
     circ_zn3_fft = fft(circ_zn3);
     circ_zn4_fft = fft(circ_zn4);

     f = (0:nzall-1)*(Fs_spiv/nzall);
     f = f';

        for i = 1:nzall
             if (Fs_spiv/2-abs(f(i)-Fs_spiv/2) <= lpsfreq) && (Fs_spiv/2-abs(f(i)-Fs_spiv/2) >= hpsfreq)
                 circ_zn1_fft_bpsfil(i) = circ_zn1_fft(i);
                 circ_zn2_fft_bpsfil(i) = circ_zn2_fft(i);
                 circ_zn3_fft_bpsfil(i) = circ_zn3_fft(i);
                 circ_zn4_fft_bpsfil(i) = circ_zn4_fft(i);
            elseif (Fs_spiv/2-abs(f(i)-Fs_spiv/2) > lpsfreq) || (Fs_spiv/2-abs(f(i)-Fs_spiv/2) < hpsfreq)
                 circ_zn1_fft_bpsfil(i) = 0;
                 circ_zn2_fft_bpsfil(i) = 0;
                 circ_zn3_fft_bpsfil(i) = 0;
                 circ_zn4_fft_bpsfil(i) = 0;
             end
        end

     circ_zn1_bpsfil = ifft(circ_zn1_fft_bpsfil);
     circ_zn2_bpsfil = ifft(circ_zn2_fft_bpsfil);
     circ_zn3_bpsfil = ifft(circ_zn3_fft_bpsfil);
     circ_zn4_bpsfil = ifft(circ_zn4_fft_bpsfil);

     fileID=fopen(strcat(savedirectory,strcat("circ_zn1_bpsfil_",num2str(date),"_",num2str(num),'.dat')),'w');
     fwrite(fileID,circ_zn1_bpsfil,'double');
     fclose(fileID);
     
     fileID=fopen(strcat(savedirectory,strcat("circ_zn2_bpsfil_",num2str(date),"_",num2str(num),'.dat')),'w');
     fwrite(fileID,circ_zn2_bpsfil,'double');
     fclose(fileID);
     
     fileID=fopen(strcat(savedirectory,strcat("circ_zn3_bpsfil_",num2str(date),"_",num2str(num),'.dat')),'w');
     fwrite(fileID,circ_zn3_bpsfil,'double');
     fclose(fileID);
     
     fileID=fopen(strcat(savedirectory,strcat("circ_zn4_bpsfil_",num2str(date),"_",num2str(num),'.dat')),'w');
     fwrite(fileID,circ_zn4_bpsfil,'double');
     fclose(fileID);

     
%%  MAKING FIGURE

  % circ_zn1
     figure('Position', [50 50 960 735],'Color','white');
     plot(spiv_taxis,circ_zn1,'k')

     ax = gca;
     xtickformat('%.2f')
     xticks([0 2 4 6 8 10])
     set(gca,'xTickLabel', char('0','2','4','6','8','10'))
     ytickformat('%.3f')
%      yticks([-0.40 -0.20 0 0.20 0.40])
%      set(gca,'YTickLabel', char('-0.40','-0.20','0.00','0.20','0.40'))

     xlim([trans_start_time trans_fin_time]);
%      ylim([-0.40 0.40]);
     
     ax.Box = 'on';
     ax.LineWidth = 2.0;
     ax.XMinorTick = 'on';
     ax.YMinorTick = 'on';

     xlabel('\it \fontname{Times New Roman} t')
     ylabel('\it \fontname{Times New Roman} \Gamma \rm[m^{2}/s]')
     set(gca,'FontName','Times New Roman','FontSize',30)
     hold on
     
     plot(spiv_taxis,circ_zn1_bpsfil,'r')
     hold off
     
     saveas(gcf,strcat(savedirectory,strcat("circ_zn1_",num2str(date),"_",num2str(num),'.png')))
     close;
     
  % circ_zn2
     figure('Position', [50 50 960 735],'Color','white');
     plot(spiv_taxis,circ_zn2,'k')

     ax = gca;
     xtickformat('%.2f')
     xticks([0 2 4 6 8 10])
     set(gca,'xTickLabel', char('0','2','4','6','8','10'))
     ytickformat('%.3f')
%      yticks([-0.40 -0.20 0 0.20 0.40])
%      set(gca,'YTickLabel', char('-0.40','-0.20','0.00','0.20','0.40'))

     xlim([trans_start_time trans_fin_time]);
%      ylim([-0.40 0.40]);
     
     ax.Box = 'on';
     ax.LineWidth = 2.0;
     ax.XMinorTick = 'on';
     ax.YMinorTick = 'on';

     xlabel('\it \fontname{Times New Roman} t')
     ylabel('\it \fontname{Times New Roman} \Gamma \rm[m^{2}/s]')
     set(gca,'FontName','Times New Roman','FontSize',30)
     hold on
     
     plot(spiv_taxis,circ_zn2_bpsfil,'r')
     hold off
     
     saveas(gcf,strcat(savedirectory,strcat("circ_zn2_",num2str(date),"_",num2str(num),'.png')))
     close;
     
   % circ_zn3
     figure('Position', [50 50 960 735],'Color','white');
     plot(spiv_taxis,circ_zn3,'k')

     ax = gca;
     xtickformat('%.2f')
     xticks([0 2 4 6 8 10])
     set(gca,'xTickLabel', char('0','2','4','6','8','10'))
     ytickformat('%.3f')
%      yticks([-0.40 -0.20 0 0.20 0.40])
%      set(gca,'YTickLabel', char('-0.40','-0.20','0.00','0.20','0.40'))

     xlim([trans_start_time trans_fin_time]);
%      ylim([-0.40 0.40]);
     
     ax.Box = 'on';
     ax.LineWidth = 2.0;
     ax.XMinorTick = 'on';
     ax.YMinorTick = 'on';

     xlabel('\it \fontname{Times New Roman} t')
     ylabel('\it \fontname{Times New Roman} \Gamma \rm[m^{2}/s]')
     set(gca,'FontName','Times New Roman','FontSize',30)
     hold on
     
     plot(spiv_taxis,circ_zn3_bpsfil,'r')
     hold off
     
     saveas(gcf,strcat(savedirectory,strcat("circ_zn3_",num2str(date),"_",num2str(num),'.png')))
     close;
     
   % circ_zn4
     figure('Position', [50 50 960 735],'Color','white');
     plot(spiv_taxis,circ_zn4,'k')

     ax = gca;
     xtickformat('%.2f')
     xticks([0 2 4 6 8 10])
     set(gca,'xTickLabel', char('0','2','4','6','8','10'))
     ytickformat('%.3f')
%      yticks([-0.40 -0.20 0 0.20 0.40])
%      set(gca,'YTickLabel', char('-0.40','-0.20','0.00','0.20','0.40'))

     xlim([trans_start_time trans_fin_time]);
%      ylim([-0.40 0.40]);
     
     ax.Box = 'on';
     ax.LineWidth = 2.0;
     ax.XMinorTick = 'on';
     ax.YMinorTick = 'on';

     xlabel('\it \fontname{Times New Roman} t')
     ylabel('\it \fontname{Times New Roman} \Gamma \rm[m^{2}/s]')
     set(gca,'FontName','Times New Roman','FontSize',30)
     hold on
     
     plot(spiv_taxis,circ_zn4_bpsfil,'r')
     hold off
     
     saveas(gcf,strcat(savedirectory,strcat("circ_zn4_",num2str(date),"_",num2str(num),'.png')))
     close;

%% Calc. division mean
     
     for d=1:div
         mean_value(1,d)=mean(circ_zn1(before_transition_data+(d-1)*calc_data+1:before_transition_data+d*calc_data)/calc_data);
         mean_value(2,d)=mean(circ_zn2(before_transition_data+(d-1)*calc_data+1:before_transition_data+d*calc_data)/calc_data);
         mean_value(3,d)=mean(circ_zn3(before_transition_data+(d-1)*calc_data+1:before_transition_data+d*calc_data)/calc_data);
         mean_value(4,d)=mean(circ_zn4(before_transition_data+(d-1)*calc_data+1:before_transition_data+d*calc_data)/calc_data);
         rms_value(1,d)=rms(circ_zn1(before_transition_data+(d-1)*calc_data+1:before_transition_data+d*calc_data)/calc_data);
         rms_value(2,d)=rms(circ_zn2(before_transition_data+(d-1)*calc_data+1:before_transition_data+d*calc_data)/calc_data);
         rms_value(3,d)=rms(circ_zn3(before_transition_data+(d-1)*calc_data+1:before_transition_data+d*calc_data)/calc_data);
         rms_value(4,d)=rms(circ_zn4(before_transition_data+(d-1)*calc_data+1:before_transition_data+d*calc_data)/calc_data);
         std_value(1,d)=std(circ_zn1(before_transition_data+(d-1)*calc_data+1:before_transition_data+d*calc_data)/calc_data);
         std_value(2,d)=std(circ_zn2(before_transition_data+(d-1)*calc_data+1:before_transition_data+d*calc_data)/calc_data);
         std_value(3,d)=std(circ_zn3(before_transition_data+(d-1)*calc_data+1:before_transition_data+d*calc_data)/calc_data);
         std_value(4,d)=std(circ_zn4(before_transition_data+(d-1)*calc_data+1:before_transition_data+d*calc_data)/calc_data);
     end
