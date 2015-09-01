sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

mv /etc/issue /etc/issue.old
cat > /etc/issue <<EOF
░█▀▀░█▀█░█░█░█▀█░█░█░█░█░█░░
░▀▀█░█░█░▀▄▀░█▀▀░█▀█░░█░░█░░
░▀▀▀░▀░▀░░▀░░▀░░░▀░▀░░▀░░▀▀▀

Welcome to the Galaxy/SNVPhyl Virtual Environment.

As you can see, the Virtual Environment does not have a GUI installed. You should interact with Galaxy/SNVPhyl using your web browser.

You can access the Galaxy web interface by navigating to http://localhost:48888/ in your web browser. The default username and password is `admin@localhost.localdomain` and `adminpassword`.

You can log into this virtual environment by using the username `vagrant` and the password `vagrant`. Alternatively, you can SSH into this virtual environment by running `ssh -p42222 vagrant@localhost` and using the password `vagrant`.  This account has `sudo` access.  The Galaxy log files are located at `/opt/galaxy/galaxy/paster.log`.

EOF

cat /etc/issue.old >> /etc/issue
rm /etc/issue.old
