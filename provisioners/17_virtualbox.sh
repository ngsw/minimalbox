# Installing the virtualbox guest additions
# https://docs.vagrantup.com/v2/virtualbox/boxes.html
VAGRANT_HOME=/home/vagrant
VBox_VER=$(cat /home/vagrant/.vbox_version)
VBoxGuestAddURL=http://download.virtualbox.org/virtualbox/${VBox_VER}/VBoxGuestAdditions_${VBox_VER}.iso
VBoxGuestAdditionISO=${VAGRANT_HOME}/VBoxGuestAdditions_${VBox_VER}.iso
VBoxMNTPNT=/media/VBoxGuestAdditions

wget    ${VBoxGuestAddURL} -O ${VBoxGuestAdditionISO}
mkdir   ${VBoxMNTPNT}
mount -o loop,ro ${VBoxGuestAdditionISO} ${VBoxMNTPNT}
sh      ${VBoxMNTPNT}/VBoxLinuxAdditions.run
rm      ${VBoxGuestAdditionISO}
umount  ${VBoxMNTPNT}
rmdir   ${VBoxMNTPNT}
