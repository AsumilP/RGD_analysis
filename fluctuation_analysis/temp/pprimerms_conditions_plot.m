    clear all
    clc

%% Parameters

    b_prms_400=[0.0205 0.0131 0.017 0.0143 0.0138 0.0161];
    a_prms_400=[0.2952 0.3261 0.3339 0.3185 0.2946 0.3446];
    b_prms_450=[0.0204 0.0191 0.0286 0.0239 0.02 0.0261 0.021 0.0262 0.0243 0.0242 0.0183 0.0247 0.0184 0.0216 0.02 0.0206 0.02];
    a_prms_450=[0.2581 0.2703 0.3608 0.3158 0.3309 0.3577 0.3611 0.3661 0.3725 0.3271 0.356 0.3124 0.2902 0.3259 0.3298 0.3287 0.3486];
    b_prms_500=[0.0345 0.0369 0.0354 0.0384 0.052 0.0259 0.0284 0.0285 0.0301 0.0344];
    a_prms_500=[0.261 0.2711 0.3666 0.334 0.3254 0.2766 0.2914 0.3157 0.3023 0.3241];

%% Calc

    b_prms_400av=mean(b_prms_400)
    a_prms_400av=mean(a_prms_400)
    b_prms_450av=mean(b_prms_450)
    a_prms_450av=mean(a_prms_450)
    b_prms_500av=mean(b_prms_500)
    a_prms_500av=mean(a_prms_500)    

%% FIGURE

    figure('Position', [1 1 540*(1+sqrt(5))/2 540],'Color','white');

    b_400_h=histogram(b_prms_400);
    hold on
    a_400_h=histogram(a_prms_400);
    hold on
    b_450_h=histogram(b_prms_450);
    hold on
    a_450_h=histogram(a_prms_450);
    hold on
    b_500_h=histogram(b_prms_500);
    hold on
    a_500_h=histogram(a_prms_500);

    b_400_h.Normalization = 'probability';
    b_400_h.BinWidth = 0.005;
    a_400_h.Normalization = 'probability';
    a_400_h.BinWidth = 0.005;
    b_450_h.Normalization = 'probability';
    b_450_h.BinWidth = 0.005;
    a_450_h.Normalization = 'probability';
    a_450_h.BinWidth = 0.005;
    b_500_h.Normalization = 'probability';
    b_500_h.BinWidth = 0.005;
    a_500_h.Normalization = 'probability';
    a_500_h.BinWidth = 0.005;
    
    legend
