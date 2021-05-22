# zabbix-agent2
How to install and configure Zabbix_Agent2

Step_1:(Update the system packages)
yum update;
yum install -y wget pcre-devel gcc zlib-devel;
Step_2:(Download the zabbix 5.0)
wget https://cdn.zabbix.com/zabbix/sources/stable/5.0/zabbix-5.0.2.tar.gz;
Step_3:(Create user and group for zabbix)
groupadd --system zabbix;
useradd --system -g zabbix -d /usr/lib/zabbix -s /sbin/nologin -c "Zabbix Monitoring System" zabbix;
Step_4:(Extract the archive file)
tar -xvzf zabbix-5.0.2.tar.gz;
cd zabbix-5.0.2;
Step_5:(Download the dependencies golang and configure zabbix agent)
wget https://golang.org/dl/go1.13.15.linux-amd64.tar.gz;
sudo tar -C /usr/local -xzf go1.13.15.linux-amd64.tar.gz;  
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile;
source /etc/profile;
./configure --enable-agent2;
make install;
Step_6:(Edit the zabbix agent2 configuration file)
vi /usr/local/etc/zabbix_agent2.conf

		Server= 172.16.0.101
		Hostname=HostnameOfThePC
Step_7:(Finally run the agent2)
cd /usr/local/sbin
./zabbix-agent2 &
or
/usr/local/sbin/zabbix_agent2 &
Step_7:(Check the logs)
cat /tmp/zabbix_agent2.log
Step_8: (Check the port 10050)
ss     -lntup | grep “10050”



Zabbix_server _Configuration

apt install zabbix-get
zabbix_get -s 127.0.0.1 -p 10050 -k services.systemctl


ZBX_NOTSUPPORTED: Unsupported item key….

Need to Configure UserParameter in zabbix_agent
#vim /etc/zabbix/zabbix_agentd.conf

UserParameter=services.systemctl,echo "{\"data\":[$(systemctl list-unit-files --type=service|grep \.service|grep -v "@"|sed -E -e "s/\.service\s+/\",\"{#STATUS}\":\"/;s/(\s+)?$/\"},/;s/^/{\"{#NAME}\":\"/;$ s/.$//")]}"



**
### Option: UserParameter
#       User-defined parameter to monitor. There can be several user-defined parameters.**
#       Format: UserParameter=<key>,<shell command>
#       See 'zabbix_agentd' directory for examples.
#
# Mandatory: no
# Default:
UserParameter=systemctl.status[*],systemctl status $1



