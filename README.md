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
│   └── docker-compose.yaml
├── db23c_database
│   └── docker-compose.yaml
└── db23c_ords
    └── docker-compose.yaml
'''

db23c is the full compose package, it include : Oracle DB 23c FREE for dev latest, Oracle REST DATA Services latest, and NGINX in order to expose ORDS REST API
db23c_database create the database only
db23c_ords attach ORDS to a previously created database

## Usage




