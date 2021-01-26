    clear all
    close all

%% Parameters 1

      frames=200; %the number of frames you will convert
      first_frame=1; %select the first frame
      skip_frame = 100; %the number of skip frame

      filename = sprintf('spiv_fr_03_cor.dat');  %convert from, under the same directory
      gifname= './spiv_fr_20190825_03_cor.gif';  %convert into, under the same directory

%% Parameters 2

      nx= 1024;
      ny= 1024;
      nzall= 21839;
      Fs_plif= 10e3;

%% Matrix

      Sts_chem = 1/Fs_plif;    % [sec]
      Pixels=nx*ny;
      error_txt = 'ERROR, TOO LONG !!!';

%% MAKING VIDEO

      if first_frame+(skip_frame+1)*frames <= nzall

        fid = fopen(sprintf(filename),'r');
        fseek(fid,(first_frame-1)*Pixels*2,'bof');  % 2 Byte, binarize...
%        fseek(fid,(first_frame-1)*Pixels*8,'bof');  % 8 Byte, smooth...

        fig = figure;

        for idx=1:1:frames
            I = fread(fid,Pixels,'uint16');  % 2 Byte
%            I = fread(fid,Pixels,'uint64');  % 8 Byte
            ImageData = permute(reshape(I,[nx,ny]),[2 1]);
            J=ImageData(:,:);

            pos1 = [0.23 0.15 0.55 0.80]; % left bottom width height
            subplot('Position',pos1)
            imshow(J,[0 1000]); % mraw, median...
%             imshow(J,[0 1]); % binarize, smooth...
%             imshow(J,[0 1]); % differentiation...
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];
            fseek(fid,skip_frame*Pixels*2,'cof');

            frame = getframe(fig);
            im{idx}=frame2im(frame);

        end
        fclose(fid);
        close;

        for idx=1:1:frames
              [A,map]= rgb2ind(im{idx},256);
            if idx == 1
                  imwrite(A,map,gifname,'gif','LoopCount',Inf,'DelayTime',0.1);
            else
                  imwrite(A,map,gifname,'gif','WriteMode','append','DelayTime',0.1);
            end
        end

      else
          error_txt
          first_frame+(skip_frame+1)*frames
      end
