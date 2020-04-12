## OpenLDAP

Installs OpenLDAP and phpLDAPadmin with a small number of initial users for the purposes of demonstrating LDAP integration capabilities of ICP.


## Installation

**OpenLDAP**

see details in [official site](http://www.openldap.org/)

default values below
```
openLdap:
  image: "docker.io/osixia/openldap"
  imageTag: "latest"
  imagePullPolicy: "Always"
  component: "openldap"

  replicas: 1

  domain: "local.io"
  adminPassword: "admin"
  https: "false"
  seedUsers: 
    usergroup: "icpusers"
    userlist: "user1,user2,user3,user4"
    initialPassword: "ChangeMe"
  persistence:
    enabled: true
    storageClassName: nfs-client
```

**phpLDAPadmin**

The LDAP admin web UI

see details in [official site](http://phpldapadmin.sourceforge.net/)

default values below
```
phpLdapAdmin:
  enabled: true
  image: "docker.io/osixia/phpldapadmin"
  imageTag: "latest"
  imagePullPolicy: "Always"
  component: "phpadmin"

  replicas: 1

  nodePort: 31080
```

## Setup IBM Cloud Private LDAP integration

Detailed information about LDAP support in ICP avilable on the [IBM KnowledgeCenter](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/user_management/configure_ldap.html)

After the chart is deployed, follow these steps to setup LDAP authentication
 
 1. From the helm release page take note of the OpenLDAP cluster ip and port for your deployment
 2. Navigate to ***Manage > Authentication*** and insert the following details
    #### LDAP Connection
    - Name: `ldap`
    - Type: `Custom`
    - URL: `ldap://<cluster-ip>:389`
    
    #### LDAP authentication
    - Base DN: `dc=local,dc=io` (default value, adjust as needed)
    - Bind DN: `cn=admin,dc=local,dc=io` (default value, adjust as needed)
    - Admin Password: `admin` (default value, adjust as needed)
    
    #### LDAP Filters
    - Group filter: `(&(cn=%v)(objectclass=groupOfUniqueNames))`
    - User filter: `(&(uid=%v)(objectclass=person))`
    - Group ID map: `*:cn`
    - User ID map: `*:uid`
    - Group member ID map: `groupOfUniqueNames:uniquemember`

    Click ***Save***
    
 3. Add users or groups to teams by navigating to ***Manage > Teams***
    - Click ***Create team***
    - Search group or user names to add, and select appropriate roles for each
    

## Credit

Inspired by work done by the [Samsung Cloud Native Computing Team](https://github.com/samsung-cnct).
