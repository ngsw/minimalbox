if [ ! -f /etc/sysconfig/iptables.orig ] ; then
  cp -a /etc/sysconfig/iptables{,.orig}
  cat > /etc/sysconfig/iptables <<'iptables.EOF'
*nat
:PREROUTING ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
COMMIT
# Completed
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]

#-- Localhost LoopBack
-A INPUT  -i lo -j ACCEPT
-A OUTPUT -o lo -j ACCEPT

#-- Ident [authentication tap ident port 113]
-A INPUT  -p tcp -m tcp --dport 113 -j REJECT --reject-with icmp-port-unreachable
-A OUTPUT -p tcp -m tcp --dport 113 -j REJECT --reject-with icmp-port-unreachable

#-- dest-unrechable [icmp-type 3 destination-unreachable]
-A INPUT  -p icmp -m icmp --icmp-type 3 -j ACCEPT
-A OUTPUT -p icmp -m icmp --icmp-type 3 -j ACCEPT

#-- Clients SMTP/HTTP/HTTPS
-A INPUT  -p tcp -m multiport --sports 25,80,443 -m tcp ! --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT
-A OUTPUT -p tcp -m multiport --dports 25,80,443 -j ACCEPT

#-- Services SMTP/POP3/HTTP/HTTPS
# -A INPUT  -p tcp -m multiport --dports 25,110,80,443 -j ACCEPT
# -A OUTPUT -p tcp -m multiport --sports 25,110,80,443 -m tcp ! --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT

#-- Resolve Domain Name
-A INPUT  -p udp -m udp --sport 53 -j ACCEPT
-A INPUT  -p tcp -m tcp --sport 53 -j ACCEPT
-A OUTPUT -p udp -m udp --dport 53 -j ACCEPT
-A OUTPUT -p tcp -m tcp --dport 53 -j ACCEPT

#-- NTP
-A INPUT  -p udp -m udp --sport 123 -j ACCEPT
-A INPUT  -p tcp -m tcp --sport 123 -j ACCEPT
-A OUTPUT -p udp -m udp --dport 123 -j ACCEPT
-A OUTPUT -p tcp -m tcp --dport 123 -j ACCEPT

##-- For MNG
###VirtualBox_NAT
-A INPUT  -s 10.0.0.0/8 -j ACCEPT
-A OUTPUT -d 10.0.0.0/8 -j ACCEPT

####-- Setting the server-specific

####-- Setting the server-specific

#-- Drop(no-log) /BOOTP/NETBIOS/Internet Printing Protocol
-A INPUT -p tcp -m multiport --dports 67,68,137,138,139,631 -j DROP
-A INPUT -p udp -m multiport --dports 67,68,137,138,139,631 -j DROP

#-- Drop(no-log) BroadCast/MultiCast
-A INPUT -d 255.255.255.255/32 -j DROP
-A INPUT -d 224.0.0.1/32 -j DROP

#-- Log and Drop
-A INPUT -m limit --limit 1/sec -j LOG --log-prefix "[IPTABLES INPUT] : "
-A INPUT -j DROP
-A OUTPUT -m limit --limit 1/sec -j LOG --log-prefix "[IPTABLES OUTPUT] : "
-A OUTPUT -j DROP



COMMIT
# Completed
iptables.EOF
fi
