if [ ! -f /etc/logrotate.conf.org ] ; then
  /bin/cp -af /etc/logrotate.conf{,.org}

  sed -i -e "s/^weekly/daily/"       /etc/logrotate.conf
  sed -i -e "s/^rotate 4/rotate 64/" /etc/logrotate.conf
  sed -i -e "s/^#compress/compress/" /etc/logrotate.conf
fi
