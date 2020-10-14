## OpenLDAP

Installs OpenLDAP and phpLDAPadmin with a small number of initial users for Cloud Pak demo LDAP integration.


## Installation

**OpenLDAP**

see details in [official site](http://www.openldap.org/)

default values below
```
openLdap:
  image: "docker.io/osixia/openldap"
  imageTag: "1.3.0"
  imagePullPolicy: "Always"
  component: "openldap"

  domain: "local.io"
  adminPassword: "admin"
  https: "false"
  seedUsers: 
    usergroup: "cpusers"
    userlist: "user1,user2,user3,user4"
    initialPassword: "ChangeMe"
  persistence:
    enabled: true
    storageClassName: ""
    accessMode: ReadWriteOnce
```

**phpLDAPadmin**

The LDAP admin web UI

see details in [official site](http://phpldapadmin.sourceforge.net/)

default values below
```
phpLdapAdmin:
  enabled: true
  image: "docker.io/osixia/phpldapadmin"
  imageTag: "0.7.0"
  imagePullPolicy: "Always"
  component: "phpadmin"

  nodePort: 31080
```

## Setup IBM Cloud Private LDAP integration

After the chart is deployed, follow these steps to setup LDAP authentication
 
 1. From the helm release page take note of the OpenLDAP cluster ip and port for your deployment
 2. In the Cloud Pak UI navigate to ***Administer > Identity and access > Authentication*** and hit "Create connection" button. In the Add LDAP connection form , isert the following details
    #### LDAP Connection
    - Connection name: `ldap`
    - Server type: `Custom`
    
    #### LDAP server
    - URL: `ldap://<openldap cluster IP or DNS name>:389`
    
    #### LDAP authentication
    - Base DN: `dc=local,dc=io` (default value, adjust as needed)
    - Bind DN: `cn=admin,dc=local,dc=io` (default value, adjust as needed)
    - Bind DN password: `admin` (default value, adjust as needed)
    
    #### LDAP Filters
    - Group filter: `(&(cn=%v)(objectclass=groupOfUniqueNames))`
    - User filter: `(&(uid=%v)(objectclass=person))`
    - Group ID map: `*:cn`
    - User ID map: `*:uid`
    - Group member ID map: `groupOfUniqueNames:uniquemember`

    Click ***Save***
    
 3. Add users or groups to teams by navigating to ***Teams*** tab
    - Click ***Create team***
    - Search group or user names to add, and select appropriate roles for each
    

## Credit

Inspired by work done by the [Samsung Cloud Native Computing Team](https://github.com/samsung-cnct).
