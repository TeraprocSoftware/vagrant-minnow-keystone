#!/bin/bash
source "/vagrant/scripts/common.sh"

function disableFirewall {
	echo "disabling firewall"
	service iptables save
	service iptables stop
	chkconfig iptables off
}

function installUtilities {
	echo "install utilities"
	apt-get update
	apt-get install -y wget
    apt-get install -y nc
    apt-get install -y zip
}
echo "setup ubuntu"

disableFirewall
installUtilities