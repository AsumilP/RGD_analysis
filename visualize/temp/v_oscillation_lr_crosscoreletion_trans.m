      clear all
      close all

%% Parameters 1

      trans_start_time = 2.9297;
      trans_fin_time = 3.2257;
      trig_time = 3.495;
      flow_rate=400;
      date=20190823;
      num=10;

      vosc_l_name = sprintf('v_oscillation_l_%d_%02u.dat',date,num);  %convert from, under the same directory
      vosc_r_name = sprintf('v_oscillation_r_%d_%02u.dat',date,num);  %convert from, under the same directory
      filename_lag = sprintf('./v_oscillation_cc/v_osclr_%d_%d_%02u_lag.dat',flow_rate,date,num);
      filename_taxislag = sprintf('./v_oscillation_cc/v_osclr_%d_%d_%02u_lagtaxis.dat',flow_rate,date,num);
%       gifname = sprintf('./v_oscillation_cc/v_osclr_%d_%d_%02u.dat',flow_rate,date,num);

%% Parameters 2

      nzall= 21838;
      Fs_spiv= 20e3;
      calc_width= 0.1; % [sec] 8 waves for 80 [Hz]
      datasize_pchip= 5000;

%% Matrix

      Sts_spiv = 1/Fs_spiv;    % [sec]
      cam_start_time = trig_time - Sts_spiv*nzall
      spiv_taxis = cam_start_time:Sts_spiv:cam_start_time+Sts_spiv*(nzall-1);     
      transstartpoint_spiv = floor((trans_start_time-cam_start_time)/Sts_spiv)
      transfinpoint_spiv = floor((trans_fin_time-cam_start_time)/Sts_spiv)
      sectionsize_spiv = calc_width/Sts_spiv;
      axis=Sts_spiv:Sts_spiv:Sts_spiv*sectionsize_spiv;
      Sts_pchip =(transfinpoint_spiv-transstartpoint_spiv)*Sts_spiv/datasize_pchip;
      taxislag = 0:Sts_spiv:(transfinpoint_spiv-transstartpoint_spiv)*Sts_spiv;
      taxis_pchip = 0:Sts_pchip:(transfinpoint_spiv-transstartpoint_spiv)*Sts_spiv;

%% Read and Calc

      fid1 = fopen(vosc_l_name,'r');
      L = fread(fid1,nzall,'double');
      fclose(fid1);

      fid2 = fopen(vosc_r_name,'r');
      R = fread(fid2,nzall,'double');
      fclose(fid2);

%       figure;
%       plot(spiv_taxis,L)
%       figure;
%       plot(spiv_taxis,R)

      for k = 1:1:transfinpoint_spiv-transstartpoint_spiv+1
        for j = 1:1:sectionsize_spiv
          vosc_l_temp(j)=L(transstartpoint_spiv-(sectionsize_spiv/2)+k-1+j-1);
          vosc_r_temp(j)=R(transstartpoint_spiv-(sectionsize_spiv/2)+k-1+j-1);
        end

%         fig=figure;
%         pos1 = [0.12 0.20 0.80 0.20]; % left bottom width height
%         subplot('Position',pos1)
%         plot(axis,vosc_l_temp)
% %         ylim([-200 200]);
%         xticks([])
%         ytickformat('%.3f')
% %         yticks([-200 -100 0 100 200])
% %         set(gca,'YTickLabel', char('-200','-100','0','100','200'))
%         ylabel('\it \fontname{Times New Roman} v''_{l} \rm[m/s]')
%         hold on
%         pos2 = [0.12 0.47 0.80 0.20];
%         subplot('Position',pos2)
%         plot(axis,vosc_r_temp,'k')
% %         ylim([-0.2 0.2]);
%         xticks([])
%         ytickformat('%.3f')
% %         yticks([-0.2 -0.1 0 0.1 0.2])
% %         set(gca,'YTickLabel', char('-0.2','-0.1','0.0','0.1','0.2'))
%         ylabel('\it \fontname{Times New Roman} v''_{r} \rm[m/s]')
%         hold off
%         frame = getframe(fig);
%         im{k}=frame2im(frame);
%         pause;
%         close;

        [C,lag]=xcorr(vosc_l_temp,vosc_r_temp);
        [M,Int]=max(C);
        t(k)=lag(Int);
        
        clear vosc_l_temp
        clear vosc_r_temp

      end

      plag = pchip(taxislag,t,taxis_pchip);

      fileID=fopen(filename_lag,'w');
      fwrite(fileID,plag,'double');
      fclose(fileID);

      fileID=fopen(filename_taxislag,'w');
      fwrite(fileID,taxis_pchip,'double');
      fclose(fileID);
      
%       for k=1:1:transfinpoint_spiv-transstartpoint_spiv+1
%         [A,map]= rgb2ind(im{k},256);
%         if k == 1
%             imwrite(A,map,gifname,'gif','LoopCount',Inf,'DelayTime',0.01);
%         else
%             imwrite(A,map,gifname,'gif','WriteMode','append','DelayTime',0.01);
%         end
%       end

%% MAKING FIGURE

      fig = figure;
      fig.Color='white';
      fig.Position=[50 50 960 735];
      
      plot(taxis_pchip, plag,'ok','MarkerSize',5,'LineWidth',1)
      hold on;

      plot(taxislag, t,'or','MarkerSize',5,'LineWidth',1)

      ax = gca;
      ax.YColor = 'k';
      xticks([0 Sts_pchip*datasize_pchip*1/4 Sts_pchip*datasize_pchip*2/4 Sts_pchip*datasize_pchip*3/4 Sts_pchip*datasize_pchip])
      set(gca,'xTickLabel', char('0.0','T/4','T/2','3T/4','T'),'FontName','Times New Roman','FontSize',40)
      ytickformat('%.3f')
%       yticks([-13.5 -6.75 0 6.75 13.5])
%       set(gca,'YTickLabel', char('-1.35','-0.68','0.00','0.68','1.35'))

      xlim([0 (transfinpoint_spiv-transstartpoint_spiv)*Sts_spiv]);
%       ylim([-13.5 13.5]);
      
      ax.Box = 'on';
      ax.LineWidth = 2.0;
      ax.XMinorTick = 'on';
      ax.YMinorTick = 'on';

      xlabel('\it \fontname{Times New Roman} t \rm[s]')
      ylabel('\it \fontname{Times New Roman} \tau \rm[ms]')
      set(gca,'FontName','Times New Roman','FontSize',40)
      hold off;
      pbaspect([sqrt(2) 1 1]);
