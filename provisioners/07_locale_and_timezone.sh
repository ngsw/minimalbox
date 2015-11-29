#####timezone
timedatectl set-timezone Asia/Tokyo

#####i18n (must reboot)
rm -f /etc/locale.conf
localectl set-locale LANG=en_US.utf8

