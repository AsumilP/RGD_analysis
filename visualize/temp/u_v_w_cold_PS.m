    clc
    clear all
    close all

%% Parameters

    date=20190825;
    num=4;
%     calc_fft_x_px=95; %[px]
    calc_fft_y_px=50; %[px]
    first_frame=1; %cold 1
    end_frame=21838; %cold 21838

    file_u_cold=sprintf('G:/piv_output/velofield/%d/spiv_fbsc_%02u_ucl.dat',date,num);
    file_v_cold=sprintf('G:/piv_output/velofield/%d/spiv_fbsc_%02u_vcl.dat',date,num);
    file_w_cold=sprintf('G:/piv_output/velofield/%d/spiv_fbsc_%02u_wcl.dat',date,num);

    for z=73:1:118
        calc_fft_x_px=z;
            
%% Parameters 2

        nx = 191;
        ny = 121;
        nz = end_frame-first_frame+1;
        vec_spc_x = 8;
        vec_spc_y = 8;
        img_res_x = 80*10^(-3);
        img_res_y = 75*10^(-3);
        Fs_spiv= 20e3;
        Pixels=nx*ny;
        X=img_res_x*vec_spc_x;
        Y=img_res_y*vec_spc_y;
        xmin=-(0.5*(nx-1))*X+X;
        ymax=Y*116; % ATTENTION, CUT
        N=[nx ny];
        wx(1,1)=1;
        wx(2,1)=nx;
        wy(1,1)=1;
        wy(2,1)=ny;

%% Parameters 3

        div_fft = 1;  % cold 1 times
        nz_calc = floor(nz/div_fft);  % data for fft
        calc_fft_x=xmin+X*(calc_fft_x_px-1)+X %[mm]
        calc_fft_y=ymax-Y*(calc_fft_y_px-1) %[mm]

        file_uPS_cold=sprintf('G:/piv_output/PS_cold/%d/spiv_uPS_%02u_%+02.2f_%+02.2f_b.dat',date,num,calc_fft_x,calc_fft_y);
        file_vPS_cold=sprintf('G:/piv_output/PS_cold/%d/spiv_vPS_%02u_%+02.2f_%+02.2f_b.dat',date,num,calc_fft_x,calc_fft_y);
        file_wPS_cold=sprintf('G:/piv_output/PS_cold/%d/spiv_wPS_%02u_%+02.2f_%+02.2f_b.dat',date,num,calc_fft_x,calc_fft_y);
        filename_faxis=sprintf('G:/piv_output/PS_cold/%d/spiv_faxis_cold.dat',date);

%% Read

        fid=fopen(file_u_cold,'r');
        fseek(fid,(first_frame-1)*Pixels*8,'bof');
        for i=1:1:nz
            I=(fread(fid,Pixels,'double'));
            u=permute(reshape(I,N),[2 1]);
            u_dat(i)=u(calc_fft_y_px,calc_fft_x_px);
        end
        fclose(fid);

        fid=fopen(file_v_cold,'r');
        fseek(fid,(first_frame-1)*Pixels*8,'bof');
        for i=1:1:nz
            I=(fread(fid,Pixels,'double'));
            v=permute(reshape(I,N),[2 1]);
            v_dat(i)=v(calc_fft_y_px,calc_fft_x_px);
        end
        fclose(fid);

        fid=fopen(file_w_cold,'r');
        fseek(fid,(first_frame-1)*Pixels*8,'bof');
        for i=1:1:nz
            I=(fread(fid,Pixels,'double'));
            w=permute(reshape(I,N),[2 1]);
            w_dat(i)=w(calc_fft_y_px,calc_fft_x_px);
        end
        fclose(fid);

%% Coordinates Confirmation

        v(calc_fft_y_px,calc_fft_x_px)=30;

        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

        pos1 = [0.10 0.37 0.83 0.60]; % left bottom width height
        subplot('Position',pos1)
        ax=gca;
        IMAGE = imagesc(wx,wy,v(:,:),[-30 30]);
        colormap(ax,jet)
        xtickformat('%2.0d')
        ytickformat('%2.0d')

        c=colorbar;
        c.Ticks=[-30 0.0 30];
        c.TickLabels={'-30','0','30'};
        c.TickLabelInterpreter='latex';
        c.Label.FontSize = 25;
        c.Label.String = '\it \fontname{Times New Roman} CHECK';
        c.Location = 'eastoutside';
        c.AxisLocation='out';

        ax = gca;
        xlabel('\it \fontname{Times New Roman} nx \rm[px]')
        ylabel('\it \fontname{Times New Roman} ny \rm[px]')
        set(gca,'FontName','Times New Roman','FontSize',25)
        xlim([1 nx]);
        ylim([1 ny]);

%% divide by div_fft, calc fft

        [ps_u, faxis_u] = fft_meanspec_sqrt2(u_dat,nz_calc,Fs_spiv,nz_calc);
        [ps_v, faxis_v] = fft_meanspec_sqrt2(v_dat,nz_calc,Fs_spiv,nz_calc);
        [ps_w, faxis_w] = fft_meanspec_sqrt2(w_dat,nz_calc,Fs_spiv,nz_calc);

        fileID=fopen(file_uPS_cold,'w');
        fwrite(fileID,ps_u,'double');
        fclose(fileID);

        fileID=fopen(file_vPS_cold,'w');
        fwrite(fileID,ps_v,'double');
        fclose(fileID);

        fileID=fopen(file_wPS_cold,'w');
        fwrite(fileID,ps_w,'double');
        fclose(fileID);

        fileID=fopen(filename_faxis,'w');
        fwrite(fileID,faxis_u,'double');
        fclose(fileID);

%% PS MAKE FIGURE

        figure('Position', [50 50 960 735],'Color','white');
        loglog(faxis_u,ps_u,'-o','MarkerSize',10,'Color','r')

        ax = gca;
        xtickformat('%.2f')
        xticks([1 10 100])
        set(gca,'xTickLabel', char('10^{0}','10^{1}','10^{2}'))
        ytickformat('%.3f')
        yticks([0.1 10 1000 100000])
        set(gca,'YTickLabel', char('10^{-1}','10^{1}','10^{3}','10^{5}'))

        ax.XAxisLocation = 'bottom';
        ax.YDir='normal';
        ax.YAxisLocation = 'left';
        ax.XColor = 'black';
        ax.YColor = 'black';
        ax.XScale = 'log';
        ax.YScale = 'log';
        ax.XLim = [10 300];
        ax.YLim = [10^-1 10^5];
        ax.FontSize = 30;
        ax.FontName =  'Times New Roman';
        ax.TitleFontSizeMultiplier = 2;
        ax.Box = 'on';
        ax.LineWidth = 2.0;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';

        xlabel('\it \fontname{Times New Roman}f \rm[Hz]');
        ylabel('\it \fontname{Times New Roman}P \rm[m/s]');
        hold on

        loglog(faxis_v,ps_v,'-^','MarkerSize',10,'Color','b')
        hold on

        loglog(faxis_v,ps_v,'-v','MarkerSize',10,'Color','k')
        legend('u','v','w','FontSize',23)
        hold off
        pbaspect([sqrt(2) 1 1]);
        
    end
