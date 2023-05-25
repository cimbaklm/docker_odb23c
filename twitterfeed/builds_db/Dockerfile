FROM gvenzl/oracle-free:slim

RUN mkdir -p /container-entrypoint-initdb.d
COPY ./data/01-setupAlphaOracle.sql /container-entrypoint-initdb.d
COPY ./data/02-finalprod.sql /container-entrypoint-initdb.d
COPY ./data/03-finalcat.sql /container-entrypoint-initdb.d