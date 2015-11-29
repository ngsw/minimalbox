CENTOS_VER_MAJOR="7"
CENTOS_VER_MINOR="1"
CENTOS_VER_TIMESTAMP="1503"
CENTOS_VER="${CENTOS_VER_MAJOR}.${CENTOS_VER_MINOR}-${CENTOS_VER_TIMESTAMP}"
ARCH_TYPE="x86_64"
CHECKSUM_TYPE="md5"
CHECKSUM="d07ab3e615c66a8b2e9a50f4852e6a77"

cat > ./centos${CENTOS_VER}.json <<JSONEOF
{
  "builders": [
    {
      "type": "virtualbox-iso",
      "vm_name": "box",
      "boot_wait": "10s",
      "disk_size": 512000,
      "guest_os_type": "RedHat_64",
      "iso_checksum": "${CHECKSUM}",
      "iso_checksum_type": "${CHECKSUM_TYPE}",
      "iso_url": "http://ftp.iij.ad.jp/pub/linux/centos/${CENTOS_VER_MAJOR}/isos/${ARCH_TYPE}/CentOS-${CENTOS_VER_MAJOR}-${ARCH_TYPE}-Minimal-${CENTOS_VER_TIMESTAMP}-01.iso",
      "ssh_username": "vagrant",
      "ssh_password": "vagrant",
      "ssh_port": 22,
      "ssh_wait_timeout": "10000s",
      "shutdown_command": "echo '/sbin/halt -h -p' > shutdown.sh; echo 'vagrant'|sudo -S sh 'shutdown.sh'",
      "guest_additions_path": "VBoxGuestAdditions_{{.Version}}.iso",
      "virtualbox_version_file": ".vbox_version",
      "vboxmanage": [
        [
          "modifyvm",
          "{{.Name}}",
          "--memory",
          "2048"
        ],
        [
          "modifyvm",
          "{{.Name}}",
          "--cpus",
          "2"
        ]
      ],
      "http_directory": "./builders/",
      "boot_command": [
        "<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"
      ]
    }
  ],
  "provisioners": [
    {
      "type": "shell",
      "scripts": [
        "provisioners/01_hosts_allow_deny_rewrite.sh",
        "provisioners/02_selinux_disabled.sh",
        "provisioners/03_yumconf.sh",
        "provisioners/04_sshd_config_rewrite.sh",
        "provisioners/05_firewalld-disable.sh",
        "provisioners/06_yum_install_remove_chkconfig.sh",
        "provisioners/07_locale_and_timezone.sh",
        "provisioners/08_kernel_param.sh",
        "provisioners/09_pam_limits.sh",
        "provisioners/10_logrotate_rewrite.sh",
        "provisioners/11_bashrc_org.sh",
        "provisioners/12_ntpd_conf_rewrite.sh",
        "provisioners/13_symboliclink_bash_perl.sh",
        "provisioners/14_vm_swappiness_0.sh",
        "provisioners/15_rsyslog_rate-limiting_disable.sh",
        "provisioners/16_resolvconf_rewrite.sh",
        "provisioners/17_virtualbox.sh",
        "provisioners/18_vagrant_user.sh",
        "provisioners/19_delete_70-persistent-net.rules.sh",
        "provisioners/20_append_authorized_keys.sh",
        "provisioners/21_hostname.sh"
      ],
      "override": {
        "virtualbox-iso": {
          "execute_command": "echo 'vagrant'|sudo -S sh '{{.Path}}'"
        }
      }
    }
  ],
  "post-processors": [
    {
      "type": "vagrant",
      "output": "./CentOS-${CENTOS_VER}-${ARCH_TYPE}-minimal.box"
    }
  ]
}

JSONEOF
