#!/bin/sh

total=$(free -m | awk 'NR==2 {print $2}')
totoro=$(free -m | awk 'NR==2 {print $3}')
toto=$((100 * $totoro / $total))
tcp=$(who | wc -l)
pourcent=$(uptime | awk '{print $10}' | tr -d ,)

echo -n "#Architecture: "; uname -a
echo -n "#CPU physical : "; cat /proc/cpuinfo | grep 'physical id' | uniq | wc -l
echo -n "#vCPU : "; cat /proc/cpuinfo | grep 'cpu cores' | uniq | awk '{print $4}'
echo  	"#Memory Usage: $totoro/${total}MB ($toto%)"
echo    "#Disk Usage: "
echo    "#CPU load: $pourcent%"
echo -n "#Last boot: "; who -b | awk '{print$3,$4}'
echo    "#LVM use: "
echo -n "#Connexions TCP : "; cat /proc/net/sockstat | awk 'NR==2 {print$3}'
echo    "#User log: $tcp ESTABLISHED"
echo -n "#Network: " 
echo -n "#Sudo : "