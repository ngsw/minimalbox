#####resolv.conf
# Tmp NameServer (KickStart) 
if [ ! -f /etc/resolv.conf.org ] ; then
  cp -a /etc/resolv.conf{,.org}
  cat > /etc/resolv.conf <<'resolv.EOF'
nameserver  8.8.8.8
resolv.EOF
fi
