    clear all
    close all
    clc

%% Parameters

    nx = 1024;
    ny = 1024;
    nz = 21839;
%     nz = 300;
    date = '20201217';
    
    for cond = [3 4]
%     for cond = [1]

        dir_in = strcat('G:/',date,'/raw_old/');
        dir_out = strcat('G:/',date,'/raw/');
        filename_in = sprintf('spiv_bl_%02u.mraw',cond);
        filename_out = sprintf('spiv_bl_%02u.dat',cond);
%         filename_in = sprintf('spiv_bl_grid.mraw');
%         filename_out = sprintf('spiv_bl_grid.dat');

%% Read & Calc.

        Pixels = nx*ny;
        fid = fopen(append(dir_in,filename_in),'r');

        for m = 1:1:nz
            I = fread(fid,Pixels,'uint8');
        
            if m == 1
                fid2 = fopen(append(dir_out,filename_out),'w');
                fwrite(fid2,I,'uint16');
                fclose(fid2);
            else
                fid3 = fopen(append(dir_out,filename_out),'a');
                fwrite(fid3,I,'uint16');
                fclose(fid3);
            end
        
        end
    
        fclose(fid);
    end