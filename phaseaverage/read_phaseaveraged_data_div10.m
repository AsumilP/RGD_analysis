function [data_av] = read_phaseaveraged_data_div10(flow_rate,series,ndata,nx,ny,date,cond,mode,dir_i)
  data_av=0;

  if mode == 1
      for i = 1:1:ndata
          formatspec=strcat(dir_i,'phasemean_',series,'_%d_%d.dat');
          fid=fopen(sprintf(formatspec,flow_rate,i),'r');
          for j=1:1:10
              I = fread(fid,nx*ny,'double');
              u(:,:,j)=reshape(I,[ny nx]);
              v(:,:,j)=transpose(u(:,:,j));
          end
          fclose(fid);

          data_av=data_av + v/ndata;
      end

  elseif mode == 2
      formatspec=strcat(dir_i,'phasemean_',series,'_%d_',date,'_%02u.dat');
      fid=fopen(sprintf(formatspec,flow_rate,cond),'r');
      for j=1:1:10
          I = fread(fid,nx*ny,'double');
          u(:,:,j)=reshape(I,[ny nx]);
          v(:,:,j)=transpose(u(:,:,j));
      end
      fclose(fid);

      data_av=v;

  end

end
