MYSQLFLAG=''
#####YUMCONF
if [ ! -f /etc/yum.conf.org ] ;then
cp -p /etc/yum.conf{,.org}
cat > /etc/yum.conf <<YUMCONF.eof
[main]
cachedir=/var/cache/yum
keepcache=0
debuglevel=2
logfile=/var/log/yum.log
distroverpkg=centos-release
tolerant=1
exactarch=1
obsoletes=1
gpgcheck=1
plugins=0
timeout=300

# Note: yum-RHN-plugin doesn't honor this.
metadata_expire=3600

installonly_limit=2

# PUT YOUR REPOS HERE OR IN separate files named file.repo
# in /etc/yum.repos.d

$( if [ "${MYSQLFLAG}x" != "x" ]; then  echo "exclude=sendmail mariadb*" ; else  echo "exclude=sendmail"  ; fi)
YUMCONF.eof
fi

# epel
yum -y install epel-release
sed -i 's|enabled=1|enabled=0|g' /etc/yum.repos.d/epel*.repo
# remi
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sed -i 's|enabled=1|enabled=0|g' /etc/yum.repos.d/remi*.repo

# rpmforge はインストールしない


yum clean all
yum list
