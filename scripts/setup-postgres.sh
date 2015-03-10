#!/bin/bash
source "/vagrant/scripts/common.sh"

function setupPostgres {
	apt-get install -y postgresql postgresql-contrib
	apt-get install -y pgadmin3
}

function setupLdap {
	apt-get install -y slapd
}

echo "setup postgress and ldap"
setupPostgres
setupLdap