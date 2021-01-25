    clc
    clear all
    close all

%% Parameters 1

    trans_start_time = 2.9297;
    trans_fin_time = 3.2257;
    trig_time = 3.495;
    flow_rate=400;
    date=20190823;
    num=1;

    file_u=sprintf('E:/piv_output/velofield/%d/spiv_fbsc_%02u_ucl.dat',date,num);
    file_v=sprintf('E:/piv_output/velofield/%d/spiv_fbsc_%02u_vcl.dat',date,num);
    file_w=sprintf('E:/piv_output/velofield/%d/spiv_fbsc_%02u_wcl.dat',date,num);
    presname = sprintf('E:/pressure/%d/calc/PDown_hps20_lps300_%d_%02u.dat',date,date,num);

    file_umax=sprintf('E:/piv_output/velophasemeanfield/phasemean_umax_%d_%d_%02u.dat',flow_rate,date,num);
    file_uinfdown=sprintf('E:/piv_output/velophasemeanfield/phasemean_uinfdown_%d_%d_%02u.dat',flow_rate,date,num);
    file_umin=sprintf('E:/piv_output/velophasemeanfield/phasemean_umin_%d_%d_%02u.dat',flow_rate,date,num);
    file_uinfup=sprintf('E:/piv_output/velophasemeanfield/phasemean_uinfup_%d_%d_%02u.dat',flow_rate,date,num);
    file_vmax=sprintf('E:/piv_output/velophasemeanfield/phasemean_vmax_%d_%d_%02u.dat',flow_rate,date,num);
    file_vinfdown=sprintf('E:/piv_output/velophasemeanfield/phasemean_vinfdown_%d_%d_%02u.dat',flow_rate,date,num);
    file_vmin=sprintf('E:/piv_output/velophasemeanfield/phasemean_vmin_%d_%d_%02u.dat',flow_rate,date,num);
    file_vinfup=sprintf('E:/piv_output/velophasemeanfield/phasemean_vinfup_%d_%d_%02u.dat',flow_rate,date,num);
    file_wmax=sprintf('E:/piv_output/velophasemeanfield/phasemean_wmax_%d_%d_%02u.dat',flow_rate,date,num);
    file_winfdown=sprintf('E:/piv_output/velophasemeanfield/phasemean_winfdown_%d_%d_%02u.dat',flow_rate,date,num);
    file_wmin=sprintf('E:/piv_output/velophasemeanfield/phasemean_wmin_%d_%d_%02u.dat',flow_rate,date,num);
    file_winfup=sprintf('E:/piv_output/velophasemeanfield/phasemean_winfup_%d_%d_%02u.dat',flow_rate,date,num);

%% Parameters 2

    nx = 191;
    ny = 121;
    ny_calc = 98; % ATTENTION, CUT
    nzall = 21838;
    Fs_spiv= 20e3;
    Fs_press= 20e3;
    pres_samp_time = 10;  % [sec]
    div =10;

%% Matrix

    Sts_spiv = 1/Fs_spiv;    % [sec]
    Sts_press = 1/Fs_press;    % [sec]
    Pixels=nx*ny;
    pres_datasize =Fs_press*pres_samp_time;
    taxis = Sts_press:Sts_press:pres_samp_time;
    cam_start_time = trig_time - Sts_spiv*nzall
    cam_start_data = floor(trig_time/Sts_press)-nzall
    before_transition_data = floor(nzall -(trig_time - trans_start_time)/Sts_spiv)
    while_transition_data = floor((trans_fin_time - trans_start_time)/Sts_spiv)
    calc_data = floor((trans_fin_time - trans_start_time)/(div*Sts_spiv))
    velo=zeros(nx,ny);
    N=[nx ny];

%% Search phases

      fid4 = fopen(sprintf(presname),'r');
      p_fil = fread(fid4,pres_datasize,'double');
      fclose(fid4);

      [pks_pres,locs_presmax] = findpeaks(p_fil);
      TF_pres = islocalmin(p_fil);

      nn=0;

      for t=1:pres_datasize
          if TF_pres(t)==1
              nn=nn+1;
              locs_prestemp(nn)=t;
          end
      end

      locs_presmin=reshape(locs_prestemp,[nn,1]);

      if length(locs_presmin) <= length(locs_presmax)
        if (locs_presmax(1) < locs_presmin(1))
            for t=1:length(locs_presmin)-1
              inflect1(t)=ceil((locs_presmin(t)+locs_presmax(t))/2);
            end
            for t=1:length(locs_presmin)-1
              inflect2(t)=ceil((locs_presmax(t+1)+locs_presmin(t))/2);
            end
        else
            for t=1:length(locs_presmin)-1
              inflect2(t)=ceil((locs_presmax(t)+locs_presmin(t))/2);
            end
            for t=1:length(locs_presmin)-1
              inflect1(t)=ceil((locs_presmin(t+1)+locs_presmax(t))/2);
            end
        end
        locs_inflectdown=reshape(inflect1,[length(locs_presmin)-1,1]);
        locs_inflectup=reshape(inflect2,[length(locs_presmin)-1,1]);

      else
        if (locs_presmax(1) < locs_presmin(1))
            for t=1:length(locs_presmax)-1
              inflect1(t)=ceil((locs_presmin(t)+locs_presmax(t))/2);
            end
            for t=1:length(locs_presmax)-1
              inflect2(t)=ceil((locs_presmax(t+1)+locs_presmin(t))/2);
            end
        else
            for t=1:length(locs_presmax)-1
              inflect2(t)=ceil((locs_presmax(t)+locs_presmin(t))/2);
            end
            for t=1:length(locs_presmax)-1
              inflect1(t)=ceil((locs_presmin(t+1)+locs_presmax(t))/2);
            end
        end
        locs_inflectdown=reshape(inflect1,[length(locs_presmax)-1,1]);
        locs_inflectup=reshape(inflect2,[length(locs_presmax)-1,1]);
      end

%% check phases

      fig = figure;
      fig.Color='white';
      fig.Position=[50 50 960 735];

      plot(taxis,p_fil,'k')
      ax = gca;
      ax.YColor = 'k';

      xtickformat('%.2f')
      xticks([trans_start_time-0.4 trans_start_time-0.2 trans_start_time trans_start_time+0.2 trans_start_time+0.4 trans_start_time+0.6 trans_start_time+0.8 trans_start_time+1.0])
      set(gca,'xTickLabel', char('-0.4','-0.2','0.0','0.2','0.4','0.6','0.8','10'))
      ytickformat('%.3f')
      yticks([-0.40 -0.20 0 0.20 0.40])
      set(gca,'YTickLabel', char('-0.40','-0.20','0.00','0.20','0.40'))

      xlim([trans_start_time-0.4 trans_fin_time+0.4]);
      ylim([-0.40 0.40]);

      ax.Box = 'on';
      ax.LineWidth = 2.0;
      ax.XMinorTick = 'on';
      ax.YMinorTick = 'on';

      xlabel('\it \fontname{Times New Roman} t \rm[sec]')
      ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
      set(gca,'FontName','Times New Roman','FontSize',20)
      hold on

      plot([trans_start_time trans_start_time],[-0.50 0.50],'m--','LineWidth',1.5)
      hold on

      plot([trans_fin_time trans_fin_time],[-0.50 0.50],'m--','LineWidth',1.5)
      hold on

      plot(taxis(locs_presmax),pks_pres,'xr')
      hold on

      plot(taxis(locs_presmin),p_fil(locs_presmin),'ob')
      hold on

      plot(taxis(locs_inflectdown),p_fil(locs_inflectdown),'vg')
      hold on

      plot(taxis(locs_inflectup),p_fil(locs_inflectup),'^c')
      hold off
      pbaspect([sqrt(2) 1 1]);

%% Calculation, PHASE MEAN, umin

      fid1 = fopen(sprintf(file_u),'r');

      for i=1:nzall
           I=(fread(fid1,Pixels,'double'));
           velo=reshape(I,N);
           velo=permute(reshape(velo,N),[2 1]);
           u(:,:,i)=velo(4:101,:);
      end

      umeantemp1=zeros(ny_calc,nx);
      umeantemp2=zeros(ny_calc,nx);
      umeantemp3=zeros(ny_calc,nx);
      umeantemp4=zeros(ny_calc,nx);
      umeantemp5=zeros(ny_calc,nx);
      umeantemp6=zeros(ny_calc,nx);
      umeantemp7=zeros(ny_calc,nx);
      umeantemp8=zeros(ny_calc,nx);
      umeantemp9=zeros(ny_calc,nx);
      umeantemp10=zeros(ny_calc,nx);
      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_presmin)
          if (locs_presmin(t)-cam_start_data >before_transition_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+calc_data)
              nn1=nn1+1;
              umeantemp1(:,:) = umeantemp1(:,:) + u(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+2*calc_data)
              nn2=nn2+1;
              umeantemp2(:,:) = umeantemp2(:,:) + u(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+3*calc_data)
              nn3=nn3+1;
              umeantemp3(:,:) = umeantemp3(:,:) + u(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+4*calc_data)
              nn4=nn4+1;
              umeantemp4(:,:) = umeantemp4(:,:) + u(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+5*calc_data)
              nn5=nn5+1;
              umeantemp5(:,:) = umeantemp5(:,:) + u(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+6*calc_data)
              nn6=nn6+1;
              umeantemp6(:,:) = umeantemp6(:,:) + u(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+7*calc_data)
              nn7=nn7+1;
              umeantemp7(:,:) = umeantemp7(:,:) + u(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+8*calc_data)
              nn8=nn8+1;
              umeantemp8(:,:) = umeantemp8(:,:) + u(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+9*calc_data)
              nn9=nn9+1;
              umeantemp9(:,:) = umeantemp9(:,:) + u(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+10*calc_data)
              nn10=nn10+1;
              umeantemp10(:,:) = umeantemp10(:,:) + u(:,:,locs_presmin(t)-cam_start_data);
          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      umin1st=umeantemp1/nn1;
      umin2nd=umeantemp2/nn2;
      umin3rd=umeantemp3/nn3;
      umin4th=umeantemp4/nn4;
      umin5th=umeantemp5/nn5;
      umin6th=umeantemp6/nn6;
      umin7th=umeantemp7/nn7;
      umin8th=umeantemp8/nn8;
      umin9th=umeantemp9/nn9;
      umin10th=umeantemp10/nn10;

      saveu=cat(3,umin1st,umin2nd,umin3rd,umin4th,umin5th,umin6th,umin7th,umin8th,umin9th,umin10th);

      fileID=fopen(file_umin,'w');
      fwrite(fileID,saveu,'double');
     fclose(fileID);

%% Calculation, PHASE MEAN, umax

      umeantemp1=zeros(ny_calc,nx);
      umeantemp2=zeros(ny_calc,nx);
      umeantemp3=zeros(ny_calc,nx);
      umeantemp4=zeros(ny_calc,nx);
      umeantemp5=zeros(ny_calc,nx);
      umeantemp6=zeros(ny_calc,nx);
      umeantemp7=zeros(ny_calc,nx);
      umeantemp8=zeros(ny_calc,nx);
      umeantemp9=zeros(ny_calc,nx);
      umeantemp10=zeros(ny_calc,nx);
      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_presmax)
          if (locs_presmax(t)-cam_start_data >before_transition_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+calc_data)
              nn1=nn1+1;
              umeantemp1(:,:) = umeantemp1(:,:) + u(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+2*calc_data)
              nn2=nn2+1;
              umeantemp2(:,:) = umeantemp2(:,:) + u(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+3*calc_data)
              nn3=nn3+1;
              umeantemp3(:,:) = umeantemp3(:,:) + u(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+4*calc_data)
              nn4=nn4+1;
              umeantemp4(:,:) = umeantemp4(:,:) + u(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+5*calc_data)
              nn5=nn5+1;
              umeantemp5(:,:) = umeantemp5(:,:) + u(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+6*calc_data)
              nn6=nn6+1;
              umeantemp6(:,:) = umeantemp6(:,:) + u(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+7*calc_data)
              nn7=nn7+1;
              umeantemp7(:,:) = umeantemp7(:,:) + u(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+8*calc_data)
              nn8=nn8+1;
              umeantemp8(:,:) = umeantemp8(:,:) + u(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+9*calc_data)
              nn9=nn9+1;
              umeantemp9(:,:) = umeantemp9(:,:) + u(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+10*calc_data)
              nn10=nn10+1;
              umeantemp10(:,:) = umeantemp10(:,:) + u(:,:,locs_presmax(t)-cam_start_data);
          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      umax1st=umeantemp1/nn1;
      umax2nd=umeantemp2/nn2;
      umax3rd=umeantemp3/nn3;
      umax4th=umeantemp4/nn4;
      umax5th=umeantemp5/nn5;
      umax6th=umeantemp6/nn6;
      umax7th=umeantemp7/nn7;
      umax8th=umeantemp8/nn8;
      umax9th=umeantemp9/nn9;
      umax10th=umeantemp10/nn10;

      saveu=cat(3,umax1st,umax2nd,umax3rd,umax4th,umax5th,umax6th,umax7th,umax8th,umax9th,umax10th);

      fileID=fopen(file_umax,'w');
      fwrite(fileID,saveu,'double');
      fclose(fileID);

%% Calculation, PHASE MEAN, uinflectdown

      umeantemp1=zeros(ny_calc,nx);
      umeantemp2=zeros(ny_calc,nx);
      umeantemp3=zeros(ny_calc,nx);
      umeantemp4=zeros(ny_calc,nx);
      umeantemp5=zeros(ny_calc,nx);
      umeantemp6=zeros(ny_calc,nx);
      umeantemp7=zeros(ny_calc,nx);
      umeantemp8=zeros(ny_calc,nx);
      umeantemp9=zeros(ny_calc,nx);
      umeantemp10=zeros(ny_calc,nx);
      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_inflectdown)
          if (locs_inflectdown(t)-cam_start_data >before_transition_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+calc_data)
              nn1=nn1+1;
              umeantemp1(:,:) = umeantemp1(:,:) + u(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+2*calc_data)
              nn2=nn2+1;
              umeantemp2(:,:) = umeantemp2(:,:) + u(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+3*calc_data)
              nn3=nn3+1;
              umeantemp3(:,:) = umeantemp3(:,:) + u(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+4*calc_data)
              nn4=nn4+1;
              umeantemp4(:,:) = umeantemp4(:,:) + u(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+5*calc_data)
              nn5=nn5+1;
              umeantemp5(:,:) = umeantemp5(:,:) + u(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+6*calc_data)
              nn6=nn6+1;
              umeantemp6(:,:) = umeantemp6(:,:) + u(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+7*calc_data)
              nn7=nn7+1;
              umeantemp7(:,:) = umeantemp7(:,:) + u(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+8*calc_data)
              nn8=nn8+1;
              umeantemp8(:,:) = umeantemp8(:,:) + u(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+9*calc_data)
              nn9=nn9+1;
              umeantemp9(:,:) = umeantemp9(:,:) + u(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+10*calc_data)
              nn10=nn10+1;
              umeantemp10(:,:) = umeantemp10(:,:) + u(:,:,locs_inflectdown(t)-cam_start_data);
          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      uinfdown1st=umeantemp1/nn1;
      uinfdown2nd=umeantemp2/nn2;
      uinfdown3rd=umeantemp3/nn3;
      uinfdown4th=umeantemp4/nn4;
      uinfdown5th=umeantemp5/nn5;
      uinfdown6th=umeantemp6/nn6;
      uinfdown7th=umeantemp7/nn7;
      uinfdown8th=umeantemp8/nn8;
      uinfdown9th=umeantemp9/nn9;
      uinfdown10th=umeantemp10/nn10;

      saveu=cat(3,uinfdown1st,uinfdown2nd,uinfdown3rd,uinfdown4th,uinfdown5th,uinfdown6th,uinfdown7th,uinfdown8th,uinfdown9th,uinfdown10th);

      fileID=fopen(file_uinfdown,'w');
      fwrite(fileID,saveu,'double');
      fclose(fileID);

%% Calculation, PHASE MEAN, uinflectup

      umeantemp1=zeros(ny_calc,nx);
      umeantemp2=zeros(ny_calc,nx);
      umeantemp3=zeros(ny_calc,nx);
      umeantemp4=zeros(ny_calc,nx);
      umeantemp5=zeros(ny_calc,nx);
      umeantemp6=zeros(ny_calc,nx);
      umeantemp7=zeros(ny_calc,nx);
      umeantemp8=zeros(ny_calc,nx);
      umeantemp9=zeros(ny_calc,nx);
      umeantemp10=zeros(ny_calc,nx);
      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_inflectup)
          if (locs_inflectup(t)-cam_start_data >before_transition_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+calc_data)
              nn1=nn1+1;
              umeantemp1(:,:) = umeantemp1(:,:) + u(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+2*calc_data)
              nn2=nn2+1;
              umeantemp2(:,:) = umeantemp2(:,:) + u(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+3*calc_data)
              nn3=nn3+1;
              umeantemp3(:,:) = umeantemp3(:,:) + u(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+4*calc_data)
              nn4=nn4+1;
              umeantemp4(:,:) = umeantemp4(:,:) + u(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+5*calc_data)
              nn5=nn5+1;
              umeantemp5(:,:) = umeantemp5(:,:) + u(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+6*calc_data)
              nn6=nn6+1;
              umeantemp6(:,:) = umeantemp6(:,:) + u(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+7*calc_data)
              nn7=nn7+1;
              umeantemp7(:,:) = umeantemp7(:,:) + u(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+8*calc_data)
              nn8=nn8+1;
              umeantemp8(:,:) = umeantemp8(:,:) + u(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+9*calc_data)
              nn9=nn9+1;
              umeantemp9(:,:) = umeantemp9(:,:) + u(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+10*calc_data)
              nn10=nn10+1;
              umeantemp10(:,:) = umeantemp10(:,:) + u(:,:,locs_inflectup(t)-cam_start_data);
          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      uinfup1st=umeantemp1/nn1;
      uinfup2nd=umeantemp2/nn2;
      uinfup3rd=umeantemp3/nn3;
      uinfup4th=umeantemp4/nn4;
      uinfup5th=umeantemp5/nn5;
      uinfup6th=umeantemp6/nn6;
      uinfup7th=umeantemp7/nn7;
      uinfup8th=umeantemp8/nn8;
      uinfup9th=umeantemp9/nn9;
      uinfup10th=umeantemp10/nn10;

      saveu=cat(3,uinfup1st,uinfup2nd,uinfup3rd,uinfup4th,uinfup5th,uinfup6th,uinfup7th,uinfup8th,uinfup9th,uinfup10th);

      fileID=fopen(file_uinfup,'w');
      fwrite(fileID,saveu,'double');
      fclose(fileID);

%% Calcvlation, PHASE MEAN, vmin

      fid1 = fopen(sprintf(file_v),'r');

      for i=1:nzall
           I=(fread(fid1,Pixels,'double'));
           velo=reshape(I,N);
           velo=permute(reshape(velo,N),[2 1]);
           v(:,:,i)=velo(4:101,:);
      end

      vmeantemp1=zeros(ny_calc,nx);
      vmeantemp2=zeros(ny_calc,nx);
      vmeantemp3=zeros(ny_calc,nx);
      vmeantemp4=zeros(ny_calc,nx);
      vmeantemp5=zeros(ny_calc,nx);
      vmeantemp6=zeros(ny_calc,nx);
      vmeantemp7=zeros(ny_calc,nx);
      vmeantemp8=zeros(ny_calc,nx);
      vmeantemp9=zeros(ny_calc,nx);
      vmeantemp10=zeros(ny_calc,nx);
      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_presmin)
          if (locs_presmin(t)-cam_start_data >before_transition_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+calc_data)
              nn1=nn1+1;
              vmeantemp1(:,:) = vmeantemp1(:,:) + v(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+2*calc_data)
              nn2=nn2+1;
              vmeantemp2(:,:) = vmeantemp2(:,:) + v(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+3*calc_data)
              nn3=nn3+1;
              vmeantemp3(:,:) = vmeantemp3(:,:) + v(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+4*calc_data)
              nn4=nn4+1;
              vmeantemp4(:,:) = vmeantemp4(:,:) + v(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+5*calc_data)
              nn5=nn5+1;
              vmeantemp5(:,:) = vmeantemp5(:,:) + v(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+6*calc_data)
              nn6=nn6+1;
              vmeantemp6(:,:) = vmeantemp6(:,:) + v(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+7*calc_data)
              nn7=nn7+1;
              vmeantemp7(:,:) = vmeantemp7(:,:) + v(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+8*calc_data)
              nn8=nn8+1;
              vmeantemp8(:,:) = vmeantemp8(:,:) + v(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+9*calc_data)
              nn9=nn9+1;
              vmeantemp9(:,:) = vmeantemp9(:,:) + v(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+10*calc_data)
              nn10=nn10+1;
              vmeantemp10(:,:) = vmeantemp10(:,:) + v(:,:,locs_presmin(t)-cam_start_data);
          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      vmin1st=vmeantemp1/nn1;
      vmin2nd=vmeantemp2/nn2;
      vmin3rd=vmeantemp3/nn3;
      vmin4th=vmeantemp4/nn4;
      vmin5th=vmeantemp5/nn5;
      vmin6th=vmeantemp6/nn6;
      vmin7th=vmeantemp7/nn7;
      vmin8th=vmeantemp8/nn8;
      vmin9th=vmeantemp9/nn9;
      vmin10th=vmeantemp10/nn10;

      savev=cat(3,vmin1st,vmin2nd,vmin3rd,vmin4th,vmin5th,vmin6th,vmin7th,vmin8th,vmin9th,vmin10th);

      fileID=fopen(file_vmin,'w');
      fwrite(fileID,savev,'double');
      fclose(fileID);

%% Calcvlation, PHASE MEAN, vmax

      vmeantemp1=zeros(ny_calc,nx);
      vmeantemp2=zeros(ny_calc,nx);
      vmeantemp3=zeros(ny_calc,nx);
      vmeantemp4=zeros(ny_calc,nx);
      vmeantemp5=zeros(ny_calc,nx);
      vmeantemp6=zeros(ny_calc,nx);
      vmeantemp7=zeros(ny_calc,nx);
      vmeantemp8=zeros(ny_calc,nx);
      vmeantemp9=zeros(ny_calc,nx);
      vmeantemp10=zeros(ny_calc,nx);
      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_presmax)
          if (locs_presmax(t)-cam_start_data >before_transition_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+calc_data)
              nn1=nn1+1;
              vmeantemp1(:,:) = vmeantemp1(:,:) + v(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+2*calc_data)
              nn2=nn2+1;
              vmeantemp2(:,:) = vmeantemp2(:,:) + v(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+3*calc_data)
              nn3=nn3+1;
              vmeantemp3(:,:) = vmeantemp3(:,:) + v(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+4*calc_data)
              nn4=nn4+1;
              vmeantemp4(:,:) = vmeantemp4(:,:) + v(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+5*calc_data)
              nn5=nn5+1;
              vmeantemp5(:,:) = vmeantemp5(:,:) + v(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+6*calc_data)
              nn6=nn6+1;
              vmeantemp6(:,:) = vmeantemp6(:,:) + v(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+7*calc_data)
              nn7=nn7+1;
              vmeantemp7(:,:) = vmeantemp7(:,:) + v(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+8*calc_data)
              nn8=nn8+1;
              vmeantemp8(:,:) = vmeantemp8(:,:) + v(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+9*calc_data)
              nn9=nn9+1;
              vmeantemp9(:,:) = vmeantemp9(:,:) + v(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+10*calc_data)
              nn10=nn10+1;
              vmeantemp10(:,:) = vmeantemp10(:,:) + v(:,:,locs_presmax(t)-cam_start_data);
          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      vmax1st=vmeantemp1/nn1;
      vmax2nd=vmeantemp2/nn2;
      vmax3rd=vmeantemp3/nn3;
      vmax4th=vmeantemp4/nn4;
      vmax5th=vmeantemp5/nn5;
      vmax6th=vmeantemp6/nn6;
      vmax7th=vmeantemp7/nn7;
      vmax8th=vmeantemp8/nn8;
      vmax9th=vmeantemp9/nn9;
      vmax10th=vmeantemp10/nn10;

      savev=cat(3,vmax1st,vmax2nd,vmax3rd,vmax4th,vmax5th,vmax6th,vmax7th,vmax8th,vmax9th,vmax10th);

      fileID=fopen(file_vmax,'w');
      fwrite(fileID,savev,'double');
      fclose(fileID);

%% Calcvlation, PHASE MEAN, vinflectdown

      vmeantemp1=zeros(ny_calc,nx);
      vmeantemp2=zeros(ny_calc,nx);
      vmeantemp3=zeros(ny_calc,nx);
      vmeantemp4=zeros(ny_calc,nx);
      vmeantemp5=zeros(ny_calc,nx);
      vmeantemp6=zeros(ny_calc,nx);
      vmeantemp7=zeros(ny_calc,nx);
      vmeantemp8=zeros(ny_calc,nx);
      vmeantemp9=zeros(ny_calc,nx);
      vmeantemp10=zeros(ny_calc,nx);
      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_inflectdown)
          if (locs_inflectdown(t)-cam_start_data >before_transition_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+calc_data)
              nn1=nn1+1;
              vmeantemp1(:,:) = vmeantemp1(:,:) + v(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+2*calc_data)
              nn2=nn2+1;
              vmeantemp2(:,:) = vmeantemp2(:,:) + v(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+3*calc_data)
              nn3=nn3+1;
              vmeantemp3(:,:) = vmeantemp3(:,:) + v(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+4*calc_data)
              nn4=nn4+1;
              vmeantemp4(:,:) = vmeantemp4(:,:) + v(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+5*calc_data)
              nn5=nn5+1;
              vmeantemp5(:,:) = vmeantemp5(:,:) + v(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+6*calc_data)
              nn6=nn6+1;
              vmeantemp6(:,:) = vmeantemp6(:,:) + v(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+7*calc_data)
              nn7=nn7+1;
              vmeantemp7(:,:) = vmeantemp7(:,:) + v(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+8*calc_data)
              nn8=nn8+1;
              vmeantemp8(:,:) = vmeantemp8(:,:) + v(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+9*calc_data)
              nn9=nn9+1;
              vmeantemp9(:,:) = vmeantemp9(:,:) + v(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+10*calc_data)
              nn10=nn10+1;
              vmeantemp10(:,:) = vmeantemp10(:,:) + v(:,:,locs_inflectdown(t)-cam_start_data);
          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      vinfdown1st=vmeantemp1/nn1;
      vinfdown2nd=vmeantemp2/nn2;
      vinfdown3rd=vmeantemp3/nn3;
      vinfdown4th=vmeantemp4/nn4;
      vinfdown5th=vmeantemp5/nn5;
      vinfdown6th=vmeantemp6/nn6;
      vinfdown7th=vmeantemp7/nn7;
      vinfdown8th=vmeantemp8/nn8;
      vinfdown9th=vmeantemp9/nn9;
      vinfdown10th=vmeantemp10/nn10;

      savev=cat(3,vinfdown1st,vinfdown2nd,vinfdown3rd,vinfdown4th,vinfdown5th,vinfdown6th,vinfdown7th,vinfdown8th,vinfdown9th,vinfdown10th);

      fileID=fopen(file_vinfdown,'w');
      fwrite(fileID,savev,'double');
      fclose(fileID);

%% Calcvlation, PHASE MEAN, vinflectvp

      vmeantemp1=zeros(ny_calc,nx);
      vmeantemp2=zeros(ny_calc,nx);
      vmeantemp3=zeros(ny_calc,nx);
      vmeantemp4=zeros(ny_calc,nx);
      vmeantemp5=zeros(ny_calc,nx);
      vmeantemp6=zeros(ny_calc,nx);
      vmeantemp7=zeros(ny_calc,nx);
      vmeantemp8=zeros(ny_calc,nx);
      vmeantemp9=zeros(ny_calc,nx);
      vmeantemp10=zeros(ny_calc,nx);
      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_inflectup)
          if (locs_inflectup(t)-cam_start_data >before_transition_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+calc_data)
              nn1=nn1+1;
              vmeantemp1(:,:) = vmeantemp1(:,:) + v(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+2*calc_data)
              nn2=nn2+1;
              vmeantemp2(:,:) = vmeantemp2(:,:) + v(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+3*calc_data)
              nn3=nn3+1;
              vmeantemp3(:,:) = vmeantemp3(:,:) + v(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+4*calc_data)
              nn4=nn4+1;
              vmeantemp4(:,:) = vmeantemp4(:,:) + v(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+5*calc_data)
              nn5=nn5+1;
              vmeantemp5(:,:) = vmeantemp5(:,:) + v(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+6*calc_data)
              nn6=nn6+1;
              vmeantemp6(:,:) = vmeantemp6(:,:) + v(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+7*calc_data)
              nn7=nn7+1;
              vmeantemp7(:,:) = vmeantemp7(:,:) + v(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+8*calc_data)
              nn8=nn8+1;
              vmeantemp8(:,:) = vmeantemp8(:,:) + v(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+9*calc_data)
              nn9=nn9+1;
              vmeantemp9(:,:) = vmeantemp9(:,:) + v(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+10*calc_data)
              nn10=nn10+1;
              vmeantemp10(:,:) = vmeantemp10(:,:) + v(:,:,locs_inflectup(t)-cam_start_data);
          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      vinfup1st=vmeantemp1/nn1;
      vinfup2nd=vmeantemp2/nn2;
      vinfup3rd=vmeantemp3/nn3;
      vinfup4th=vmeantemp4/nn4;
      vinfup5th=vmeantemp5/nn5;
      vinfup6th=vmeantemp6/nn6;
      vinfup7th=vmeantemp7/nn7;
      vinfup8th=vmeantemp8/nn8;
      vinfup9th=vmeantemp9/nn9;
      vinfup10th=vmeantemp10/nn10;

      savev=cat(3,vinfup1st,vinfup2nd,vinfup3rd,vinfup4th,vinfup5th,vinfup6th,vinfup7th,vinfup8th,vinfup9th,vinfup10th);

      fileID=fopen(file_vinfup,'w');
      fwrite(fileID,savev,'double');
      fclose(fileID);

%% Calcwlation, PHASE MEAN, wmin

      fid1 = fopen(sprintf(file_w),'r');

      for i=1:nzall
           I=(fread(fid1,Pixels,'double'));
           velo=reshape(I,N);
           velo=permute(reshape(velo,N),[2 1]);
           w(:,:,i)=velo(4:101,:);
      end

      wmeantemp1=zeros(ny_calc,nx);
      wmeantemp2=zeros(ny_calc,nx);
      wmeantemp3=zeros(ny_calc,nx);
      wmeantemp4=zeros(ny_calc,nx);
      wmeantemp5=zeros(ny_calc,nx);
      wmeantemp6=zeros(ny_calc,nx);
      wmeantemp7=zeros(ny_calc,nx);
      wmeantemp8=zeros(ny_calc,nx);
      wmeantemp9=zeros(ny_calc,nx);
      wmeantemp10=zeros(ny_calc,nx);
      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_presmin)
          if (locs_presmin(t)-cam_start_data >before_transition_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+calc_data)
              nn1=nn1+1;
              wmeantemp1(:,:) = wmeantemp1(:,:) + w(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+2*calc_data)
              nn2=nn2+1;
              wmeantemp2(:,:) = wmeantemp2(:,:) + w(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+3*calc_data)
              nn3=nn3+1;
              wmeantemp3(:,:) = wmeantemp3(:,:) + w(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+4*calc_data)
              nn4=nn4+1;
              wmeantemp4(:,:) = wmeantemp4(:,:) + w(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+5*calc_data)
              nn5=nn5+1;
              wmeantemp5(:,:) = wmeantemp5(:,:) + w(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+6*calc_data)
              nn6=nn6+1;
              wmeantemp6(:,:) = wmeantemp6(:,:) + w(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+7*calc_data)
              nn7=nn7+1;
              wmeantemp7(:,:) = wmeantemp7(:,:) + w(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+8*calc_data)
              nn8=nn8+1;
              wmeantemp8(:,:) = wmeantemp8(:,:) + w(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+9*calc_data)
              nn9=nn9+1;
              wmeantemp9(:,:) = wmeantemp9(:,:) + w(:,:,locs_presmin(t)-cam_start_data);
          elseif (locs_presmin(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_presmin(t)-cam_start_data <= before_transition_data+10*calc_data)
              nn10=nn10+1;
              wmeantemp10(:,:) = wmeantemp10(:,:) + w(:,:,locs_presmin(t)-cam_start_data);
          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      wmin1st=wmeantemp1/nn1;
      wmin2nd=wmeantemp2/nn2;
      wmin3rd=wmeantemp3/nn3;
      wmin4th=wmeantemp4/nn4;
      wmin5th=wmeantemp5/nn5;
      wmin6th=wmeantemp6/nn6;
      wmin7th=wmeantemp7/nn7;
      wmin8th=wmeantemp8/nn8;
      wmin9th=wmeantemp9/nn9;
      wmin10th=wmeantemp10/nn10;

      savew=cat(3,wmin1st,wmin2nd,wmin3rd,wmin4th,wmin5th,wmin6th,wmin7th,wmin8th,wmin9th,wmin10th);

      fileID=fopen(file_wmin,'w');
      fwrite(fileID,savew,'double');
      fclose(fileID);

%% Calcwlation, PHASE MEAN, wmax

      wmeantemp1=zeros(ny_calc,nx);
      wmeantemp2=zeros(ny_calc,nx);
      wmeantemp3=zeros(ny_calc,nx);
      wmeantemp4=zeros(ny_calc,nx);
      wmeantemp5=zeros(ny_calc,nx);
      wmeantemp6=zeros(ny_calc,nx);
      wmeantemp7=zeros(ny_calc,nx);
      wmeantemp8=zeros(ny_calc,nx);
      wmeantemp9=zeros(ny_calc,nx);
      wmeantemp10=zeros(ny_calc,nx);
      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_presmax)
          if (locs_presmax(t)-cam_start_data >before_transition_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+calc_data)
              nn1=nn1+1;
              wmeantemp1(:,:) = wmeantemp1(:,:) + w(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+2*calc_data)
              nn2=nn2+1;
              wmeantemp2(:,:) = wmeantemp2(:,:) + w(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+3*calc_data)
              nn3=nn3+1;
              wmeantemp3(:,:) = wmeantemp3(:,:) + w(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+4*calc_data)
              nn4=nn4+1;
              wmeantemp4(:,:) = wmeantemp4(:,:) + w(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+5*calc_data)
              nn5=nn5+1;
              wmeantemp5(:,:) = wmeantemp5(:,:) + w(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+6*calc_data)
              nn6=nn6+1;
              wmeantemp6(:,:) = wmeantemp6(:,:) + w(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+7*calc_data)
              nn7=nn7+1;
              wmeantemp7(:,:) = wmeantemp7(:,:) + w(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+8*calc_data)
              nn8=nn8+1;
              wmeantemp8(:,:) = wmeantemp8(:,:) + w(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+9*calc_data)
              nn9=nn9+1;
              wmeantemp9(:,:) = wmeantemp9(:,:) + w(:,:,locs_presmax(t)-cam_start_data);
          elseif (locs_presmax(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_presmax(t)-cam_start_data <= before_transition_data+10*calc_data)
              nn10=nn10+1;
              wmeantemp10(:,:) = wmeantemp10(:,:) + w(:,:,locs_presmax(t)-cam_start_data);
          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      wmax1st=wmeantemp1/nn1;
      wmax2nd=wmeantemp2/nn2;
      wmax3rd=wmeantemp3/nn3;
      wmax4th=wmeantemp4/nn4;
      wmax5th=wmeantemp5/nn5;
      wmax6th=wmeantemp6/nn6;
      wmax7th=wmeantemp7/nn7;
      wmax8th=wmeantemp8/nn8;
      wmax9th=wmeantemp9/nn9;
      wmax10th=wmeantemp10/nn10;

      savew=cat(3,wmax1st,wmax2nd,wmax3rd,wmax4th,wmax5th,wmax6th,wmax7th,wmax8th,wmax9th,wmax10th);

      fileID=fopen(file_wmax,'w');
      fwrite(fileID,savew,'double');
      fclose(fileID);

%% Calcwlation, PHASE MEAN, winflectdown

      wmeantemp1=zeros(ny_calc,nx);
      wmeantemp2=zeros(ny_calc,nx);
      wmeantemp3=zeros(ny_calc,nx);
      wmeantemp4=zeros(ny_calc,nx);
      wmeantemp5=zeros(ny_calc,nx);
      wmeantemp6=zeros(ny_calc,nx);
      wmeantemp7=zeros(ny_calc,nx);
      wmeantemp8=zeros(ny_calc,nx);
      wmeantemp9=zeros(ny_calc,nx);
      wmeantemp10=zeros(ny_calc,nx);
      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_inflectdown)
          if (locs_inflectdown(t)-cam_start_data >before_transition_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+calc_data)
              nn1=nn1+1;
              wmeantemp1(:,:) = wmeantemp1(:,:) + w(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+2*calc_data)
              nn2=nn2+1;
              wmeantemp2(:,:) = wmeantemp2(:,:) + w(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+3*calc_data)
              nn3=nn3+1;
              wmeantemp3(:,:) = wmeantemp3(:,:) + w(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+4*calc_data)
              nn4=nn4+1;
              wmeantemp4(:,:) = wmeantemp4(:,:) + w(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+5*calc_data)
              nn5=nn5+1;
              wmeantemp5(:,:) = wmeantemp5(:,:) + w(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+6*calc_data)
              nn6=nn6+1;
              wmeantemp6(:,:) = wmeantemp6(:,:) + w(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+7*calc_data)
              nn7=nn7+1;
              wmeantemp7(:,:) = wmeantemp7(:,:) + w(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+8*calc_data)
              nn8=nn8+1;
              wmeantemp8(:,:) = wmeantemp8(:,:) + w(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+9*calc_data)
              nn9=nn9+1;
              wmeantemp9(:,:) = wmeantemp9(:,:) + w(:,:,locs_inflectdown(t)-cam_start_data);
          elseif (locs_inflectdown(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_inflectdown(t)-cam_start_data <= before_transition_data+10*calc_data)
              nn10=nn10+1;
              wmeantemp10(:,:) = wmeantemp10(:,:) + w(:,:,locs_inflectdown(t)-cam_start_data);
          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      winfdown1st=wmeantemp1/nn1;
      winfdown2nd=wmeantemp2/nn2;
      winfdown3rd=wmeantemp3/nn3;
      winfdown4th=wmeantemp4/nn4;
      winfdown5th=wmeantemp5/nn5;
      winfdown6th=wmeantemp6/nn6;
      winfdown7th=wmeantemp7/nn7;
      winfdown8th=wmeantemp8/nn8;
      winfdown9th=wmeantemp9/nn9;
      winfdown10th=wmeantemp10/nn10;

      savew=cat(3,winfdown1st,winfdown2nd,winfdown3rd,winfdown4th,winfdown5th,winfdown6th,winfdown7th,winfdown8th,winfdown9th,winfdown10th);

      fileID=fopen(file_winfdown,'w');
      fwrite(fileID,savew,'double');
      fclose(fileID);

%% Calcwlation, PHASE MEAN, winflectup

      wmeantemp1=zeros(ny_calc,nx);
      wmeantemp2=zeros(ny_calc,nx);
      wmeantemp3=zeros(ny_calc,nx);
      wmeantemp4=zeros(ny_calc,nx);
      wmeantemp5=zeros(ny_calc,nx);
      wmeantemp6=zeros(ny_calc,nx);
      wmeantemp7=zeros(ny_calc,nx);
      wmeantemp8=zeros(ny_calc,nx);
      wmeantemp9=zeros(ny_calc,nx);
      wmeantemp10=zeros(ny_calc,nx);
      nn1=0;
      nn2=0;
      nn3=0;
      nn4=0;
      nn5=0;
      nn6=0;
      nn7=0;
      nn8=0;
      nn9=0;
      nn10=0;

      for t=1:length(locs_inflectup)
          if (locs_inflectup(t)-cam_start_data >before_transition_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+calc_data)
              nn1=nn1+1;
              wmeantemp1(:,:) = wmeantemp1(:,:) + w(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+2*calc_data)
              nn2=nn2+1;
              wmeantemp2(:,:) = wmeantemp2(:,:) + w(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+2*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+3*calc_data)
              nn3=nn3+1;
              wmeantemp3(:,:) = wmeantemp3(:,:) + w(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+3*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+4*calc_data)
              nn4=nn4+1;
              wmeantemp4(:,:) = wmeantemp4(:,:) + w(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+4*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+5*calc_data)
              nn5=nn5+1;
              wmeantemp5(:,:) = wmeantemp5(:,:) + w(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+5*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+6*calc_data)
              nn6=nn6+1;
              wmeantemp6(:,:) = wmeantemp6(:,:) + w(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+6*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+7*calc_data)
              nn7=nn7+1;
              wmeantemp7(:,:) = wmeantemp7(:,:) + w(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+7*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+8*calc_data)
              nn8=nn8+1;
              wmeantemp8(:,:) = wmeantemp8(:,:) + w(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+8*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+9*calc_data)
              nn9=nn9+1;
              wmeantemp9(:,:) = wmeantemp9(:,:) + w(:,:,locs_inflectup(t)-cam_start_data);
          elseif (locs_inflectup(t)-cam_start_data >before_transition_data+9*calc_data) && (locs_inflectup(t)-cam_start_data <= before_transition_data+10*calc_data)
              nn10=nn10+1;
              wmeantemp10(:,:) = wmeantemp10(:,:) + w(:,:,locs_inflectup(t)-cam_start_data);
          end
      end

      nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
      winfup1st=wmeantemp1/nn1;
      winfup2nd=wmeantemp2/nn2;
      winfup3rd=wmeantemp3/nn3;
      winfup4th=wmeantemp4/nn4;
      winfup5th=wmeantemp5/nn5;
      winfup6th=wmeantemp6/nn6;
      winfup7th=wmeantemp7/nn7;
      winfup8th=wmeantemp8/nn8;
      winfup9th=wmeantemp9/nn9;
      winfup10th=wmeantemp10/nn10;

      savew=cat(3,winfup1st,winfup2nd,winfup3rd,winfup4th,winfup5th,winfup6th,winfup7th,winfup8th,winfup9th,winfup10th);

      fileID=fopen(file_winfup,'w');
      fwrite(fileID,savew,'double');
      fclose(fileID);
