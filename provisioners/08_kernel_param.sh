if [ ! -f /etc/sysctl.conf.org ] ; then
  cp -a /etc/sysctl.conf{,.org}
  cat >> /etc/sysctl.conf << 'sysctl.EOF'
# Kernel sysctl configuration file for Red Hat Linux
#
# For binary values, 0 is disabled, 1 is enabled.  See sysctl(8) and
# sysctl.conf(5) for more details.

# Controls IP packet forwarding
net.ipv4.ip_forward = 0

# Controls source route verification
net.ipv4.conf.default.rp_filter = 1

# Do not accept source routing
net.ipv4.conf.default.accept_source_route = 0

# Controls the System Request debugging functionality of the kernel
kernel.sysrq = 0

# Controls whether core dumps will append the PID to the core filename.
# Useful for debugging multi-threaded applications.
kernel.core_uses_pid = 1

# Controls the use of TCP syncookies
net.ipv4.tcp_syncookies = 1

# Controls the default maxmimum size of a mesage queue
kernel.msgmnb = 65536

# Controls the maximum size of a message, in bytes
kernel.msgmax = 65536

# Controls the maximum shared segment size, in bytes ( = `64GB' )
kernel.shmmax = 68719476736

# Controls the maximum number of shared memory segments, in pages ( = `ceil(SHMMAX / $(getconf PAGE_SIZE) * SHMMNI / 16' )
kernel.shmall = 4294967296

## append

# FileHandler Max([Default = RAM_Kbyte / 10][VFS: file-max limit  reached])
fs.file-max = 6815744

sysctl.EOF
else
  echo "/etc/sysctl.conf.org EXIST"
fi