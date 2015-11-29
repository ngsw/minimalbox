nmcli con mod enp0s3 ipv4.ignore-auto-dns yes
nmcli con mod enp0s3 ipv4.dns 8.8.8.8
systemctl restart NetworkManager
