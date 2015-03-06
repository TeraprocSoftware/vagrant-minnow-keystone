minnow-keystone
================================

# Introduction

Vagrant project to spin up an integration environment for minnow. A node named "minnow-1" is provisioned with keystone installed.

1. OS: Ubuntu 14.04
2. Keystone: latest release (branch: stable/juno)

# Getting Started

1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download and install Vagrant](http://www.vagrantup.com/downloads.html).
3. Run ```vagrant box add ubuntu14 https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box```
4. Git clone this project, and change directory (cd) into this project (directory).
5. Run ```vagrant up``` to create the VM.

# Getting started

1. Start up keystone

```
keystone-all --config-file /usr/local/keystone/etc/keystone.conf
```

2. Add "admin" role

```
keystone --os-token=ADMIN --os-endpoint=http://localhost:35357/v2.0 role-create --name=admin
```

3. Keystone configuration refer to http://docs.openstack.org/developer/keystone/configuration.html

##Integration cases:

Keystone API specification refer to http://developer.openstack.org/api-ref-identity-v2.html

### Create user

```
curl -s -H "X-Auth-Token: ADMIN" -H "Content-Type: application/json" -d '
{
	"user": {
		"name": "weina", 
		"email":"weina.ma@example.com",
		"password": "Letmein123", 
		"firstname": "Weina", 
		"lastname":"Ma"
	}
}' \
http://localhost:35357/v2.0/users
```

###  User log on

```
curl -i -H "Content-Type: application/json" -d '
{
    "auth": {
        "passwordCredentials": {
            "password": "Letmein123",
            "username": "weina"
        }
    }
}' \
 http://localhost:5000/v2.0/tokens
```

### Query tenant (cluster)

```
curl -H "X-Auth-Token: ${token_id}" http://localhost:5000/v2.0/tenants
```

### Change user password

Note: need get a new token after changing password

```
curl \
 -H "X-Auth-Token: ${token_id}" \
 -H "Content-Type: application/json" \
 -d '{ "user": {"password": "'123456'", "original_password": "'Letmein123'"} }' \
 http://localhost:5000/v3/users/${user_id}/password
```

### Create a tenant

```
curl -s -H "Content-Type: application/json" -H "X-Auth-Token: ADMIN" -d '
{
    "tenant": {
        "name": "OL-R-Cluster",
	"enabled": true
    }
}' \
  http://localhost:35357/v2.0/tenants
```

### List roles

```
curl -i -H "X-Auth-Token: ADMIN" http://localhost:35357/v2.0/OS-KSADM/roles
```

### Assign role to user on tenant

```
curl -s -X PUT -H "X-Auth-Token: ADMIN" http://localhost:35357/v2.0/tenants/${tenant_id}/users/{user_id}/roles/OS-KSADM/${role_id}
```

### Logon with tenant

```
curl -i -H "Content-Type: application/json" -d '
{
    "auth": {
	"tenantName": "OL-R-Cluster",
        "token": {
            "id": "${token_id}"
        }
    }
}' \
 http://localhost:5000/v2.0/tokens
```

### Validate token

```
curl -i -H "X-Auth-Token: ADMIN" http://localhost:35357/v2.0/tokens/${token_id}
```


