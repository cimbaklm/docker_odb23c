
set define off
set pagesize 500

shutdown immediate;
startup mount;
alter database noarchivelog;
alter database open; 
exec dbms_xdb_config.sethttpport(5600);
exec dbms_xdb_config.sethttpsport(5500);

conn sys/Oradoc_db1@//localhost/orclpdb1.localdomain as sysdba

create user alpha identified by Alpha2017_;
grant connect,resource,dba to alpha;

conn alpha/Alpha2017_@//localhost/orclpdb1.localdomain
alter session set nls_date_format = 'yyyy-mm-dd';

drop table products;
CREATE TABLE PRODUCTS 
   (	PRODUCT_ID NUMERIC(15,0), 
	PARENT_CATEGORY_ID NUMERIC(15,0), 
	CATEGORY_ID NUMERIC(15,0), 
	PRODUCT_NAME VARCHAR(150), 
	PRODUCT_STATUS VARCHAR(30), 
	COST_PRICE NUMERIC(8,2), 
	LIST_PRICE NUMERIC(8,2), 
	MIN_PRICE NUMERIC(8,2), 
	WARRANTY_PERIOD_MONTHS NUMERIC(2,0), 
	EXTERNAL_URL VARCHAR(200), 
	TWITTER_TAG varchar(1000),
	ATTRIBUTE_CATEGORY VARCHAR(30), 
	ATTRIBUTE1 VARCHAR(150), 
	ATTRIBUTE2 VARCHAR(150), 
	ATTRIBUTE3 VARCHAR(150), 
	ATTRIBUTE4 VARCHAR(150), 
	ATTRIBUTE5 VARCHAR(150), 
	CREATED_BY VARCHAR(60), 
	CREATION_DATE DATE, 
	LAST_UPDATED_BY VARCHAR(60), 
	LAST_UPDATE_DATE DATE, 
	OBJECT_VERSION_ID NUMERIC(15,0)
   );

!cat /dbfiles/products.in | sed 's/),/);\n/g' | sed 's/^(/INSERT INTO PRODUCTS VALUES (/g' | sed 's/`PRODUCTS`/PRODUCTS/g' > /dbfiles/finalprod.sql
@/dbfiles/finalprod.sql

alter session set nls_date_format = 'dd-mon-yy';

drop table product_categories;
CREATE TABLE PRODUCT_CATEGORIES 
   (	CATEGORY_ID NUMERIC(15,0), 
	CATEGORY_NAME VARCHAR(40), 
	PARENT_CATEGORY_ID NUMERIC(15,0), 
	CATEGORY_LEVEL NUMERIC(15,0), 
	CATEGORY_LOCKED_FLAG VARCHAR(1) DEFAULT 'N', 
	REPRESENTATIVE_PRODUCT_ID NUMERIC(15,0), 
	CREATED_BY VARCHAR(60), 
	CREATION_DATE DATE, 
	LAST_UPDATED_BY VARCHAR(60), 
	LAST_UPDATE_DATE DATE, 
	OBJECT_VERSION_ID NUMERIC(15,0)
   );

!cat /dbfiles/categories.in | sed 's/str_to_date(//g' | sed "s/,'%d-%M-%y')//g" > /dbfiles/finalcat.sql
@/dbfiles/finalcat.sql

select count(*) from products;
select count(*) from product_categories;
exit;
