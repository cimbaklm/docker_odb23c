# docker_odb23c - Oracle Database 23c App Simple FREE for Dev edition

This repo aims at giving some examples on how to deploy the FREE Oracle Database 23c for developers on docker containers.

## Installation

Use git clone :

```bash
git clone git clone https://github.com/cimbaklm/docker_odb23c.git
```

## Tree

```python
├── README.md
├── db23c
│   ├── .env
│   └── docker-compose.yaml
├── db23c_database
│   ├── .env
│   └── docker-compose.yaml
└── db23c_ords
    ├── .env
    └── docker-compose.yaml
```

db23c is the full compose package, it include : Oracle DB 23c FREE for dev latest, Oracle REST DATA Services latest, and NGINX in order to expose ORDS REST API
db23c_database create the database only
db23c_ords attach ORDS to a previously created database with Nginx configured as a reverse proxy pointing to the API (http only for demo purpose)

## Usage

For every compose file, the .env file has to be used to configure the resource that will be created

## Prerequisites

Ubuntu 22.04 (other OS or version should also work)
Latest Docker CE with docker compose plugin
Latest SQLcl for connection testing

Fill the .env file corresponding to the compose file you want to use (db23c contains the full set of entries) :
'''python
23c Database configuration entries (db32c_database) :
DATABASE_SYSTEM_PASSWORD ==> sys & system password
DATABASE_APP_USER ==> application user name
DATABASE_APP_PASSWORD ==> application user password
DB_DATA_BASE_DIR ==> Database files, points to /opt/oracle/oradata in the container

ORDS configuration entries (db23c_ords) :
IGNORE_APEX ==> Possible vaules are TRUE (default) or FALSE. Used either to install APEX or not
ORDS_SETTINGS_BASE_DIR=.
ORDS_SETTING_API_URL=ords.demodocker.fr
ORDS_SETTING_API_PORT=8181
```

### For db23c

    This docker compose file will create :
        - A latest Oracle Database 23c fre for developers with psersistent datafiles
        - A latest Oracle REST Data Services connected to the database
        - An Nginx reverse proxy with a backend pointing to the ORDS API

    Configuration :
    '''python
    cd db23c
    source .env
    # Directories creation
    mkdir ${ORDS_SETTINGS_BASE_DIR}/secrets ; chmod 775 ${ORDS_SETTINGS_BASE_DIR}/secrets
    mkdir ${ORDS_SETTINGS_BASE_DIR}/settings ; chmod 775 ${ORDS_SETTINGS_BASE_DIR}/settings
    mkdir ${DB_DATA_BASE_DIR}/data ; chown :54321 ${DB_DATA_BASE_DIR}/data ; chmod 775 ${DB_DATA_BASE_DIR}/data
    
    # Secret file for ORDS first configuration
    echo CONN_STRING=sys/${DATABASE_SYSTEM_PASSWORD}@oracle:1521/FREEPDB1 > ${ORDS_SETTINGS_BASE_DIR}secrets/conn_string.txt
    ```

    Creation of the container :
    '''python
    cd db23c
    docker compose up -d
    docker ps
    ```

### For db23c_database

    This docker compose file will create :
        - A latest Oracle Database 23c fre for developers with psersistent datafiles

    Configuration :
    '''python
    cd db23c_database
    source .env
    # Directory creation
    mkdir ${DB_DATA_BASE_DIR}/data ; chown :54321 ${DB_DATA_BASE_DIR}/data ; chmod 775 ${DB_DATA_BASE_DIR}/data
    ```

    Creation of the container :
    '''python
    cd db23c_database
    docker compose up -d
    docker ps
    ```

### For db23c_ords

    This docker compose file will create :
        - A latest Oracle REST Data Services connected to the database
        - An Nginx reverse proxy with a backend pointing to the ORDS API

    Configuration :
    '''python
    cd db23c
    source .env
    # Directories creation
    mkdir ${ORDS_SETTINGS_BASE_DIR}/secrets ; chmod 775 ${ORDS_SETTINGS_BASE_DIR}/secrets
    mkdir ${ORDS_SETTINGS_BASE_DIR}/settings ; chmod 775 ${ORDS_SETTINGS_BASE_DIR}/settings
    
    # Secret file for ORDS first configuration
    echo CONN_STRING=sys/${DATABASE_SYSTEM_PASSWORD}@oracle:1521/FREEPDB1 > ${ORDS_SETTINGS_BASE_DIR}secrets/conn_string.txt
    ```

    Creation of the container :
    '''python
    cd db23c_ords
    docker compose up -d
    docker ps
    ```

## Troubleshoot

    # docker exec -it db23c_ords-ords-1 tail -f /tmp/install_container.log

    # docker inspect <container_id> | jq '.[0].Config.Env'


