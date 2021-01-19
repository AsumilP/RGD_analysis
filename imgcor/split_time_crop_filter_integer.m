    clear all
    close all
    clc

%% Parameters 1

    date=20190820;
    num=2;

    dir=sprintf('D:/plif_output/%d/plif_med/',date);
    filename=sprintf('D:/plif_output/%d/plif_med/plif_%02u_med',num);
    dataex='.dat';

%% Parameters 2

    nx_start=1;
    nx_end=1024;
    ny_start=1;
    ny_end=1024;
    nz_start=1;
    nz_end=1024;
    name_start=1;

%% Parameters 3

    nx= 1024;
    ny= 1024;
    nzall= 21839;

%% fseek

    fid1 = fopen(sprintf(filename),'r');
    fseek(fid1,(nz_start-1)*nx*ny*2,'bof');

%% Filtering

    I=fread(fid1,nx*ny,'uint16');
    ImageData=permute(reshape(I,[nx,ny]),[2 1]);
    imagecrop=ImageData(1:origin_height_px+origin_y,1:2*origin_x);


            imagecrop=ImageData(1:origin_height_px+origin_y,1:2*origin_x);

            pos1 = [0.10 0.37 0.80 0.60]; % left bottom width height
            subplot('Position',pos1)
            IMAGE = imagesc(wx,wy,imagecrop(:,:),[0 col_max]);
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
            fseek(fid1,skip_frame*nx*ny*2,'cof');

            pos2 = [0.10 0.15 0.80 0.10];
            subplot('Position',pos2)
            plot(taxis,K,'k')

            ax = gca;
            xtickformat('%.2f')
            xticks([calc_start_time-1 calc_start_time-0.5 calc_start_time calc_start_time+0.5 calc_start_time+1.0 calc_start_time+1.5 calc_start_time+2.0])
            set(gca,'xTickLabel', char('-1.0','-0.5','0.0','0.5','1.0','1.5','2.0'))
            ytickformat('%.3f')
            yticks([-0.50 -0.25 0 0.25 0.50])
            set(gca,'YTickLabel', char('-0.50','-0.25','0.00','0.25','0.50'))

            xlim([calc_start_time-0.5 calc_start_time+1.0]);
            ylim([-0.50 0.50]);

            xlabel('\it \fontname{Times New Roman} t \rm[sec]')
            ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
            set(gca,'FontName','Times New Roman','FontSize',15)
            hold on

            plot([calc_start_time calc_start_time],[-0.50 0.50],'m--','LineWidth',2.0)
            hold on

            plot([calc_fin_time calc_fin_time],[-0.50 0.50],'m--','LineWidth',2.0)
            hold on

            plot([chem_vis_start_time+Sts_chem*(idx-1)*(skip_frame+1) chem_vis_start_time+Sts_chem*(idx-1)*(skip_frame+1)],[-0.50 0.50],'b-','LineWidth',2.0)
            hold off

            frame = getframe(fig);
            im{idx}=frame2im(frame);

        end
        fclose(fid1);
        close;

        for idx=1:1:frames
              [A,map]= rgb2ind(im{idx},256);
            if idx == 1
                  imwrite(A,map,gifname,'gif','LoopCount',Inf,'DelayTime',0.1);
            else
                  imwrite(A,map,gifname,'gif','WriteMode','append','DelayTime',0.1);
            end
        end
