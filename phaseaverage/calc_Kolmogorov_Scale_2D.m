function [eta] = calc_Kolmogorov_Scale_2D(u,v,dx,dy,nx,ny)

    NYU= 1.333e-5; % [m^2/s]
    [eps_o] = calc_dissipation_rate_2D(u,v,dx,dy,nx,ny)

    eps_av=mean(eps_o);
    eta=((NYU^3)/eps_av)^0.25

end
