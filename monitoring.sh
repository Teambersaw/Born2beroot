#!/bin/sh
Architecture=$(uname -a)

CPU_physical=$(cat /proc/cpuinfo | grep 'physical id' | uniq | wc -l)

vCPU=$(cat /proc/cpuinfo | grep 'cpu cores' | uniq | awk '{print $4}')

Memory=$(free -m | awk 'NR==2 {print $3}')
Max_Memory=$(free -m | awk 'NR==2 {print $2}')
Total=$((100 * $Memory / $Max_Memory))

CPU_Load=$(uptime | awk '{print $10}' | tr -d ,)

Last_Boot=$(who -b | awk '{print$3,$4}')

Connexions_TCP=$(cat /proc/net/sockstat | awk 'NR==2 {print$3}')

User_log=$(who | wc -l)

Network=$(hostname -I)


echo   "
        #Architecture: $Architecture
        #CPU physical : $CPU_physical
        #vCPU : $vCPU
        #Memory Usage: $Memory/${Max_Memory}MB ($Total%)
        #Disk Usage:
        #CPU load: $CPU_Load%
        #Last boot: $Last_Boot
        #LVM use:
        #Connexions TCP : $Connexions_TCP ESTABLISHED
        #User log: $User_log
        #Network: IP $Network
        #Sudo :"
