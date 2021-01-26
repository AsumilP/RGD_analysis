    clc
    clear all
    close all

%% Parameters 1

    nincrement=2;
    first_frame=1;      %select the first frame
    frames=5000;         %time steps
    skip_frame = 0; %the number of skip frame

    file_u='D:/Dropbox/left_behind/20190825/spiv_fbsc_02_ucl.dat';
    file_v='D:/Dropbox/left_behind/20190825/spiv_fbsc_02_vcl.dat';
    file_w='D:/Dropbox/left_behind/20190825/spiv_fbsc_02_wcl.dat';

    gifname='./spiv_20190825_02_1-5000.gif';  %convert into, under the same directory

%% Parameters 2

    nx = 191;
    ny = 121;
    nzall = 21838;
    vec_spc_x = 8;
    vec_spc_y = 8;
    img_res_x = 80*10^(-3);
    img_res_y = 75*10^(-3);

%% Matrix

    Pixels=nx*ny;

    X=img_res_x*vec_spc_x;
    Y=img_res_y*vec_spc_y;
    u=zeros(nx,ny);
    v=zeros(nx,ny);
    w=zeros(nx,ny);
    N=[nx ny];
    xmin=-(0.5*(nx-1))*X+X;
    xmax=0.5*(nx-1)*X+X;
    ymin=Y;
    ymax=ny*Y;
    wx=zeros(2,1);
    wy=zeros(2,1);

%% Decide Axes

    for i=1:floor(nx/nincrement)
        x(i,:)= xmin+X*nincrement*(i-1)+X;
    end

    for i=1:floor(ny/nincrement)
        y(i,:)=ymax-Y*nincrement*(i-1);
    end
    
    y=sort(y);

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

        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

    for idx=1:1:frames

        I=(fread(fid1,Pixels,'double'));
        u=reshape(I,N);
        u=permute(reshape(u,[nx,ny]),[2 1]);
        fseek(fid1,skip_frame*Pixels*8,'cof');

        I=(fread(fid2,Pixels,'double'));
        v=reshape(I,N);
        v=permute(reshape(-v,[nx,ny]),[2 1]);
        fseek(fid2,skip_frame*Pixels*8,'cof');

        I=(fread(fid3,Pixels,'double'));
        w=reshape(I,N);
        w=permute(reshape(w,[nx,ny]),[2 1]);
        fseek(fid3,skip_frame*Pixels*8,'cof');

        for j=1:floor(nx/nincrement)
            for i=1:floor(ny/nincrement)
               uplot(i,j)= u(nincrement*(i-1)+1,nincrement*(j-1)+1);
               vplot(i,j)= v(nincrement*(i-1)+1,nincrement*(j-1)+1);
            end
        end

        ax=gca;
        IMAGE = imagesc(wx,wy,w(:,:),[-10 10]);
        load('MyColormap_for_w','mymap')
        colormap(ax,mymap)
        xtickformat('%.2f')
        xticks([-60 -40 -20 0 20 40 60])
        set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

        ytickformat('%.2f')
        yticks([ymax-70 ymax-60 ymax-50 ymax-40 ymax-30 ymax-20 ymax-10 ymax])
        set(gca,'YTickLabel', char('70','60','50','40','30','20','10','0'))

        c=colorbar;
        c.Ticks=[-10 -5  0 5 10];
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
        xlim([-60 60])
        ylim([0 ymax])
        hold off
        pbaspect([sqrt(2) 1 1]);

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
