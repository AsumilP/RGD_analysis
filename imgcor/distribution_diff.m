    clear all
    close all

%% Parameters

    nx = 1024;
    ny = 1024;
    nz = 21839;
    date =20202020;
    
    for cond = [1 2 3 4 5]

        dir_in1 = strcat('G:/Analysis/piv_output/dmd/',date,'/%02u/averaging/',step,'/',div,'/mode/');
        dir_in2 = strcat('G:/Analysis/piv_output/dmd/',date,'/%02u/averaging/',step,'/',div,'/mode/');
        filename_in1 = sprintf('pressure_d%d_%d_%.2f_cER.xlsx',duct_l,flow_rate,eq_ratio);
        filename_in2 = sprintf('pressure_d%d_%d_%.2f_cER.xlsx',duct_l,flow_rate,eq_ratio);

%% Matrix

        Pixels = nx*ny;
        I = zeros(Pixels,frames,'uint8');
        bcout = zeros(Pixels,'uint16');
        dif_max = zeros(nz,'double');
  
%% Read & Calc.

        fid1 = fopen(append(dir_in1,filename_in1),'r');
        fid2 = fopen(append(dir_in2,filename_in2),'r');

        for m = 1:1:nz
            I = fread(fid1,Pixels,'uint8');
            bcout = fread(fid2,Pixels,'uint16');
            dif_max(m) = max(bcout - I);
        end
    
        fclose(fid1);
        fclose(fid2);
        
 %% Plot
 
        figure('Position', [50 50 960 735],'Color','white');
        plot(1:nz,dif_max,'vk')

        ax = gca;
        xtickformat('%d')
        ytickformat('%.2f')

        ax.XColor = 'k';
        ax.YColor = 'k';
        ax.FontSize = 20;
        ax.FontName = 'Times New Roman';
        ax.TitleFontSizeMultiplier = 2;
        ax.Box = 'on';
        ax.LineWidth = 2.0;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.XLim = [1 nz];

        xlabel('\rm \fontname{Times New Roman} frames')
        ylabel('\rm \fontname{Times New Roman} diff')
        set(gca,'FontName','Times New Roman','FontSize',20)

        pbaspect([sqrt(2) 1 1]);

    end