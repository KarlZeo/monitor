#!/bin/bash

#This script is used for monitoring system load.

 time=`date +"%Y-%m-%d %H:%M:%S"`

 ip='ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/''

 ps aux | grep -v 'USER' >> /tmp/temp.txt

 while read -r line

 do

 declare -i CPUUsage=`echo $line | awk '{print $3}' | awk -F. ' {print $1}'`

 MEMUsage=`echo $line | awk '{print $4}' | awk -F. '{print $1}'`

 ProcessNum=`echo $line | awk '{print $2}'`

 STAT=`echo $line | awk '{print $8}'`

 Command=`echo $line | awk ' {print $11}'`

 Key=''

 function do_check() {
     curl http://sc.ftqq.com/$Key.send?text=$1&desp=$ip
 }

# Monitor CPU load.

 if [ $CPUUsage -ge 90 ];then

#  kill -9 $ProcessNum 报警开始

 Text='$time Process $Command occupies too large CPU space'

 echo $Text >> /var/log/cpu_monitor.log

 do_check Text

 fi

# Monitor Memory load.

 if [ $MEMUsage -ge 90 ];then

#  kill -9 $ProcessNum  报警开始

 Text='$time Memory $Command occupies too large memory space'

 echo $Text >> /var/log/mem_monitor.log

 do_check Text

 fi

# Monitor the zombie process.

 if [ "$STAT" == "Z" ]; then

#  kill -9 $ProcessNum  报警开始

 Text='$time Process $Command is zombie process and was killed.'

 echo $Text >> /var/log/zombie_monotor.log

 do_check Text

 fi

 done < /tmp/temp.txt

 rm -f /tmp/temp.txt

#Momitor the disk partition used space.

 df | grep -v Filesystem > /tmp/temp.txt

 while read -r line

 do

 declare -i DiskUsage=`echo $line | awk '{ if(NF==6){ print $5 } else if(NF==5) { print $4 } }'| awk -F% '{print $1}'`

 DirName=`echo $line | awk '{ if(NF==6){ print $6 } else if(NF==5) { print $5 } }'| awk -F% '{print $1}'`

 if [ $DiskUsage -ge 90 ];then

 # 磁盘90%报警

 Text='$time The partitipn which the directory $DirName mounted on occupies too large space ,please check it.'

 echo Text >> /var/log/disk_monitor.log

 do_check Text

 fi

 done < /tmp/temp.txt

 rm -f /tmp/temp.txt
