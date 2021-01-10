#!/bin/sh
./piv -s 1 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_03_velo1.dat &
./piv -s 1 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_04_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_04_velo1.dat &
wait

./piv -s 2001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_03_velo2.dat &
./piv -s 2001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_04_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_04_velo2.dat &
wait

./piv -s 4001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_03_velo3.dat &
./piv -s 4001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_04_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_04_velo3.dat &
wait

./piv -s 6001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_03_velo4.dat &
./piv -s 6001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_04_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_04_velo4.dat &
wait

./piv -s 8001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_03_velo5.dat &
./piv -s 8001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_04_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_04_velo5.dat &
wait

./piv -s 10001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_03_velo6.dat &
./piv -s 10001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_04_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_04_velo6.dat &
wait

./piv -s 12001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_03_velo7.dat &
./piv -s 12001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_04_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_04_velo7.dat &
wait

./piv -s 14001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_03_velo8.dat &
./piv -s 14001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_04_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_04_velo8.dat &
wait

./piv -s 16001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_03_velo9.dat &
./piv -s 16001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_04_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_04_velo9.dat &
wait

./piv -s 18001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_03_velo10.dat &
./piv -s 18001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_04_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_04_velo10.dat &
wait

./piv -s 20001 -n 1838 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_03_velo11.dat &
./piv -s 20001 -n 1838 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20201217/fr/spiv_fr_04_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20201217/fr/spiv_fr_04_velo11.dat &
wait
