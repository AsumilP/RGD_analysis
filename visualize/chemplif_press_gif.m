    clear all
    close all
    clc

%% Parameters 1

      trans_start_time = 2.3561;
      trans_fin_time = 2.5689;
      trig_time = 3.0425;
      date=20190820;
      num=2;
%       col_max=2000; %Chem
      col_max=800; %PLIF
      vis='gray';

      first_frame_in_velo=8112;      %select the first frame
      frames=500;       %the number of frames you will convert
      skip_frame = 10; %the number of skip frame

%       filename = sprintf('D:/chem_output/%d/chem_rmv/chem_%02u_rmv.dat',date,num);
      filename = sprintf('D:/plif_output/%d/plif_med/plif_%02u_med.dat',date,num);
      presname = sprintf('E:/pressure/%d/calc/PDown_hps20_lps300_%d_%02u.dat',date,date,num);

%       gifname= sprintf('./chem_press_%d_%02u.gif',date,num);  %convert into, under the same directory
      gifname= sprintf('./plif_press_%d_%02u.gif',date,num);  %convert into, under the same directory

%% Parameters 2

      nx= 1024;
      ny= 1024;
      nzall= 21839;
      Fs_chem= 10e3;
      Fs_spiv= 20e3;
      Fs_press= 20e3;
      pres_samp_time = 10;  % [sec]
      origin_x = 500; % [px]
      origin_y = 640; % [px]
      origin_height = 46; %[mm]
      img_res_x = 120*10^(-3); % [mm/px]
      img_res_y = 120*10^(-3); % [mm/px]

%% Matrix

      Sts_press = 1/Fs_press;    % [sec]
      Sts_chem = 1/Fs_chem;    % [sec]
      Sts_spiv = 1/Fs_spiv;    % [sec]
      Pixels=nx*ny;
      origin_height_px=origin_height/img_res_y; %[px]
      xmin=-origin_x*img_res_x; %[mm]
      ymax=origin_height+origin_y*img_res_y; %[mm]
      wx=zeros(2,1);
      wy=zeros(2,1);
      pres_datasize =Fs_press*pres_samp_time;
      taxis = Sts_press:Sts_press:pres_samp_time;
      chem_cam_start_time = trig_time - Sts_chem*nzall
      cam_start_time = trig_time - Sts_spiv*nzall
      transstartpoint_chem = floor((trans_start_time-chem_cam_start_time)/Sts_chem)
      neg_frame = floor(((cam_start_time - chem_cam_start_time)/Sts_chem) + floor(first_frame_in_velo/2))
      transstartpoint_chem - neg_frame
      chem_vis_start_time = chem_cam_start_time + neg_frame*Sts_chem;
      scrsz=get(groot,'ScreenSize');
      pause;

      %% Decide Axes

     for i=1:2*origin_x+1
         x(i,:)= xmin+img_res_x*(i-1);
     end

     for i=1:origin_y+origin_height_px+1
         y(i,:)=ymax-img_res_y*(i-1);
     end

     y=sort(y);
     xmax=max(x);
     ymin=min(y);

     wx(1,1)=xmin;
     wx(2,1)=xmax;
     wy(1,1)=ymin;
     wy(2,1)=ymax;

%% MAKING VIDEO

        fid1 = fopen(sprintf(presname),'r');
        K = fread(fid1,pres_datasize,'double');
        fclose(fid1);

        fid2 = fopen(sprintf(filename),'r');
        fseek(fid2,neg_frame*Pixels*2,'bof');

        fig = figure;
        fig.Position=[1 1 800 800];
        fig.Color='white';


        for idx=1:1:frames
            I = fread(fid2,Pixels,'uint16');
            ImageData = permute(reshape(I,[nx,ny]),[2 1]);
            image_vis=ImageData(1:origin_height_px+origin_y,1:2*origin_x);

            pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
            subplot('Position',pos1)
            IMAGE = imagesc(wx,wy,image_vis(:,:),[0 col_max]);
            ax=gca;
            colormap(ax,vis)
            xtickformat('%.2f')
            xticks([-60 -40 -20 0 20 40 60])
            set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))
            ytickformat('%.2f')
            yticks([ymax-120 ymax-100 ymax-80 ymax-60 ymax-40 ymax-20 ymax])
            set(gca,'YTickLabel', char('120','100','80','60','40','20','0'))

            c=colorbar;
            c.Ticks=[0 500 1000 1500 2000 2500 3000]; % Chem
            c.TickLabels={'0','500','1000','1500','2000','2500','3000'};
            c.TickLabelInterpreter='latex';
            c.Label.FontSize = 15;
            c.Label.String = '\it \fontname{Times New Roman}';
            c.Location = 'eastoutside';
            c.AxisLocation='out';

            xlabel('\it \fontname{Times New Roman} x \rm[mm]')
            ylabel('\it \fontname{Times New Roman} y \rm[mm]')
            set(gca,'FontName','Times New Roman','FontSize',15)
            hold on

            xlim([-60 60])
            ylim([ymin ymax])
            hold off
            fseek(fid2,skip_frame*Pixels*2,'cof');

            pos2 = [0.10 0.15 0.80 0.10];
            subplot('Position',pos2)
            plot(taxis,K,'k')

            ax = gca;
            xtickformat('%.2f')
            xticks([trans_start_time-1 trans_start_time-0.5 trans_start_time trans_start_time+0.5 trans_start_time+1.0 trans_start_time+1.5 trans_start_time+2.0])
            set(gca,'xTickLabel', char('-1.0','-0.5','0.0','0.5','1.0','1.5','2.0'))
            ytickformat('%.3f')
            yticks([-0.50 -0.25 0 0.25 0.50])
            set(gca,'YTickLabel', char('-0.50','-0.25','0.00','0.25','0.50'))

            xlim([trans_start_time-0.5 trans_start_time+1.0]);
            ylim([-0.50 0.50]);

            xlabel('\it \fontname{Times New Roman} t \rm[sec]')
            ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
            set(gca,'FontName','Times New Roman','FontSize',15)
            hold on

            plot([trans_start_time trans_start_time],[-0.50 0.50],'m--','LineWidth',2.0)
            hold on

            plot([trans_fin_time trans_fin_time],[-0.50 0.50],'m--','LineWidth',2.0)
            hold on

            plot([chem_vis_start_time+Sts_chem*(idx-1)*(skip_frame+1) chem_vis_start_time+Sts_chem*(idx-1)*(skip_frame+1)],[-0.50 0.50],'b-','LineWidth',2.0)
            hold off

            frame = getframe(fig);
            im{idx}=frame2im(frame);

        end
        fclose(fid2);
        close;

        for idx=1:1:frames
              [A,map]= rgb2ind(im{idx},256);
            if idx == 1
                  imwrite(A,map,gifname,'gif','LoopCount',Inf,'DelayTime',0.1);
            else
                  imwrite(A,map,gifname,'gif','WriteMode','append','DelayTime',0.1);
            end
        end
