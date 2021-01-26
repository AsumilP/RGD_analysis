  clear all
  close all

%% Parameters

  nx=1024;
  ny=1024;

  frames=396;       %the number of frames you will convert
  first_frame=1;      %select the first frame
  filename = 'plif_grid.mraw';  %convert from, under the same directory
  avoutname= 'plif_grid.dat';  %convert into, under the same directory

%% Matrix

  Pixels=nx*ny;
  I=zeros(Pixels,frames,'uint16');
  N = [nx ny frames];
  avout=zeros(nx,ny,'uint16');
  nn=0;
  
%% Read

  fid2 = fopen(sprintf(filename),'r');
  fseek(fid2,(first_frame-1)*Pixels*2,'bof');

  for n=1:1:frames
      I(:,n)=(fread(fid2,Pixels,'uint16'));
  end
  fclose(fid2);

  ImageData=permute(reshape(I,N),[2 1 3]);
  
%% Seek

  for idx=[1 2 4 5 7 8 10 11];
      nn=nn+1;
      avout(:,:) = avout(:,:) + ImageData(:,:,idx);
  end

   avout2=avout/nn;

% %% Seek
% 
%   for idx=1:1:frames
%       if (floor(mean(mean(ImageData(:,:,idx)))) > 1240);
%           nn=nn+1;
%           avout(:,:) = avout(:,:) + ImageData(:,:,idx)/max(max(ImageData(:,:,idx)));
%       else
%           nn
%       end
%   end
% 
%   avout2=avout/nn;

%% Save

  imshow(avout2,[0 4000]);
  fileID=fopen(avoutname,'w');
  fwrite(fileID,avout2,'uint16');
  fclose(fileID);
