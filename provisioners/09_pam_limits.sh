# 90-nproc.conf  (CentOS/Scientific Linux 6)
if [ -f /etc/security/limits.d/90-nproc.conf ] ; then
  if [ ! -f /etc/security/limits.d/90-nproc.conf.orig ] ; then
    cp -a /etc/security/limits.d/90-nproc.conf{,.orig}
    echo '' > /etc/security/limits.d/90-nproc.conf
  fi
fi

# 20-nproc.conf  (CentOS 7)
if [ -f /etc/security/limits.d/20-nproc.conf ] ; then
  if [ ! -f /etc/security/limits.d/20-nproc.conf.orig ] ; then
    cp -a /etc/security/limits.d/20-nproc.conf{,.orig}
    echo '' > /etc/security/limits.d/20-nproc.conf
  fi
fi

if [ ! -f /etc/security/limits.conf.orig ] ; then
  cp -a /etc/security/limits.conf{,.orig}
  cat > /etc/security/limits.conf <<'LIMITS.EOF'
*    -    nproc    32768
*    -    nofile   65536
*    -    stack    10240
LIMITS.EOF
fi

if [ ! -f /etc/sysconfig/init.orig ] ; then
  cp -a /etc/sysconfig/init{,.orig}
  cat >> /etc/sysconfig/init <<'SYSCONFIG_INIT.EOF'

## 20150818 add ##
ulimit -n 65536
ulimit -u 32768
ulimit -s 10240

SYSCONFIG_INIT.EOF
fi
