    clear all
    clc

%% Parameters

    T_400=[0.4117 0.3879 0.3238 0.2684 0.3447 0.296];
    T_450=[0.2439 0.336 0.2709 0.3022 0.2916 0.2551 0.4202 0.2758 0.2922 0.2235 0.3263 0.3468 0.3554 0.319 0.4677 0.2406 0.3387];
    T_500=[0.2924 0.1874 0.3418 0.2128 0.342 0.2879 0.2387 0.2756 0.2361 0.2485];

%% Calc

    T_400av=mean(T_400)
    T_450av=mean(T_450)
    T_500av=mean(T_500)  

%% FIGURE

    figure('Position', [1 1 540*(1+sqrt(5))/2 540],'Color','white');

    T_400_h=histogram(T_400);
    hold on
    T_450_h=histogram(T_450);
    hold on
    T_500_h=histogram(T_500);

    T_400_h.Normalization = 'probability';
    T_400_h.BinWidth = 0.05;
    T_450_h.Normalization = 'probability';
    T_450_h.BinWidth = 0.05;
    T_500_h.Normalization = 'probability';
    T_500_h.BinWidth = 0.05;
    
    legend
