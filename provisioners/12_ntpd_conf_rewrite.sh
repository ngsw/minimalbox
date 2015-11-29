#####NTPD
#########/etc/hosts resolver
NTPSERVER01="ntp.nict.jp"
NTPSERVER02=""

if [ ! -f /etc/ntp.conf.org ] ; then
/bin/cp -af /etc/ntp.conf{,.org}

cat > /etc/ntp.conf << EOF.ntp
restrict default kod nomodify notrap nopeer noquery
restrict 127.0.0.1
server ${NTPSERVER01}
$(if [ "${NTPSERVER02}x" != "x" ] ; then echo "server ${NTPSERVER02}" ; fi)
server 127.127.1.0 # local clock
fudge 127.127.1.0 stratum 10
driftfile /var/lib/ntp/drift
EOF.ntp


systemctl stop  ntpd
ntpdate -b ${NTPSERVER01}
systemctl start ntpd
systemctl enable ntpd
clock -w
fi
