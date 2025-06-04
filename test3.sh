#!/bin/bash

# 定义命令和对应的说明
declare -A cmd_desc=(
    ["cat /etc/passwd"]="显示系统所有用户账户信息"
    ["stat /etc/passwd"]="查看/etc/passwd文件的状态信息"
    ["cat /etc/passwd | grep -v nologin"]="显示可以登录的用户"
    ["cat /etc/passwd | grep x:0"]="查找UID为0的用户(超级用户)"
    ["cat /etc/passwd | grep /bin/bash"]="查找使用bash shell的用户"
    ["cat /etc/shadow"]="显示用户密码哈希(需要root权限)"
    ["awk -F: '\$3==0{print \$1}' /etc/passwd"]="另一种查找超级用户的方法"
    ["who"]="显示当前登录用户"
    ["w"]="显示当前登录用户及其活动"
    ["uptime"]="显示系统运行时间和负载"
	["ps -ef --sort -pcpu"]="按CPU 使用率从高到底排序"
	["ps aux –sort=pcpu | head -10"]="查看cpu占用率前十的进程"
    ["awk '/\$1|\$6/{print \$1}' /etc/shadow"]="查找密码策略不安全的账户"
    ["more /etc/sudoers | grep -v \"^#|^$\" | grep \"ALL=(ALL)\""]="查看有sudo权限的用户"
    ["cat .bash_history"]="查看当前用户的历史命令"
    ["netstat -antp"]="显示所有网络连接和监听端口"
    ["ps -aux"]="显示所有运行中的进程"
    ["more /etc/rc.local"]="查看启动时自动执行的脚本"
    ["cat /etc/rc.d/rc[0-6].d/"]="查看各运行级别的服务链接"
    ["cat /etc/rc.d/rc3.d/"]="查看运行级别3的服务链接"
    ["crontab -l"]="查看当前用户的定时任务"
    ["ls -la /var/spool/cron/"]="列出所有用户的定时任务文件"
    ["cat /var/spool/cron/crontabs/*"]="查看crontabs目录下的定时任务"
    ["cat /var/spool/anacron/*"]="查看anacron的定时任务"
    ["cat /etc/crontab"]="查看系统定时任务"
    ["cat /etc/anacrontab"]="查看anacron配置"
    ["cat /etc/cron.hourly/*"]="查看每小时执行的脚本"
    ["cat /etc/cron.daily/*"]="查看每天执行的脚本"
    ["cat /etc/cron.weekly/*"]="查看每周执行的脚本"
    ["cat /etc/cron.monthly/*"]="查看每月执行的脚本"
    ["chkconfig"]="查看服务启动状态(RedHat系)"
    ["chkconfig --list"]="列出所有服务的启动状态"
    ["free"]="查看内存使用情况"
    ["cat /etc/hosts"]="查看主机名解析配置"
    ["grep \"Failed password for root\" /var/log/secure | awk '{print \$11}' | sort | uniq -c | sort -nr"]="统计root登录失败的IP和次数"
    ["grep \"Accepted \" /var/log/secure | awk '{print \$11}' | sort | uniq -c | sort -nr | more"]="统计成功登录的IP和次数"
    ["grep \"Accepted \" /var/log/secure | awk '{print \$1,\$2,\$3,\$9,\$11}'"]="显示成功登录的详细信息"
)

# 执行每个命令并格式化输出
for cmd in "${!cmd_desc[@]}"; do
    echo "执行的命令: $cmd"
    echo "此命令的作用: ${cmd_desc[$cmd]}"
    echo "执行结果:"
    eval "$cmd" 2>&1
    echo "----------------------------------------"
done
