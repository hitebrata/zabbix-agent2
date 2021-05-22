#!/bin/bash
echo "Starting zabbix-agent2"
/usr/local/sbin/zabbix_agent2 > /dev/null 2>&1 <&- &
pid=$(ps -ef | grep 'zabbix_agent2' | grep -Ev grep | awk '{print $2}')"
echo "zabbix-agent2 Running with pid $pid"
