LOCALHOST_LOOPBACK="127.0.0.1"
NW192='192.168.0.0/255.255.0.0'
NW172='172.16.0.0/255.240.0.0'
NW_10='10.0.0.0/255.0.0.0'
DENY_ALL='ALL'

#####hosts.allow & hosts.deny
if [ ! -f /etc/hosts.allow.org ] ;then
cp -p /etc/hosts.allow{,.org}
cat > /etc/hosts.allow <<HOSTSALLOW.eof
### DON'T TOUCH ########################
ALL  : ${LOCALHOST_LOOPBACK}
sshd : ${NW192}
sshd : ${NW172}
sshd : ${NW_10}
### DON'T TOUCH ########################
HOSTSALLOW.eof
fi
if [ ! -f /etc/hosts.deny.org ] ;then
cp -p /etc/hosts.deny{,.org}
cat > /etc/hosts.deny <<HOSTSDENY.eof
ALL : ${DENY_ALL}
HOSTSDENY.eof
fi
