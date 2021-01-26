function [omega] = calc_strain(dvdx,dudy)

    omega=dvdx-dudy;

end
