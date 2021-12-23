#!/bin/sh
Architecture=$(uname -a)

CPU_physical=$(cat /proc/cpuinfo | grep 'physical id' | uniq | wc -l)

vCPU=$(cat /proc/cpuinfo | grep 'cpu cores' | uniq | awk '{print $4}')

Memory=$(free -m | awk 'NR==2 {print $3}')
Max_Memory=$(free -m | awk 'NR==2 {print $2}')
Total=$((100 * $Memory / $Max_Memory))

Disk_Usage=$(df -m --total | awk 'NR==10 {print $3}')
Disk_Total=$(df -h --total | awk 'NR==10 {print $2}')
Disk_Pourcent=$(df -h --total | awk 'NR==10 {print $5}')

CPU_Load=$(uptime | awk '{print $9}' | tr -d ,)

Last_Boot=$(who -b | awk '{print$3,$4}')

LVM=$(lsblk | grep 'lvm' | wc -l)
LVM_use=$(if [ $LVM -eq 0 ]; then echo no; else echo yes; fi)

Connexions_TCP=$(cat /proc/net/sockstat | awk 'NR==2 {print$ 3}')

User_log=$(users | wc -w)

Ipv4=$(hostname -I)
MAC=$(ip link show | awk 'NR==4 {print $2}')

Sudo=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall   "
        #Architecture: $Architecture
        #CPU physical : $CPU_physical
        #vCPU : $vCPU
        #Memory Usage: $Memory/${Max_Memory}MB ($Total%)
        #Disk Usage: $Disk_Usage/${Disk_Total}Gb ($Disk_Pourcent%)
        #CPU load: $CPU_Load%
        #Last boot: $Last_Boot
        #LVM use: $LVM_use
        #Connexions TCP : $Connexions_TCP ESTABLISHED
        #User log: $User_log
        #Network: IP $Ipv4 ($MAC)
        #Sudo : $Sudo cmd"
