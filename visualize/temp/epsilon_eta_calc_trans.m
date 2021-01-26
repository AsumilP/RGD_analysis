    clc
    clear all
    close all

%% Parameters 1

    trans_start_time = 2.9297;
    trans_fin_time = 3.2257;
    trig_time = 3.495;
    date=20190823;
    num=10;

    file_eps=sprintf('E:/piv_output/dissipationrate/%d/spiv_%02u_eps.dat',date,num);

%% Parameters 2

    nx = 191;
    ny = 98; % ATTENTION, CUT
    nzall = 21838;
    Fs_spiv= 20e3;
    div =10;
    NYU= 1.333e-5; % [m^2/s]

%% Matrix

    Sts_spiv = 1/Fs_spiv;    % [sec]
    Pixels=nx*ny;
    before_transition_data = floor(nzall -(trig_time - trans_start_time)/Sts_spiv)
    while_transition_data = floor((trans_fin_time - trans_start_time)/Sts_spiv)
    calc_data = floor((trans_fin_time - trans_start_time)/(div*Sts_spiv))
      
%% Calculation, PHASE MEAN, umin

      fid1 = fopen(sprintf(file_eps),'r');
      fseek(fid1,before_transition_data*Pixels*8,'bof');
      
      eps_av=[0 0 0 0 0 0 0 0 0 0];
      eta_av=[0 0 0 0 0 0 0 0 0 0];
      
      for d=1:div
          I=(fread(fid1,Pixels*calc_data,'double'));
          for i=Pixels*calc_data
              eps_av(d)=eps_av(d)+I(i)/Pixels*calc_data;
          end
          eta_av(d)=((NYU^3)/eps_av(d))^0.25;
      end
      fclose(fid1);
 