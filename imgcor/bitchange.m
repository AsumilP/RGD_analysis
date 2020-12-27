    clear all
    close all

%% Parameters

    nx = 1024;
    ny = 1024;
    nz = 21839;
    date =20202020;
    
    for cond = [1 2 3 4 5]

        dir_in = strcat('G:/Analysis/piv_output/dmd/',date,'/%02u/averaging/',step,'/',div,'/mode/');
        dir_out = strcat('G:/Analysis/piv_output/dmd/',date,'/%02u/averaging/',step,'/',div,'/mode/');
        filename_in = sprintf('pressure_d%d_%d_%.2f_cER.xlsx',duct_l,flow_rate,eq_ratio);
        filename_out = sprintf('pressure_d%d_%d_%.2f_cER.xlsx',duct_l,flow_rate,eq_ratio);

%% Matrix

        Pixels = nx*ny;
        I = zeros(Pixels,frames,'uint8');
        bcout = zeros(Pixels,'uint16');
  
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