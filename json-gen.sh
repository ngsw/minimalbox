CENTOS_VER_MAJOR="6"
CENTOS_VER_MINOR="7"
CENTOS_VER="${CENTOS_VER_MAJOR}.${CENTOS_VER_MINOR}"
ARCH_TYPE="x86_64"
CHECKSUM_TYPE="md5"
CHECKSUM="9381a24b8bee2fed0c26896141a64b69"

cat > ./centos${CENTOS_VER_MAJOR}${CENTOS_VER_MINOR}.json <<JSONEOF
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
      "iso_url": "http://ftp.iij.ad.jp/pub/linux/centos/${CENTOS_VER}/isos/${ARCH_TYPE}/CentOS-${CENTOS_VER}-${ARCH_TYPE}-minimal.iso",
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
        "provisioners/01_selinux_disabled.sh",
        "provisioners/02_yumconf.sh",
        "provisioners/03_sshd_config_rewrite.sh",
        "provisioners/04_iptables_rewrite.sh",
        "provisioners/05_yum_install_remove_chkconfig.sh",
        "provisioners/06_i18n_rewrite.sh",
        "provisioners/07_resolvconf_rewrite.sh",
        "provisioners/08_kernel_param.sh",
        "provisioners/09_pam_limits.sh",
        "provisioners/10_logrotate_rewrite.sh",
        "provisioners/11_bashrc_org.sh",
        "provisioners/12_ntpd_conf_rewrite.sh",
        "provisioners/13_ipv6_disabled_reboot.sh",
        "provisioners/14_symboliclink_bash_perl.sh",
        "provisioners/15_virtualbox.sh",
        "provisioners/16_vagrant_user.sh",
        "provisioners/17_delete_70-persistent-net.rules.sh"
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
