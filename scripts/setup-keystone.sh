#!/bin/bash
#http://docs.openstack.org/developer/keystone/installing.html

source "/vagrant/scripts/common.sh"

function setupKeystone {
    echo "setup keystone from source"
    apt-get install -y git
	apt-get install -y python-setuptools python-pip python-dev
	pip install pbr

	git clone -b $KEYSTONE_BRANCH $KEYSTONE_GITHUB
	mv /home/vagrant/keystone /usr/local
	cd /usr/local/keystone
	python setup.py install
	cp /usr/local/keystone/etc/keystone.conf.sample /usr/local/keystone/etc/keystone.conf
}

function startKeystone {
    echo "configure keystone"
	# start keystone
	keystone-all --config-file /usr/local/keystone/etc/keystone.conf &
	# add "admin" role
	keystone --os-token=ADMIN --os-endpoint=http://localhost:35357/v2.0 role-create --name=admin
}

echo "setup keystone"
setupKeystone
startKeystone
