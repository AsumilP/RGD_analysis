function velo_pick_phase_dist(dir_i,fn_ui,fn_vi,fn_wi,dir_o,fn_uav,fn_vav,...
         fn_wav,fn_fav,locs,cam_start_data,...
         before_transition_data,calc_start_time,calc_data,nx,ny,ny_calc,...
         cnt_st1,cnt_st2,cnt_st3,cnt_st4,cnt_st5,cnt_st6,cnt_st7,cnt_st8,...
         cnt_st9,cnt_st10,vissw,svsw,nincrement,...
                      dx,dy,wmin,wmax,quivermode,...
         origin_x,origin_y,origin_height,img_res_x,img_res_y,visx_start,...
         visx_end,visy_start,visy_end,col_min,col_max,vis,dir_f)

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

      fid = fopen(strcat(dir_i,fn_i),'r');
      skip_frames(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))+1,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      fclose(fid);

      nn4=nn4+1;
      meantemp4(:,:) = meantemp4(:,:) + image(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

        chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                         visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
        saveas(gcf,strcat(dir_f,fn_av,'_0.3T-0.4T_',num2str(cnt_st4+nn4-1),'.png'))
        close;
      end

      if svsw == 1
        fileID=fopen(strcat(dir_f,fn_av,'_0.3T-0.4T_',num2str(cnt_st4+nn4-1),'.dat'),'w');
        fwrite(fileID,I,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+4*calc_data) && (locs(t)-cam_start_data <= before_transition_data+5*calc_data)

      fid = fopen(strcat(dir_i,fn_i),'r');
      skip_frames(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))+1,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      fclose(fid);

      nn5=nn5+1;
      meantemp5(:,:) = meantemp5(:,:) + image(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

        chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                         visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
        saveas(gcf,strcat(dir_f,fn_av,'_0.4T-0.5T_',num2str(cnt_st5+nn5-1),'.png'))
        close;
      end

      if svsw == 1
        fileID=fopen(strcat(dir_f,fn_av,'_0.4T-0.5T_',num2str(cnt_st5+nn5-1),'.dat'),'w');
        fwrite(fileID,I,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+5*calc_data) && (locs(t)-cam_start_data <= before_transition_data+6*calc_data)

      fid = fopen(strcat(dir_i,fn_i),'r');
      skip_frames(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))+1,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      fclose(fid);

      nn6=nn6+1;
      meantemp6(:,:) = meantemp6(:,:) + image(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

        chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                         visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
        saveas(gcf,strcat(dir_f,fn_av,'_0.5T-0.6T_',num2str(cnt_st6+nn6-1),'.png'))
        close;
      end

      if svsw == 1
        fileID=fopen(strcat(dir_f,fn_av,'_0.5T-0.6T_',num2str(cnt_st6+nn6-1),'.dat'),'w');
        fwrite(fileID,I,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+6*calc_data) && (locs(t)-cam_start_data <= before_transition_data+7*calc_data)

      fid = fopen(strcat(dir_i,fn_i),'r');
      skip_frames(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))+1,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      fclose(fid);

      nn7=nn7+1;
      meantemp7(:,:) = meantemp7(:,:) + image(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

        chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                         visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
        saveas(gcf,strcat(dir_f,fn_av,'_0.6T-0.7T_',num2str(cnt_st7+nn7-1),'.png'))
        close;
      end

      if svsw == 1
        fileID=fopen(strcat(dir_f,fn_av,'_0.6T-0.7T_',num2str(cnt_st7+nn7-1),'.dat'),'w');
        fwrite(fileID,I,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+7*calc_data) && (locs(t)-cam_start_data <= before_transition_data+8*calc_data)

      fid = fopen(strcat(dir_i,fn_i),'r');
      skip_frames(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))+1,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      fclose(fid);

      nn8=nn8+1;
      meantemp8(:,:) = meantemp8(:,:) + image(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

        chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                         visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
        saveas(gcf,strcat(dir_f,fn_av,'_0.7T-0.8T_',num2str(cnt_st8+nn8-1),'.png'))
        close;
      end

      if svsw == 1
        fileID=fopen(strcat(dir_f,fn_av,'_0.7T-0.8T_',num2str(cnt_st8+nn8-1),'.dat'),'w');
        fwrite(fileID,I,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+8*calc_data) && (locs(t)-cam_start_data <= before_transition_data+9*calc_data)

      fid = fopen(strcat(dir_i,fn_i),'r');
      skip_frames(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))+1,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      fclose(fid);

      nn9=nn9+1;
      meantemp9(:,:) = meantemp9(:,:) + image(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

        chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                         visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
        saveas(gcf,strcat(dir_f,fn_av,'_0.8T-0.9T_',num2str(cnt_st9+nn9-1),'.png'))
        close;
      end

      if svsw == 1
        fileID=fopen(strcat(dir_f,fn_av,'_0.8T-0.9T_',num2str(cnt_st9+nn9-1),'.dat'),'w');
        fwrite(fileID,I,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+9*calc_data) && (locs(t)-cam_start_data <= before_transition_data+10*calc_data)

      fid = fopen(strcat(dir_i,fn_i),'r');
      skip_frames(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))+1,nx*ny,2,1);
      I=(fread(fid,nx*ny,'double'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      fclose(fid);

      nn10=nn10+1;
      meantemp10(:,:) = meantemp10(:,:) + image(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

        chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                         visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
        saveas(gcf,strcat(dir_f,fn_av,'_0.9T-T_',num2str(cnt_st10+nn10-1),'.png'))
        close;
      end

      if svsw == 1
        fileID=fopen(strcat(dir_f,fn_av,'_0.9T-T_',num2str(cnt_st10+nn10-1),'.dat'),'w');
        fwrite(fileID,I,'double');
        fclose(fileID);
      end

    end
  end

  nn1+nn2+nn3+nn4+nn5+nn6+nn7+nn8+nn9+nn10
  avtemp1st=meantemp1/nn1;
  avtemp2nd=meantemp2/nn2;
  avtemp3rd=meantemp3/nn3;
  avtemp4th=meantemp4/nn4;
  avtemp5th=meantemp5/nn5;
  avtemp6th=meantemp6/nn6;
  avtemp7th=meantemp7/nn7;
  avtemp8th=meantemp8/nn8;
  avtemp9th=meantemp9/nn9;
  avtemp10th=meantemp10/nn10;

  saveav=cat(3,avtemp1st,avtemp2nd,avtemp3rd,avtemp4th,avtemp5th,avtemp6th,avtemp7th,avtemp8th,avtemp9th,avtemp10th);

  fileID=fopen(strcat(dir_o,fn_av,'.dat'),'w');
  fwrite(fileID,saveav,'double');
  fclose(fileID);

end
