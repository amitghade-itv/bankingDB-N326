SHOW databases;

create database banking_db;
use banking_db;

create table customers (
customerID INT,
firstname varchar(50),
lastname varchar(50),
email varchar(100),
phone varchar(10)
);

desc customers;


