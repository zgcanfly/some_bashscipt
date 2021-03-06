#!/bin/bash
if [ -f /etc/bashrc ];then
    source /etc/bashrc
fi
#建议添加进定时任务
#* * * * * /bin/bash  /root/some_bashscript/AutoCommit.sh && echo "last update success:`date +\%F-\%R`">>/tmp/Autocommit.txt || echo "last update false:`date +\%F-\%R`">>/tmp/Autocommit.txt
gitdirectory='/opt/docker/jupyter/data/jupyter/  /root/jupyter/data/jupyter /root/some_bashscript/ /home/yang/jupyter/data/jupyter'


#同步时间 方式github上时间戳不同步
/usr/sbin/ntpdate  ntp.ubuntu.com
for i in ${gitdirectory};do
	if [ -d ${i} ];then

		echo "开始pull $i" >> /tmp/Autocommit.txt
		cd ${i} && git pull --no-edit

		echo "开始push $i" >> /tmp/Autocommit.txt
		cd ${i} && git add . --all&& git commit -m "automatic commit and push files" && git push ||git push

		echo "last update date:`date +%F-%R`">>/tmp/Autocommit.txt
	fi
done

