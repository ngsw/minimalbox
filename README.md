minimalbox
==========
    
    
    .
    |-- README.md
    |-- builders
    |   `-- ks.cfg
    |-- centos7.1-1503.json
    |-- json-gen.sh
    `-- provisioners
        |-- 01_hosts_allow_deny_rewrite.sh
        |-- 02_selinux_disabled.sh
        |-- 03_yumconf.sh
        |-- 04_sshd_config_rewrite.sh
        |-- 05_firewalld-disable.sh
        |-- 06_yum_install_remove_chkconfig.sh
        |-- 07_locale_and_timezone.sh
        |-- 08_kernel_param.sh
        |-- 09_pam_limits.sh
        |-- 10_logrotate_rewrite.sh
        |-- 11_bashrc_org.sh
        |-- 12_ntpd_conf_rewrite.sh
        |-- 13_symboliclink_bash_perl.sh
        |-- 14_vm_swappiness_0.sh
        |-- 15_rsyslog_rate-limiting_disable.sh
        |-- 16_resolvconf_rewrite.sh
        |-- 17_virtualbox.sh
        |-- 18_vagrant_user.sh
        |-- 19_delete_70-persistent-net.rules.sh
        |-- 20_append_authorized_keys.sh
        `-- 21_hostname.sh

