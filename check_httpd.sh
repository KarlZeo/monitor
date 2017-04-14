#!/bin/sh

 time=`date +"%Y-%m-%d %H:%M:%S"`
 ip=$(/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v 10.|grep -v inet6|awk '{print $2}'|tr -d "addr:")
 Key=''

while true;do
    count=`ps -ef|grep httpd|grep -v grep`
    if [ "$?" != "0" ];then

curl http://sc.ftqq.com/$Key.send?text=nginx-is-Boom.&desp=ip:$ip

else
echo "nothings"
fi

exit 0

done
