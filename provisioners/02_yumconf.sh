#####YUMCONF
if [ ! -f /etc/yum.conf.org ] ;then
cp -p /etc/yum.conf{,.org}
cat > /etc/yum.conf <<'YUMCONF.eof'
[main]
cachedir=/var/cache/yum
keepcache=0
debuglevel=2
logfile=/var/log/yum.log
distroverpkg=redhat-release
tolerant=1
exactarch=1
obsoletes=1
gpgcheck=1
plugins=0
timeout=300

# Note: yum-RHN-plugin doesn't honor this.
metadata_expire=3600

# Default.
# installonly_limit = 3

# PUT YOUR REPOS HERE OR IN separate files named file.repo
# in /etc/yum.repos.d

exclude=sendmail
YUMCONF.eof
fi

cd /etc/yum.repos.d/
rm -f CentOS-Debuginfo.repo
rm -f CentOS-Media.repo
rm -f CentOS-Vault.repo


