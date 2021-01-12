    clear all
    close all
    clc

%% PARAMETERS

    sw_num = 45; % [-], vane angle
    duct_l = 2; % 1.d1185,  2.d582
    vis_map = 2; % 1.peak-frequency, 2.ppr(20-300), 3.ppr(20-3000)
    down_or_up = 1; % 1.downstream, 2.upstream

    col_min = 0.01; % 60(d1185,f), 0(d1185,ppr)
    col_max = 0.03; % 120(d1185,f), 0.9(d1185,ppr)

    er_min = 0.70;
    er_max = 0.80;
    fr_min = 250;
    fr_max = 500;
    interpolation = 2; % 1.spline, 2.hermite
    er_interp_num = 15;
    fr_interp_num = 26;
    
    vis_col = 'jet';
    figex = '.png'; % fig, png

%% Read

    dir = sprintf('G:/Analysis/pressure/PS_cER_calc/sw%d/results/',sw_num);
    
    if sw_num == 45
        rfn = sprintf('sw%d_cER.xlsx',sw_num);
        if duct_l == 1
            data_sheet_l = 'd1185';
            if vis_map == 1
                fr = xlsread(append(dir,rfn),data_sheet_l,'A2:A15');
                er = xlsread(append(dir,rfn),data_sheet_l,'B1:K1');
                T = xlsread(append(dir,rfn),data_sheet_l,'B2:K15');
                ofn = sprintf('sw%d_cER_d1185_f_%d',sw_num,interpolation);
            elseif vis_map == 2            
                if down_or_up == 1
                    fr = xlsread(append(dir,rfn),data_sheet_l,'M2:M15');
                    er = xlsread(append(dir,rfn),data_sheet_l,'N1:W1');
                    T = xlsread(append(dir,rfn),data_sheet_l,'N2:W15');
                    ofn = sprintf('sw%d_cER_d1185_ppr(20-300)_down_%d',sw_num,interpolation);
                elseif down_or_up == 2
                    fr = xlsread(append(dir,rfn),data_sheet_l,'Y2:Y15');
                    er = xlsread(append(dir,rfn),data_sheet_l,'Z1:AI1');
                    T = xlsread(append(dir,rfn),data_sheet_l,'Z2:AI15');
                    ofn = sprintf('sw%d_cER_d1185_ppr(20-300)_up_%d',sw_num,interpolation);
                end
            elseif vis_map == 3
                if down_or_up == 1
                    fr = xlsread(append(dir,rfn),data_sheet_l,'M18:M31');
                    er = xlsread(append(dir,rfn),data_sheet_l,'N17:W17');
                    T = xlsread(append(dir,rfn),data_sheet_l,'N18:W31');
                    ofn = sprintf('sw%d_cER_d1185_ppr(20-3000)_down_%d',sw_num,interpolation);
                elseif down_or_up == 2
                    fr = xlsread(append(dir,rfn),data_sheet_l,'Y18:Y31');
                    er = xlsread(append(dir,rfn),data_sheet_l,'Z17:AI17');
                    T = xlsread(append(dir,rfn),data_sheet_l,'Z18:AI31');
                    ofn = sprintf('sw%d_cER_d1185_ppr(20-3000)_up_%d',sw_num,interpolation);
                end
            end
            
        elseif duct_l ==2
            data_sheet_l = 'd582';
            if vis_map == 1
                fr = xlsread(append(dir,rfn),data_sheet_l,'A2:A15');
                er = xlsread(append(dir,rfn),data_sheet_l,'B1:G1');
                T = xlsread(append(dir,rfn),data_sheet_l,'B2:G15');
                ofn = sprintf('sw%d_cER_d582_f_%d',sw_num,interpolation);
            elseif vis_map == 2            
                if down_or_up == 1
                    fr = xlsread(append(dir,rfn),data_sheet_l,'I2:I15');
                    er = xlsread(append(dir,rfn),data_sheet_l,'J1:O1');
                    T = xlsread(append(dir,rfn),data_sheet_l,'J2:O15');
                    ofn = sprintf('sw%d_cER_d582_ppr(20-300)_down_%d',sw_num,interpolation);
                elseif down_or_up == 2
                    fr = xlsread(append(dir,rfn),data_sheet_l,'Q2:Q15');
                    er = xlsread(append(dir,rfn),data_sheet_l,'R1:W1');
                    T = xlsread(append(dir,rfn),data_sheet_l,'R2:W15');
                    ofn = sprintf('sw%d_cER_d582_ppr(20-300)_up_%d',sw_num,interpolation);
                end
            elseif vis_map == 3
                if down_or_up == 1
                    fr = xlsread(append(dir,rfn),data_sheet_l,'I18:I31');
                    er = xlsread(append(dir,rfn),data_sheet_l,'J17:O17');
                    T = xlsread(append(dir,rfn),data_sheet_l,'J18:O31');
                    ofn = sprintf('sw%d_cER_d582_ppr(20-3000)_down_%d',sw_num,interpolation);
                elseif down_or_up == 2
                    fr = xlsread(append(dir,rfn),data_sheet_l,'Q18:Q31');
                    er = xlsread(append(dir,rfn),data_sheet_l,'R17:W17');
                    T = xlsread(append(dir,rfn),data_sheet_l,'R18:W31');
                    ofn = sprintf('sw%d_cER_d582_ppr(20-3000)_up_%d',sw_num,interpolation);
                end
            end
        end
        
    elseif sw_num == 60
        rfn = sprintf('sw%d_cER.xlsx',sw_num);
        if duct_l == 1
            data_sheet_l = 'd1185';
            if vis_map == 1
                fr = xlsread(append(dir,rfn),data_sheet_l,'A2:A15');
                er = xlsread(append(dir,rfn),data_sheet_l,'B1:G1');
                T = xlsread(append(dir,rfn),data_sheet_l,'B2:G15');
                ofn = sprintf('sw%d_cER_d1185_f_%d',sw_num,interpolation);
            elseif vis_map == 2            
                if down_or_up == 1
                    fr = xlsread(append(dir,rfn),data_sheet_l,'I2:I15');
                    er = xlsread(append(dir,rfn),data_sheet_l,'J1:O1');
                    T = xlsread(append(dir,rfn),data_sheet_l,'J2:O15');
                    ofn = sprintf('sw%d_cER_d1185_ppr(20-300)_down_%d',sw_num,interpolation);
                elseif down_or_up == 2
                    fr = xlsread(append(dir,rfn),data_sheet_l,'Q2:Q15');
                    er = xlsread(append(dir,rfn),data_sheet_l,'R1:W1');
                    T = xlsread(append(dir,rfn),data_sheet_l,'R2:W15');
                    ofn = sprintf('sw%d_cER_d1185_ppr(20-300)_up_%d',sw_num,interpolation);
                end
            elseif vis_map == 3
                if down_or_up == 1
                    fr = xlsread(append(dir,rfn),data_sheet_l,'I18:I31');
                    er = xlsread(append(dir,rfn),data_sheet_l,'J17:O17');
                    T = xlsread(append(dir,rfn),data_sheet_l,'J18:O31');
                    ofn = sprintf('sw%d_cER_d1185_ppr(20-3000)_down_%d',sw_num,interpolation);
                elseif down_or_up == 2
                    fr = xlsread(append(dir,rfn),data_sheet_l,'Q18:Q31');
                    er = xlsread(append(dir,rfn),data_sheet_l,'R17:W17');
                    T = xlsread(append(dir,rfn),data_sheet_l,'R18:W31');
                    ofn = sprintf('sw%d_cER_d1185_ppr(20-3000)_up_%d',sw_num,interpolation);
                end
            end
            
        elseif duct_l ==2
            data_sheet_l = 'd582';
            if vis_map == 1
                fr = xlsread(append(dir,rfn),data_sheet_l,'A2:A15');
                er = xlsread(append(dir,rfn),data_sheet_l,'B1:G1');
                T = xlsread(append(dir,rfn),data_sheet_l,'B2:G15');
                ofn = sprintf('sw%d_cER_d582_f_%d',sw_num,interpolation);
            elseif vis_map == 2            
                if down_or_up == 1
                    fr = xlsread(append(dir,rfn),data_sheet_l,'I2:I15');
                    er = xlsread(append(dir,rfn),data_sheet_l,'J1:O1');
                    T = xlsread(append(dir,rfn),data_sheet_l,'J2:O15');
                    ofn = sprintf('sw%d_cER_d582_ppr(20-300)_down_%d',sw_num,interpolation);
                elseif down_or_up == 2
                    fr = xlsread(append(dir,rfn),data_sheet_l,'Q2:Q15');
                    er = xlsread(append(dir,rfn),data_sheet_l,'R1:W1');
                    T = xlsread(append(dir,rfn),data_sheet_l,'R2:W15');
                    ofn = sprintf('sw%d_cER_d582_ppr(20-300)_up_%d',sw_num,interpolation);
                end
            elseif vis_map == 3
                if down_or_up == 1
                    fr = xlsread(append(dir,rfn),data_sheet_l,'I18:I31');
                    er = xlsread(append(dir,rfn),data_sheet_l,'J17:O17');
                    T = xlsread(append(dir,rfn),data_sheet_l,'J18:O31');
                    ofn = sprintf('sw%d_cER_d582_ppr(20-3000)_down_%d',sw_num,interpolation);
                elseif down_or_up == 2
                    fr = xlsread(append(dir,rfn),data_sheet_l,'Q18:Q31');
                    er = xlsread(append(dir,rfn),data_sheet_l,'R17:W17');
                    T = xlsread(append(dir,rfn),data_sheet_l,'R18:W31');
                    ofn = sprintf('sw%d_cER_d582_ppr(20-3000)_up_%d',sw_num,interpolation);
                end
            end
        end
    end
    
%% Interpolation

    der = (er_max-er_min)/(er_interp_num-1);
    dfr = (fr_max-fr_min)/(fr_interp_num-1);
    er_interp = er_min:der:er_max;
    fr_interp = fr_min:dfr:fr_max;
    
    T_interp_temp = zeros(length(fr),length(er_interp));
    T_interp_plot = zeros(length(fr_interp),length(er_interp));
    
    if interpolation == 1
        for i = 1:1:length(fr)
            T_interp_temp(i,:) = spline(er,T(i,:),er_interp);
        end
        for j = 1:1:length(er_interp)
            T_interp_plot(:,j) = spline(fr,T_interp_temp(:,j),fr_interp);
        end
        
    elseif interpolation == 2
        for i = 1:1:length(fr)
            T_interp_temp(i,:) = pchip(er,T(i,:),er_interp);
        end
        for j = 1:1:length(er_interp)
            T_interp_plot(:,j) = pchip(fr,T_interp_temp(:,j),fr_interp);
        end
    end

%% Plot, Figure
    
    figure('Position', [50 50 960 735],'Color','white');
    imagesc([er_min er_max],[fr_min fr_max],T_interp_plot,[col_min col_max]);

    ax = gca;
    colormap(ax,vis_col)
%     load('MyColormap_for_w','mymap')
%     colormap(ax,mymap)
    xtickformat('%.2f')
    ytickformat('%.d')

    ax.XColor = 'k';
    ax.YColor = 'k';
    ax.FontSize = 20;
    ax.FontName = 'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XLim = [er_min er_max];
    ax.YLim = [fr_min fr_max];
    
    c = colorbar;
    c.TickLabelInterpreter='latex';
    c.Label.FontSize = 20;
    if vis_map == 1
        c.Label.String = '\it \fontname{Times New Roman} f \rm [Hz]';
    else
        c.Label.String = '\it \fontname{Times New Roman} p''_{rms} \rm [kPa]';
    end
    c.Location = 'eastoutside';
    c.AxisLocation='out';

     xlabel('\rm \fontname{Times New Roman} Equivalence ratio')
     ylabel('\rm \fontname{Times New Roman} Flow rate \rm[L/min]')
     set(gca,'FontName','Times New Roman','FontSize',20)

     pbaspect([sqrt(2) 1 1]);
     saveas(gcf,strcat(dir,ofn,figex));