#!/bin/sh

 time=`date +"%Y-%m-%d %H:%M:%S"`
 ip='ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/''
 Key=''

# while true;do
#     count=`ps -ef|grep httpd|grep -v grep`
#     if [ "$?" != "0" ];then
# echo  ">>>>no zsh,run it"

# curl http://sc.ftqq.com/$Key.send?text=主人服务器又挂掉啦~

# else
# echo ">>>>zsh is runing..."
# fi
# exit 0
# #sleep 5
# done

while true;do
    count=`ps -ef|grep nginx|grep -v grep`
    if [ "$?" != "0" ];then

curl http://sc.ftqq.com/$Key.send?text=nginx-is-Boom.&desp=ip:$ip

else

fi
exit 0
done

while true;do
    count=`ps -ef|grep mysql|grep -v grep`
    if [ "$?" != "0" ];then

curl http://sc.ftqq.com/$Key.send?text=mysql-is-Boom.&desp=ip:$ip

else

fi
exit 0
done

while true;do
    count=`ps -ef|grep php-fpm|grep -v grep`
    if [ "$?" != "0" ];then

curl http://sc.ftqq.com/$Key.send?text=php-is-Boom.&desp=ip:$ip

else

fi
exit 0
done

while true;do
    count=`ps -ef|grep redis|grep -v grep`
    if [ "$?" != "0" ];then

curl http://sc.ftqq.com/$Key.send?text=redis-is-Boom.&desp=ip:$ip

else

fi
exit 0
done