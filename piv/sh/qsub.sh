t2sub -N PIV1_ -et 1 -l walltime=24:00:00 -W group_list=t2gmt-fluid -q V -l select=1:ncpus=5:mem=23gb -l place=free -j oe ./piv0_L.sh
t2sub -N PIV1_ -et 1 -l walltime=24:00:00 -W group_list=t2gmt-fluid -q V -l select=1:ncpus=5:mem=23gb -l place=free -j oe ./piv1_L.sh
t2sub -N PIV1_ -et 1 -l walltime=24:00:00 -W group_list=t2gmt-fluid -q V -l select=1:ncpus=5:mem=23gb -l place=free -j oe ./piv2_L.sh
t2sub -N PIV1_ -et 1 -l walltime=24:00:00 -W group_list=t2gmt-fluid -q V -l select=1:ncpus=5:mem=23gb -l place=free -j oe ./piv3_L.sh
