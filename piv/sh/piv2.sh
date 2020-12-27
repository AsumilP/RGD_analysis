#!/bin/sh

../../imgcor/imgcor &
wait
./piv -s 1 -n 2000 --dt 50 -i ../z1_41_cor.dat -o ../velo/z1_41_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_41_cor.dat -o ../velo/z1_41_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_41_cor.dat -o ../velo/z2_41_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_41_cor.dat -o ../velo/z2_41_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z1_42_cor.dat -o ../velo/z1_42_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_42_cor.dat -o ../velo/z1_42_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_42_cor.dat -o ../velo/z2_42_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_42_cor.dat -o ../velo/z2_42_velo02.dat &
wait
./piv -s 4001 -n 2000 --dt 50 -i ../z1_41_cor.dat -o ../velo/z1_41_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_41_cor.dat -o ../velo/z1_41_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_41_cor.dat -o ../velo/z2_41_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_41_cor.dat -o ../velo/z2_41_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z1_42_cor.dat -o ../velo/z1_42_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_42_cor.dat -o ../velo/z1_42_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_42_cor.dat -o ../velo/z2_42_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_42_cor.dat -o ../velo/z2_42_velo04.dat &
wait
./piv -s 8001 -n 2000 --dt 50 -i ../z1_41_cor.dat -o ../velo/z1_41_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_41_cor.dat -o ../velo/z1_41_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_41_cor.dat -o ../velo/z2_41_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_41_cor.dat -o ../velo/z2_41_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z1_42_cor.dat -o ../velo/z1_42_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_42_cor.dat -o ../velo/z1_42_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_42_cor.dat -o ../velo/z2_42_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_42_cor.dat -o ../velo/z2_42_velo06.dat &
wait
./piv -s 1 -n 2000 --dt 50 -i ../z1_43_cor.dat -o ../velo/z1_43_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_43_cor.dat -o ../velo/z1_43_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_43_cor.dat -o ../velo/z2_43_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_43_cor.dat -o ../velo/z2_43_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z1_44_cor.dat -o ../velo/z1_44_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_44_cor.dat -o ../velo/z1_44_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_44_cor.dat -o ../velo/z2_44_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_44_cor.dat -o ../velo/z2_44_velo02.dat &
wait
./piv -s 4001 -n 2000 --dt 50 -i ../z1_43_cor.dat -o ../velo/z1_43_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_43_cor.dat -o ../velo/z1_43_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_43_cor.dat -o ../velo/z2_43_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_43_cor.dat -o ../velo/z2_43_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z1_44_cor.dat -o ../velo/z1_44_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_44_cor.dat -o ../velo/z1_44_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_44_cor.dat -o ../velo/z2_44_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_44_cor.dat -o ../velo/z2_44_velo04.dat &
wait
./piv -s 8001 -n 2000 --dt 50 -i ../z1_43_cor.dat -o ../velo/z1_43_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_43_cor.dat -o ../velo/z1_43_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_43_cor.dat -o ../velo/z2_43_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_43_cor.dat -o ../velo/z2_43_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z1_44_cor.dat -o ../velo/z1_44_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_44_cor.dat -o ../velo/z1_44_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_44_cor.dat -o ../velo/z2_44_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_44_cor.dat -o ../velo/z2_44_velo06.dat &
wait
./piv -s 1 -n 2000 --dt 50 -i ../z1_45_cor.dat -o ../velo/z1_45_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_45_cor.dat -o ../velo/z1_45_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_45_cor.dat -o ../velo/z2_45_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_45_cor.dat -o ../velo/z2_45_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z1_46_cor.dat -o ../velo/z1_46_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_46_cor.dat -o ../velo/z1_46_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_46_cor.dat -o ../velo/z2_46_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_46_cor.dat -o ../velo/z2_46_velo02.dat &
wait
./piv -s 4001 -n 2000 --dt 50 -i ../z1_45_cor.dat -o ../velo/z1_45_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_45_cor.dat -o ../velo/z1_45_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_45_cor.dat -o ../velo/z2_45_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_45_cor.dat -o ../velo/z2_45_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z1_46_cor.dat -o ../velo/z1_46_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_46_cor.dat -o ../velo/z1_46_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_46_cor.dat -o ../velo/z2_46_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_46_cor.dat -o ../velo/z2_46_velo04.dat &
wait
./piv -s 8001 -n 2000 --dt 50 -i ../z1_45_cor.dat -o ../velo/z1_45_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_45_cor.dat -o ../velo/z1_45_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_45_cor.dat -o ../velo/z2_45_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_45_cor.dat -o ../velo/z2_45_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z1_46_cor.dat -o ../velo/z1_46_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_46_cor.dat -o ../velo/z1_46_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_46_cor.dat -o ../velo/z2_46_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_46_cor.dat -o ../velo/z2_46_velo06.dat &
wait
./piv -s 1 -n 2000 --dt 50 -i ../z1_47_cor.dat -o ../velo/z1_47_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_47_cor.dat -o ../velo/z1_47_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_47_cor.dat -o ../velo/z2_47_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_47_cor.dat -o ../velo/z2_47_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z1_48_cor.dat -o ../velo/z1_48_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_48_cor.dat -o ../velo/z1_48_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_48_cor.dat -o ../velo/z2_48_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_48_cor.dat -o ../velo/z2_48_velo02.dat &
wait
./piv -s 4001 -n 2000 --dt 50 -i ../z1_47_cor.dat -o ../velo/z1_47_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_47_cor.dat -o ../velo/z1_47_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_47_cor.dat -o ../velo/z2_47_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_47_cor.dat -o ../velo/z2_47_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z1_48_cor.dat -o ../velo/z1_48_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_48_cor.dat -o ../velo/z1_48_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_48_cor.dat -o ../velo/z2_48_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_48_cor.dat -o ../velo/z2_48_velo04.dat &
wait
./piv -s 8001 -n 2000 --dt 50 -i ../z1_47_cor.dat -o ../velo/z1_47_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_47_cor.dat -o ../velo/z1_47_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_47_cor.dat -o ../velo/z2_47_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_47_cor.dat -o ../velo/z2_47_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z1_48_cor.dat -o ../velo/z1_48_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_48_cor.dat -o ../velo/z1_48_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_48_cor.dat -o ../velo/z2_48_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_48_cor.dat -o ../velo/z2_48_velo06.dat &
wait
./piv -s 1 -n 2000 --dt 50 -i ../z1_49_cor.dat -o ../velo/z1_49_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_49_cor.dat -o ../velo/z1_49_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_49_cor.dat -o ../velo/z2_49_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_49_cor.dat -o ../velo/z2_49_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z1_50_cor.dat -o ../velo/z1_50_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_50_cor.dat -o ../velo/z1_50_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_50_cor.dat -o ../velo/z2_50_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_50_cor.dat -o ../velo/z2_50_velo02.dat &
wait
./piv -s 4001 -n 2000 --dt 50 -i ../z1_49_cor.dat -o ../velo/z1_49_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_49_cor.dat -o ../velo/z1_49_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_49_cor.dat -o ../velo/z2_49_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_49_cor.dat -o ../velo/z2_49_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z1_50_cor.dat -o ../velo/z1_50_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_50_cor.dat -o ../velo/z1_50_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_50_cor.dat -o ../velo/z2_50_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_50_cor.dat -o ../velo/z2_50_velo04.dat &
wait
./piv -s 8001 -n 2000 --dt 50 -i ../z1_49_cor.dat -o ../velo/z1_49_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_49_cor.dat -o ../velo/z1_49_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_49_cor.dat -o ../velo/z2_49_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_49_cor.dat -o ../velo/z2_49_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z1_50_cor.dat -o ../velo/z1_50_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_50_cor.dat -o ../velo/z1_50_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_50_cor.dat -o ../velo/z2_50_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_50_cor.dat -o ../velo/z2_50_velo06.dat &
wait
./piv -s 1 -n 2000 --dt 50 -i ../z1_51_cor.dat -o ../velo/z1_51_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_51_cor.dat -o ../velo/z1_51_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_51_cor.dat -o ../velo/z2_51_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_51_cor.dat -o ../velo/z2_51_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z1_52_cor.dat -o ../velo/z1_52_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_52_cor.dat -o ../velo/z1_52_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_52_cor.dat -o ../velo/z2_52_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_52_cor.dat -o ../velo/z2_52_velo02.dat &
wait
./piv -s 4001 -n 2000 --dt 50 -i ../z1_51_cor.dat -o ../velo/z1_51_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_51_cor.dat -o ../velo/z1_51_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_51_cor.dat -o ../velo/z2_51_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_51_cor.dat -o ../velo/z2_51_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z1_52_cor.dat -o ../velo/z1_52_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_52_cor.dat -o ../velo/z1_52_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_52_cor.dat -o ../velo/z2_52_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_52_cor.dat -o ../velo/z2_52_velo04.dat &
wait
./piv -s 8001 -n 2000 --dt 50 -i ../z1_51_cor.dat -o ../velo/z1_51_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_51_cor.dat -o ../velo/z1_51_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_51_cor.dat -o ../velo/z2_51_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_51_cor.dat -o ../velo/z2_51_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z1_52_cor.dat -o ../velo/z1_52_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_52_cor.dat -o ../velo/z1_52_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_52_cor.dat -o ../velo/z2_52_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_52_cor.dat -o ../velo/z2_52_velo06.dat &
wait
./piv -s 1 -n 2000 --dt 50 -i ../z1_53_cor.dat -o ../velo/z1_53_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_53_cor.dat -o ../velo/z1_53_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_53_cor.dat -o ../velo/z2_53_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_53_cor.dat -o ../velo/z2_53_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z1_54_cor.dat -o ../velo/z1_54_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_54_cor.dat -o ../velo/z1_54_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_54_cor.dat -o ../velo/z2_54_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_54_cor.dat -o ../velo/z2_54_velo02.dat &
wait
./piv -s 4001 -n 2000 --dt 50 -i ../z1_53_cor.dat -o ../velo/z1_53_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_53_cor.dat -o ../velo/z1_53_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_53_cor.dat -o ../velo/z2_53_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_53_cor.dat -o ../velo/z2_53_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z1_54_cor.dat -o ../velo/z1_54_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_54_cor.dat -o ../velo/z1_54_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_54_cor.dat -o ../velo/z2_54_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_54_cor.dat -o ../velo/z2_54_velo04.dat &
wait
./piv -s 8001 -n 2000 --dt 50 -i ../z1_53_cor.dat -o ../velo/z1_53_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_53_cor.dat -o ../velo/z1_53_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_53_cor.dat -o ../velo/z2_53_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_53_cor.dat -o ../velo/z2_53_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z1_54_cor.dat -o ../velo/z1_54_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_54_cor.dat -o ../velo/z1_54_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_54_cor.dat -o ../velo/z2_54_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_54_cor.dat -o ../velo/z2_54_velo06.dat &
wait
./piv -s 1 -n 2000 --dt 50 -i ../z1_55_cor.dat -o ../velo/z1_55_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_55_cor.dat -o ../velo/z1_55_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_55_cor.dat -o ../velo/z2_55_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_55_cor.dat -o ../velo/z2_55_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z1_56_cor.dat -o ../velo/z1_56_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_56_cor.dat -o ../velo/z1_56_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_56_cor.dat -o ../velo/z2_56_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_56_cor.dat -o ../velo/z2_56_velo02.dat &
wait
./piv -s 4001 -n 2000 --dt 50 -i ../z1_55_cor.dat -o ../velo/z1_55_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_55_cor.dat -o ../velo/z1_55_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_55_cor.dat -o ../velo/z2_55_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_55_cor.dat -o ../velo/z2_55_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z1_56_cor.dat -o ../velo/z1_56_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_56_cor.dat -o ../velo/z1_56_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_56_cor.dat -o ../velo/z2_56_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_56_cor.dat -o ../velo/z2_56_velo04.dat &
wait
./piv -s 8001 -n 2000 --dt 50 -i ../z1_55_cor.dat -o ../velo/z1_55_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_55_cor.dat -o ../velo/z1_55_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_55_cor.dat -o ../velo/z2_55_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_55_cor.dat -o ../velo/z2_55_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z1_56_cor.dat -o ../velo/z1_56_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_56_cor.dat -o ../velo/z1_56_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_56_cor.dat -o ../velo/z2_56_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_56_cor.dat -o ../velo/z2_56_velo06.dat &
wait
./piv -s 1 -n 2000 --dt 50 -i ../z1_57_cor.dat -o ../velo/z1_57_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_57_cor.dat -o ../velo/z1_57_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_57_cor.dat -o ../velo/z2_57_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_57_cor.dat -o ../velo/z2_57_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z1_58_cor.dat -o ../velo/z1_58_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_58_cor.dat -o ../velo/z1_58_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_58_cor.dat -o ../velo/z2_58_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_58_cor.dat -o ../velo/z2_58_velo02.dat &
wait
./piv -s 4001 -n 2000 --dt 50 -i ../z1_57_cor.dat -o ../velo/z1_57_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_57_cor.dat -o ../velo/z1_57_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_57_cor.dat -o ../velo/z2_57_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_57_cor.dat -o ../velo/z2_57_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z1_58_cor.dat -o ../velo/z1_58_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_58_cor.dat -o ../velo/z1_58_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_58_cor.dat -o ../velo/z2_58_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_58_cor.dat -o ../velo/z2_58_velo04.dat &
wait
./piv -s 8001 -n 2000 --dt 50 -i ../z1_57_cor.dat -o ../velo/z1_57_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_57_cor.dat -o ../velo/z1_57_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_57_cor.dat -o ../velo/z2_57_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_57_cor.dat -o ../velo/z2_57_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z1_58_cor.dat -o ../velo/z1_58_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_58_cor.dat -o ../velo/z1_58_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_58_cor.dat -o ../velo/z2_58_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_58_cor.dat -o ../velo/z2_58_velo06.dat &
wait
./piv -s 1 -n 2000 --dt 50 -i ../z1_59_cor.dat -o ../velo/z1_59_velo01.dat &
./piv -s 3001 -n 2000 --dt 50 -i ../z1_59_cor.dat -o ../velo/z1_59_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_59_cor.dat -o ../velo/z2_59_velo01.dat &
./piv -s 3001 -n 2000 --dt 50 -i ../z2_59_cor.dat -o ../velo/z2_59_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z1_60_cor.dat -o ../velo/z1_60_velo01.dat &
./piv -s 3001 -n 2000 --dt 50 -i ../z1_60_cor.dat -o ../velo/z1_60_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_60_cor.dat -o ../velo/z2_60_velo01.dat &
./piv -s 3001 -n 2000 --dt 50 -i ../z2_60_cor.dat -o ../velo/z2_60_velo02.dat &
wait
./piv -s 4001 -n 2000 --dt 50 -i ../z1_59_cor.dat -o ../velo/z1_59_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_59_cor.dat -o ../velo/z1_59_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_59_cor.dat -o ../velo/z2_59_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_59_cor.dat -o ../velo/z2_59_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z1_60_cor.dat -o ../velo/z1_60_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_60_cor.dat -o ../velo/z1_60_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_60_cor.dat -o ../velo/z2_60_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_60_cor.dat -o ../velo/z2_60_velo04.dat &
wait
./piv -s 8001 -n 2000 --dt 50 -i ../z1_59_cor.dat -o ../velo/z1_59_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_59_cor.dat -o ../velo/z1_59_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_59_cor.dat -o ../velo/z2_59_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_59_cor.dat -o ../velo/z2_59_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z1_60_cor.dat -o ../velo/z1_60_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_60_cor.dat -o ../velo/z1_60_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_60_cor.dat -o ../velo/z2_60_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_60_cor.dat -o ../velo/z2_60_velo06.dat &
wait
./piv -s 1 -n 2000 --dt 50 -i ../z1_61_cor.dat -o ../velo/z1_61_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_61_cor.dat -o ../velo/z1_61_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_61_cor.dat -o ../velo/z2_61_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_61_cor.dat -o ../velo/z2_61_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z1_62_cor.dat -o ../velo/z1_62_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_62_cor.dat -o ../velo/z1_62_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_62_cor.dat -o ../velo/z2_62_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_62_cor.dat -o ../velo/z2_62_velo02.dat &
wait
./piv -s 4001 -n 2000 --dt 50 -i ../z1_61_cor.dat -o ../velo/z1_61_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_61_cor.dat -o ../velo/z1_61_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_61_cor.dat -o ../velo/z2_61_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_61_cor.dat -o ../velo/z2_61_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z1_62_cor.dat -o ../velo/z1_62_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_62_cor.dat -o ../velo/z1_62_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_62_cor.dat -o ../velo/z2_62_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_62_cor.dat -o ../velo/z2_62_velo04.dat &
wait
./piv -s 8001 -n 2000 --dt 50 -i ../z1_61_cor.dat -o ../velo/z1_61_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_61_cor.dat -o ../velo/z1_61_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_61_cor.dat -o ../velo/z2_61_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_61_cor.dat -o ../velo/z2_61_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z1_62_cor.dat -o ../velo/z1_62_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_62_cor.dat -o ../velo/z1_62_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_62_cor.dat -o ../velo/z2_62_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_62_cor.dat -o ../velo/z2_62_velo06.dat &
wait
./piv -s 1 -n 2000 --dt 50 -i ../z1_63_cor.dat -o ../velo/z1_63_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_63_cor.dat -o ../velo/z1_63_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_63_cor.dat -o ../velo/z2_63_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_63_cor.dat -o ../velo/z2_63_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z1_64_cor.dat -o ../velo/z1_64_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_64_cor.dat -o ../velo/z1_64_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_64_cor.dat -o ../velo/z2_64_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_64_cor.dat -o ../velo/z2_64_velo02.dat &
wait
./piv -s 4001 -n 2000 --dt 50 -i ../z1_63_cor.dat -o ../velo/z1_63_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_63_cor.dat -o ../velo/z1_63_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_63_cor.dat -o ../velo/z2_63_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_63_cor.dat -o ../velo/z2_63_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z1_64_cor.dat -o ../velo/z1_64_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_64_cor.dat -o ../velo/z1_64_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_64_cor.dat -o ../velo/z2_64_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_64_cor.dat -o ../velo/z2_64_velo04.dat &
wait
./piv -s 8001 -n 2000 --dt 50 -i ../z1_63_cor.dat -o ../velo/z1_63_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_63_cor.dat -o ../velo/z1_63_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_63_cor.dat -o ../velo/z2_63_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_63_cor.dat -o ../velo/z2_63_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z1_64_cor.dat -o ../velo/z1_64_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_64_cor.dat -o ../velo/z1_64_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_64_cor.dat -o ../velo/z2_64_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_64_cor.dat -o ../velo/z2_64_velo06.dat &
wait
./piv -s 1 -n 2000 --dt 50 -i ../z1_65_cor.dat -o ../velo/z1_65_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_65_cor.dat -o ../velo/z1_65_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_65_cor.dat -o ../velo/z2_65_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_65_cor.dat -o ../velo/z2_65_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z1_66_cor.dat -o ../velo/z1_66_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_66_cor.dat -o ../velo/z1_66_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_66_cor.dat -o ../velo/z2_66_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_66_cor.dat -o ../velo/z2_66_velo02.dat &
wait
./piv -s 4001 -n 2000 --dt 50 -i ../z1_65_cor.dat -o ../velo/z1_65_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_65_cor.dat -o ../velo/z1_65_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_65_cor.dat -o ../velo/z2_65_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_65_cor.dat -o ../velo/z2_65_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z1_66_cor.dat -o ../velo/z1_66_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_66_cor.dat -o ../velo/z1_66_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_66_cor.dat -o ../velo/z2_66_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_66_cor.dat -o ../velo/z2_66_velo04.dat &
wait
./piv -s 8001 -n 2000 --dt 50 -i ../z1_65_cor.dat -o ../velo/z1_65_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_65_cor.dat -o ../velo/z1_65_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_65_cor.dat -o ../velo/z2_65_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_65_cor.dat -o ../velo/z2_65_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z1_66_cor.dat -o ../velo/z1_66_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_66_cor.dat -o ../velo/z1_66_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_66_cor.dat -o ../velo/z2_66_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_66_cor.dat -o ../velo/z2_66_velo06.dat &
wait
./piv -s 1 -n 2000 --dt 50 -i ../z1_67_cor.dat -o ../velo/z1_67_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_67_cor.dat -o ../velo/z1_67_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_67_cor.dat -o ../velo/z2_67_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_67_cor.dat -o ../velo/z2_67_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z1_68_cor.dat -o ../velo/z1_68_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z1_68_cor.dat -o ../velo/z1_68_velo02.dat &
./piv -s 1 -n 2000 --dt 50 -i ../z2_68_cor.dat -o ../velo/z2_68_velo01.dat &
./piv -s 2001 -n 2000 --dt 50 -i ../z2_68_cor.dat -o ../velo/z2_68_velo02.dat &
wait
./piv -s 4001 -n 2000 --dt 50 -i ../z1_67_cor.dat -o ../velo/z1_67_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_67_cor.dat -o ../velo/z1_67_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_67_cor.dat -o ../velo/z2_67_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_67_cor.dat -o ../velo/z2_67_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z1_68_cor.dat -o ../velo/z1_68_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z1_68_cor.dat -o ../velo/z1_68_velo04.dat &
./piv -s 4001 -n 2000 --dt 50 -i ../z2_68_cor.dat -o ../velo/z2_68_velo03.dat &
./piv -s 6001 -n 2000 --dt 50 -i ../z2_68_cor.dat -o ../velo/z2_68_velo04.dat &
wait
./piv -s 8001 -n 2000 --dt 50 -i ../z1_67_cor.dat -o ../velo/z1_67_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_67_cor.dat -o ../velo/z1_67_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_67_cor.dat -o ../velo/z2_67_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_67_cor.dat -o ../velo/z2_67_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z1_68_cor.dat -o ../velo/z1_68_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z1_68_cor.dat -o ../velo/z1_68_velo06.dat &
./piv -s 8001 -n 2000 --dt 50 -i ../z2_68_cor.dat -o ../velo/z2_68_velo05.dat &
./piv -s 10001 -n 2000 --dt 50 -i ../z2_68_cor.dat -o ../velo/z2_68_velo06.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_41_cor.dat -o ../velo/z1_41_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_41_cor.dat -o ../velo/z1_41_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_41_cor.dat -o ../velo/z2_41_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_41_cor.dat -o ../velo/z2_41_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_41_cor.dat -o ../velo/z1_41_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_41_cor.dat -o ../velo/z1_41_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_41_cor.dat -o ../velo/z2_41_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_41_cor.dat -o ../velo/z2_41_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_42_cor.dat -o ../velo/z1_42_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_42_cor.dat -o ../velo/z1_42_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_42_cor.dat -o ../velo/z2_42_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_42_cor.dat -o ../velo/z2_42_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_42_cor.dat -o ../velo/z1_42_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_42_cor.dat -o ../velo/z1_42_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_42_cor.dat -o ../velo/z2_42_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_42_cor.dat -o ../velo/z2_42_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_43_cor.dat -o ../velo/z1_43_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_43_cor.dat -o ../velo/z1_43_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_43_cor.dat -o ../velo/z2_43_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_43_cor.dat -o ../velo/z2_43_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_43_cor.dat -o ../velo/z1_43_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_43_cor.dat -o ../velo/z1_43_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_43_cor.dat -o ../velo/z2_43_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_43_cor.dat -o ../velo/z2_43_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_44_cor.dat -o ../velo/z1_44_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_44_cor.dat -o ../velo/z1_44_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_44_cor.dat -o ../velo/z2_44_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_44_cor.dat -o ../velo/z2_44_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_44_cor.dat -o ../velo/z1_44_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_44_cor.dat -o ../velo/z1_44_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_44_cor.dat -o ../velo/z2_44_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_44_cor.dat -o ../velo/z2_44_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_45_cor.dat -o ../velo/z1_45_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_45_cor.dat -o ../velo/z1_45_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_45_cor.dat -o ../velo/z2_45_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_45_cor.dat -o ../velo/z2_45_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_45_cor.dat -o ../velo/z1_45_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_45_cor.dat -o ../velo/z1_45_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_45_cor.dat -o ../velo/z2_45_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_45_cor.dat -o ../velo/z2_45_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_46_cor.dat -o ../velo/z1_46_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_46_cor.dat -o ../velo/z1_46_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_46_cor.dat -o ../velo/z2_46_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_46_cor.dat -o ../velo/z2_46_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_46_cor.dat -o ../velo/z1_46_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_46_cor.dat -o ../velo/z1_46_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_46_cor.dat -o ../velo/z2_46_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_46_cor.dat -o ../velo/z2_46_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_47_cor.dat -o ../velo/z1_47_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_47_cor.dat -o ../velo/z1_47_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_47_cor.dat -o ../velo/z2_47_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_47_cor.dat -o ../velo/z2_47_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_47_cor.dat -o ../velo/z1_47_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_47_cor.dat -o ../velo/z1_47_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_47_cor.dat -o ../velo/z2_47_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_47_cor.dat -o ../velo/z2_47_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_48_cor.dat -o ../velo/z1_48_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_48_cor.dat -o ../velo/z1_48_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_48_cor.dat -o ../velo/z2_48_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_48_cor.dat -o ../velo/z2_48_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_48_cor.dat -o ../velo/z1_48_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_48_cor.dat -o ../velo/z1_48_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_48_cor.dat -o ../velo/z2_48_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_48_cor.dat -o ../velo/z2_48_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_49_cor.dat -o ../velo/z1_49_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_49_cor.dat -o ../velo/z1_49_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_49_cor.dat -o ../velo/z2_49_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_49_cor.dat -o ../velo/z2_49_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_49_cor.dat -o ../velo/z1_49_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_49_cor.dat -o ../velo/z1_49_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_49_cor.dat -o ../velo/z2_49_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_49_cor.dat -o ../velo/z2_49_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_50_cor.dat -o ../velo/z1_50_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_50_cor.dat -o ../velo/z1_50_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_50_cor.dat -o ../velo/z2_50_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_50_cor.dat -o ../velo/z2_50_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_50_cor.dat -o ../velo/z1_50_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_50_cor.dat -o ../velo/z1_50_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_50_cor.dat -o ../velo/z2_50_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_50_cor.dat -o ../velo/z2_50_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_51_cor.dat -o ../velo/z1_51_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_51_cor.dat -o ../velo/z1_51_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_51_cor.dat -o ../velo/z2_51_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_51_cor.dat -o ../velo/z2_51_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_51_cor.dat -o ../velo/z1_51_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_51_cor.dat -o ../velo/z1_51_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_51_cor.dat -o ../velo/z2_51_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_51_cor.dat -o ../velo/z2_51_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_52_cor.dat -o ../velo/z1_52_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_52_cor.dat -o ../velo/z1_52_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_52_cor.dat -o ../velo/z2_52_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_52_cor.dat -o ../velo/z2_52_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_52_cor.dat -o ../velo/z1_52_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_52_cor.dat -o ../velo/z1_52_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_52_cor.dat -o ../velo/z2_52_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_52_cor.dat -o ../velo/z2_52_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_53_cor.dat -o ../velo/z1_53_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_53_cor.dat -o ../velo/z1_53_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_53_cor.dat -o ../velo/z2_53_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_53_cor.dat -o ../velo/z2_53_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_53_cor.dat -o ../velo/z1_53_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_53_cor.dat -o ../velo/z1_53_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_53_cor.dat -o ../velo/z2_53_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_53_cor.dat -o ../velo/z2_53_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_54_cor.dat -o ../velo/z1_54_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_54_cor.dat -o ../velo/z1_54_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_54_cor.dat -o ../velo/z2_54_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_54_cor.dat -o ../velo/z2_54_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_54_cor.dat -o ../velo/z1_54_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_54_cor.dat -o ../velo/z1_54_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_54_cor.dat -o ../velo/z2_54_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_54_cor.dat -o ../velo/z2_54_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_55_cor.dat -o ../velo/z1_55_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_55_cor.dat -o ../velo/z1_55_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_55_cor.dat -o ../velo/z2_55_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_55_cor.dat -o ../velo/z2_55_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_55_cor.dat -o ../velo/z1_55_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_55_cor.dat -o ../velo/z1_55_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_55_cor.dat -o ../velo/z2_55_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_55_cor.dat -o ../velo/z2_55_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_56_cor.dat -o ../velo/z1_56_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_56_cor.dat -o ../velo/z1_56_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_56_cor.dat -o ../velo/z2_56_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_56_cor.dat -o ../velo/z2_56_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_56_cor.dat -o ../velo/z1_56_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_56_cor.dat -o ../velo/z1_56_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_56_cor.dat -o ../velo/z2_56_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_56_cor.dat -o ../velo/z2_56_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_57_cor.dat -o ../velo/z1_57_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_57_cor.dat -o ../velo/z1_57_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_57_cor.dat -o ../velo/z2_57_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_57_cor.dat -o ../velo/z2_57_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_57_cor.dat -o ../velo/z1_57_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_57_cor.dat -o ../velo/z1_57_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_57_cor.dat -o ../velo/z2_57_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_57_cor.dat -o ../velo/z2_57_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_58_cor.dat -o ../velo/z1_58_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_58_cor.dat -o ../velo/z1_58_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_58_cor.dat -o ../velo/z2_58_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_58_cor.dat -o ../velo/z2_58_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_58_cor.dat -o ../velo/z1_58_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_58_cor.dat -o ../velo/z1_58_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_58_cor.dat -o ../velo/z2_58_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_58_cor.dat -o ../velo/z2_58_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_59_cor.dat -o ../velo/z1_59_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_59_cor.dat -o ../velo/z1_59_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_59_cor.dat -o ../velo/z2_59_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_59_cor.dat -o ../velo/z2_59_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_59_cor.dat -o ../velo/z1_59_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_59_cor.dat -o ../velo/z1_59_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_59_cor.dat -o ../velo/z2_59_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_59_cor.dat -o ../velo/z2_59_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_60_cor.dat -o ../velo/z1_60_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_60_cor.dat -o ../velo/z1_60_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_60_cor.dat -o ../velo/z2_60_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_60_cor.dat -o ../velo/z2_60_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_60_cor.dat -o ../velo/z1_60_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_60_cor.dat -o ../velo/z1_60_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_60_cor.dat -o ../velo/z2_60_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_60_cor.dat -o ../velo/z2_60_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_61_cor.dat -o ../velo/z1_61_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_61_cor.dat -o ../velo/z1_61_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_61_cor.dat -o ../velo/z2_61_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_61_cor.dat -o ../velo/z2_61_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_61_cor.dat -o ../velo/z1_61_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_61_cor.dat -o ../velo/z1_61_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_61_cor.dat -o ../velo/z2_61_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_61_cor.dat -o ../velo/z2_61_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_62_cor.dat -o ../velo/z1_62_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_62_cor.dat -o ../velo/z1_62_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_62_cor.dat -o ../velo/z2_62_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_62_cor.dat -o ../velo/z2_62_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_62_cor.dat -o ../velo/z1_62_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_62_cor.dat -o ../velo/z1_62_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_62_cor.dat -o ../velo/z2_62_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_62_cor.dat -o ../velo/z2_62_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_63_cor.dat -o ../velo/z1_63_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_63_cor.dat -o ../velo/z1_63_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_63_cor.dat -o ../velo/z2_63_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_63_cor.dat -o ../velo/z2_63_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_63_cor.dat -o ../velo/z1_63_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_63_cor.dat -o ../velo/z1_63_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_63_cor.dat -o ../velo/z2_63_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_63_cor.dat -o ../velo/z2_63_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_64_cor.dat -o ../velo/z1_64_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_64_cor.dat -o ../velo/z1_64_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_64_cor.dat -o ../velo/z2_64_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_64_cor.dat -o ../velo/z2_64_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_64_cor.dat -o ../velo/z1_64_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_64_cor.dat -o ../velo/z1_64_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_64_cor.dat -o ../velo/z2_64_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_64_cor.dat -o ../velo/z2_64_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_65_cor.dat -o ../velo/z1_65_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_65_cor.dat -o ../velo/z1_65_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_65_cor.dat -o ../velo/z2_65_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_65_cor.dat -o ../velo/z2_65_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_65_cor.dat -o ../velo/z1_65_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_65_cor.dat -o ../velo/z1_65_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_65_cor.dat -o ../velo/z2_65_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_65_cor.dat -o ../velo/z2_65_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_66_cor.dat -o ../velo/z1_66_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_66_cor.dat -o ../velo/z1_66_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_66_cor.dat -o ../velo/z2_66_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_66_cor.dat -o ../velo/z2_66_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_66_cor.dat -o ../velo/z1_66_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_66_cor.dat -o ../velo/z1_66_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_66_cor.dat -o ../velo/z2_66_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_66_cor.dat -o ../velo/z2_66_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_67_cor.dat -o ../velo/z1_67_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_67_cor.dat -o ../velo/z1_67_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_67_cor.dat -o ../velo/z2_67_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_67_cor.dat -o ../velo/z2_67_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_67_cor.dat -o ../velo/z1_67_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_67_cor.dat -o ../velo/z1_67_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_67_cor.dat -o ../velo/z2_67_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_67_cor.dat -o ../velo/z2_67_velo10.dat &
wait
./piv -s 12001 -n 2000 --dt 50 -i ../z1_68_cor.dat -o ../velo/z1_68_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z1_68_cor.dat -o ../velo/z1_68_velo08.dat &
./piv -s 12001 -n 2000 --dt 50 -i ../z2_68_cor.dat -o ../velo/z2_68_velo07.dat &
./piv -s 14001 -n 2000 --dt 50 -i ../z2_68_cor.dat -o ../velo/z2_68_velo08.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z1_68_cor.dat -o ../velo/z1_68_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z1_68_cor.dat -o ../velo/z1_68_velo10.dat &
./piv -s 16001 -n 2000 --dt 50 -i ../z2_68_cor.dat -o ../velo/z2_68_velo09.dat &
./piv -s 18001 -n 1999 --dt 50 -i ../z2_68_cor.dat -o ../velo/z2_68_velo10.dat &
wait
