YUMPKG_INSTALL='ntp vim-enhanced nkf sysstat yum-cron cronie-noanacron bind-utils telnet xinetd lsof man traceroute strace git wget net-snmp net-snmp-utils perl make gcc dkms'
YUMPKG_REMOVE='cronie-anacron'
yum install -y ${YUMPKG_INSTALL}
yum remove  -y ${YUMPKG_REMOVE}
yum clean all

chkconfig xinetd on
/etc/init.d/xinetd start

yum -y update
