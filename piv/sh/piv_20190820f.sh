#!/bin/sh
./piv -s 1 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_01_velo1.dat &

./piv -s 1 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_02_velo1.dat &

./piv -s 1 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_03_velo1.dat &
wait

./piv -s 2001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_01_velo2.dat &

./piv -s 2001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_02_velo2.dat &

./piv -s 2001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_03_velo2.dat &
wait

./piv -s 4001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_01_velo3.dat &

./piv -s 4001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_02_velo3.dat &

./piv -s 4001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_03_velo3.dat &
wait

./piv -s 6001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_01_velo4.dat &

./piv -s 6001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_02_velo4.dat &

./piv -s 6001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_03_velo4.dat &
wait

./piv -s 8001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_01_velo5.dat &

./piv -s 8001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_02_velo5.dat &

./piv -s 8001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_03_velo5.dat &
wait

./piv -s 10001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_01_velo6.dat &

./piv -s 10001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_02_velo6.dat &

./piv -s 10001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_03_velo6.dat &
wait

./piv -s 12001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_01_velo7.dat &

./piv -s 12001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_02_velo7.dat &

./piv -s 12001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_03_velo7.dat &
wait

./piv -s 14001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_01_velo8.dat &

./piv -s 14001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_02_velo8.dat &

./piv -s 14001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_03_velo8.dat &
wait

./piv -s 16001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_01_velo9.dat &

./piv -s 16001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_02_velo9.dat &

./piv -s 16001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_03_velo9.dat &
wait

./piv -s 18001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_01_velo10.dat &

./piv -s 18001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_02_velo10.dat &

./piv -s 18001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_03_velo10.dat &
wait

./piv -s 20001 -n 1838 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_01_velo11.dat &

./piv -s 20001 -n 1838 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_02_velo11.dat &

./piv -s 20001 -n 1838 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fl/spiv_fl_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fl/spiv_fl_03_velo11.dat &
wait

./piv -s 1 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_01_velo1.dat &

./piv -s 1 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_02_velo1.dat &

./piv -s 1 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_03_velo1.dat &
wait

./piv -s 2001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_01_velo2.dat &

./piv -s 2001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_02_velo2.dat &

./piv -s 2001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_03_velo2.dat &
wait

./piv -s 4001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_01_velo3.dat &

./piv -s 4001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_02_velo3.dat &

./piv -s 4001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_03_velo3.dat &
wait

./piv -s 6001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_01_velo4.dat &

./piv -s 6001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_02_velo4.dat &

./piv -s 6001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_03_velo4.dat &
wait

./piv -s 8001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_01_velo5.dat &

./piv -s 8001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_02_velo5.dat &

./piv -s 8001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_03_velo5.dat &
wait

./piv -s 10001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_01_velo6.dat &

./piv -s 10001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_02_velo6.dat &

./piv -s 10001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_03_velo6.dat &
wait

./piv -s 12001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_01_velo7.dat &

./piv -s 12001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_02_velo7.dat &

./piv -s 12001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_03_velo7.dat &
wait

./piv -s 14001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_01_velo8.dat &

./piv -s 14001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_02_velo8.dat &

./piv -s 14001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_03_velo8.dat &
wait

./piv -s 16001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_01_velo9.dat &

./piv -s 16001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_02_velo9.dat &

./piv -s 16001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_03_velo9.dat &
wait

./piv -s 18001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_01_velo10.dat &

./piv -s 18001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_02_velo10.dat &

./piv -s 18001 -n 2000 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_03_velo10.dat &
wait

./piv -s 20001 -n 1838 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_01_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_01_velo11.dat &

./piv -s 20001 -n 1838 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_02_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_02_velo11.dat &

./piv -s 20001 -n 1838 --dt 50 -i /home/yatagi/analysis/piv_output/flow_cor/20190820/cor/spiv_fr/spiv_fr_03_cor.dat -o /home/yatagi/analysis/piv_output/velofield/20190820/piv/fr/spiv_fr_03_velo11.dat &
wait
