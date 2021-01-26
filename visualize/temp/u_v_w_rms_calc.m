    clc
    clear all
    close all

%% Parameters 1
    date=20190823;
    cond=10;
    savedirectory='C:/Users/yatagi/Desktop/';

    for num=1:1:cond

        file_u=sprintf('G:/Analysis/piv_output/velofield/%d/spiv_fbsc_%02u_ucl.dat',date,num);
        file_v=sprintf('G:/Analysis/piv_output/velofield/%d/spiv_fbsc_%02u_vcl.dat',date,num);
        file_w=sprintf('G:/Analysis/piv_output/velofield/%d/spiv_fbsc_%02u_wcl.dat',date,num);

%% Parameters 2
        nx=191;
        ny=121;
        ny_calc=98; % ATTENTION, CUT
        ny_start=4;
        deal_start_frame=1;
        deal_end_frame=21838;

        vec_spc_x=8;
        vec_spc_y=8;
        img_res_x=80*10^(-3);
        img_res_y=75*10^(-3);
        Fs_spiv=20e3;

%% Matrix
        Sts_spiv = 1/Fs_spiv;    % [sec]
        Pixels=nx*ny;
        X=img_res_x*vec_spc_x;
        Y=img_res_y*vec_spc_y;
        dx=img_res_x*vec_spc_x*10^-3;
        dy=img_res_y*vec_spc_y*10^-3;
        xmin=-(0.5*(nx-1))*X+X;
        xmax=0.5*(nx-1)*X+X;
        ymin=Y*(ny-(ny_start+ny_calc)); % ATTENTION, CUT
        ymax=Y*(ny-ny_start-1); % ATTENTION, CUT
        wx=zeros(2,1);
        wy=zeros(2,1);
        u=zeros(nx,ny_calc);
        N=[nx ny];

%% Decide Axes
        for i=1:nx
            x(i,:)=xmin+X*(i-1)+X;
        end

        for i=1:ny_calc
            y(i,:)=ymax-Y*(i-1);
        end

        y=sort(y);

        wx(1,1)=xmin;
        wx(2,1)=xmax;
        wy(1,1)=ymin;
        wy(2,1)=ymax;

%% READ & CALC
        tic

        fid=fopen(sprintf(file_u),'r');
        fseek(fid,(deal_start_frame-1)*Pixels*8,'bof');
        for idx=1:1:deal_end_frame-deal_start_frame+1
            I=(fread(fid,Pixels,'double'));
            u=permute(reshape(I,N),[2 1]);
            udat(:,:,idx)=u(ny_start:ny_start+ny_calc-1,1:nx);
        end
        fclose(fid);

        for j=1:ny_calc
          for i=1:nx
              uprms(j,i)=sqrt((sum((udat(j,i,:)-mean(udat(j,i,:))).^2))/(deal_end_frame-deal_start_frame+1));
          end
        end

        fid=fopen(sprintf(file_v),'r');
        fseek(fid,(deal_start_frame-1)*Pixels*8,'bof');
        for idx=1:1:deal_end_frame-deal_start_frame+1
            I=(fread(fid,Pixels,'double'));
            u=permute(reshape(I,N),[2 1]);
            udat(:,:,idx)=u(ny_start:ny_start+ny_calc-1,1:nx);
        end
        fclose(fid);

        for j=1:ny_calc
          for i=1:nx
              vprms(j,i)=sqrt((sum((udat(j,i,:)-mean(udat(j,i,:))).^2))/(deal_end_frame-deal_start_frame+1));
          end
        end

        fid=fopen(sprintf(file_w),'r');
        fseek(fid,(deal_start_frame-1)*Pixels*8,'bof');
        for idx=1:1:deal_end_frame-deal_start_frame+1
            I=(fread(fid,Pixels,'double'));
            u=permute(reshape(I,N),[2 1]);
            udat(:,:,idx)=u(ny_start:ny_start+ny_calc-1,1:nx);
        end
        fclose(fid);

        for j=1:ny_calc
          for i=1:nx
              wprms(j,i)=sqrt((sum((udat(j,i,:)-mean(udat(j,i,:))).^2))/(deal_end_frame-deal_start_frame+1));
          end
        end

        rms_dist=sqrt((uprms.^2+vprms.^2+wprms.^2)/3);
        fileID=fopen(strcat(savedirectory,'uprimerms_',num2str(date),'_',num2str(num),'.dat'),'w');
        fwrite(fileID,rms_dist,'double');
        fclose(fileID);
        toc

%% MAKE FIGURE
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

        ax=gca;
        IMAGE=imagesc(wx,wy,rms_dist(:,:),[0 5]);
        colormap(ax,jet)
        xtickformat('%.2f')
        xticks([-60 -40 -20 0 20 40 60])
        set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

        ytickformat('%.2f')
        yticks([ymin ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4', 'ymin' is actually 'ymax-58.6'
        set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))
        % yticks([ymax-60 ymax-50 ymax-40 ymax-30 ymax-20 ymax-10 ymax])
        % set(gca,'YTickLabel', char('60','50','40','30','20','10','0'))

        c=colorbar;
        c.Ticks=[0 2.5 5];
        c.TickLabels={'0.0','2.5','5.0'};
        c.TickLabelInterpreter='latex';
        c.Label.FontSize = 25;
        c.Label.String = '\it \fontname{Times New Roman} u''_{rms} \rm[m/s]';
        c.Location = 'eastoutside';
        c.AxisLocation='out';

        xlabel('\it \fontname{Times New Roman} x \rm[mm]')
        ylabel('\it \fontname{Times New Roman} y \rm[mm]')
        set(gca,'FontName','Times New Roman','FontSize',25)
        xlim([-60 60])
        ylim([ymin ymax])
        % ylim([0 ymax])

        saveas(gcf,strcat(savedirectory,strcat('uprimerms_',num2str(date),'_',num2str(num),'.png')))
        close;

    end
