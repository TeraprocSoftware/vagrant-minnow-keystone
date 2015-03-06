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


echo "setup keystone"
setupKeystone
