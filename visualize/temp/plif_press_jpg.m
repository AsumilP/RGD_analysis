    clear all
    close all

%% Parameters

      nx= 1024;
      ny= 1024;
      nzall= 21839;

      trans_start_time = 2.6717;
      trans_fin_time = 3.0940;
      trig_time = 3.4670;
      Fs_press= 20e3;
      Fs_chem= 10e3;

      frames=300;       %the number of frames you will convert
%       first_frame=nzall-(trig_time-trans_start_time)*Fs_chem;      %select the first frame
      first_frame=16000;      %select the first frame
      skip_frame = 0; %the number of skip frame

      filename = sprintf('C:/Users/yatagi/Desktop/OHplif_07_sv1_binn3_ffstep1.dat');  %convert from, under the same directory
      presname = sprintf('D:/TanahashiShimuraLab/Analysis/20181218/chem/PDown_cutlps_19.dat'); %convert from, under the same directory

      directory='C:/Users/yatagi/Desktop/test6/';
%       gifname= './plif_press_03.gif';  %convert into, under the same directory

%% Matrix

      Sts_press = 1/Fs_press;    % [sec]
      Sts_chem = 1/Fs_chem;    % [sec]
      Pixels=nx*ny;
      trim_time_tmp = (trans_fin_time/Sts_press + 1/Sts_press) - (trans_start_time/Sts_press - 1/Sts_press)+1;
      taxis2 = -1:Sts_press:trans_fin_time-trans_start_time+1;
      first_time = trig_time - trans_start_time - Sts_chem*nzall;
      temp = first_time + (first_frame -1)*Sts_chem;
      error_txt = 'ERROR, TOO LONG !!!';

%% MAKING VIDEO

      if first_frame+(skip_frame+1)*frames <= nzall

         fid2 = fopen(sprintf(filename),'r');
        fseek(fid2,(first_frame-1)*Pixels*2,'bof');

        fid3 = fopen(sprintf(presname),'r');
        K = fread(fid3,trim_time_tmp,'double');
        fclose(fid3);

        for idx=1:1:frames
            I = fread(fid2,Pixels,'uint16');
            ImageData = permute(reshape(I,[nx,ny]),[2 1]);
            J=ImageData(:,:);
            
            for j=1:ny
                for i=1:nx
                    if J(i,j)==1
                        J(i,j)=0;
                        else
                        J(i,j)=1;
                    end
                end
            end

            fig = figure;
            pos1 = [0.30 0.36 0.40 0.65]; % left bottom width height
            subplot('Position',pos1)
            imshow(J,[0 1]); %change the range for each of dat, default 0-3000
            fig.Color='white';
            fig.Position=[1 1 800*(1+sqrt(5))/2 800];
            %K=imadjust(J,[],[],0.3)  % change for gamma value
            %title(['test'])    %if you'd like to add a title
            frame = getframe(fig);
            im{idx}=frame2im(frame);
            fseek(fid2,skip_frame*Pixels*2,'cof');

            %pos2 = [0.15 0.13 0.75 0.2];
            pos2 = [0.30 0.13 0.40 0.2];
            subplot('Position',pos2)
            plot(taxis2,K,'k')

            ax = gca;
            xtickformat('%.2f')
            xticks([-1 -0.5 0 0.5 1.0 1.5 2.0])
            set(gca,'xTickLabel', char('-1','-0.5','0','0.5','1.0','1.5','2.0'))
            ytickformat('%.3f')
            yticks([-0.25 -0.10 0 0.10 0.25])
            %yticks([-0.35 -0.20 0 0.20 0.35])
            set(gca,'YTickLabel', char('-0.25','-0.10','0','0.10','0.25'))
            %set(gca,'YTickLabel', char('-0.35','-0.20','0','0.20','0.35'))

            %xlim([-1 trans_fin_time-trans_start_time+1]);
            xlim([-0.5 trans_fin_time-trans_start_time+1]);
            ylim([-0.25 0.25]);
            %ylim([-0.35 0.35]);

            xlabel('\it \fontname{Times New Roman} t \rm[sec]')
            ylabel('\it \fontname{Times New Roman} p'' \rm[kPa]')
            set(gca,'FontName','Times New Roman','FontSize',15)
            hold on

            plot([0 0],[-0.25 0.25],'m--','LineWidth',2.0)
            hold on

            plot([trans_fin_time-trans_start_time trans_fin_time-trans_start_time],[-0.25 0.25],'m--','LineWidth',2.0)
            hold on

            plot([temp+Sts_chem*(idx-1)*(skip_frame+1) temp+Sts_chem*(idx-1)*(skip_frame+1)],[-0.25 0.25],'b-','LineWidth',2.0)
            hold off
            
            saveas(gcf,strcat(directory,strcat("test_",num2str(idx),'.jpeg')))
            close

        end
        fclose(fid2);
        close;

%         for idx=1:1:frames
%               [A,map]= rgb2ind(im{idx},256);
%             if idx == 1
%                   imwrite(A,map,gifname,'gif','LoopCount',Inf,'DelayTime',0.1);
%             else
%                   imwrite(A,map,gifname,'gif','WriteMode','append','DelayTime',0.1);
%             end
%         end

      else
          error_txt
          first_frame+(skip_frame+1)*frames
      end
