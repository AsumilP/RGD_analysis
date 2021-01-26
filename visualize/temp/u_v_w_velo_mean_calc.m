    clc
    clear all
    close all

%% Parameters 1

    trig_time = 3.495;
    avrg_start_time = 2.4032; % (cam_start_time), (trans_start_time), (trans_fin_time)
    avrg_fin_time = 2.9297; % (trig_time, trans_start_time), (trans_fin_time), (trig_time)  

    nincrement=3;

    file_u='E:/piv_output/velofield/20190823/spiv_fbsc_10_ucl.dat';
    file_v='E:/piv_output/velofield/20190823/spiv_fbsc_10_vcl.dat';
    file_w='E:/piv_output/velofield/20190823/spiv_fbsc_10_wcl.dat';

    file_umean='C:/Users/atagi/Desktop/modified/velomeanfield/400_bmean_u_20190823_10.dat';
    file_vmean='C:/Users/atagi/Desktop/modified/velomeanfield/400_bmean_v_20190823_10.dat';
    file_wmean='C:/Users/atagi/Desktop/modified/velomeanfield/400_bmean_w_20190823_10.dat';

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

%% Matrix

    Sts_spiv = 1/Fs_spiv;    % [sec]
    Pixels=nx*ny;
    cam_start_time = trig_time - Sts_spiv*nzall
    skip_frame = floor((cam_start_time - avrg_start_time)/Sts_spiv)
    calc_frame = floor((avrg_fin_time - avrg_start_time)/Sts_spiv)

     X=img_res_x*vec_spc_x;
     Y=img_res_y*vec_spc_y;
     xmin=-(0.5*(nx-1))*X+X;
     xmax=0.5*(nx-1)*X+X;
     ymin=Y*19; % ATTENTION, CUT
     ymax=Y*116; % ATTENTION, CUT
     wx=zeros(2,1);
     wy=zeros(2,1);
     
     velo=zeros(nx,ny);
     N=[nx ny];

%% Decide Axes
        
     for i=1:floor(nx/nincrement)
         x(i,:)= xmin+X*nincrement*(i-1)+X;
     end

     for i=1:floor(ny_calc/nincrement)
         y(i,:)=ymax-Y*nincrement*(i-1);
     end
    
     y=sort(y);

     wx(1,1)=xmin;
     wx(2,1)=xmax;
     wy(1,1)=ymin;
     wy(2,1)=ymax;

%% Calculation, MEAN
%u
      fid = fopen(sprintf(file_u),'r');
      fseek(fid,(skip_frame)*Pixels*8,'bof');
      
      umeantemp=zeros(ny_calc,nx);
      for idx=1:1:calc_frame
         I=(fread(fid,Pixels,'double'));
         velo=reshape(I,N);
         velo=permute(reshape(velo,[nx,ny]),[2 1]);
         
         umeantemp(:,:)=umeantemp(:,:)+velo(4:101,:)/calc_frame; % ATTENTION, CUT
      end
      
      fclose(fid);
            
      fileID=fopen(file_umean,'w');
      fwrite(fileID,umeantemp,'double');
      fclose(fileID);
      
%v
      fid = fopen(sprintf(file_v),'r');
      fseek(fid,(skip_frame)*Pixels*8,'bof');
      
      vmeantemp=zeros(ny_calc,nx);
      for idx=1:1:calc_frame
         I=(fread(fid,Pixels,'double'));
         velo=reshape(I,N);
         velo=permute(reshape(velo,[nx,ny]),[2 1]);
         
         vmeantemp(:,:)=vmeantemp(:,:)+velo(4:101,:)/calc_frame; % ATTENTION, CUT
      end
      
      fclose(fid);
            
      fileID=fopen(file_vmean,'w');
      fwrite(fileID,vmeantemp,'double');
      fclose(fileID);
      
 %w
      fid = fopen(sprintf(file_w),'r');
      fseek(fid,(skip_frame)*Pixels*8,'bof');
      
      wmeantemp=zeros(ny_calc,nx);
      for idx=1:1:calc_frame
         I=(fread(fid,Pixels,'double'));
         velo=reshape(I,N);
         velo=permute(reshape(velo,[nx,ny]),[2 1]);
         
         wmeantemp(:,:)=wmeantemp(:,:)+velo(4:101,:)/calc_frame; % ATTENTION, CUT
      end
      
      fclose(fid);
            
      fileID=fopen(file_wmean,'w');
      fwrite(fileID,wmeantemp,'double');
      fclose(fileID);
      
%% Visualize

      fig=figure;
      fig.Color='white';
      fig.Position=[1 1 800*(1+sqrt(5))/2 800];
      
      for j=1:floor(nx/nincrement)
            for i=1:floor(ny_calc/nincrement)
               uplot(i,j)= umeantemp(nincrement*(i-1)+1,nincrement*(j-1)+1);
               vplot(i,j)= vmeantemp(nincrement*(i-1)+1,nincrement*(j-1)+1);
            end
      end
        
      ax=gca;
      IMAGE = imagesc(wx,wy,wmeantemp(:,:),[-10 10]);
      load('MyColormap_for_w','mymap')
      colormap(ax,mymap)
      xtickformat('%.2f')
      xticks([-60 -40 -20 0 20 40 60])
      set(gca,'xTickLabel', char('-60','-40','-20','0','20','40','60'))

      ytickformat('%.2f')
      yticks([ymax-58.6 ymax-48.6 ymax-38.6 ymax-28.6 ymax-18.6 ymax-8.6 ymax]) %[ymax-t = ymin+t], 'ymax' is actually 'ymax+1.4'
      set(gca,'YTickLabel', char('70','60','50','40','30','20','10'))

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

      ncquiverref2(x,y,uplot(:,:),-vplot(:,:),'[m/s]','median','true','k','0');
      xlim([-60 60])
      ylim([ymax-58.6 ymax])
      hold off
      