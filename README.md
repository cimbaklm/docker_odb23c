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
db23c_ords attach ORDS to a previously created database

## Usage

### For db23c

    # echo CONN_STRING=sys/$(cat $HOME/db23c_database/secrets/dbcred.txt)@oracle:1521/FREEPDB1 > secrets/conn_string.txt
    # docker exec -it db23c_ords-ords-1 tail -f /tmp/install_container.log


### For db23c_database

### For db23c_ords


