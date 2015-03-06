#!/bin/bash
source "/vagrant/scripts/common.sh"

function setupPostgres {
	apt-get install -y postgresql postgresql-contrib
	apt-get install -y pgadmin3
}

echo "setup postgress"
setupPostgres