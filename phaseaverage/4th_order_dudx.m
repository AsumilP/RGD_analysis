function [dudx, dudy] = 4th_order_dudx(u,dx,dy,nx,ny)

    for j=1:ny
        for i=1:nx
            if i==1
                dudx(j,i)=(-25*u(j,1)+48*u(j,2)-36*u(j,3)+16*u(j,4)-3*u(j,5))/(12*dx);
            elseif i==2
                dudx(j,i)=(-3*u(j,1)-10*u(j,2)+18*u(j,3)-6*u(j,4)+u(j,5))/(12*dx);
            elseif i==nx-1
                dudx(j,i)=(3*u(j,nx)+10*u(j,nx-1)-18*u(j,nx-2)+6*u(j,nx-3)-u(j,nx-4))/(12*dx);
            elseif i==nx
                dudx(j,i)=(25*u(j,nx)-48*u(j,nx-1)+36*u(j,nx-2)-16*u(j,nx-3)+3*u(j,nx-4))/(12*dx);
            else
                dudx(j,i)=(u(j,i-2)-8*u(j,i-1)+8*u(j,i+1)-u(j,i+2))/(12*dx);
            end
        end
    end
    
    for i=1:nx
        for j=1:ny
            if j==1
                dudy(j,i)=-(-25*u(1,i)+48*u(2,i)-36*u(3,i)+16*u(4,i)-3*u(5,i))/(12*dy);
            elseif j==2
                dudy(j,i)=-(-3*u(1,i)-10*u(2,i)+18*u(3,i)-6*u(4,i)+u(5,i))/(12*dy);
            elseif j==ny-1
                dudy(j,i)=-(3*u(ny,i)+10*u(ny-1,i)-18*u(ny-2,i)+6*u(ny-3,i)-u(ny-4,i))/(12*dy);
            elseif j==ny
                dudy(j,i)=-(25*u(ny,i)-48*u(ny-1,i)+36*u(ny-2,i)-16*u(ny-3,i)+3*u(ny-4,i))/(12*dy);
            else
                dudy(j,i)=-(u(j-2,i)-8*u(j-1,i)+8*u(j+1,i)-u(j+2,i))/(12*dy);
            end
        end
    end
    
end
