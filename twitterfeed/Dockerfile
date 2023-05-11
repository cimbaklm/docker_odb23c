FROM gvenzl/oracle-free

RUN mkdir -p /container-entrypoint-initdb.d
COPY ./data/setupAlphaOracle.sql /container-entrypoint-initdb.d
COPY ./data/products.in /container-entrypoint-initdb.d

USER oracle
WORKDIR /home/oracle