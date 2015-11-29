YUMPKG_INSTALL='ntp vim-enhanced sysstat yum-cron yum-utils cronie-noanacron bind-utils telnet.x86_64 xinetd lsof man traceroute strace git wget tree tcpdump kernel-devel kernel-headers perl make gcc bzip2'
YUMPKG_EPEL_INSTALL='dkms'
YUMPKG_REMOVE='cronie-anacron'
yum install -y ${YUMPKG_INSTALL}
yum install -y --enablerepo=epel ${YUMPKG_EPEL_INSTALL}
yum remove  -y ${YUMPKG_REMOVE}

systemctl enable xinetd
systemctl is-enabled xinetd
systemctl start  xinetd

yum -y update
