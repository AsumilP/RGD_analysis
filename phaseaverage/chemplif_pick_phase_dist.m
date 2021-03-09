function chemplif_pick_phase_dist(dir_i,fn_i,dir_o,fn_av,locs,cam_start_data,...
         before_transition_data,before_transition_data_calc,calc_start_time,...
         calc_data,Sts_press,Sts,nx,ny,cnt_st1,cnt_st2,cnt_st3,cnt_st4,cnt_st5,...
         cnt_st6,cnt_st7,cnt_st8,cnt_st9,cnt_st10,vissw,svsw,...
         origin_x,origin_y,origin_height,img_res_x,img_res_y,visx_start,...
         visx_end,visy_start,visy_end,col_min,col_max,vis,dir_f)

  meantemp1=zeros(ny,nx);
  meantemp2=zeros(ny,nx);
  meantemp3=zeros(ny,nx);
  meantemp4=zeros(ny,nx);
  meantemp5=zeros(ny,nx);
  meantemp6=zeros(ny,nx);
  meantemp7=zeros(ny,nx);
  meantemp8=zeros(ny,nx);
  meantemp9=zeros(ny,nx);
  meantemp10=zeros(ny,nx);
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

      fid = fopen(strcat(dir_i,fn_i),'r');
      skip_frames(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))+1,nx*ny,2,1);
      I=(fread(fid,nx*ny,'uint16'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      fclose(fid);

      nn1=nn1+1;
      meantemp1(:,:) = meantemp1(:,:) + image(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

        chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                         visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
        saveas(gcf,strcat(dir_f,fn_av,'_0-0.1T_',num2str(cnt_st1+nn1-1),'.png'))
        close;
      end

      if svsw == 1
        fileID=fopen(strcat(dir_f,fn_av,'_0-0.1T_',num2str(cnt_st1+nn1-1),'.dat'),'w');
        fwrite(fileID,I,'double');
        fclose(fileID);
      end

%savetemp,figvis

    elseif (locs(t)-cam_start_data >before_transition_data+calc_data) && (locs(t)-cam_start_data <= before_transition_data+2*calc_data)

      fid = fopen(strcat(dir_i,fn_i),'r');
      skip_frames(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))+1,nx*ny,2,1);
      I=(fread(fid,nx*ny,'uint16'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      fclose(fid);

      nn2=nn2+1;
      meantemp2(:,:) = meantemp2(:,:) + image(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

        chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                         visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
        saveas(gcf,strcat(dir_f,fn_av,'_0.1T-0.2T_',num2str(cnt_st2+nn2-1),'.png'))
        close;
      end

      if svsw == 1
        fileID=fopen(strcat(dir_f,fn_av,'_0.1T-0.2T_',num2str(cnt_st2+nn2-1),'.dat'),'w');
        fwrite(fileID,I,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+2*calc_data) && (locs(t)-cam_start_data <= before_transition_data+3*calc_data)

      fid = fopen(strcat(dir_i,fn_i),'r');
      skip_frames(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))+1,nx*ny,2,1);
      I=(fread(fid,nx*ny,'uint16'));
      image=permute(reshape(I,[nx,ny]),[2 1]);
      fclose(fid);

      nn3=nn3+1;
      meantemp3(:,:) = meantemp3(:,:) + image(:,:);

      if vissw == 1
        fig=figure;
        fig.Color='white';
        fig.Position=[1 1 800 800];

        chem_vis(I,nx,ny,origin_x,origin_y,origin_height,img_res_x,img_res_y,...
                         visx_start,visx_end,visy_start,visy_end,col_min,col_max,vis)
        saveas(gcf,strcat(dir_f,fn_av,'_0.2T-0.3T_',num2str(cnt_st3+nn3-1),'.png'))
        close;
      end

      if svsw == 1
        fileID=fopen(strcat(dir_f,fn_av,'_0.2T-0.3T_',num2str(cnt_st3+nn3-1),'.dat'),'w');
        fwrite(fileID,I,'double');
        fclose(fileID);
      end

    elseif (locs(t)-cam_start_data >before_transition_data+3*calc_data) && (locs(t)-cam_start_data <= before_transition_data+4*calc_data)

      fid = fopen(strcat(dir_i,fn_i),'r');
      skip_frames(fid,(before_transition_data_calc+floor((locs(t)*Sts_press-calc_start_time)/Sts))+1,nx*ny,2,1);
      I=(fread(fid,nx*ny,'uint16'));
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
      I=(fread(fid,nx*ny,'uint16'));
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
      I=(fread(fid,nx*ny,'uint16'));
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
      I=(fread(fid,nx*ny,'uint16'));
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
      I=(fread(fid,nx*ny,'uint16'));
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
      I=(fread(fid,nx*ny,'uint16'));
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
      I=(fread(fid,nx*ny,'uint16'));
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
