    clear all
    close all
    clc

%% Parameters

    nx = 1024;
    ny = 1024;
    nz = 21839;
    date = '20201218';
    
    for cond = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]

        dir_in = strcat('G:/',date,'/raw_old/');
        dir_out = strcat('G:/',date,'/raw/');
        filename_in = sprintf('spiv_bl_%02u.mraw',cond);
        filename_out = sprintf('spiv_bl_%02u.dat',cond);

%% Matrix

        Pixels = nx*ny;
  
%% Read

        fid = fopen(append(dir_in,filename_in),'r');

        for m = 1:1:nz
            I = fread(fid,Pixels,'uint8');
            for n = 1:1:Pixels
                bcout(n) = I(n);
            end
        
            if m == 1
                fid2 = fopen(append(dir_out,filename_out),'w');
                fwrite(fid2,bcout,'uint16');
                fclose(fid2);
            else
                fid3 = fopen(append(dir_out,filename_out),'a');
                fwrite(fid3,bcout,'uint16');
                fclose(fid3);
            end
        
        end
    
        fclose(fid);
    end