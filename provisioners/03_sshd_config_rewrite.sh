#####sshd_config
id vagrant > /dev/null 2>&1 && grep '^vagrant:\$' /etc/shadow > /dev/null 2>&1
res=${?}
if [ "${res}" == "0" ] ; then
  if [ ! -f /etc/ssh/sshd_config.org ] ; then
  cp -a /etc/ssh/sshd_config /etc/ssh/sshd_config.org

  # 空パスワード接続設定(不許可)
  sed -i -e "s/^#PermitEmptyPasswords no/PermitEmptyPasswords no/"      /etc/ssh/sshd_config

  # パスワード認証設定(不許可)
  sed -i -e "s/^#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
  sed -i -e "/^PasswordAuthentication yes/d"                            /etc/ssh/sshd_config

  # 公開鍵認証設定(許可)
  sed -i -e "s/^#PubkeyAuthentication yes/PubkeyAuthentication yes/"    /etc/ssh/sshd_config

  # 公開鍵ファイル名設定
  sed -i -e "s/^#AuthorizedKeysFile/AuthorizedKeysFile/"                /etc/ssh/sshd_config

  # 接続元ホスト名名前解決(無効-接続時認証までの速度改善)
  sed -i -e "s/^#UseDNS yes/UseDNS no/"                                 /etc/ssh/sshd_config

  # GSSAPI 認証無効(無効-接続時認証までの速度改善)
  sed -i -e "s/^GSSAPIAuthentication yes/#GSSAPIAuthentication yes/"    /etc/ssh/sshd_config
  sed -i -e "s/^#GSSAPIAuthentication no/GSSAPIAuthentication no/"      /etc/ssh/sshd_config

  # パスワード認証設定 コメント行は削除
  sed -i -e "/^#PasswordAuthentication yes/d"                           /etc/ssh/sshd_config

  # root Login 設定 コメント行は削除
  sed -i -e "/^#PermitRootLogin yes/d"                                  /etc/ssh/sshd_config

  # root Login 設定(不許可)
  sed -i -e "s/^PermitRootLogin yes/PermitRootLogin no/"                /etc/ssh/sshd_config

  /etc/init.d/sshd restart
  fi
else
  echo "[MUST] make user 'vagrant' [AND] passwd 'vagrant'"
fi
