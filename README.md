# docker_odb23c - Oracle Database 23c App Simple FREE for Dev edition

This repo aims at giving some examples on how to deploy the FREE Oracle Database 23c for developers on docker containers.

## Installation

Use git clone :

```bash
git clone https://github.com/ocimbaluria/docker_odb23c.git
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
├── db23c_ords
│   ├── .env
│   └── docker-compose.yaml
└── twitterfeed
    ├── .env
    ├── Dockerfile
    ├── data
    │   ├── 01-setupAlphaOracle.sql
    │   ├── 02-finalprod.sql
    │   └── 03-finalcat.sql
    ├── docker-compose.yaml
    └── finalcat.sql
```

db23c is the full compose package, it include : Oracle DB 23c FREE for dev latest, Oracle REST DATA Services latest, and NGINX in order to expose ORDS REST API
db23c_database create the database only
db23c_ords attach ORDS to a previously created database with Nginx configured as a reverse proxy pointing to the API (http only for demo purpose)
twitterfeed is an example application that uses two data sources (from two containers) to show products and the popularity of some products (with statics JSON twitter for demo purpose)

## Usage

For every compose file, the .env file has to be used to configure the resource that will be created

## Prerequisites

Ubuntu 22.04 (other OS or version should also work)
Latest Docker CE with docker compose plugin
Latest SQLcl for connection testing

Fill the .env file corresponding to the compose file you want to use (db23c contains the full set of entries) :

```python
# 23c Database configuration entries (db32c_database) :
DATABASE_SYSTEM_PASSWORD     ==> sys & system password
DATABASE_APP_USER            ==> application user name
DATABASE_APP_PASSWORD        ==> application user password
DB_DATA_BASE_DIR             ==> Database files, points to /opt/oracle/oradata in the container

# ORDS configuration entries (db23c_ords) :
IGNORE_APEX                  ==> Possible vaules are TRUE (default) or FALSE. Used either to install APEX or not
ORDS_SETTINGS_BASE_DIR       ==> Settings and secret file for ORDS installation and configuration (i.e /opt/ords)
ORDS_SETTING_API_URL         ==> Name to use in Nginx reverse proxy (i.e ords.demodocker.fr)
ORDS_SETTING_API_PORT        ==> Port used by ORDS (default 8181, until changed in the configuration after installation)
```

### For db23c

This docker compose file will create :

    - A latest Oracle Database 23c free for developers with psersistent datafiles

    - A latest Oracle REST Data Services connected to the database
    
    - An Nginx reverse proxy with a backend pointing to the ORDS API

Configuration :

```python
cd db23c
source .env
# Directories creation
sudo mkdir -p ${DB_DATA_BASE_DIR} ; sudo chown $USER:$USER ${DB_DATA_BASE_DIR}
sudo mkdir -p ${ORDS_SETTINGS_BASE_DIR} ; sudo chown $USER:$USER ${ORDS_SETTINGS_BASE_DIR}
mkdir -p ${ORDS_SETTINGS_BASE_DIR}/secrets ; chmod 775 ${ORDS_SETTINGS_BASE_DIR}/secrets
mkdir -p ${ORDS_SETTINGS_BASE_DIR}/settings ; chmod 775 ${ORDS_SETTINGS_BASE_DIR}/settings
mkdir -p ${DB_DATA_BASE_DIR}/data ; chmod 775 ${DB_DATA_BASE_DIR}/data ; sudo chown :54321 ${DB_DATA_BASE_DIR}/data

# Secret file for ORDS first configuration
echo CONN_STRING=sys/${DATABASE_SYSTEM_PASSWORD}@oracle:1521/FREEPDB1 > ${ORDS_SETTINGS_BASE_DIR}/secrets/conn_string.txt
```

Creation of the container :

```python
cd db23c
docker compose up -d
docker ps
```

### For db23c_database

This docker compose file will create :
    - A latest Oracle Database 23c free for developers with psersistent datafiles

Configuration :

```python
cd db23c_database
source .env
# Directory creation
mkdir ${DB_DATA_BASE_DIR}/data ; chown :54321 ${DB_DATA_BASE_DIR}/data ; chmod 775 ${DB_DATA_BASE_DIR}/data
```

Creation of the container :

```python
cd db23c_database
docker compose up -d
docker ps
```

### For db23c_ords

This docker compose file will create :
    - A latest Oracle REST Data Services connected to the database
    - An Nginx reverse proxy with a backend pointing to the ORDS API

Configuration :

```python
cd db23c_ords
source .env
# Directories creation
mkdir ${ORDS_SETTINGS_BASE_DIR}/secrets ; chmod 775 ${ORDS_SETTINGS_BASE_DIR}/secrets
mkdir ${ORDS_SETTINGS_BASE_DIR}/settings ; chmod 775 ${ORDS_SETTINGS_BASE_DIR}/settings

# Secret file for ORDS first configuration
echo CONN_STRING=sys/${DATABASE_SYSTEM_PASSWORD}@oracle:1521/FREEPDB1 > ${ORDS_SETTINGS_BASE_DIR}/secrets/conn_string.txt
```

Creation of the container :

```python
cd db23c_ords
docker compose up -d
docker ps
```

### For twitterfeed

This docker compose file will create :
    - An specific image including initialisation script using the latest Oracle Database 23c free for developers with psersistent datafiles
    - A REST API connected to the application schema of the database
    - A REST API giving twitter feeds by products
    - An application UI to show the result

Configuration :

```python
cd twitterfeed
source .env
# Directories creation
sudo mkdir -p ${DB_DATA_BASE_DIR} ; sudo chown $USER:$USER ${DB_DATA_BASE_DIR}
mkdir -p ${DB_DATA_BASE_DIR}/data ; chmod 775 ${DB_DATA_BASE_DIR}/data ; sudo chown :54321 ${DB_DATA_BASE_DIR}/data
docker build -t oracledb23c .
```

Creation of the container :

```python
cd twitterfeed
docker compose up -d
docker ps
```

## Troubleshoot

    # docker exec -it db23c_ords-ords-1 tail -f /tmp/install_container.log

    # docker inspect <container_id> | jq '.[0].Config.Env'


