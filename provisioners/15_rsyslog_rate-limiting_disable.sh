if [ ! -f /etc/rsyslog.conf_origin ];then
  sed -i_origin 's|#$InputTCPServerRun 514|#$InputTCPServerRun 514\n$SystemLogRateLimitInterval 0|g' /etc/rsyslog.conf
  systemctl restart rsyslog.service
else
  echo "/etc/rsyslog.conf_origin is Exist"
fi