    clc
    clear all
    close all

%% Parameters 1

    date=20190825;
    cond=4;

    for num=1:1:cond

%         file_u=sprintf('E:/piv_output/velofield/%d/spiv_fbsc_%02u_ucl.dat',date,num);
%         file_v=sprintf('E:/piv_output/velofield/%d/spiv_fbsc_%02u_vcl.dat',date,num);
        file_u=sprintf('D:/Analysis/velofield/%d/comblps/spiv_fbsc_%02u_ucl.dat',date,num);
        file_v=sprintf('D:/Analysis/velofield/%d/comblps/spiv_fbsc_%02u_vcl.dat',date,num);

%         file_strain_u11=sprintf('E:/piv_output/Sij_strain/spiv_strain_u11_%d_%02u.dat',date,num);
%         file_strain_v11=sprintf('E:/piv_output/Sij_strain/spiv_strain_v11_%d_%02u.dat',date,num);
%         file_strain_u22=sprintf('E:/piv_output/Sij_strain/spiv_strain_u22_%d_%02u.dat',date,num);
%         file_strain_v22=sprintf('E:/piv_output/Sij_strain/spiv_strain_v22_%d_%02u.dat',date,num);
%         file_eig11=sprintf('E:/piv_output/Sij_strain/spiv_strain_eig11_%d_%02u.dat',date,num);
%         file_eig22=sprintf('E:/piv_output/Sij_strain/spiv_strain_eig22_%d_%02u.dat',date,num);
        file_strain_u11=sprintf('D:/Analysis/velofield/%d/spiv_strain_u11_%d_%02u.dat',date,date,num);
        file_strain_v11=sprintf('D:/Analysis/velofield/%d/spiv_strain_v11_%d_%02u.dat',date,date,num);
        file_strain_u22=sprintf('D:/Analysis/velofield/%d/spiv_strain_u22_%d_%02u.dat',date,date,num);
        file_strain_v22=sprintf('D:/Analysis/velofield/%d/spiv_strain_v22_%d_%02u.dat',date,date,num);
        file_eig11=sprintf('D:/Analysis/velofield/%d/spiv_strain_eig11_%d_%02u.dat',date,date,num);
        file_eig22=sprintf('D:/Analysis/velofield/%d/spiv_strain_eig22_%d_%02u.dat',date,date,num);

%% Parameters 2

        nx = 191;
        ny = 121;
        ny_calc = 98; % ATTENTION, CUT
        nzall = 21838;
        vec_spc_x = 8;
        vec_spc_y = 8;
        img_res_x = 80*10^(-3);
        img_res_y = 75*10^(-3);
        Fs_spiv= 20e3;

%% Matrix

        Sts_spiv = 1/Fs_spiv;    % [sec]
        Pixels=nx*ny;
        X=img_res_x*vec_spc_x;
        Y=img_res_y*vec_spc_y;
        dx=img_res_x*vec_spc_x*10^-3;
        dy=img_res_y*vec_spc_y*10^-3;
        xmin=-(0.5*(nx-1))*X+X;
        xmax=0.5*(nx-1)*X+X;
        ymin=Y*19; % ATTENTION, CUT
        ymax=Y*116; % ATTENTION, CUT
        wx=zeros(2,1);
        wy=zeros(2,1);
        u=zeros(nx,ny);
        v=zeros(nx,ny);
        dudx=zeros(ny,nx);
        dvdx=zeros(ny,nx);
        dudy=zeros(ny,nx);
        dvdy=zeros(ny,nx);
        strain_u11=zeros(ny,nx);
        strain_v11=zeros(ny,nx);
        strain_u22=zeros(ny,nx);
        strain_v22=zeros(ny,nx);
        eig11=zeros(ny,nx);
        eig22=zeros(ny,nx);
        N=[nx ny];

%% Decide Axes

        for i=1:nx
            x(i,:)= xmin+X*(i-1)+X;
        end

        for i=1:ny_calc
            y(i,:)=ymax-Y*(i-1);
        end

        y=sort(y);

        wx(1,1)=xmin;
        wx(2,1)=xmax;
        wy(1,1)=ymin;
        wy(2,1)=ymax;

%% READ & CALC

        tic
        fid1 = fopen(sprintf(file_u),'r');
        fid2 = fopen(sprintf(file_v),'r');

        for idx = 1:1:nzall
            I=(fread(fid1,Pixels,'double'));
            u=permute(reshape(I,N),[2 1]);
            J=(fread(fid2,Pixels,'double'));
            v=permute(reshape(J,N),[2 1]);

%% du/dx

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

%% dv/dx

            for j=1:ny
                for i=1:nx
                    if i==1
                        dvdx(j,i)=(-25*v(j,1)+48*v(j,2)-36*v(j,3)+16*v(j,4)-3*v(j,5))/(12*dx);
                    elseif i==2
                        dvdx(j,i)=(-3*v(j,1)-10*v(j,2)+18*v(j,3)-6*v(j,4)+v(j,5))/(12*dx);
                    elseif i==nx-1
                        dvdx(j,i)=(3*v(j,nx)+10*v(j,nx-1)-18*v(j,nx-2)+6*v(j,nx-3)-v(j,nx-4))/(12*dx);
                    elseif i==nx
                        dvdx(j,i)=(25*v(j,nx)-48*v(j,nx-1)+36*v(j,nx-2)-16*v(j,nx-3)+3*v(j,nx-4))/(12*dx);
                    else
                        dvdx(j,i)=(v(j,i-2)-8*v(j,i-1)+8*v(j,i+1)-v(j,i+2))/(12*dx);
                    end
                end
            end

%% du/dy

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

%% dv/dy

            for i=1:nx
                for j=1:ny
                    if j==1
                        dvdy(j,i)=-(-25*v(1,i)+48*v(2,i)-36*v(3,i)+16*v(4,i)-3*v(5,i))/(12*dy);
                    elseif j==2
                        dvdy(j,i)=-(-3*v(1,i)-10*v(2,i)+18*v(3,i)-6*v(4,i)+v(5,i))/(12*dy);
                    elseif j==ny-1
                        dvdy(j,i)=-(3*v(ny,i)+10*v(ny-1,i)-18*v(ny-2,i)+6*v(ny-3,i)-v(ny-4,i))/(12*dy);
                    elseif j==ny
                        dvdy(j,i)=-(25*v(ny,i)-48*v(ny-1,i)+36*v(ny-2,i)-16*v(ny-3,i)+3*v(ny-4,i))/(12*dy);
                    else
                        dvdy(j,i)=-(v(j-2,i)-8*v(j-1,i)+8*v(j+1,i)-v(j+2,i))/(12*dy);
                    end
                end
            end

%% Sij, strain

            for j=1:ny
                for i=1:nx
                    Sij=[dudx(j,i) 0.5*(dudy(j,i)+dvdx(j,i)); 0.5*(dudy(j,i)+dvdx(j,i)) dvdy(j,i)];
                    [V,D]=eig(Sij);
                    if D(1,1) > D(2,2)
                        strain_u11(j,i)=V(1,1);
                        strain_v11(j,i)=V(2,1);
                        strain_u22(j,i)=V(1,2);
                        strain_v22(j,i)=V(2,2);
                        eig11(j,i)=D(1,1);
                        eig22(j,i)=D(2,2);
                    elseif D(1,1) < D(2,2)
                        strain_u11(j,i)=V(1,2);
                        strain_v11(j,i)=V(2,2);
                        strain_u22(j,i)=V(1,1);
                        strain_v22(j,i)=V(2,1);
                        eig11(j,i)=D(2,2);
                        eig22(j,i)=D(1,1);
                    end
                end
            end

%% SAVE

            if idx ==1
                fileID_strain_u11=fopen(file_strain_u11,'w');
                fwrite(fileID_strain_u11,strain_u11,'double');
                fclose(fileID_strain_u11);
            else
                fileID_strain_u11=fopen(file_strain_u11,'a');
                fwrite(fileID_strain_u11,strain_u11,'double');
                fclose(fileID_strain_u11);
            end

            if idx ==1
                fileID_strain_v11=fopen(file_strain_v11,'w');
                fwrite(fileID_strain_v11,strain_v11,'double');
                fclose(fileID_strain_v11);
            else
                fileID_strain_v11=fopen(file_strain_v11,'a');
                fwrite(fileID_strain_v11,strain_v11,'double');
                fclose(fileID_strain_v11);
            end
            
            if idx ==1
                fileID_strain_u22=fopen(file_strain_u22,'w');
                fwrite(fileID_strain_u22,strain_u22,'double');
                fclose(fileID_strain_u22);
            else
                fileID_strain_u22=fopen(file_strain_u22,'a');
                fwrite(fileID_strain_u22,strain_u22,'double');
                fclose(fileID_strain_u22);
            end

            if idx ==1
                fileID_strain_v22=fopen(file_strain_v22,'w');
                fwrite(fileID_strain_v22,strain_v22,'double');
                fclose(fileID_strain_v22);
            else
                fileID_strain_v22=fopen(file_strain_v22,'a');
                fwrite(fileID_strain_v22,strain_v22,'double');
                fclose(fileID_strain_v22);
            end

            if idx ==1
                fileID_eig11=fopen(file_eig11,'w');
                fwrite(fileID_eig11,eig11,'double');
                fclose(fileID_eig11);
            else
                fileID_eig11=fopen(file_eig11,'a');
                fwrite(fileID_eig11,eig11,'double');
                fclose(fileID_eig11);
            end

            if idx ==1
                fileID_eig22=fopen(file_eig22,'w');
                fwrite(fileID_eig22,eig22,'double');
                fclose(fileID_eig22);
            else
                fileID_eig22=fopen(file_eig22,'a');
                fwrite(fileID_eig22,eig22,'double');
                fclose(fileID_eig22);
            end

        end
        fclose(fid1);
        fclose(fid2);
        toc

    end
