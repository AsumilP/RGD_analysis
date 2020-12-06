    clear all
    close all
    clc

%% PARAMETERS
    lx = 1.185; % [m]
    ly = 0.12; % [m]
    lz = 0.12; % [m]
    T_room = 20; %[degree C]
    T_estim = 200; %[degree C]

%% MATRIX
    lx_plot = 0.01:0.01:2; % [m]
%     c_room = 331.5+0.6*T_room; %speed of sound, [m/s]
%     c_estim = 331.5+0.6*T_estim; %speed of sound, [m/s]
    c_room = 20.055*sqrt(273.15+T_room); %speed of sound, [m/s]
    c_estim = 20.055*sqrt(273.15+T_estim); %speed of sound, [m/s]

    for i = 1:1:length(lx_plot)
        freq_room_100(i) = (c_room/2)*(1/(2*i*10^(-2)));
        freq_room_200(i) = (c_room/2)*(3/(2*i*10^(-2)));
    end

    for i = 1:1:length(lx_plot)
        freq_estim_100(i) = (c_estim/2)*(1/(2*i*10^(-2)));
        freq_estim_200(i) = (c_estim/2)*(3/(2*i*10^(-2)));
    end

    for nz = 1:4
        for ny = 1:4
            for nx = 1:4
                freq_comb_osc(nx,ny,nz) = (c_room/2)*sqrt(((2*nx-3)/(2*lx))^2 + ((ny-1)/(2*ly))^2 + ((nz-1)/(2*lz))^2);
            end
        end
    end

    T_plot = -273:1:2000;
    
    for i = 1:1:length(T_plot)
        c_model1(i) = 331.5+0.6*(i-274);
        c_model2(i) = 20.055*sqrt(273.15+i-274);
    end
    
    
%% FIGURE, lx - f
    figure('Position', [50 50 960 735],'Color','white');
    plot(lx_plot, freq_room_100, '--k', 'LineWidth',1.5)

    ax = gca;
    xtickformat('%.1f')
    ytickformat('%d')
    ax.XAxisLocation = 'bottom';
    ax.YDir = 'normal';
    ax.YAxisLocation = 'left';
    ax.XColor = 'black';
    ax.YColor = 'black';
%     ax.XScale = 'log';
%     ax.YScale = 'log';
    ax.XLim = [0.4 1.4];
    ax.YLim = [0 350];
    ax.FontSize = 25;
    ax.FontName =  'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlabel('\it \fontname{Times New Roman} l_{x} \rm[m]')
    ylabel('\it \fontname{Times New Roman} f \rm[Hz]')
    set(gca,'FontName','Times New Roman','FontSize',25)
    hold on
    
    plot(lx_plot, freq_room_200, '-.k', 'LineWidth',1.5)
    hold on

    plot(lx_plot, freq_estim_100, '--r', 'LineWidth',1.5)
    hold on
    
    plot(lx_plot, freq_estim_200, '-.r', 'LineWidth',1.5)
    hold on

%     plot([0.4 1.4], [freq_comb_osc(2,1,1) freq_comb_osc(2,1,1)], '-^k', 'LineWidth',1)
%     hold on
% 
%     plot([0.4 1.4], [freq_comb_osc(3,1,1) freq_comb_osc(3,1,1)], '-vk', 'LineWidth',1)
    hold off

    legend('\it T \rm=293K, (1,0,0)','\it T \rm=293K, (2,0,0)','\it T \rm=473K, (1,0,0)','\it T \rm=473K, (2,0,0)', 'Location', 'southwest')
    pbaspect([sqrt(2) 1 1]);
    saveas(gcf,'combustion_oscillation_freq.fig')
    
%% FIGURE, T - c
    figure('Position', [50 50 960 735],'Color','white');
    plot(T_plot, c_model1, '--k', 'LineWidth',1.5)

    ax = gca;
    xtickformat('%d')
    ytickformat('%d')
    ax.XAxisLocation = 'bottom';
    ax.YDir = 'normal';
    ax.YAxisLocation = 'left';
    ax.XColor = 'black';
    ax.YColor = 'black';
%     ax.XScale = 'log';
%     ax.YScale = 'log';
    ax.XLim = [0 2000];
%     ax.YLim = [0 ];
    ax.FontSize = 25;
    ax.FontName =  'Times New Roman';
    ax.TitleFontSizeMultiplier = 2;
    ax.Box = 'on';
    ax.LineWidth = 2.0;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';

    xlabel('\it \fontname{Times New Roman} T \rm[degree Celsius]')
    ylabel('\it \fontname{Times New Roman} c \rm[m/s]')
    set(gca,'FontName','Times New Roman','FontSize',25)
    hold on
    
    plot(T_plot, c_model2, '-.r', 'LineWidth',1.5)
    hold off

    legend('331.5+0.6*T','20.055*sqrt(273.15+T)', 'Location', 'northwest')
    pbaspect([sqrt(2) 1 1]);
    saveas(gcf,'speed_of_sound_temperature.fig')
