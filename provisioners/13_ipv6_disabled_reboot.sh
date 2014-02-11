if [ ! -f /etc/modprobe.d/ipv6-disabled.conf ] ; then
  cat > /etc/modprobe.d/ipv6-disabled.conf << ipv6_disabled.EOF
install ipv6  /sbin/modprobe -n -i ipv6
ipv6_disabled.EOF
  chkconfig ip6tables off
  lsmod | grep ipv6 || echo "IPv6 Disabled"
fi
