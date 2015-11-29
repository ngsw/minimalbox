sync
sync
sync

swap_partition=`grep partition  /proc/swaps |awk -F' ' '{print $1}'`

/sbin/swapoff ${swap_partition}
grep 'vm.swappiness' /etc/sysctl.conf
_res=${?}

if [ ! "${_res}" == "0" ] ; then
  cat >> /etc/sysctl.conf <<'EOF'
# swap 最適化
vm.swappiness = 0

EOF
sysctl -p
fi
/sbin/swapon ${swap_partition}

