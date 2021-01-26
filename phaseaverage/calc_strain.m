function [omega] = calc_strain(u,v,dx,dy,nx,ny,mode)

    N = [nx ny];
    u = permute(reshape(u,N),[2 1]);
    v = permute(reshape(v,N),[2 1]);

    [dudx, dudy] = 4th_order_dudx(u,dx,dy,nx,ny)
    [dvdx, dvdy] = 4th_order_dudx(v,dx,dy,nx,ny)

    for j=1:ny
      for i=1:nx
        Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
        [V,D]=eig(Sij);
        if D(1,1) > D(2,2)
          strain_u(j,i)=V(1,1);
          strain_v(j,i)=V(2,1);
          eig11(j,i)=D(1,1);
          eig22(j,i)=D(2,2);
        elseif D(1,1) < D(2,2)
          strain_u(j,i)=V(1,2);
          strain_v(j,i)=V(2,2);
          eig11(j,i)=D(2,2);
          eig22(j,i)=D(1,1);
        end
      end
    end

    if mode == 1
      strain_u_o=reshape(strain_u.*eig11,[nx*ny 1]);
      strain_v_o=reshape(strain_v.*eig11,[nx*ny 1]);
    elseif mode == 2
      strain_u_o=reshape(strain_u,[nx*ny 1]);
      strain_v_o=reshape(strain_v,[nx*ny 1]);
    end

end
