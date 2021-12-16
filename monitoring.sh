#!/bin/sh

total=$(free -m | awk 'NR==2 {print $2}')
totoro=$(free -m | awk 'NR==2 {print $3}')
toto=$((100 * $totoro / $total))

echo -n "#Architecture: "; uname -a
echo -n "#CPU physical : "; cat /proc/cpuinfo | grep 'physical id' | uniq | wc -l
echo -n "#vCPU : "; cat /proc/cpuinfo | grep 'cpu cores' | uniq | awk '{print $4}'
echo  	"#Memory Usage: $totoro/${total}MB ($toto%)"
echo    "#Disk Usage: "
echo -n "#CPU load: "; uptime | awk '{print $10}' | tr -d ,
echo -n "#Last boot: ";  