if [ ! -f /etc/sysctl.conf.orig ] ; then
  cp -a /etc/sysctl.conf{,.orig}
  cat > /etc/sysctl.conf << 'sysctl.EOF'
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
# Asynchronous I/O events ([io_setup][ERRNO][EAGAIN])
fs.aio-max-nr = 1048576

# FileHandler Max([Default = RAM_Kbyte / 10][VFS: file-max limit  reached])
fs.file-max = 6815744

# max num of segs system wide([Default = '4096'])
kernel.shmmni = 4096

# semaphore param ([Default = '250 32000 32 128'])
kernel.sem = 250 32000 100 128

# Ephemeral port range ([Default = '32768 65500'])
net.ipv4.ip_local_port_range = 9000 65500

# The default setting of the socket receive buffer in bytes ([Default = '229376'])
net.core.rmem_default  = 262144

# The maximum receive socket buffer size in bytes. ([Default = '229376'])
net.core.rmem_max = 4194304

# The default setting (in bytes) of the socket send buffer. ([Default = '229376'])
net.core.wmem_default = 262144

# The maximum send socket buffer size in bytes. ([Default = '229376'])
net.core.wmem_max = 1048576
sysctl.EOF
else
  echo "/etc/sysctl.conf.orig EXIST"
fi
