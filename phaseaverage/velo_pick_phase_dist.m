function velo_pick_phase_dist(dir_i,fn_ui,fn_vi,fn_wi,dir_o,fn_uav,fn_vav,...
         fn_wav,fn_fav,locs,cam_start_data,before_transition_data,calc_start_time,...
         calc_data,nx,ny,ny_calc,cnt_st1,cnt_st2,cnt_st3,cnt_st4,cnt_st5,cnt_st6,...
         cnt_st7,cnt_st8,cnt_st9,cnt_st10,vissw,svsw,nincrement,dx,dy,wmin,wmax,...
         quivermode,dir_f)

  meantempu1=zeros(ny_calc,nx);
  meantempu2=zeros(ny_calc,nx);
  meantempu3=zeros(ny_calc,nx);
  meantempu4=zeros(ny_calc,nx);
  meantempu5=zeros(ny_calc,nx);
  meantempu6=zeros(ny_calc,nx);
  meantempu7=zeros(ny_calc,nx);
  meantempu8=zeros(ny_calc,nx);
  meantempu9=zeros(ny_calc,nx);
  meantempu10=zeros(ny_calc,nx);
  meantempv1=zeros(ny_calc,nx);
  meantempv2=zeros(ny_calc,nx);
  meantempv3=zeros(ny_calc,nx);
  meantempv4=zeros(ny_calc,nx);
  meantempv5=zeros(ny_calc,nx);
  meantempv6=zeros(ny_calc,nx);
  meantempv7=zeros(ny_calc,nx);
  meantempv8=zeros(ny_calc,nx);
  meantempv9=zeros(ny_calc,nx);
  meantempv10=zeros(ny_calc,nx);
  meantempw1=zeros(ny_calc,nx);
  meantempw2=zeros(ny_calc,nx);
  meantempw3=zeros(ny_calc,nx);
  meantempw4=zeros(ny_calc,nx);
  meantempw5=zeros(ny_calc,nx);
  meantempw6=zeros(ny_calc,nx);
  meantempw7=zeros(ny_calc,nx);
  meantempw8=zeros(ny_calc,nx);
  meantempw9=zeros(ny_calc,nx);
  meantempw10=zeros(ny_calc,nx);
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

  for t=1:length(locs)
    if (locs(t)-cam_start_data >before_transition_data) && (locs(t)-cam_start_data <= before_transition_data+calc_data)

      fid=fopen(strcat(dir_i,fn_ui),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      u=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_vi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      v=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_wi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      w=image(ny_start:ny_end,:);
      fclose(fid);

      nn1=nn1+1;
      meantempu1(:,:) = meantempu1(:,:) + u(:,:);
      meantempv1(:,:) = meantempv1(:,:) + v(:,:);
      meantempw1(:,:) = meantempw1(:,:) + w(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        squiver(up,-vp,wp,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                dx,dy,wmin,wmax,quivermode)

        saveas(gcf,strcat(dir_f,fn_fav,'_0-0.1T_',num2str(cnt_st1+nn1-1),'.png'))
        close;
      end

      if svsw == 1
        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        fileID=fopen(strcat(dir_f,fn_uav,'_0-0.1T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,up,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_vav,'_0-0.1T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,vp,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_wav,'_0-0.1T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,wp,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+calc_data) && (locs(t)-cam_start_data <= before_transition_data+2*calc_data)

      fid=fopen(strcat(dir_i,fn_ui),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      u=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_vi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      v=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_wi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      w=image(ny_start:ny_end,:);
      fclose(fid);

      nn2=nn2+1;
      meantempu2(:,:) = meantempu2(:,:) + u(:,:);
      meantempv2(:,:) = meantempv2(:,:) + v(:,:);
      meantempw2(:,:) = meantempw2(:,:) + w(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        squiver(up,-vp,wp,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                dx,dy,wmin,wmax,quivermode)

        saveas(gcf,strcat(dir_f,fn_fav,'_0.1T-0.2T_',num2str(cnt_st1+nn1-1),'.png'))
        close;
      end

      if svsw == 1
        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        fileID=fopen(strcat(dir_f,fn_uav,'_0.1T-0.2T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,up,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_vav,'_0.1T-0.2T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,vp,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_wav,'_0.1T-0.2T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,wp,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+2*calc_data) && (locs(t)-cam_start_data <= before_transition_data+3*calc_data)

      fid=fopen(strcat(dir_i,fn_ui),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      u=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_vi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      v=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_wi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      w=image(ny_start:ny_end,:);
      fclose(fid);

      nn3=nn3+1;
      meantempu3(:,:) = meantempu3(:,:) + u(:,:);
      meantempv3(:,:) = meantempv3(:,:) + v(:,:);
      meantempw3(:,:) = meantempw3(:,:) + w(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        squiver(up,-vp,wp,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                dx,dy,wmin,wmax,quivermode)

        saveas(gcf,strcat(dir_f,fn_fav,'_0.2T-0.3T_',num2str(cnt_st1+nn1-1),'.png'))
        close;
      end

      if svsw == 1
        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        fileID=fopen(strcat(dir_f,fn_uav,'_0.2T-0.3T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,up,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_vav,'_0.2T-0.3T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,vp,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_wav,'_0.2T-0.3T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,wp,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+3*calc_data) && (locs(t)-cam_start_data <= before_transition_data+4*calc_data)

      fid=fopen(strcat(dir_i,fn_ui),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      u=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_vi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      v=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_wi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      w=image(ny_start:ny_end,:);
      fclose(fid);

      nn4=nn4+1;
      meantempu4(:,:) = meantempu4(:,:) + u(:,:);
      meantempv4(:,:) = meantempv4(:,:) + v(:,:);
      meantempw4(:,:) = meantempw4(:,:) + w(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        squiver(up,-vp,wp,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                dx,dy,wmin,wmax,quivermode)

        saveas(gcf,strcat(dir_f,fn_fav,'_0.3T-0.4T_',num2str(cnt_st1+nn1-1),'.png'))
        close;
      end

      if svsw == 1
        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        fileID=fopen(strcat(dir_f,fn_uav,'_0.3T-0.4T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,up,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_vav,'_0.3T-0.4T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,vp,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_wav,'_0.3T-0.4T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,wp,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+4*calc_data) && (locs(t)-cam_start_data <= before_transition_data+5*calc_data)

      fid=fopen(strcat(dir_i,fn_ui),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      u=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_vi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      v=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_wi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      w=image(ny_start:ny_end,:);
      fclose(fid);

      nn5=nn5+1;
      meantempu5(:,:) = meantempu5(:,:) + u(:,:);
      meantempv5(:,:) = meantempv5(:,:) + v(:,:);
      meantempw5(:,:) = meantempw5(:,:) + w(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        squiver(up,-vp,wp,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                dx,dy,wmin,wmax,quivermode)

        saveas(gcf,strcat(dir_f,fn_fav,'_0.4T-0.5T_',num2str(cnt_st1+nn1-1),'.png'))
        close;
      end

      if svsw == 1
        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        fileID=fopen(strcat(dir_f,fn_uav,'_0.4T-0.5T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,up,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_vav,'_0.4T-0.5T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,vp,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_wav,'_0.4T-0.5T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,wp,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+5*calc_data) && (locs(t)-cam_start_data <= before_transition_data+6*calc_data)

      fid=fopen(strcat(dir_i,fn_ui),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      u=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_vi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      v=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_wi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      w=image(ny_start:ny_end,:);
      fclose(fid);

      nn6=nn6+1;
      meantempu6(:,:) = meantempu6(:,:) + u(:,:);
      meantempv6(:,:) = meantempv6(:,:) + v(:,:);
      meantempw6(:,:) = meantempw6(:,:) + w(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        squiver(up,-vp,wp,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                dx,dy,wmin,wmax,quivermode)

        saveas(gcf,strcat(dir_f,fn_fav,'_0.5T-0.6T_',num2str(cnt_st1+nn1-1),'.png'))
        close;
      end

      if svsw == 1
        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        fileID=fopen(strcat(dir_f,fn_uav,'_0.5T-0.6T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,up,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_vav,'_0.5T-0.6T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,vp,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_wav,'_0.5T-0.6T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,wp,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+6*calc_data) && (locs(t)-cam_start_data <= before_transition_data+7*calc_data)

      fid=fopen(strcat(dir_i,fn_ui),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      u=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_vi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      v=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_wi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      w=image(ny_start:ny_end,:);
      fclose(fid);

      nn7=nn7+1;
      meantempu7(:,:) = meantempu7(:,:) + u(:,:);
      meantempv7(:,:) = meantempv7(:,:) + v(:,:);
      meantempw7(:,:) = meantempw7(:,:) + w(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        squiver(up,-vp,wp,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                dx,dy,wmin,wmax,quivermode)

        saveas(gcf,strcat(dir_f,fn_fav,'_0.6T-0.7T_',num2str(cnt_st1+nn1-1),'.png'))
        close;
      end

      if svsw == 1
        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        fileID=fopen(strcat(dir_f,fn_uav,'_0.6T-0.7T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,up,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_vav,'_0.6T-0.7T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,vp,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_wav,'_0.6T-0.7T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,wp,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+7*calc_data) && (locs(t)-cam_start_data <= before_transition_data+8*calc_data)

      fid=fopen(strcat(dir_i,fn_ui),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      u=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_vi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      v=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_wi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      w=image(ny_start:ny_end,:);
      fclose(fid);

      nn8=nn8+1;
      meantempu8(:,:) = meantempu8(:,:) + u(:,:);
      meantempv8(:,:) = meantempv8(:,:) + v(:,:);
      meantempw8(:,:) = meantempw8(:,:) + w(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        squiver(up,-vp,wp,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                dx,dy,wmin,wmax,quivermode)

        saveas(gcf,strcat(dir_f,fn_fav,'_0.7T-0.8T_',num2str(cnt_st1+nn1-1),'.png'))
        close;
      end

      if svsw == 1
        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        fileID=fopen(strcat(dir_f,fn_uav,'_0.7T-0.8T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,up,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_vav,'_0.7T-0.8T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,vp,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_wav,'_0.7T-0.8T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,wp,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+8*calc_data) && (locs(t)-cam_start_data <= before_transition_data+9*calc_data)

      fid=fopen(strcat(dir_i,fn_ui),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      u=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_vi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      v=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_wi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      w=image(ny_start:ny_end,:);
      fclose(fid);

      nn9=nn9+1;
      meantempu9(:,:) = meantempu9(:,:) + u(:,:);
      meantempv9(:,:) = meantempv9(:,:) + v(:,:);
      meantempw9(:,:) = meantempw9(:,:) + w(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        squiver(up,-vp,wp,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                dx,dy,wmin,wmax,quivermode)

        saveas(gcf,strcat(dir_f,fn_fav,'_0.8T-0.9T_',num2str(cnt_st1+nn1-1),'.png'))
        close;
      end

      if svsw == 1
        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        fileID=fopen(strcat(dir_f,fn_uav,'_0.8T-0.9T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,up,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_vav,'_0.8T-0.9T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,vp,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_wav,'_0.8T-0.9T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,wp,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+9*calc_data) && (locs(t)-cam_start_data <= before_transition_data+10*calc_data)

      fid=fopen(strcat(dir_i,fn_ui),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      u=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_vi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      v=image(ny_start:ny_end,:);
      fclose(fid);

      fid=fopen(strcat(dir_i,fn_wi),'r');
      skip_frames(fid,locs(t)-cam_start_data,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      w=image(ny_start:ny_end,:);
      fclose(fid);

      nn10=nn10+1;
      meantempu10(:,:) = meantempu10(:,:) + u(:,:);
      meantempv10(:,:) = meantempv10(:,:) + v(:,:);
      meantempw10(:,:) = meantempw10(:,:) + w(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800*(1+sqrt(5))/2 800];

        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        squiver(up,-vp,wp,nx,ny_calc,1,nx,1,ny_calc,nincrement,...
                dx,dy,wmin,wmax,quivermode)

        saveas(gcf,strcat(dir_f,fn_fav,'_0.9T-T_',num2str(cnt_st1+nn1-1),'.png'))
        close;
      end

      if svsw == 1
        up=reshape(u,[nx*ny_calc 1]);
        vp=reshape(v,[nx*ny_calc 1]);
        wp=reshape(w,[nx*ny_calc 1]);

        fileID=fopen(strcat(dir_f,fn_uav,'_0.9T-T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,up,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_vav,'_0.9T-T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,vp,'double');
        fclose(fileID);

        fileID=fopen(strcat(dir_f,fn_wav,'_0.9T-T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,wp,'double');
        fclose(fileID);
      end

    end
  end

  nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
  avtemp1st=meantempu1/nn1;
  avtemp2nd=meantempu2/nn2;
  avtemp3rd=meantempu3/nn3;
  avtemp4th=meantempu4/nn4;
  avtemp5th=meantempu5/nn5;
  avtemp6th=meantempu6/nn6;
  avtemp7th=meantempu7/nn7;
  avtemp8th=meantempu8/nn8;
  avtemp9th=meantempu9/nn9;
  avtemp10th=meantempu10/nn10;

  saveav=cat(3,avtemp1st,avtemp2nd,avtemp3rd,avtemp4th,avtemp5th,avtemp6th,avtemp7th,avtemp8th,avtemp9th,avtemp10th);

  fileID=fopen(strcat(dir_o,fn_uav,'.dat'),'w');
  fwrite(fileID,saveav,'double');
  fclose(fileID);

  avtemp1st=meantempv1/nn1;
  avtemp2nd=meantempv2/nn2;
  avtemp3rd=meantempv3/nn3;
  avtemp4th=meantempv4/nn4;
  avtemp5th=meantempv5/nn5;
  avtemp6th=meantempv6/nn6;
  avtemp7th=meantempv7/nn7;
  avtemp8th=meantempv8/nn8;
  avtemp9th=meantempv9/nn9;
  avtemp10th=meantempv10/nn10;

  saveav=cat(3,avtemp1st,avtemp2nd,avtemp3rd,avtemp4th,avtemp5th,avtemp6th,avtemp7th,avtemp8th,avtemp9th,avtemp10th);

  fileID=fopen(strcat(dir_o,fn_vav,'.dat'),'w');
  fwrite(fileID,saveav,'double');
  fclose(fileID);

  avtemp1st=meantempw1/nn1;
  avtemp2nd=meantempw2/nn2;
  avtemp3rd=meantempw3/nn3;
  avtemp4th=meantempw4/nn4;
  avtemp5th=meantempw5/nn5;
  avtemp6th=meantempw6/nn6;
  avtemp7th=meantempw7/nn7;
  avtemp8th=meantempw8/nn8;
  avtemp9th=meantempw9/nn9;
  avtemp10th=meantempw10/nn10;

  saveav=cat(3,avtemp1st,avtemp2nd,avtemp3rd,avtemp4th,avtemp5th,avtemp6th,avtemp7th,avtemp8th,avtemp9th,avtemp10th);

  fileID=fopen(strcat(dir_o,fn_wav,'.dat'),'w');
  fwrite(fileID,saveav,'double');
  fclose(fileID);

end
