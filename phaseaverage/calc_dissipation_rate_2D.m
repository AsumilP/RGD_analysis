function [eps_o] = calc_dissipation_rate_2D(u,v,dx,dy,nx,ny)

    NYU= 1.333e-5; % [m^2/s]

    N = [nx ny];
    u = permute(reshape(u,N),[2 1]);
    v = permute(reshape(v,N),[2 1]);

    [dudx, dudy] = 4th_order_dudx(u,dx,dy,nx,ny)
    [dvdx, dvdy] = 4th_order_dudx(v,dx,dy,nx,ny)

    for j=1:ny
      for i=1:nx
        eps(j,i)=2*NYU*(dudx(j,i)^2+dvdy(j,i)^2+dudy(j,i)*dvdx(j,i)+(dudy(j,i)^2)/2+(dvdx(j,i)^2)/2);
      end
    end

    eps_o=reshape(eps,[nx*ny 1]);

end
