#!/usr/bin/env bash
#this is based on CPU Load of Paul W. Rankin

# <xbar.title>Disk Free Space Available</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Alejandroslab</xbar.author>
# <xbar.author.github>Alejandroslab</xbar.author.github>
# <xbar.desc>Shows free disk space availabe.</xbar.desc>
# <xbar.dependencies>bash</xbar.dependencies>

# xbar Free disk space
#check your disks list with df in terminal

freediskspace=$(/bin/df -H | /usr/bin/awk '/\/dev\/disk1s1/ {printf("%sB\n", $4)}'|cut -c 1-3)
totalspace=$(/bin/df -H | /usr/bin/awk '/\/dev\/disk1s1/ {printf("%sB\n", $2)}'|cut -c 1-3)
#usage=$freediskspace / $totalspace
free_perc=$(echo "scale = 2; ($freediskspace / $totalspace)*100" | bc)
used_perc=$(echo "scale = 2; (1-($freediskspace / $totalspace))*100" | bc)

printf "DiskAvl: $freediskspace GB / $totalspace GB\n"
echo "---"
printf "Perc. Available: %0.2f%%\n" "$free_perc"
printf "Perc. Used: %0.2f%%\n" "$used_perc"
echo "Refresh | refresh=true"
