    clc
    clear all
    close all

%% Parameters 1, cold

    flow_rate = 500; % [L/min]

    file_v='E:/piv_output/velofield/20190819/spiv_fbsc_05_vcl.dat';

    file_axis ='C:/Users/atagi/Desktop/modified/v_attenuation/20190819/vatten_yaxis.dat';
    file_dist_vl ='C:/Users/atagi/Desktop/modified/v_attenuation/20190819/450_20190819_01_vatten_l.dat';
    file_dist_vr ='C:/Users/atagi/Desktop/modified/v_attenuation/20190819/450_20190819_01_vatten_r.dat';

%% Parameters 2

    d = 7.5; % [mm]
    jet_pixel_ll = 75; %77(,81),75
    jet_pixel_lr = 85; %88(,91),85     11-12 pixels
    jet_pixel_rl = 109; %104(,101),109
    jet_pixel_rr = 119; %115(,111),119
    nx = 191;
    ny = 121;
    nzall = 21838;
    Fs = 20000; % [Hz]
    vec_spc_y = 8;
    img_res_y = 75*10^(-3);
    frames = nzall;
    U0 = (flow_rate*10^3)/(pi*(15^2-7.5^2)*60);

%% Matrix

    Pixels=nx*ny;
    Y=img_res_y*vec_spc_y;
    v=zeros(nx,ny);
    N=[nx ny];
    ymin=Y;
    ymax=ny*Y;

%% Decide Axes

    for i=1:ny
        y(i,:)=(ymax-Y*(i-1))/d;
    end

    y=sort(y);

%% Calculate V distribution, SAVE

    fid2 = fopen(sprintf(file_v),'r');

    for idx=1:1:frames

        I=(fread(fid2,Pixels,'double'));
        v=reshape(I,N);
        v=permute(reshape(-v,[nx,ny]),[2 1]);

        v_dist_l(:,idx)=mean(v(:,jet_pixel_ll:jet_pixel_lr),2);
        v_dist_r(:,idx)=mean(v(:,jet_pixel_rl:jet_pixel_rr),2);

    end

    v_dist_l_plot=flipud(-mean(v_dist_l,2)/U0); 
    v_dist_r_plot=flipud(-mean(v_dist_r,2)/U0);
    
    fileID=fopen(file_dist_vl,'w');
    fwrite(fileID,v_dist_l_plot,'double');
    fclose(fileID);

    fileID=fopen(file_dist_vr,'w');
    fwrite(fileID,v_dist_r_plot,'double');
    fclose(fileID);

%% Make Figure

    figure('Position', [50 50 960 735],'Color','white');
    l_plot = loglog(y,v_dist_l_plot,'-*','MarkerSize',10,'Color','r');
    
    ax = gca;
    xtickformat('%.2f')
    xticks([0 1 5 10 50 100 150])
    set(gca,'xTickLabel', char('0','1','5','10','50','100','150'))
    ytickformat('%.3f')
    yticks([0 0.02 0.05 0.1 0.2 0.5 1 1.5])
    set(gca,'YTickLabel', char('0.00','0.02','0.05','0.10','0.20','0.50','1.00','1.50'))

    ax.XAxisLocation = 'bottom';
    ax.YDir='normal';
    ax.YAxisLocation = 'left';
    ax.XColor = 'black';
    ax.YColor = 'black';
    ax.XScale = 'log';
    ax.YScale = 'log';
    ax.XLim = [1 10];
    ax.YLim = [0.2 1.0];
    ax.FontSize = 30;
    ax.FontName =  'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlabel('\it \fontname{Times New Roman}y/d');
    ylabel('\it \fontname{Times New Roman}v/U_{0}');
    hold on

    r_plot = loglog(y,v_dist_r_plot,'-^','MarkerSize',10,'Color','b');
    hold on
    
%     loglog(y,U0*(y.^-1)*0.32,'--','MarkerSize',20,'LineWidth',3,'Color','k') % 400 L/min
    loglog(y,U0*(y.^-1)*0.282,'--','MarkerSize',20,'LineWidth',3,'Color','k') % 400 L/min
%     loglog(y,U0*(y.^-1)*0.254,'--','MarkerSize',20,'LineWidth',3,'Color','k') % 500 L/min
    legend([l_plot r_plot], {'left','right'},'FontSize',30,'Location','southwest')
    hold off
    pbaspect([sqrt(2) 1 1]);
