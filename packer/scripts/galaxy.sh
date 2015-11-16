wait_for_galaxy() {
	echo "Waiting patiently for Galaxy to start..."
	# sleep 10
	while ! bash -c "echo 2> /dev/null > /dev/tcp/localhost/8080" ; do
		echo -n '.'
		sleep 1
	done
	echo "Galaxy has (hopefully) started by now..."
}

export GALAXY_HOME=/home/galaxy
export SHED_TOOLS=$GALAXY_HOME/shed_tools
export TOOL_DEPENDENCIES=$GALAXY_HOME/tool_dependencies
export DEPENDENCIES_INSTALL=$GALAXY_HOME/install
export GALAXY_ENV=$GALAXY_HOME/env.sh
export GALAXY_USER=galaxy
export GALAXY_DATABASE=galaxy

# install tools that we need to build and run galaxy:
yum -y makecache
yum -y install epel-release
yum -y install mercurial pwgen python zlib-devel ncurses-devel tcsh db4-devel expat-devel java-1.8.0-openjdk-headless python-pip perl-App-cpanminus gnuplot libyaml-devel python-devel cmake mariadb-server mariadb
yum -y groupinstall "Development Tools"

# install perl dependencies (force because bioperl fails spuriously)
cpanm --force Fatal Clone Parallel::ForkManager http://search.cpan.org/CPAN/authors/id/C/CJ/CJFIELDS/BioPerl-1.6.901.tar.gz Time::Piece XML::Simple Data::Dumper autodie

pip install bioblend

# prepare the directories and check out galaxy
mkdir $GALAXY_HOME $SHED_TOOLS $TOOL_DEPENDENCIES $DEPENDENCIES_INSTALL

useradd --create-home --system $GALAXY_USER --home-dir $GALAXY_HOME
chown -R $GALAXY_USER $GALAXY_HOME

function config_galaxy () {
	cd $DEPENDENCIES_INSTALL
	curl -L -O http://downloads.sourceforge.net/project/mummer/mummer/3.23/MUMmer3.23.tar.gz
	tar xf MUMmer3.23.tar.gz
	cd MUMmer3.23
	make

	cd $DEPENDENCIES_INSTALL
	curl -L -O http://downloads.sourceforge.net/project/samtools/samtools/0.1.18/samtools-0.1.18.tar.bz2
	tar xf samtools-0.1.18.tar.bz2
	cd samtools-0.1.18
	make

	cat >> $GALAXY_ENV <<EOF
PATH=$DEPENDENCIES_INSTALL/MUMmer3.23:$DEPENDENCIES_INSTALL/samtools-0.1.18:$DEPENDENCIES_INSTALL/samtools-0.1.18/bcftools:/bin:/usr/bin
EOF

	cd $GALAXY_HOME

	git clone https://github.com/galaxyproject/galaxy/ galaxy
	cd galaxy
	git checkout f01300d7da5625ac264552258b29818598d4d535 # tag 'v15.05.1' as of September 1, 2015

	sh scripts/common_startup.sh 2>&1 | tee common_startup.log

	cp config/galaxy.ini.sample config/galaxy.ini
	cp config/tool_sheds_conf.xml.sample config/tool_sheds_conf.xml

	# begin configuring galaxy

	## config.ini
        sed -i 's_#host.*_host = 0.0.0.0_' $GALAXY_HOME/galaxy/config/galaxy.ini
	sed -i 's_#port.*_port = 8080_' $GALAXY_HOME/galaxy/config/galaxy.ini
	# use 127.0.0.1 instead of localhost; localhost tries to connect over a socket, 127.0.0.1 uses tcp
	sed -i "s_#database\_connection.*_database\_connection = mysql://$GALAXY_USER:$GALAXY_USER@127.0.0.1/${GALAXY_DATABASE}_" $GALAXY_HOME/galaxy/config/galaxy.ini
	sed -i 's/#allow_library_path_paste.*/allow_library_path_paste = True/' $GALAXY_HOME/galaxy/config/galaxy.ini
	sed -i 's/#admin_users.*/admin_users = admin@localhost.localdomain/' $GALAXY_HOME/galaxy/config/galaxy.ini
	sed -i 's_debug = True_debug = False_' $GALAXY_HOME/galaxy/config/galaxy.ini
	sed -i 's/use_interactive = True/use_interactive = False/' $GALAXY_HOME/galaxy/config/galaxy.ini
	sed -i 's_^filter-with = gzip_#&_' $GALAXY_HOME/galaxy/config/galaxy.ini
	sed -i "s@#tool_dependency_dir.*@tool_dependency_dir = $TOOL_DEPENDENCIES@" $GALAXY_HOME/galaxy/config/galaxy.ini
	sed -i 's/#\(tool_sheds_config_file.*\)/\1/' $GALAXY_HOME/galaxy/config/galaxy.ini
	SECRET=$(pwgen --secure -N 1 56)
	sed -i "s/#id_secret.*/id_secret = $SECRET/" $GALAXY_HOME/galaxy/config/galaxy.ini
	MASTER_API_KEY=$(pwgen --secure -N 1 40)
	sed -i "s/#master_api_key.*/master_api_key = $MASTER_API_KEY/" $GALAXY_HOME/galaxy/config/galaxy.ini
	sed -i "s/^#force_beta_workflow_scheduled_min_steps.*/force_beta_workflow_scheduled_min_steps=75/" $GALAXY_HOME/galaxy/config/galaxy.ini
	sed -i "s/^#force_beta_workflow_scheduled_for_collections.*/force_beta_workflow_scheduled_for_collections=True/" $GALAXY_HOME/galaxy/config/galaxy.ini
	sed -i "s@#environment_setup_file = None@environment_setup_file = $GALAXY_ENV@" $GALAXY_HOME/galaxy/config/galaxy.ini

	## tool_sheds_conf.xml
	sed -i 's@</tool_sheds>@    <tool_shed name="IRIDA tool shed" url="https://irida.corefacility.ca/galaxy-shed/"/>\n</tool_sheds>@' $GALAXY_HOME/galaxy/config/tool_sheds_conf.xml
}

export -f config_galaxy
su $GALAXY_USER -c 'config_galaxy'

systemctl start mariadb
echo "grant all privileges on $GALAXY_DATABASE.* to '$GALAXY_USER'@'localhost' identified by '$GALAXY_USER';" | mysql -u root
echo "create database $GALAXY_DATABASE character set 'utf8';" | mysql -u root

# Write out a systemd startup script for galaxy
cat > /etc/systemd/system/galaxy.service <<EOF
[Unit]
Description=Galaxy workflow execution manager
Requires=mariadb.service
After=mariadb.service

[Service]
ExecStart=$GALAXY_HOME/galaxy/run.sh --daemon
ExecStop=$GALAXY_HOME/galaxy/run.sh --stop-daemon
Type=forking
Restart=always
User=$GALAXY_USER
EnvironmentFile=$GALAXY_ENV

[Install]
WantedBy=multi-user.target
EOF

## startup galaxy for the first time
systemctl enable galaxy
systemctl start galaxy
wait_for_galaxy

# Move workflow/install scripts
mv /tmp/workflows $DEPENDENCIES_INSTALL
mv /tmp/install-workflow-tools.py $DEPENDENCIES_INSTALL

MASTER_API_KEY=$(grep master_api_key $GALAXY_HOME/galaxy/config/galaxy.ini | awk '{print $3}')

cd $DEPENDENCIES_INSTALL
python install-workflow-tools.py --workflows-dir workflows/SNVPhyl/0.3/ --master-api-key $MASTER_API_KEY --master-api-url http://localhost:8080/api --galaxy-admin-user admin@localhost.localdomain --galaxy-admin-pass adminpassword | tee install-workflow-tools.log

systemctl stop galaxy
systemctl stop mariadb

firewall-cmd --permanent --zone=public --add-port=8080/tcp
