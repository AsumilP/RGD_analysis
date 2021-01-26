function [omega_o] = calc_omega(u,v,dx,dy,nx,ny)

    N = [nx ny];
    u = permute(reshape(u,N),[2 1]);
    v = permute(reshape(v,N),[2 1]);

    [dudx, dudy] = 4th_order_dudx(u,dx,dy,nx,ny)
    [dvdx, dvdy] = 4th_order_dudx(v,dx,dy,nx,ny)

    omega=dvdx-dudy;
    omega_o=reshape(omega,[nx*ny 1]);

end
