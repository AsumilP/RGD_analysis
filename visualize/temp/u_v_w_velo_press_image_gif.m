    clc
    clear all
    close all

%% Parameters 1

    trans_start_time = 1.7392;
    trans_fin_time = 1.9779;
    trig_time = 2.3932;
    date=20190821;
    num=3;
    nincrement=2;

    first_frame=8758;      %select the first frame
    frames=2000;         %time steps %2000, 500
    skip_frame = 0; %the number of skip frame %0, 21

    file_u=sprintf('E:/piv_output/velofield/%d/spiv_fbsc_%02u_ucl.dat',date,num);
    file_v=sprintf('E:/piv_output/velofield/%d/spiv_fbsc_%02u_vcl.dat',date,num);
    file_w=sprintf('E:/piv_output/velofield/%d/spiv_fbsc_%02u_wcl.dat',date,num);
    presname = sprintf('E:/pressure/%d/calc/PDown_hps20_lps300_%d_%02u.dat',date,date,num);

    gifname=sprintf('./spiv_press_%d_%02u.gif',date,num);  %convert into, under the same directory
%     gifname=sprintf('./spiv_press_%d_%02u_long.gif',date,num);  %convert into, under the same directory

%% Parameters 2

    nx = 191;
    ny = 121;
    ny_calc = 98; % ATTENTION, CUT
    nzall = 21838;
    vec_spc_x = 8;
    vec_spc_y = 8;
    img_res_x = 80*10^(-3);
    img_res_y = 75*10^(-3);
    Fs_spiv= 20e3;
    Fs_press= 20e3;
    pres_samp_time = 10;  % [sec]

%% Matrix

    Sts_spiv = 1/Fs_spiv;    % [sec]
    Sts_press = 1/Fs_press;    % [sec]
    Pixels=nx*ny;
    pres_datasize =Fs_press*pres_samp_time;
    taxis = Sts_press:Sts_press:pres_samp_time;
    cam_start_time = trig_time - Sts_spiv*nzall
    spiv_vis_start_time = cam_start_time + (first_frame -1)*Sts_spiv;
    error_txt = 'ERROR, TOO LONG !!!';

    X=img_res_x*vec_spc_x;
    Y=img_res_y*vec_spc_y;
    xmin=-(0.5*(nx-1))*X+X;
    xmax=0.5*(nx-1)*X+X;
    ymin=Y*19; % ATTENTION, CUT
    ymax=Y*116; % ATTENTION, CUT
    N=[nx ny];
    wx=zeros(2,1);
    wy=zeros(2,1);
%    img = imread('vec_refference.png');

%% Decide Axes

    for i=1:floor(nx/nincrement)
         x(i,:)= xmin+X*nincrement*(i-1)+X;
     end

     for i=1:floor(ny_calc/nincrement)
         y(i,:)=ymax-Y*nincrement*(i-1);
     end

     y=sort(y);

     for i=1:floor(nx)
         xstream(i,:)= xmin+X*(i-1)+X;
     end

     for i=1:floor(ny_calc)
         ystream(i,:)=ymax-Y*(i-1);
     end

     ystream=sort(ystream);

     [sx,sy]=meshgrid(xstream,ystream);

     wx(1,1)=xmin;
     wx(2,1)=xmax;
     wy(1,1)=ymin;
     wy(2,1)=ymax;

%% Make Movie

        fid1 = fopen(sprintf(file_u),'r');
        fseek(fid1,(first_frame-1)*Pixels*8,'bof');

        fid2 = fopen(sprintf(file_v),'r');
        fseek(fid2,(first_frame-1)*Pixels*8,'bof');

        fid3 = fopen(sprintf(file_w),'r');
        fseek(fid3,(first_frame-1)*Pixels*8,'bof');

        fid4 = fopen(sprintf(presname),'r');
        K = fread(fid4,pres_datasize,'double');
        fclose(fid4);

        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

    if first_frame+(skip_frame+1)*frames <= nzall

    for idx=1:1:frames

        I=(fread(fid1,Pixels,'double'));
        u=permute(reshape(I,N),[2 1]);
        fseek(fid1,skip_frame*Pixels*8,'cof');

        I=(fread(fid2,Pixels,'double'));
        v=permute(reshape(-I,N),[2 1]);
        fseek(fid2,skip_frame*Pixels*8,'cof');

        I=(fread(fid3,Pixels,'double'));
        w=permute(reshape(I,N),[2 1]);
        fseek(fid3,skip_frame*Pixels*8,'cof');

        u_vis=u(4:101,:);
        v_vis=v(4:101,:);
        w_vis=w(4:101,:);

        for j=1:floor(nx/nincrement)
            for i=1:floor(ny_calc/nincrement)
               uplot(i,j)= u_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
               vplot(i,j)= v_vis(nincrement*(i-1)+1,nincrement*(j-1)+1);
            end
        end

        pos1 = [0.10 0.37 0.83 0.60]; % left bottom width height
        subplot('Position',pos1)
        ax=gca;
        IMAGE = imagesc(wx,wy,w_vis(:,:),[-10 10]);
        load('MyColormap_for_w','mymap')
        colormap(ax,mymap)
        xtickformat('%.2f')
        xticks([-60 -40 -20 0 20 40 60])
        set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

        ytickformat('%.2f')
        yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
        set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

        c=colorbar;
        c.Ticks=[-10 -5.0 0 5.0 10];
        c.TickLabels={'-10','-5.0','0.0','5.0','10'};
        c.TickLabelInterpreter='latex';
        c.Label.FontSize = 25;
        c.Label.String = '\it \fontname{Times New Roman} w \rm[m/s]';
        c.Location = 'eastoutside';
        c.AxisLocation='out';

        ax = gca;
        xlabel('\it \fontname{Times New Roman} x \rm[mm]')
        ylabel('\it \fontname{Times New Roman} y \rm[mm]')
        set(gca,'FontName','Times New Roman','FontSize',25)
        hold on

        ncquiverref2(x,y,uplot(:,:),vplot(:,:),'[m/s]','median','true','k','0');
%        quiver(x,y,uplot(:,:),vplot(:,:),0,'Color',[0.2,0.2,0.2]);
        xlim([-60 60]);
        ylim([ymin ymax])
        hold on

%        image([52 62],[64 68],img)
        hold off

        pos2 = [0.10 0.12 0.83 0.12];
        subplot('Position',pos2)
        plot(taxis,K,'k')

        ax = gca;
        xtickformat('%.2f')
        xticks([trans_start_time-0.2 trans_start_time trans_start_time+0.2 trans_start_time+0.4 trans_start_time+0.6])
        set(gca,'xTickLabel', char('-0.2','0.0','0.2','0.4','0.6'))
        ytickformat('%.3f')
        yticks([-0.50 0 0.50])
        set(gca,'YTickLabel', char('-0.50','0.00','0.50'))

        xlim([trans_start_time-0.2 trans_start_time+0.6]);
        ylim([-0.50 0.50]);

        xlabel('\it \fontname{Times New Roman} t \rm[sec]')
        ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
        set(gca,'FontName','Times New Roman','FontSize',25)
        hold on

        plot([trans_start_time trans_start_time],[-0.50 0.50],'m--','LineWidth',2.0)
        hold on

        plot([trans_fin_time trans_fin_time],[-0.50 0.50],'m--','LineWidth',2.0)
        hold on

        plot([spiv_vis_start_time+Sts_spiv*(idx-1)*(skip_frame+1) spiv_vis_start_time+Sts_spiv*(idx-1)*(skip_frame+1)],[-0.50 0.50],'b-','LineWidth',2.0)
        hold off

        frame = getframe(fig);
        im{idx}=frame2im(frame);
    end
    close;

    for idx=1:1:frames
        [A,map]= rgb2ind(im{idx},256);
        if idx == 1
            imwrite(A,map,gifname,'gif','LoopCount',Inf,'DelayTime',0.01);
        else
            imwrite(A,map,gifname,'gif','WriteMode','append','DelayTime',0.01);
        end
    end

    else
          error_txt
          first_frame+(skip_frame+1)*frames
     end
