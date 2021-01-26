      clear all
      close all
      clc

%% Parameters 1

      trans_start_time = 1.7392;
      trans_fin_time = 1.9779;
      trig_time = 2.3932;
      date=20190821;
      num=3;

      pp_switch=1; % 1 or 2
      Ip_switch=2; % 1 or 2
      vpl_switch=2; % 1 or 2
      vpr_switch=2; % 1 or 2
      cpzn1_switch=2; % 1 or 2
      cpzn2_switch=2; % 1 or 2
      cpzn3_switch=2; % 1 or 2
      cpzn4_switch=2; % 1 or 2

      savedirectory='C:/Users/yatagi/Desktop/modified/';
      filename_ppd=sprintf('H:/pressure/%d/calc/PDown_hps20_lps300_%d_%02u.dat',date,date,num);
      filename_Ip=sprintf('H:/chem_output/chem_intensity/%d/chem_Intensity_bps_%d_%02u.dat',date,date,num);
      filename_vpl=sprintf('H:/piv_output/v_oscillation/v_oscillation_l_%d_%02u.dat',date,num);
      filename_vpr=sprintf('H:/piv_output/v_oscillation/v_oscillation_r_%d_%02u.dat',date,num);
      filename_cpzn1=sprintf('H:/piv_output/omega_circulation/%d/circ_zn1_bpsfil_%d_%d.dat',date,date,num);
      filename_cpzn2=sprintf('H:/piv_output/omega_circulation/%d/circ_zn2_bpsfil_%d_%d.dat',date,date,num);
      filename_cpzn3=sprintf('H:/piv_output/omega_circulation/%d/circ_zn3_bpsfil_%d_%d.dat',date,date,num);
      filename_cpzn4=sprintf('H:/piv_output/omega_circulation/%d/circ_zn4_bpsfil_%d_%d.dat',date,date,num);

%% Parameters 2

      nzall_chem= 21839;
      nzall_spiv= 21838;
      Fs_chem= 10e3;
      Fs_spiv= 20e3;
      Fs_press= 20e3;
      pres_samp_time = 10;  % [sec]

%% Matrix

      Sts_press=1/Fs_press;    % [sec]
      Sts_chem=1/Fs_chem;    % [sec]
      Sts_spiv=1/Fs_spiv;    % [sec]
      pres_datasize =Fs_press*pres_samp_time;
      chem_cam_start_time = trig_time - Sts_chem*nzall_chem;
      cam_start_time = trig_time - Sts_spiv*nzall_spiv;
      transstartpoint_press = floor(trans_start_time/Sts_press);
      transfinpoint_press = floor(trans_fin_time/Sts_press);
      transstartpoint_chem = floor((trans_start_time-chem_cam_start_time)/Sts_chem);
      transfinpoint_chem = floor((trans_fin_time-chem_cam_start_time)/Sts_chem);
      transstartpoint_spiv = floor((trans_start_time-cam_start_time)/Sts_spiv);
      transfinpoint_spiv = floor((trans_fin_time-cam_start_time)/Sts_spiv);
      taxis = Sts_press:Sts_press:pres_samp_time;
      chem_taxis = chem_cam_start_time:Sts_chem:chem_cam_start_time+Sts_chem*(nzall_chem-1);
      spiv_taxis = cam_start_time:Sts_spiv:cam_start_time+Sts_spiv*(nzall_spiv-1);
      taxis_plot = trans_start_time:Sts_chem:trans_start_time+(transfinpoint_chem-transstartpoint_chem)*Sts_chem;

%% Reading

      fid1 = fopen(sprintf(filename_ppd),'r');
      PP = fread(fid1,pres_datasize,'double');
      fclose(fid1);

      fid2 = fopen(sprintf(filename_Ip),'r');
      IP = fread(fid2,nzall_chem,'double');
      fclose(fid2);

      fid3 = fopen(sprintf(filename_vpl),'r');
      VPL = fread(fid3,nzall_spiv,'double');
      fclose(fid3);

      fid4 = fopen(sprintf(filename_vpr),'r');
      VPR = fread(fid4,nzall_spiv,'double');
      fclose(fid4);

      fid5 = fopen(sprintf(filename_cpzn1),'r');
      CPZN1 = fread(fid5,nzall_spiv,'double');
      fclose(fid5);

      fid6 = fopen(sprintf(filename_cpzn2),'r');
      CPZN2 = fread(fid6,nzall_spiv,'double');
      fclose(fid6);

      fid7 = fopen(sprintf(filename_cpzn3),'r');
      CPZN3 = fread(fid7,nzall_spiv,'double');
      fclose(fid7);

      fid8 = fopen(sprintf(filename_cpzn4),'r');
      CPZN4 = fread(fid8,nzall_spiv,'double');
      fclose(fid8);

%% Making Figure

    figure('Position', [50 50 960 735],'Color','white');

    if pp_switch==1
        plot(taxis_plot,PP(transstartpoint_press:2:transfinpoint_press)/max(abs(PP(transstartpoint_press:2:transfinpoint_press))),'-k','MarkerSize',5,'MarkerFaceColor','k','LineWidth',2.5)
        hold on
    end
    if Ip_switch==1
        plot(taxis_plot,IP(transstartpoint_chem:1:transfinpoint_chem)/max(abs(IP(transstartpoint_chem:1:transfinpoint_chem))),'--r','MarkerSize',5,'MarkerFaceColor','r','LineWidth',2.5)
        hold on
    end
    if vpl_switch==1
        plot(taxis_plot,VPL(transstartpoint_spiv:2:transfinpoint_spiv)/max(abs(VPL(transstartpoint_spiv:2:transfinpoint_spiv))),'--r','MarkerSize',5,'MarkerFaceColor','b','LineWidth',2.5)
        hold on
    end
    if vpr_switch==1
        plot(taxis_plot,VPR(transstartpoint_spiv:2:transfinpoint_spiv)/max(abs(VPR(transstartpoint_spiv:2:transfinpoint_spiv))),'--r','MarkerSize',5,'MarkerFaceColor','b','LineWidth',2.5)
        hold on
    end
    if cpzn1_switch==1
        plot(taxis_plot,CPZN1(transstartpoint_spiv:2:transfinpoint_spiv)/max(abs(CPZN1(transstartpoint_spiv:2:transfinpoint_spiv))),'--r','MarkerSize',5,'MarkerFaceColor','g','LineWidth',2.5)
        hold on
    end
    if cpzn2_switch==1
        plot(taxis_plot,CPZN2(transstartpoint_spiv:2:transfinpoint_spiv)/max(abs(CPZN2(transstartpoint_spiv:2:transfinpoint_spiv))),'--r','MarkerSize',5,'MarkerFaceColor','g','LineWidth',2.5)
        hold on
    end
    if cpzn3_switch==1
        plot(taxis_plot,CPZN3(transstartpoint_spiv:2:transfinpoint_spiv)/max(abs(CPZN3(transstartpoint_spiv:2:transfinpoint_spiv))),'--r','MarkerSize',5,'MarkerFaceColor','g','LineWidth',2.5)
        hold on
    end
    if cpzn4_switch==1
        plot(taxis_plot,CPZN4(transstartpoint_spiv:2:transfinpoint_spiv)/max(abs(CPZN4(transstartpoint_spiv:2:transfinpoint_spiv))),'--r','MarkerSize',5,'MarkerFaceColor','g','LineWidth',2.5)
        hold on
    end

    ax = gca;
    ax.YColor = 'k';
    xticks([trans_start_time trans_start_time+(trans_fin_time-trans_start_time)/4 trans_start_time+(trans_fin_time-trans_start_time)/2 trans_start_time+3*(trans_fin_time-trans_start_time)/4 trans_fin_time])
    set(gca,'xTickLabel', char('0.0','T/4','T/2','3T/4','T'),'FontName','Times New Roman','FontSize',40)
    ytickformat('%.1f')
    yticks([-1 -0.5 0 0.5 1])
    set(gca,'YTickLabel', char('-1.0','-0.5','0.0','0.5','1.0'))

    ax.Box = 'on';
    ax.LineWidth = 2.0;
%     ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlim([trans_start_time trans_fin_time]);
    ylim([-1 1]);

    xlabel('\it \fontname{Times New Roman} t \rm[s]')
    ylabel('\it \fontname{Times New Roman} Amplitude \rm')
    set(gca,'FontName','Times New Roman','FontSize',30)
    legend('\it a','\it a','FontSize',30,'Location','northwest')
    hold off

    pbaspect([sqrt(2) 1 1]);
    savefig(strcat(savedirectory,strcat("fluctuation_trans",num2str(date),'_',num2str(num),'_',num2str(pp_switch),num2str(Ip_switch),num2str(vpl_switch),num2str(vpr_switch),num2str(cpzn1_switch),num2str(cpzn2_switch),num2str(cpzn3_switch),num2str(cpzn4_switch),'.fig')))
