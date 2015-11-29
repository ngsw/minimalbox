sed -i 's@SELINUX=enforcing@SELINUX=disabled@g' /etc/sysconfig/selinux
sed -i 's@SELINUX=permissive@SELINUX=disabled@g' /etc/sysconfig/selinux
sed -i 's@SELINUX=enforcing@SELINUX=disabled@g' /etc/selinux/config
sed -i 's@SELINUX=permissive@SELINUX=disabled@g' /etc/selinux/config
setenforce 0
getenforce