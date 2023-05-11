FROM gvenzl/oracle-free:latest

RUN mkdir -p /container-entrypoint-initdb.d
COPY ./data/setupAlphaOracle.sql /container-entrypoint-initdb.d
COPY ./data/products.in /container-entrypoint-initdb.d