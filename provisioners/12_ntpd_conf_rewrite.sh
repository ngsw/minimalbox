#####NTPD
#########/etc/hosts resolver
NTPSERVER01="ntp.nict.jp"

if [ ! -f /etc/ntp.conf.org ] ; then
/bin/cp -af /etc/ntp.conf{,.org}

cat > /etc/ntp.conf << EOF.ntp
restrict default kod nomodify notrap nopeer noquery
restrict -6 default kod nomodify notrap nopeer noquery
restrict 127.0.0.1
restrict -6 ::1
server ${NTPSERVER01}
server 127.127.1.0 # local clock
fudge 127.127.1.0 stratum 10
driftfile /var/lib/ntp/drift
keys /etc/ntp/keys
EOF.ntp


/etc/init.d/ntpd stop
ntpdate -b ${NTPSERVER01}
/etc/init.d/ntpd start
/sbin/chkconfig ntpd on
clock -w
fi
