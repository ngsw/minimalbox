#####bashrc
if [ ! -f /etc/bashrc.org ] ; then
/bin/cp -af /etc/bashrc /etc/bashrc.org

sed -i -e "s/\[\\\u@\\\h \\\W\]/\\\n\[\\\t\]\[\\\w\]\\\n\[\\\u@\\\h\]/g" /etc/bashrc
echo "alias vi='vim'" >> /etc/bashrc
echo "export EDITOR='vim'" >> /etc/bashrc
fi