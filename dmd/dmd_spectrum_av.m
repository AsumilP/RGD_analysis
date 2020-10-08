clear
close all
clc

%% PARAMETERS

  dt = 50*10^(-6); %[s]
  increment = 6;
  id = 1; %1: norm, 2: norm (considering damp)
  average_width = 4;
  
  flow_rate = 500;
  step = 'trans1';
  num_data = 15;
  
  filepath_out = strcat('G:/dmd_averaged/');

%% FILE INFORMATION
%
  date_1 = '20190819'; %1
  cond_1 = 5;
  % div_1='01_13';
  div_1='u1_3';

  date_2 = '20190819'; %2
  cond_2 = 5;
  div_2 = 'u2_3';

  date_3 = '20190819'; %3
  cond_3 = 5;
  div_3 = 'u3_3';
%
  date_4 = '20190820'; %4
  cond_4 = 1;
  div_4 = 'u1_3';

  date_5 = '20190820'; %5
  cond_5 = 1;
  div_5 = 'u2_3';

  date_6 = '20190820'; %6
  cond_6 = 1;
  div_6 = 'u3_3';
%
  date_7 = '20190820'; %7
  cond_7 = 2;
  div_7 = 'u1_3';

  date_8 = '20190820'; %8
  cond_8 = 2;
  div_8 = 'u2_3';

  date_9 = '20190820'; %9
  cond_9 = 2;
  div_9 = 'u3_3';
%
  date_10 = '20190821'; %10
  cond_10 = 2;
  div_10 = 'u1_3';

  date_11 = '20190821'; %11
  cond_11 = 2;
  div_11 = 'u2_3';

  date_12 = '20190821'; %12
  cond_12 = 2;
  div_12 = 'u3_3';
%
  date_13 = '20190821'; %13
  cond_13 = 3;
  div_13 = 'u1_3';
  
  date_14 = '20190821'; %13
  cond_14 = 3;
  div_14 = 'u2_3';
  
  date_15 = '20190821'; %13
  cond_15 = 3;
  div_15 = 'u3_3';
% %
%   date_16 = '20190821'; %13
%   cond_16 = 7;
%   div_16 = 'u1_3';
%   
%   date_17 = '20190821'; %13
%   cond_17 = 7;
%   div_17 = 'u2_3';
%   
%   date_18 = '20190821'; %13
%   cond_18 = 7;
%   div_18 = 'u3_3';
% %
%   date_19 = '20190821'; %13
%   cond_19 = 9;
%   div_19 = 'u1_3';
%   
%   date_20 = '20190821'; %13
%   cond_20 = 9;
%   div_20 = 'u2_3';
%   
%   date_21 = '20190821'; %13
%   cond_21 = 9;
%   div_21 = 'u3_3';
% %
%   date_22 = '20190823'; %13
%   cond_22 = 1;
%   div_22 = 'u1_3';
%   
%   date_23 = '20190823'; %13
%   cond_23 = 1;
%   div_23 = 'u2_3';
%   
%   date_24 = '20190823'; %13
%   cond_24 = 1;
%   div_24 = 'u3_3';
% %
%   date_25 = '20190823'; %13
%   cond_25 = 2;
%   div_25 = 'u1_3';
%   
%   date_26 = '20190823'; %13
%   cond_26 = 2;
%   div_26 = 'u2_3';
%   
%   date_27 = '20190823'; %13
%   cond_27 = 2;
%   div_27 = 'u3_3';
% %
%   date_28 = '20190823'; %13
%   cond_28 = 3;
%   div_28 = 'u1_3';
%   
%   date_29 = '20190823'; %13
%   cond_29 = 3;
%   div_29 = 'u2_3';
%   
%   date_30 = '20190823'; %13
%   cond_30 = 3;
%   div_30 = 'u3_3';
% %
%   date_31 = '20190823'; %13
%   cond_31 = 4;
%   div_31 = 'u1_3';
%   
%   date_32 = '20190823'; %13
%   cond_32 = 4;
%   div_32 = 'u2_3';
%   
%   date_33 = '20190823'; %13
%   cond_33 = 4;
%   div_33 = 'u3_3';
% 
%   date_34 = '20190823'; %13
%   cond_34 = 5;
%   div_34 = 'u1_3';
%   
%   date_35 = '20190823'; %13
%   cond_35 = 5;
%   div_35 = 'u2_3';
%   
%   date_36 = '20190823'; %13
%   cond_36 = 5;
%   div_36 = 'u3_3';
% % 

%% FILENAMES & READ

  ifilename_fg = 'f_and_g.txt';
  ifilename_norm = 'norm.txt';

% 1
  filepath_1 = strcat('G:/',date_1,'/%02u/averaging/',step,'/',div_1,'/mode/');
  ifilename_1 = sprintf(strcat(filepath_1,ifilename_fg),cond_1);
  fileID = fopen(ifilename_1,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,1) = fg';

  ifilename_1 = sprintf(strcat(filepath_1,ifilename_norm),cond_1);
  fileID = fopen(ifilename_1,'r');
  norm(:,:,1) = fscanf(fileID,'%f');
  fclose(fileID);

% 2
  filepath_2 = strcat('G:/',date_2,'/%02u/averaging/',step,'/',div_2,'/mode/');
  ifilename_2 = sprintf(strcat(filepath_2,ifilename_fg),cond_2);
  fileID = fopen(ifilename_2,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,2) = fg';

  ifilename_2 = sprintf(strcat(filepath_2,ifilename_norm),cond_2);
  fileID = fopen(ifilename_2,'r');
  norm(:,:,2) = fscanf(fileID,'%f');
  fclose(fileID);

% 3
  filepath_3 = strcat('G:/',date_3,'/%02u/averaging/',step,'/',div_3,'/mode/');
  ifilename_3 = sprintf(strcat(filepath_3,ifilename_fg),cond_3);
  fileID = fopen(ifilename_3,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,3) = fg';

  ifilename_3 = sprintf(strcat(filepath_3,ifilename_norm),cond_3);
  fileID = fopen(ifilename_3,'r');
  norm(:,:,3) = fscanf(fileID,'%f');
  fclose(fileID);

% 4
  filepath_4 = strcat('G:/',date_4,'/%02u/averaging/',step,'/',div_4,'/mode/');
  ifilename_4 = sprintf(strcat(filepath_4,ifilename_fg),cond_4);
  fileID = fopen(ifilename_4,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,4) = fg';

  ifilename_4 = sprintf(strcat(filepath_4,ifilename_norm),cond_4);
  fileID = fopen(ifilename_4,'r');
  norm(:,:,4) = fscanf(fileID,'%f');
  fclose(fileID);

% 5
  filepath_5 = strcat('G:/',date_5,'/%02u/averaging/',step,'/',div_5,'/mode/');
  ifilename_5 = sprintf(strcat(filepath_5,ifilename_fg),cond_5);
  fileID = fopen(ifilename_5,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,5) = fg';

  ifilename_5 = sprintf(strcat(filepath_5,ifilename_norm),cond_5);
  fileID = fopen(ifilename_5,'r');
  norm(:,:,5) = fscanf(fileID,'%f');
  fclose(fileID);

% 6
  filepath_6 = strcat('G:/',date_6,'/%02u/averaging/',step,'/',div_6,'/mode/');
  ifilename_6 = sprintf(strcat(filepath_6,ifilename_fg),cond_6);
  fileID = fopen(ifilename_6,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,6) = fg';

  ifilename_6 = sprintf(strcat(filepath_6,ifilename_norm),cond_6);
  fileID = fopen(ifilename_6,'r');
  norm(:,:,6) = fscanf(fileID,'%f');
  fclose(fileID);

% 7
  filepath_7 = strcat('G:/',date_7,'/%02u/averaging/',step,'/',div_7,'/mode/');
  ifilename_7 = sprintf(strcat(filepath_7,ifilename_fg),cond_7);
  fileID = fopen(ifilename_7,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,7) = fg';

  ifilename_7 = sprintf(strcat(filepath_7,ifilename_norm),cond_7);
  fileID = fopen(ifilename_7,'r');
  norm(:,:,7) = fscanf(fileID,'%f');
  fclose(fileID);

% 8
  filepath_8 = strcat('G:/',date_8,'/%02u/averaging/',step,'/',div_8,'/mode/');
  ifilename_8 = sprintf(strcat(filepath_8,ifilename_fg),cond_8);
  fileID = fopen(ifilename_8,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,8) = fg';

  ifilename_8 = sprintf(strcat(filepath_8,ifilename_norm),cond_8);
  fileID = fopen(ifilename_8,'r');
  norm(:,:,8) = fscanf(fileID,'%f');
  fclose(fileID);

% 9
  filepath_9 = strcat('G:/',date_9,'/%02u/averaging/',step,'/',div_9,'/mode/');
  ifilename_9 = sprintf(strcat(filepath_9,ifilename_fg),cond_9);
  fileID = fopen(ifilename_9,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,9) = fg';

  ifilename_9 = sprintf(strcat(filepath_9,ifilename_norm),cond_9);
  fileID = fopen(ifilename_9,'r');
  norm(:,:,9) = fscanf(fileID,'%f');
  fclose(fileID);

% 10
  filepath_10 = strcat('G:/',date_10,'/%02u/averaging/',step,'/',div_10,'/mode/');
  ifilename_10 = sprintf(strcat(filepath_10,ifilename_fg),cond_10);
  fileID = fopen(ifilename_10,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,10) = fg';

  ifilename_10 = sprintf(strcat(filepath_10,ifilename_norm),cond_10);
  fileID = fopen(ifilename_10,'r');
  norm(:,:,10) = fscanf(fileID,'%f');
  fclose(fileID);

% 11
  filepath_11 = strcat('G:/',date_11,'/%02u/averaging/',step,'/',div_11,'/mode/');
  ifilename_11 = sprintf(strcat(filepath_11,ifilename_fg),cond_11);
  fileID = fopen(ifilename_11,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,11) = fg';

  ifilename_11 = sprintf(strcat(filepath_11,ifilename_norm),cond_11);
  fileID = fopen(ifilename_11,'r');
  norm(:,:,11) = fscanf(fileID,'%f');
  fclose(fileID);

% 12
  filepath_12 = strcat('G:/',date_12,'/%02u/averaging/',step,'/',div_12,'/mode/');
  ifilename_12 = sprintf(strcat(filepath_12,ifilename_fg),cond_12);
  fileID = fopen(ifilename_12,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,12) = fg';

  ifilename_12 = sprintf(strcat(filepath_12,ifilename_norm),cond_12);
  fileID = fopen(ifilename_12,'r');
  norm(:,:,12) = fscanf(fileID,'%f');
  fclose(fileID);

% 13
  filepath_13 = strcat('G:/',date_13,'/%02u/averaging/',step,'/',div_13,'/mode/');
  ifilename_13 = sprintf(strcat(filepath_13,ifilename_fg),cond_13);
  fileID = fopen(ifilename_13,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,13) = fg';

  ifilename_13 = sprintf(strcat(filepath_13,ifilename_norm),cond_13);
  fileID = fopen(ifilename_13,'r');
  norm(:,:,13) = fscanf(fileID,'%f');
  fclose(fileID);

% 14
  filepath_14 = strcat('G:/',date_14,'/%02u/averaging/',step,'/',div_14,'/mode/');
  ifilename_14 = sprintf(strcat(filepath_14,ifilename_fg),cond_14);
  fileID = fopen(ifilename_14,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,14) = fg';

  ifilename_14 = sprintf(strcat(filepath_14,ifilename_norm),cond_14);
  fileID = fopen(ifilename_14,'r');
  norm(:,:,14) = fscanf(fileID,'%f');
  fclose(fileID);
  
% 15
  filepath_15 = strcat('G:/',date_15,'/%02u/averaging/',step,'/',div_15,'/mode/');
  ifilename_15 = sprintf(strcat(filepath_15,ifilename_fg),cond_15);
  fileID = fopen(ifilename_15,'r');
  fg = fscanf(fileID,'%f',[2 Inf]);
  fclose(fileID);
  fg_v(:,:,15) = fg';

  ifilename_15 = sprintf(strcat(filepath_15,ifilename_norm),cond_15);
  fileID = fopen(ifilename_15,'r');
  norm(:,:,15) = fscanf(fileID,'%f');
  fclose(fileID);
  
% % 16
%   filepath_16 = strcat('G:/',date_16,'/%02u/averaging/',step,'/',div_16,'/mode/');
%   ifilename_16 = sprintf(strcat(filepath_16,ifilename_fg),cond_16);
%   fileID = fopen(ifilename_16,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,16) = fg';
% 
%   ifilename_16 = sprintf(strcat(filepath_16,ifilename_norm),cond_16);
%   fileID = fopen(ifilename_16,'r');
%   norm(:,:,16) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 17
%   filepath_17 = strcat('G:/',date_17,'/%02u/averaging/',step,'/',div_17,'/mode/');
%   ifilename_17 = sprintf(strcat(filepath_17,ifilename_fg),cond_17);
%   fileID = fopen(ifilename_17,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,17) = fg';
% 
%   ifilename_17 = sprintf(strcat(filepath_17,ifilename_norm),cond_17);
%   fileID = fopen(ifilename_17,'r');
%   norm(:,:,17) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 18
%   filepath_18 = strcat('G:/',date_18,'/%02u/averaging/',step,'/',div_18,'/mode/');
%   ifilename_18 = sprintf(strcat(filepath_18,ifilename_fg),cond_18);
%   fileID = fopen(ifilename_18,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,18) = fg';
% 
%   ifilename_18 = sprintf(strcat(filepath_18,ifilename_norm),cond_18);
%   fileID = fopen(ifilename_18,'r');
%   norm(:,:,18) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 19
%   filepath_19 = strcat('G:/',date_19,'/%02u/averaging/',step,'/',div_19,'/mode/');
%   ifilename_19 = sprintf(strcat(filepath_19,ifilename_fg),cond_19);
%   fileID = fopen(ifilename_19,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,19) = fg';
% 
%   ifilename_19 = sprintf(strcat(filepath_19,ifilename_norm),cond_19);
%   fileID = fopen(ifilename_19,'r');
%   norm(:,:,19) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 20
%   filepath_20 = strcat('G:/',date_20,'/%02u/averaging/',step,'/',div_20,'/mode/');
%   ifilename_20 = sprintf(strcat(filepath_20,ifilename_fg),cond_20);
%   fileID = fopen(ifilename_20,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,20) = fg';
% 
%   ifilename_20 = sprintf(strcat(filepath_20,ifilename_norm),cond_20);
%   fileID = fopen(ifilename_20,'r');
%   norm(:,:,20) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 21
%   filepath_21 = strcat('G:/',date_21,'/%02u/averaging/',step,'/',div_21,'/mode/');
%   ifilename_21 = sprintf(strcat(filepath_21,ifilename_fg),cond_21);
%   fileID = fopen(ifilename_21,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,21) = fg';
% 
%   ifilename_21 = sprintf(strcat(filepath_21,ifilename_norm),cond_21);
%   fileID = fopen(ifilename_21,'r');
%   norm(:,:,21) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 22
%   filepath_22 = strcat('G:/',date_22,'/%02u/averaging/',step,'/',div_22,'/mode/');
%   ifilename_22 = sprintf(strcat(filepath_22,ifilename_fg),cond_22);
%   fileID = fopen(ifilename_22,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,22) = fg';
% 
%   ifilename_22 = sprintf(strcat(filepath_22,ifilename_norm),cond_22);
%   fileID = fopen(ifilename_22,'r');
%   norm(:,:,22) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 23
%   filepath_23 = strcat('G:/',date_23,'/%02u/averaging/',step,'/',div_23,'/mode/');
%   ifilename_23 = sprintf(strcat(filepath_23,ifilename_fg),cond_23);
%   fileID = fopen(ifilename_23,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,23) = fg';
% 
%   ifilename_23 = sprintf(strcat(filepath_23,ifilename_norm),cond_23);
%   fileID = fopen(ifilename_23,'r');
%   norm(:,:,23) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 24
%   filepath_24 = strcat('G:/',date_24,'/%02u/averaging/',step,'/',div_24,'/mode/');
%   ifilename_24 = sprintf(strcat(filepath_24,ifilename_fg),cond_24);
%   fileID = fopen(ifilename_24,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,24) = fg';
% 
%   ifilename_24 = sprintf(strcat(filepath_24,ifilename_norm),cond_24);
%   fileID = fopen(ifilename_24,'r');
%   norm(:,:,24) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 25
%   filepath_25 = strcat('G:/',date_25,'/%02u/averaging/',step,'/',div_25,'/mode/');
%   ifilename_25 = sprintf(strcat(filepath_25,ifilename_fg),cond_25);
%   fileID = fopen(ifilename_25,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,25) = fg';
% 
%   ifilename_25 = sprintf(strcat(filepath_25,ifilename_norm),cond_25);
%   fileID = fopen(ifilename_25,'r');
%   norm(:,:,25) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 26
%   filepath_26 = strcat('G:/',date_26,'/%02u/averaging/',step,'/',div_26,'/mode/');
%   ifilename_26 = sprintf(strcat(filepath_26,ifilename_fg),cond_26);
%   fileID = fopen(ifilename_26,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,26) = fg';
% 
%   ifilename_26 = sprintf(strcat(filepath_26,ifilename_norm),cond_26);
%   fileID = fopen(ifilename_26,'r');
%   norm(:,:,26) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 27
%   filepath_27 = strcat('G:/',date_27,'/%02u/averaging/',step,'/',div_27,'/mode/');
%   ifilename_27 = sprintf(strcat(filepath_27,ifilename_fg),cond_27);
%   fileID = fopen(ifilename_27,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,27) = fg';
% 
%   ifilename_27 = sprintf(strcat(filepath_27,ifilename_norm),cond_27);
%   fileID = fopen(ifilename_27,'r');
%   norm(:,:,27) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 28
%   filepath_28 = strcat('G:/',date_28,'/%02u/averaging/',step,'/',div_28,'/mode/');
%   ifilename_28 = sprintf(strcat(filepath_28,ifilename_fg),cond_28);
%   fileID = fopen(ifilename_28,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,28) = fg';
% 
%   ifilename_28 = sprintf(strcat(filepath_28,ifilename_norm),cond_28);
%   fileID = fopen(ifilename_28,'r');
%   norm(:,:,28) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 29
%   filepath_29 = strcat('G:/',date_29,'/%02u/averaging/',step,'/',div_29,'/mode/');
%   ifilename_29 = sprintf(strcat(filepath_29,ifilename_fg),cond_29);
%   fileID = fopen(ifilename_29,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,29) = fg';
% 
%   ifilename_29 = sprintf(strcat(filepath_29,ifilename_norm),cond_29);
%   fileID = fopen(ifilename_29,'r');
%   norm(:,:,29) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 30
%   filepath_30 = strcat('G:/',date_30,'/%02u/averaging/',step,'/',div_30,'/mode/');
%   ifilename_30 = sprintf(strcat(filepath_30,ifilename_fg),cond_30);
%   fileID = fopen(ifilename_30,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,30) = fg';
% 
%   ifilename_30 = sprintf(strcat(filepath_30,ifilename_norm),cond_30);
%   fileID = fopen(ifilename_30,'r');
%   norm(:,:,30) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 31
%   filepath_31 = strcat('G:/',date_31,'/%02u/averaging/',step,'/',div_31,'/mode/');
%   ifilename_31 = sprintf(strcat(filepath_31,ifilename_fg),cond_31);
%   fileID = fopen(ifilename_31,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,31) = fg';
% 
%   ifilename_31 = sprintf(strcat(filepath_31,ifilename_norm),cond_31);
%   fileID = fopen(ifilename_31,'r');
%   norm(:,:,31) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 32
%   filepath_32 = strcat('G:/',date_32,'/%02u/averaging/',step,'/',div_32,'/mode/');
%   ifilename_32 = sprintf(strcat(filepath_32,ifilename_fg),cond_32);
%   fileID = fopen(ifilename_32,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,32) = fg';
% 
%   ifilename_32 = sprintf(strcat(filepath_32,ifilename_norm),cond_32);
%   fileID = fopen(ifilename_32,'r');
%   norm(:,:,32) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 33
%   filepath_33 = strcat('G:/',date_33,'/%02u/averaging/',step,'/',div_33,'/mode/');
%   ifilename_33 = sprintf(strcat(filepath_33,ifilename_fg),cond_33);
%   fileID = fopen(ifilename_33,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,33) = fg';
% 
%   ifilename_33 = sprintf(strcat(filepath_33,ifilename_norm),cond_33);
%   fileID = fopen(ifilename_33,'r');
%   norm(:,:,33) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 34
%   filepath_34 = strcat('G:/',date_34,'/%02u/averaging/',step,'/',div_34,'/mode/');
%   ifilename_34 = sprintf(strcat(filepath_34,ifilename_fg),cond_34);
%   fileID = fopen(ifilename_34,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,34) = fg';
% 
%   ifilename_34 = sprintf(strcat(filepath_34,ifilename_norm),cond_34);
%   fileID = fopen(ifilename_34,'r');
%   norm(:,:,34) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 35
%   filepath_35 = strcat('G:/',date_35,'/%02u/averaging/',step,'/',div_35,'/mode/');
%   ifilename_35 = sprintf(strcat(filepath_35,ifilename_fg),cond_35);
%   fileID = fopen(ifilename_35,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,35) = fg';
% 
%   ifilename_35 = sprintf(strcat(filepath_35,ifilename_norm),cond_35);
%   fileID = fopen(ifilename_35,'r');
%   norm(:,:,35) = fscanf(fileID,'%f');
%   fclose(fileID);
%   
% % 36
%   filepath_36 = strcat('G:/',date_36,'/%02u/averaging/',step,'/',div_36,'/mode/');
%   ifilename_36 = sprintf(strcat(filepath_36,ifilename_fg),cond_36);
%   fileID = fopen(ifilename_36,'r');
%   fg = fscanf(fileID,'%f',[2 Inf]);
%   fclose(fileID);
%   fg_v(:,:,36) = fg';
% 
%   ifilename_36 = sprintf(strcat(filepath_36,ifilename_norm),cond_36);
%   fileID = fopen(ifilename_36,'r');
%   norm(:,:,36) = fscanf(fileID,'%f');
%   fclose(fileID);  

%% COMBINE

  T = dt*length(norm(:,:,1))*increment; %data time [s]
  fg_combine = vertcat(fg_v(:,:,1),fg_v(:,:,2));
  norm_combine = vertcat(norm(:,1,1),norm(:,1,2));
  
  for i = 1:1:num_data-2
      fg_combine = vertcat(fg_combine,fg_v(:,:,i+2));
      norm_combine = vertcat(norm_combine,norm(:,1,i+2));
  end
      
%   fg_combine = vertcat(fg_v(:,:,1),fg_v(:,:,2),fg_v(:,:,3),fg_v(:,:,4),fg_v(:,:,5),fg_v(:,:,6),fg_v(:,:,7),fg_v(:,:,8),fg_v(:,:,9),fg_v(:,:,10),fg_v(:,:,11),fg_v(:,:,12),fg_v(:,:,13));
%   norm_combine=vertcat(norm(:,1,1),norm(:,1,2),norm(:,1,3),norm(:,1,4),norm(:,1,5),norm(:,1,6),norm(:,1,7),norm(:,1,8),norm(:,1,9),norm(:,1,10),norm(:,1,11),norm(:,1,12),norm(:,1,13));

%% SORT

  tmp_fg_r = 0;
  tmp_fg_i = 0;
  tmp_norm = 0;
  
  for i = 1:1:length(norm_combine)
      for j = i+1:1:length(norm_combine)
          if fg_combine(i,1) > fg_combine(j,1)
              tmp_fg_r = fg_combine(i,1);
              fg_combine(i,1) = fg_combine(j,1);
              fg_combine(j,1) = tmp_fg_r;
              
              tmp_fg_i = fg_combine(i,2);
              fg_combine(i,2) = fg_combine(j,2);
              fg_combine(j,2) = tmp_fg_i;
              
              tmp_norm = norm_combine(i,1);
              norm_combine(i,1) = norm_combine(j,1);
              norm_combine(j,1) = tmp_norm;
          end
      end
  end

%% FILTERING_1

  for k = 1:1:length(norm_combine) - 2*ceil(average_width/2) + 1
      fg_fil(k) = mean(fg_combine(k:1:k+average_width-1,1));
      norm_fil(k) = mean(norm_combine(k:1:k+average_width-1,1));
  end
  
  fg_fil = fg_fil';
  norm_fil = norm_fil';

%% SAVE, FILTERED_1

  fg_fil_out = sprintf(strcat(filepath_out,'fg_real_fil_%02u_',step,'.dat'),flow_rate);
  fileID = fopen(fg_fil_out,'w');
  fwrite(fileID,fg_fil,'double');
  fclose(fileID);
  
  norm_fil_out = sprintf(strcat(filepath_out,'norm_fil_%02u_',step,'.dat'),flow_rate);
  fileID = fopen(norm_fil_out,'w');
  fwrite(fileID,norm_fil,'double');
  fclose(fileID);

%% IF=1

      if id == 1
%% MAKE A FIGURE

        figure('Position', [50 50 960 735],'Color','white');
%         stem(fg_combine(:,1),norm_combine(:,1),'k') % no filter
        loglog(fg_fil,norm_fil,'-v','MarkerSize',5,'MarkerFaceColor','w','Color','k') % filtered
        
        ax = gca;
        xtickformat('%d')
%         xticks([20 30 40 50 60 70 80 90 100 200])
%         set(gca,'xTickLabel', char('20','','40','','60','','80','','100','200'))
        ytickformat('%d')
%         yticks([0.00000001 0.000001 0.0001 0.01 1 100 10000])
%         set(gca,'YTickLabel', char('10^{-8}','10^{-6}','10^{-4}','10^{-2}','10^{0}','10^{2}','10^{4}'))

        ax.XAxisLocation = 'bottom';
        ax.YDir='normal';
        ax.YAxisLocation = 'left';
        ax.XColor = 'black';
        ax.YColor = 'black';
%         ax.XScale = 'log';
%         ax.YScale = 'log';
        ax.XLim = [20 300];
        ax.YLim = [10^0 10^4];
        ax.FontSize = 20;
        ax.FontName =  'Times New Roman';
        ax.TitleFontSizeMultiplier = 2;
        ax.Box = 'on';
        ax.LineWidth = 2.0;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        
        xlabel('\it{ f}_j \rm{[Hz]}')
        ylabel('||\it{\bf{v}}_j||')   
        pbaspect([sqrt(2) 1 1]);

        figname_out = sprintf(strcat(filepath_out,'fig/fg_fil_norm_av_%02u_',step,'.png'),flow_rate);
        saveas(gca,figname_out)
        
      end

%% IF=2

      if id == 2  %norm (considering damp)
          
        norm_d = norm_combine.* abs(exp((fg_combine(:,2)+sqrt(-1)*2*pi*fg_combine(:,1))*T));
        ii = 0;
        norm_dm = 0;
        fg_m = 0;

        for j = 1:length(norm_combine)
            if fg_combine(j,1) >= 0
                ii = ii + 1;
                norm_dm(ii) = norm_d(j);
                fg_m(ii) = fg_combine(j,1);
            end
        end
        
        norm_dm = norm_dm';
        fg_m = fg_m';

%% FILTERING_2

        for k = 1:1:length(norm_dm)-2*ceil(average_width/2)+1
            fg_m_fil(k) = mean(fg_m(k:1:k+average_width-1,1));
            norm_dm_fil(k) = mean(norm_dm(k:1:k+average_width-1,1));
        end
  
        fg_m_fil=fg_m_fil';
        norm_dm_fil=norm_dm_fil';

%% SAVE, FILTERED_2

        fg_m_fil_out = sprintf(strcat(filepath_out,'fg_m_real_fil_%02u_',step,'.dat'),flow_rate);
        fileID = fopen(fg_m_fil_out,'w');
        fwrite(fileID,fg_m_fil,'double');
        fclose(fileID);
  
        norm_dm_fil_out = sprintf(strcat(filepath_out,'norm_dm_fil_%02u_',step,'.dat'),flow_rate);
        fileID = fopen(norm_dm_fil_out,'w');
        fwrite(fileID,norm_dm_fil,'double');
        fclose(fileID);

%% MAKE FIGURES

        figure('Position', [50 50 960 735],'Color','white');
%         loglog(fg_m,norm_dm,'-v','MarkerSize',5,'MarkerFaceColor','w','Color','k') % no filter
        loglog(fg_m_fil,norm_dm_fil,'-v','MarkerSize',5,'MarkerFaceColor','w','Color','k') % filtered
        
        ax = gca;
        xtickformat('%d')
%         xticks([20 30 40 50 60 70 80 90 100 200])
%         set(gca,'xTickLabel', char('20','','40','','60','','80','','100','200'))
        ytickformat('%d')
%         yticks([0.00000001 0.000001 0.0001 0.01 1 100 10000])
%         set(gca,'YTickLabel', char('10^{-8}','10^{-6}','10^{-4}','10^{-2}','10^{0}','10^{2}','10^{4}'))

        ax.XAxisLocation = 'bottom';
        ax.YDir='normal';
        ax.YAxisLocation = 'left';
        ax.XColor = 'black';
        ax.YColor = 'black';
%         ax.XScale = 'log';
%         ax.YScale = 'log';
        ax.XLim = [20 300];
        ax.YLim = [10^-1 10^2];
        ax.FontSize = 20;
        ax.FontName =  'Times New Roman';
        ax.TitleFontSizeMultiplier = 2;
        ax.Box = 'on';
        ax.LineWidth = 2.0;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        
        xlabel('\it{ f}_j \rm{[Hz]}')
        ylabel('|\it{\lambda}_{j}^{m}| ||\it{\bf{v}}_j||')
        pbaspect([sqrt(2) 1 1]);

        figname_out=sprintf(strcat(filepath_out,'fig/fg_m_fil_norm_dm_av_%02u_',step,'.png'),flow_rate);
        saveas(gca,figname_out)
        
      end